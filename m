Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9848D6F8C24
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 00:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjEEWBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 18:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjEEWBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 18:01:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEAF5FF0;
        Fri,  5 May 2023 15:00:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 106FA64135;
        Fri,  5 May 2023 22:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB7DC4339B;
        Fri,  5 May 2023 22:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683324057;
        bh=arsyBM1Ju2+rsxuFa33xD23Tpqvq4c7+KQq0jw1C4Is=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jDSc7DDEeTor4PNGoWVENJxZP8gRPxTfDzAcH+xNKkfEjDe1Jo0A0NLpuM2gHUUxm
         /5qPXe5eGWMn3Ami0WD4hVl02MppJvrosBR/7teyFNxvtRoLJygGtDPeHh3mRIzY4r
         lwt/uf6iWpMiYjTB1aAjNQavB9ln6LIgi6/HhDgeqK96N5i0R1vhbTL+haxCp360It
         BfZ51hvmr6uwLLIaNvZSv5K48YlmOhH30qnZ49tYvY1drPm8Iqhl1LnM/Oqmhu/Gii
         H0rsPsWZTt+SRUq8+jZCYGQwO6LGjDnUt9QGkHdEG4ns1XyDgHqI1BAH172pLOo6dg
         0bwr0u+LNNEHw==
Date:   Fri, 5 May 2023 15:00:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH RFC 01/16] block: Add atomic write operations to
 request_queue limits
Message-ID: <20230505220056.GJ15394@frogsfrogsfrogs>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-2-john.g.garry@oracle.com>
 <20230503213925.GD3223426@dread.disaster.area>
 <fc91aa12-1707-9825-a77e-9d5a41d97808@oracle.com>
 <20230504222623.GI3223426@dread.disaster.area>
 <90522281-863f-58bf-9b26-675374c72cc7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90522281-863f-58bf-9b26-675374c72cc7@oracle.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 08:54:12AM +0100, John Garry wrote:
> On 04/05/2023 23:26, Dave Chinner wrote:
> 
> Hi Dave,
> 
> > > atomic_write_unit_max is largest application block size which we can
> > > support, while atomic_write_max_bytes is the max size of an atomic operation
> > > which the HW supports.
> > Why are these different? If the hardware supports 128kB atomic
> > writes, why limit applications to something smaller?
> 
> Two reasons:
> a. If you see patch 6/16, we need to apply a limit on atomic_write_unit_max
> from what is guaranteed we can fit in a bio without it being required to be
> split when submitted.
> 
> Consider iomap generates an atomic write bio for a single userspace block
> and submits to the block layer - if the block layer needs to split due to
> block driver request_queue limits, like max_segments, then we're in trouble.
> So we need to limit atomic_write_unit_max such that this will not occur.
> That same limit should not apply to atomic_write_max_bytes.
> 
> b. For NVMe, atomic_write_unit_max and atomic_write_max_bytes which the host
> reports will be the same (ignoring a.).
> 
> However for SCSI they may be different. SCSI has its own concept of boundary
> and it is relevant here. This is confusing as it is very different from NVMe
> boundary. NVMe is a media boundary really. For SCSI, a boundary is a
> sub-segment which the device may split an atomic write operation. For a SCSI
> device which only supports this boundary mode of operation, we limit
> atomic_write_unit_max to the max boundary segment size (such that we don't
> get splitting of an atomic write by the device) and then limit
> atomic_write_max_bytes to what is known in the spec as "maximum atomic
> transfer length with boundary". So in this device mode of operation,
> atomic_write_max_bytes and atomic_write_unit_max should be different.

Hmm, maybe some concrete examples would be useful here?  I find the
queue limits stuff pretty confusing too.

Could a SCSI device could advertise 512b LBAs, 4096b physical blocks, a
64k atomic_write_unit_max, and a 1MB maximum transfer length
(atomic_write_max_bytes)?  And does that mean that application software
can send one 64k-aligned write and expect it either to be persisted
completely or not at all?

And, does that mean that the application can send up to 16 of these
64k-aligned blocks as a single 1MB IO and expect that each of those 16
blocks will either be persisted entirely or not at all?  There doesn't
seem to be any means for the device to report /which/ of the 16 were
persisted, which is disappointing.  But maybe the application encodes
LSNs and can tell after the fact that something went wrong, and recover?

