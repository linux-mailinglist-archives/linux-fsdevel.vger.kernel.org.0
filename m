Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6DC22DAA4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 01:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgGYXsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jul 2020 19:48:01 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:49494 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727086AbgGYXsA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jul 2020 19:48:00 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id E7D84D5AF5D;
        Sun, 26 Jul 2020 09:47:53 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jzTtP-0001MM-R6; Sun, 26 Jul 2020 09:47:51 +1000
Date:   Sun, 26 Jul 2020 09:47:51 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iomap: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200725234751.GR2005@dread.disaster.area>
References: <20200720233739.824943-1-satyat@google.com>
 <20200720233739.824943-4-satyat@google.com>
 <20200722211629.GE2005@dread.disaster.area>
 <20200722223404.GA76479@sol.localdomain>
 <20200723220752.GF2005@dread.disaster.area>
 <20200723230345.GB870@sol.localdomain>
 <20200724013910.GH2005@dread.disaster.area>
 <20200724034628.GC870@sol.localdomain>
 <20200724053130.GO2005@dread.disaster.area>
 <20200724174132.GB819@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724174132.GB819@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=7-415B0cAAAA:8
        a=kCWghvGevV_Be34-x9kA:9 a=0nE9jjMUsWplL590:21 a=Ro6-E-bpJJKdh-rk:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 10:41:32AM -0700, Eric Biggers wrote:
> On Fri, Jul 24, 2020 at 03:31:30PM +1000, Dave Chinner wrote:
> > On Thu, Jul 23, 2020 at 08:46:28PM -0700, Eric Biggers wrote:
> > > On Fri, Jul 24, 2020 at 11:39:10AM +1000, Dave Chinner wrote:
> > > > fscrypt_inode_uses_inline_crypto() ends up being:
> > > > 
> > > > 	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) &&
> > > > 	    inode->i_crypt_info->ci_inlinecrypt)
> > > > 
> > > > I note there are no checks for inode->i_crypt_info being non-null,
> > > > and I note that S_ENCRYPTED is set on the inode when the on-disk
> > > > encrypted flag is encountered, not when inode->i_crypt_info is set.
> > > > 
> > > 
> > > ->i_crypt_info is set when the file is opened, so it's guaranteed to be set for
> > > any I/O.  So the case you're concerned about just doesn't happen.
> > 
> > Ok. The connection is not obvious to someone who doesn't know the
> > fscrypt code inside out.
> > 
> > > > > Note that currently, I don't think iomap_dio_bio_actor() would handle an
> > > > > encrypted file with blocksize > PAGE_SIZE correctly, as the I/O could be split
> > > > > in the middle of a filesystem block (even after the filesystem ensures that
> > > > > direct I/O on encrypted files is fully filesystem-block-aligned, which we do ---
> > > > > see the rest of this patchset), which isn't allowed on encrypted files.
> > > > 
> > > > That can already happen unless you've specifically restricted DIO
> > > > alignments in the filesystem code. i.e. Direct IO already supports
> > > > sub-block ranges and alignment, and we can already do user DIO on
> > > > sub-block, sector aligned ranges just fine. And the filesystem can
> > > > already split the iomap on sub-block alignments and ranges if it
> > > > needs to because the iomap uses byte range addressing, not sector or
> > > > block based addressing.
> > > > 
> > > > So either you already have a situation where the 2^32 offset can
> > > > land *inside* a filesystem block, or the offset is guaranteed to be
> > > > filesystem block aligned and so you'll never get this "break an IO
> > > > on sub-block alignment" problem regardless of the filesystem block
> > > > size...
> > > > 
> > > > Either way, it's not an iomap problem - it's a filesystem mapping
> > > > problem...
> > > > 
> > > 
> > > I think you're missing the point here.  Currently, the granularity of encryption
> > > (a.k.a. "data unit size") is always filesystem blocks, so that's the minimum we
> > > can directly read or write to an encrypted file.  This has nothing to do with
> > > the IV wraparound case also being discussed.
> > 
> > So when you change the subject, please make it *really obvious* so
> > that people don't think you are still talking about the same issue.
> > 
> > > For example, changing a single bit in the plaintext of a filesystem block may
> > > result in the entire block's ciphertext changing.  (The exact behavior depends
> > > on the cryptographic algorithm that is used.)
> > > 
> > > That's why this patchset makes ext4 only allow direct I/O on encrypted files if
> > > the I/O is fully filesystem-block-aligned.  Note that this might be a more
> > > strict alignment requirement than the bdev_logical_block_size().
> > > 
> > > As long as the iomap code only issues filesystem-block-aligned bios, *given
> > > fully filesystem-block-aligned inputs*, we're fine.  That appears to be the case
> > > currently.
> > 
> > The actual size and shape of the bios issued by direct IO (both old
> > code and newer iomap code) is determined by the user supplied iov,
> > the size of the biovec array allocated in the bio, and the IO
> > constraints of the underlying hardware.  Hence direct IO does not
> > guarantee alignment to anything larger than the underlying block
> > device logical sector size because there's no guarantee when or
> > where a bio will fill up.
> > 
> > To guarantee alignment of what ends up at the hardware, you have to
> > set the block device parameters (e.g. logical sector size)
> > appropriately all the way down the stack. You also need to ensure
> > that the filesystem is correctly aligned on the block device so that
> > filesystem blocks don't overlap things like RAID stripe boundaires,
> > linear concat boundaries, etc.
> > 
> > IOWs, to constrain alignment in the IO path, you need to configure
> > you system correct so that the information provided to iomap for IO
> > alignment matches your requirements. This is not somethign iomap can
> > do itself; everything from above needs to be constrained by the
> > filesystem using iomap, everything sent below by iomap is
> > constrained by the block device config.
> 
> That way of thinking about things doesn't entirely work for inline encryption.

