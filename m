Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C501386D32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 00:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343787AbhEQWtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 18:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238582AbhEQWtt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 18:49:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFB9C61209;
        Mon, 17 May 2021 22:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621291712;
        bh=ZGAHT0vKC5f3VhAAiDbYUG+YlqZze6CrfYKzvDxVfQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tIolb+oZ3M45XjBQiE20nRQW6582nOVxwu0nb5GPNtl+Qddp4e+F5DO0/z/Eq7sbI
         NFuwp2TXeQIwascJBNI5pzGn+sYGpFE67nVOnD/lQEJ0JxBHqoJvE5nESrVSUih9v8
         bCo4w1dQwVf/kY+ETOwcMXxv6Pe3U5jH8UsgL/1lDj3d4xgJx+h1q0yDZVsgiFw+V2
         jp5AP6AfsowDTLGZCW4dvwmmnwdSIUHXzDSHq1DDBJ3/HPAYZNyi2776yf347vdVf+
         c0GFviiwLtOCKTXK1iBwbS39bxTOPZ4k3PMgZN1Bjc3vK13wVqIrajVEVo9BpO8IUZ
         uxb1D12xK7Uyg==
Date:   Mon, 17 May 2021 15:48:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RERESEND v9 0/9] fs: interface for directly
 reading/writing compressed data
Message-ID: <YKLyvnb19QmayJaJ@gmail.com>
References: <cover.1621276134.git.osandov@fb.com>
 <CAHk-=wh74eFxL0f_HSLUEsD1OQfFNH9ccYVgCXNoV1098VCV6Q@mail.gmail.com>
 <YKLt5GyznttizBjd@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKLt5GyznttizBjd@relinquished.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 17, 2021 at 03:27:48PM -0700, Omar Sandoval wrote:
> On Mon, May 17, 2021 at 02:32:47PM -0700, Linus Torvalds wrote:
> > On Mon, May 17, 2021 at 11:35 AM Omar Sandoval <osandov@osandov.com> wrote:
> > >
> > > Patches 1-3 add the VFS support, UAPI, and documentation. Patches 4-7
> > > are Btrfs prep patches. Patch 8 adds Btrfs encoded read support and
> > > patch 9 adds Btrfs encoded write support.
> > 
> > I don't love the RWF_ENCODED flag, but if that's the way people think
> > this should be done, as a model this looks reasonable to me.
> > 
> > I'm not sure what the deal with the encryption metadata is. I realize
> > there is currently only one encryption type ("none") in this series,
> > but it's not clear how any other encryption type would actually ever
> > be described. It's not like you can pass in the key (well, I guess
> > passing in the key would be fine, but passing it back out certainly
> > would not be).  A key ID from a keyring?
> > 
> > So there's presumably some future plan for it, but it would be good to
> > verify that that plan makes sense..
> 
> What I'm imagining for fscrypt is:
> 
> 1. Add ENCODED_IOV_ENCRYPTION_* types for fscrypt. Consumers at least
>    need to be able to distinguish between encryption policy versions,
>    DIRECT_KEY policies, and IV_INO_LBLK_{64,32} policies, and maybe
>    other details.
> 2. Use RWF_ENCODED only for the data itself.
> 3. Add new fscrypt ioctls to get and set the encryption key.
> 
> The interesting part is (3). If I'm reading the fscrypt documentation
> correctly, in the default mode, each file is encrypted with a per-file
> key that is a function of the master key for the directory tree and a
> per-file nonce.
> 
> Userspace manages the master key, we have a FS_IOC_GET_ENCRYPTION_NONCE
> ioctl, and the key derivation function is documented. So, userspace
> already has all of the pieces it needs to get the encryption key, and
> all of the information it needs to decrypt the data it gets from
> RWF_ENCODED if it so desires.
> 
> On the set/write side, the user can set the same master key and policy
> with FS_IOC_SET_ENCRYPTION_POLICY, and we'd need something like an
> FS_IOC_SET_ENCRYPTION_NONCE ioctl (possibly with a requirement that it
> be set when the file is empty). I think that's it.
> 
> The details will vary for the other fscrypt policies, but that's the
> gist of it. I added the fscrypt maintainers to correct me if I missed
> something.
> 

Well, assuming we're talking about regular files only (so file contents
encryption, not filenames encryption), with fscrypt the information needed to
understand a file's encrypted data is the following:

1. The encryption key

2. The filesystem's block size

3. The encryption context:

    struct fscrypt_context_v2 {                                                      
         u8 version; /* FSCRYPT_CONTEXT_V2 */                                     
         u8 contents_encryption_mode;                                             
         u8 filenames_encryption_mode;                                            
         u8 flags;                                                                
         u8 __reserved[4];                                                        
         u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];                   
         u8 nonce[FSCRYPT_FILE_NONCE_SIZE];                                       
    };                                                                               

   (Or alternatively struct fscrypt_policy_v2 + the nonce field separately;
    that results in the same fields as struct fscrypt_context_v2.)

This is definitely more complex than the compression cases like "the data is a
zlib stream".  So the question is, how much of this metadata (if any) should
actually be passed around during RWF_ENCODED pread/pwrite operations, and how
much should be out-of-band.

I feel like this should be mostly out-of-band (e.g. via the existing ioctls
FS_IOC_{GET,SET}_ENCRYPTION_POLICY), especially given that compression and
encryption could be combined which would make describing the on-disk data even
more difficult.

But I'm not sure what you intended.

- Eric