If the same device reports a 2048b atomic_write_unit_min, does that mean
that I can send between 2 and 64k of data as a single atomic write and
that's ok?  I assume that this weird situation (512b LBA, 4k physical,
2k atomic unit min) requires some fancy RMW but that the device is
prepared to cr^Wpersist that correctly?

What if the device also advertises a 128k atomic_write_boundary?
That means that a 2k atomic block write will fail if it starts at 127k,
but if it starts at 126k then thats ok.  Right?

As for avoiding splits in the block layer, I guess that also means that
someone needs to reduce atomic_write_unit_max and atomic_write_boundary
if (say) some sysadmin decides to create a raid0 of these devices with a
32k stripe size?

It sounds like NVME is simpler in that it would report 64k for both the
max unit and the max transfer length?  And for the 1M write I mentioned
above, the application must send 16 individual writes?

(Did I get all that correctly?)

> > 
> > >  From your review on the iomap patch, I assume that now you realise that we
> > > are proposing a write which may include multiple application data blocks
> > > (each limited in size to atomic_write_unit_max), and the limit in total size
> > > of that write is atomic_write_max_bytes.
> > I still don't get it - you haven't explained why/what an application
> > atomic block write might be, nor why the block device should be
> > determining the size of application data blocks, etc.  If the block
> > device can do 128kB atomic writes, why wouldn't the device allow the
> > application to do 128kB atomic writes if they've aligned the atomic
> > write correctly?
> 
> An application block needs to be:
> - sized at a power-of-two
> - sized between atomic_write_unit_min and atomic_write_unit_max, inclusive
> - naturally aligned
> 
> Please consider that the application does not explicitly tell the kernel the
> size of its data blocks, it's implied from the size of the write and file
> offset. So, assuming that userspace follows the rules properly when issuing
> a write, the kernel may deduce the application block size and ensure only
> that each individual user data block is not split.
> 
> If userspace wants a guarantee of no splitting of all in its write, then it
> may issue a write for a single userspace data block, e.g. userspace block
> size is 16KB, then write at a file offset aligned to 16KB and a total write
> size of 16KB will be guaranteed to be written atomically by the device.

I'm ... not sure what the userspace block size is?

With my app developer hat on, the simplest mental model of this is that
if I want to persist a blob of data that is larger than one device LBA,
then atomic_write_unit_min <= blob size <= atomic_write_unit_max must be
true, and the LBA range for the write cannot cross a atomic_write_boundary.

Does that sound right?

Going back to my sample device above, the XFS buffer cache could write
individual 4k filesystem metadata blocks using REQ_ATOMIC because 4k is
between the atomic write unit min/max, 4k metadata blocks will never
cross a 128k boundary, and we'd never have to worry about torn writes
in metadata ever again?

Furthermore, if I want to persist a bunch of blobs in a contiguous LBA
range and atomic_write_max_bytes > atomic_write_unit_max, then I can do
that with a single direct write?  I'm assuming that the blobs in the
middle of the range must all be exactly atomic_write_unit_max bytes in
size?  And I had better be prepared to (I guess) re-read the entire
range after the system goes down to find out if any of them did or did
not persist?

(This part sounds like a PITA.)