Then the inline encryption design is flawed. Block devices tell the
layers above what the minimum unit of atomic IO is via the logical
block size of the device is. Everything above the block device
assumes that it can align and size IO to this size, and the IO will
succeed.

> Hardware can support multiple encryption "data unit sizes", some of which may be
> larger than the logical block size.  (The data unit size is the granularity of
> encryption.  E.g. if software selects data_unit_size=4096, then each invocation
> of the encryption/decryption algorithm is passed 4096 bytes.  You can't then
> later encrypt/decrypt just part of that; that's not how the algorithms work.)

I know what a DUN is. The problem here is that it's the unit of
atomic IO the hardware supports when encryption is enabled....

> For example hardware might *in general* support addressing 512-byte sectors and
> thus have logical_block_size=512.  But it could also support encryption data
> unit sizes [512, 1024, 2048, 4096].  Encrypted I/O has to be aligned to the data
> unit size, not just to the logical block size.  The data unit size to use, and
> whether to use encryption or not, is decided on a per-I/O basis.

And that is the fundamental problem here: DUN > logical block size
of the underlying device. i.e. The storage stack does not guarantee
atomicity of such IOs.

If inline encryption increases the size of the atomic unit of IO,
then the logical block size of the device must increase to match it.
If you do that, then the iomap and storage layers will guarantee
that IOs are *always* aligned to DUN boundaries.

> So in this case technically it's the filesystem (and later the
> bio::bi_crypt_context which the filesystem sets) that knows about the alignment
> needed -- *not* the request_queue.

Exactly my point. Requiring infrastructure and storage layers to
obey completely new, undefined, undiscoverable, opaque and variable
definition of the block devices' "atomic unit of IO", then that's
simply a non-starter. That requires a complete re-architecture of
the block layers and how things interface and transmit information
through them. At minimum, high level IO alignment constraints must
be generic and not be hidden in context specific crypto structures.

> Is it your opinion that inline encryption should only be supported when
> data_unit_size <= logical_block_size?  The problems with that are

Pretty much.

>     (a) Using an unnecessarily small data_unit_size degrades performance a
> 	lot -- for *all* I/O, not just direct I/O.  This is because there are a
> 	lot more separate encryptions/decryptions to do, and there's a fixed
> 	overhead to each one (much of which is intrinsic in the crypto
> 	algorithms themselves, i.e. this isn't simply an implementation quirk).

Performance is irrelevant if correctness is not possible.

>     (b) fscrypt currently only supports data_unit_size == filesystem_block_size.
> 	(OFC, filesystem_block_size may be greater than logical_block_size.)

Which is just fine if FSB == logical block size.

The existing constraint on filesystems is that FSB >= block device
logical sector size as the filesystem has to be able to do single
block IOs.  For inline encryption, this turns into a constraint on
fscrypt that DUN <= logical block size because it requires IOs to be
aligned to DUNs, not filesystem blocks..

And because of the -implementation limitation- of fscrypt that DUN
== FSB, that means the only valid configuration right now is DUN =
FSB = logical sector size.

>     (c) Filesystem images would be less portable, unless the minimum
> 	data_unit_size were used everywhere which would degrade performance.

Not my problem. If the hardware and/or kernel cannot support the
requirements of the encryption used within the filesystem image,
then it -should error out-.

> (We could address (b) by allowing users to specify data_unit_size when
> encrypting a directory.  That would add complexity, but it's possible.)
> 
> But again, as far as I can tell, fs/iomap/direct-io.c currently *does* guarantee
> that *if* the input is fully filesystem-block-aligned and if blocksize <=
> PAGE_SIZE, then the issued I/O is also filesystem-block-aligned.

Please listen to what I'm saying, Eric.

The -current iomap implementation- may provide that behaviour. That
doesn't mean we guarantee that behaviour. i.e. the iomap -design-
does not guaranteee that behaviour, and we don't guarantee such
behaviour into the future. And we won't guarantee this behaviour -
even though the current implementation may provide it - because the
rest of the IO stack below iomap does not provide iomap with that
guarantee.

Hence if iomap cannot get a guarantee that IO it issues won't get
split at some arbitrary boundary, it cannot provide filesystems with
that guarantee.

> So as far as I can tell, there isn't really any problem there, at least not now.
> I just want to make sure we're on the same page...

If that page is "fscrypt+inline encryption is making fundamentally
flawed assumptions about IO stack behaviour" then, yes, we're on the
same page.

And that code that has fundamentally flawed assumptions is grounds
for a NACK, yes?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