> > 
> > What happens we we get hardware that can do atomic writes at any
> > alignment, of any size up to atomic_write_max_bytes? Because this
> > interface defines atomic writes as "must be a multiple of 2 of
> > atomic_write_unit_min" then hardware that can do atomic writes of
> > any size can not be effectively utilised by this interface....
> > 
> > > user applications should only pay attention to what we return from statx,
> > > that being atomic_write_unit_min and atomic_write_unit_max.
> > > 
> > > atomic_write_max_bytes and atomic_write_boundary is only relevant to the
> > > block layer.
> > If applications can issue an multi-atomic_write_unit_max-block
> > writes as a single, non-atomic, multi-bio RWF_ATOMIC pwritev2() IO
> > and such IO is constrainted to atomic_write_max_bytes, then
> > atomic_write_max_bytes is most definitely relevant to user
> > applications.
> 
> But we still do not guarantee that multi-atomic_write_unit_max-block writes
> as a single, non-atomic, multi-bio RWF_ATOMIC pwritev2() IO and such IO is
> constrained to atomic_write_max_bytes will be written atomically by the
> device.
> 
> Three things may happen in the kernel:
> - we may need to split due to atomic boundary
> - we may need to split due to the write spanning discontig extents
> - atomic_write_max_bytes may be much larger than what we could fit in a bio,
> so may need multiple bios
> 
> And maybe more which does not come to mind.
> 
> So I am not sure what value there is in reporting atomic_write_max_bytes to
> the user. The description would need to be something like "we guarantee that
> if the total write length is greater than atomic_write_max_bytes, then all
> data will never be submitted to the device atomically. Otherwise it might
> be".
> 
> > 
> > 
> > > > > +What:		/sys/block/<disk>/atomic_write_boundary
> > > > > +Date:		May 2023
> > > > > +Contact:	Himanshu Madhani<himanshu.madhani@oracle.com>
> > > > > +Description:
> > > > > +		[RO] A device may need to internally split I/Os which
> > > > > +		straddle a given logical block address boundary. In that
> > > > > +		case a single atomic write operation will be processed as
> > > > > +		one of more sub-operations which each complete atomically.
> > > > > +		This parameter specifies the size in bytes of the atomic
> > > > > +		boundary if one is reported by the device. This value must
> > > > > +		be a power-of-two.
> > > > How are users/filesystems supposed to use this?
> > > As above, this is not relevant to the user.
> > Applications will greatly care if their atomic IO gets split into
> > multiple IOs whose persistence order is undefined.
> 
> Sure, so maybe then we need to define and support persistence ordering
> rules. But still, any atomic_write_boundary is already taken into account
> when we report atomic_write_unit_min and atomic_write_unit_max to the user.
> 
> > I think it also
> > matters for filesystems when it comes to allocation, because we are
> > going to have to be very careful not to have extents straddle ranges
> > that will cause an atomic write to be split.
> 
> Note that block drivers need to ensure that they report the following:
> - atomic_write_unit_max is a power-of-2
> - atomic_write_boundary is a power-of-2 (and naturally it would need to be
> greater or equal to atomic_write_unit_max)
> [sidenote: I actually think that atomic_write_boundary needs to be just a
> multiple of atomic_write_unit_max, but let's stick with these rules for the
> moment]
> 
> As such, if we split a write due to a boundary, we would still always be
> able to split such that we don't need to split an individual userspace data
> block.

...but only if userspace data blocks (whatever those are) don't
themselves split atomic_write_boundary.

> > 
> > e.g. how does this work with striped devices? e.g. we have a stripe
> > unit of 16kB, but the devices support atomic_write_unit_max = 32kB.
> > Instantly, we have a configuration where atomic writes need to be
> > split at 16kB boundaries, and so the maximum atomic write size that
> > can be supported is actually 16kB - the stripe unit of RAID device.
> 
> OK, so in that case, I think that we would need to limit the reported
> atomic_write_unit_max value to the stripe value in a RAID config.
> 
> > 
> > This means the filesystem must, at minimum, align all allocations
> > for atomic IO to 16kB stripe unit alignment, and must not allow
> > atomic IOs that are not stripe unit aligned or sized to proceed
> > because they can't be processed as an atomic IO....
> 
> As above. Martin may be able to comment more on this.
> 
> > 
> > 
> > > > >    /**
> > > > > @@ -183,6 +186,59 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
> > > > >    }
> > > > >    EXPORT_SYMBOL(blk_queue_max_discard_sectors);
> > > > > +/**
> > > > > + * blk_queue_atomic_write_max_bytes - set max bytes supported by
> > > > > + * the device for atomic write operations.
> > > > > + * @q:  the request queue for the device
> > > > > + * @size: maximum bytes supported
> > > > > + */
> > > > > +void blk_queue_atomic_write_max_bytes(struct request_queue *q,
> > > > > +				      unsigned int size)
> > > > > +{
> > > > > +	q->limits.atomic_write_max_bytes = size;
> > > > > +}
> > > > > +EXPORT_SYMBOL(blk_queue_atomic_write_max_bytes);
> > > > > +
> > > > > +/**
> > > > > + * blk_queue_atomic_write_boundary - Device's logical block address space
> > > > > + * which an atomic write should not cross.
> > > > I have no idea what "logical block address space which an atomic
> > > > write should not cross" means, especially as the unit is in bytes
> > > > and not in sectors (which are the units LBAs are expressed in).
> > > It means that an atomic operation which straddles the atomic boundary is not
> > > guaranteed to be atomic by the device, so we should (must) not cross it to
> > > maintain atomic behaviour for an application block. That's one reason that
> > > we have all these size and alignment rules.
> > Yes, That much is obvious. What I have no idea diea about is what
> > this means in practice. When is this ever going to be non-zero, and
> > what should be we doing at the filesystem allocation level when it
> > is non-zero to ensure that allocations for atomic writes never cross
> > such a boundary. i.e. how do we prevent applications from ever
> > needing this functionality to be triggered? i.e. so the filesystem
> > can guarantee a single RWF_ATOMIC user IO is actually dispatched
> > as a single REQ_ATOMIC IO....
> 
> We only guarantee that a single user data block will not be split. So to
> avoid any splitting at all, all you can do is write a single user data
> block. That's the best which we can offer.
> 
> As mentioned earlier, atomic boundary is only relevant to NVMe. If the
> device does not support an atomic boundary which is not compliant with the
> rules, then we cannot support atomic writes for that device.

I guess here that any device advertising a atomic_write_boundary > 0
internally splits its LBA address space into chunks of that size and can
only persist full chunks.  The descriptions of how flash storage work
would seem to fit that description to me.  <shrug>

> > 
> > > ...
> > > 
> > > > > +static inline unsigned int queue_atomic_write_unit_max(const struct request_queue *q)
> > > > > +{
> > > > > +	return q->limits.atomic_write_unit_max << SECTOR_SHIFT;
> > > > > +}
> > > > > +
> > > > > +static inline unsigned int queue_atomic_write_unit_min(const struct request_queue *q)
> > > > > +{
> > > > > +	return q->limits.atomic_write_unit_min << SECTOR_SHIFT;
> > > > > +}
> > > > Ah, what? This undocumented interface reports "unit limits" in
> > > > bytes, but it's not using the physical device sector size to convert
> > > > between sector units and bytes. This really needs some more
> > > > documentation and work to make it present all units consistently and
> > > > not result in confusion when devices have 4kB sector sizes and not
> > > > 512 byte sectors...
> > > ok, we'll look to fix this up to give a coherent and clear interface.
> > > 
> > > > Also, I think all the byte ranges should support full 64 bit values,
> > > > otherwise there will be silent overflows in converting 32 bit sector
> > > > counts to byte ranges. And, eventually, something will want to do
> > > > larger than 4GB atomic IOs
> > > > 
> > > ok, we can do that but would also then make statx field 64b. I'm fine with
> > > that if it is wise to do so - I don't don't want to wastefully use up an
> > > extra 2 x 32b in struct statx.
> > Why do we need specific varibles for DIO atomic write alignment
> > limits?
> 
> I guess that we don't
> 
> > We already have direct IO alignment and size constraints in statx(),
> > so why wouldn't we just reuse those variables when the user requests
> > atomic limits for DIO?
> > 
> > i.e. if STATX_DIOALIGN is set, we return normal DIO alignment
> > constraints. If STATX_DIOALIGN_ATOMIC is set, we return the atomic
> > DIO alignment requirements in those variables.....
> > 
> > Yes, we probably need the dio max size to be added to statx for
> > this. Historically speaking, I wanted statx to support this in the
> > first place because that's what we were already giving userspace
> > with XFS_IOC_DIOINFO and we already knew that atomic IO when it came
> > along would require a bound maximum IO size much smaller than normal
> > DIO limits.  i.e.:
> > 
> > struct dioattr {
> >          __u32           d_mem;          /* data buffer memory alignment */
> >          __u32           d_miniosz;      /* min xfer size                */
> >          __u32           d_maxiosz;      /* max xfer size                */
> > };
> > 
> > where d_miniosz defined the alignment and size constraints for DIOs.
> > 
> > If we simply document that STATX_DIOALIGN_ATOMIC returns minimum
> > (unit) atomic IO size and alignment in statx->dio_offset_align (as
> > per STATX_DIOALIGN) and the maximum atomic IO size in
> > statx->dio_max_iosize, then we don't burn up anywhere near as much
> > space in the statx structure....
> 
> ok, so you are saying to unionize them, right? That would seem reasonable to
> me.
> Thanks,
> John
> 
