Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CB56F7919
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 00:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjEDW0d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 18:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjEDW0c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 18:26:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E6C120AD
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 May 2023 15:26:29 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64115eef620so15731832b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 May 2023 15:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683239189; x=1685831189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0PGJtFyK7gJnSiUzHQVMxHgKXd5CmRv3rf91PVJFRAk=;
        b=a/QoUspgk3pMtdlLwgA3lZkGDux8oWXEt9uq8IQfISgAxUpHsprqdSHQxcDnm6fVil
         Kh7PgEuDzuaRDm/XeU/Q+bZcSAh+aej0wEmKQ0VwK7u5K3uNpIgJotDiE45R4Cx23ua9
         1e84EquSfJVWSEpqJctew3TYTG3R1Yx0kYVQWzdU+zgClGJy+ZE0gP3z+Q4oCGzKg8vT
         aJy4qy13IQhkC8sfjD7VFKFshaR9OZoE2S+kiFMkXke76OdI9K9LsTzoAoCtwIy0zHgz
         6q7Eq+f3DxtVCO10OTb6Vi5Fr2JdEnf/XR0Xi+gas5rlBItOcdvI/u7lKc7y5XdNFpcY
         YHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683239189; x=1685831189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PGJtFyK7gJnSiUzHQVMxHgKXd5CmRv3rf91PVJFRAk=;
        b=QbVQanVg5DtmkagPNj1RF5zw+9hu5uCCtlpsFotytwTTsFwW1a/f/oPOj2AcpuL6kh
         k4AicBtk/eHx4DoB04KsDrwAZnvrvR8iUHOsSAhLI2WANvXBNq7rwkBWbJ598IfG+9yG
         sq3yv16dSSnCmorsRmwLoHoIzZMik9kjomNNz/t7UId+MTS1Wnhs4nDXFeLPyJ47+xao
         w4iqkfn29gwUzSxP5khfMLbuDnBm/OX8x8n9CwFEEzc042O6nyIUe/MnY7TkiNwGkoK2
         Ns5xVPVjRsiBJqESKu92SDSF/HJdD/E//SGxQIxujo7sKQqz4+IouC0rqLCryq/uAQQt
         QYOw==
X-Gm-Message-State: AC+VfDw5ZCYar3tb6UBO8T6/nbyIAIjaS7CtMbVl0lxJztBhOP6mAgQc
        mFHhB2vSn6RndxyWYW3ngBpBEw==
X-Google-Smtp-Source: ACHHUZ77jAxUd5xIcycMyzqPrl6iGCXfjAOeoU7zib/iCRNZ8B6RPxY7Gsgjo2XpOhIPp01YO28mEw==
X-Received: by 2002:a17:902:9342:b0:1ab:fce:7b4d with SMTP id g2-20020a170902934200b001ab0fce7b4dmr4925317plp.27.1683239188721;
        Thu, 04 May 2023 15:26:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ab8d00b001aaea39043dsm44505plr.41.2023.05.04.15.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:26:27 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1puhP5-00BPeb-Ee; Fri, 05 May 2023 08:26:23 +1000
Date:   Fri, 5 May 2023 08:26:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH RFC 01/16] block: Add atomic write operations to
 request_queue limits
Message-ID: <20230504222623.GI3223426@dread.disaster.area>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-2-john.g.garry@oracle.com>
 <20230503213925.GD3223426@dread.disaster.area>
 <fc91aa12-1707-9825-a77e-9d5a41d97808@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc91aa12-1707-9825-a77e-9d5a41d97808@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 04, 2023 at 07:14:29PM +0100, John Garry wrote:
> Hi Dave,
> 
> > > diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> > > index 282de3680367..f3ed9890e03b 100644
> > > --- a/Documentation/ABI/stable/sysfs-block
> > > +++ b/Documentation/ABI/stable/sysfs-block
> > > @@ -21,6 +21,48 @@ Description:
> > >   		device is offset from the internal allocation unit's
> > >   		natural alignment.
> > > +What:		/sys/block/<disk>/atomic_write_max_bytes
> > > +Date:		May 2023
> > > +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> > > +Description:
> > > +		[RO] This parameter specifies the maximum atomic write
> > > +		size reported by the device. An atomic write operation
> > > +		must not exceed this number of bytes.
> > > +
> > > +
> > > +What:		/sys/block/<disk>/atomic_write_unit_min
> > > +Date:		May 2023
> > > +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> > > +Description:
> > > +		[RO] This parameter specifies the smallest block which can
> > > +		be written atomically with an atomic write operation. All
> > > +		atomic write operations must begin at a
> > > +		atomic_write_unit_min boundary and must be multiples of
> > > +		atomic_write_unit_min. This value must be a power-of-two.
> > 
> > What units is this defined to use? Bytes?
> 
> Bytes
> 
> > 
> > > +
> > > +
> > > +What:		/sys/block/<disk>/atomic_write_unit_max
> > > +Date:		January 2023
> > > +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> > > +Description:
> > > +		[RO] This parameter defines the largest block which can be
> > > +		written atomically with an atomic write operation. This
> > > +		value must be a multiple of atomic_write_unit_min and must
> > > +		be a power-of-two.
> > 
> > Same question. Also, how is this different to
> > atomic_write_max_bytes?
> 
> Again, this is bytes. We can add "bytes" to the name of these other files if
> people think it's better. Unfortunately request_queue sysfs file naming
> isn't consistent here to begin with.
> 
> atomic_write_unit_max is largest application block size which we can
> support, while atomic_write_max_bytes is the max size of an atomic operation
> which the HW supports.

Why are these different? If the hardware supports 128kB atomic
writes, why limit applications to something smaller?

> From your review on the iomap patch, I assume that now you realise that we
> are proposing a write which may include multiple application data blocks
> (each limited in size to atomic_write_unit_max), and the limit in total size
> of that write is atomic_write_max_bytes.

I still don't get it - you haven't explained why/what an application
atomic block write might be, nor why the block device should be
determining the size of application data blocks, etc.  If the block
device can do 128kB atomic writes, why wouldn't the device allow the
application to do 128kB atomic writes if they've aligned the atomic
write correctly?

What happens we we get hardware that can do atomic writes at any
alignment, of any size up to atomic_write_max_bytes? Because this
interface defines atomic writes as "must be a multiple of 2 of
atomic_write_unit_min" then hardware that can do atomic writes of
any size can not be effectively utilised by this interface....

> user applications should only pay attention to what we return from statx,
> that being atomic_write_unit_min and atomic_write_unit_max.
> 
> atomic_write_max_bytes and atomic_write_boundary is only relevant to the
> block layer.

If applications can issue an multi-atomic_write_unit_max-block
writes as a single, non-atomic, multi-bio RWF_ATOMIC pwritev2() IO
and such IO is constrainted to atomic_write_max_bytes, then
atomic_write_max_bytes is most definitely relevant to user
applications.


> > > +What:		/sys/block/<disk>/atomic_write_boundary
> > > +Date:		May 2023
> > > +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> > > +Description:
> > > +		[RO] A device may need to internally split I/Os which
> > > +		straddle a given logical block address boundary. In that
> > > +		case a single atomic write operation will be processed as
> > > +		one of more sub-operations which each complete atomically.
> > > +		This parameter specifies the size in bytes of the atomic
> > > +		boundary if one is reported by the device. This value must
> > > +		be a power-of-two.
> > 
> > How are users/filesystems supposed to use this?
> 
> As above, this is not relevant to the user.

Applications will greatly care if their atomic IO gets split into
multiple IOs whose persistence order is undefined. I think it also
matters for filesystems when it comes to allocation, because we are
going to have to be very careful not to have extents straddle ranges
that will cause an atomic write to be split.

e.g. how does this work with striped devices? e.g. we have a stripe
unit of 16kB, but the devices support atomic_write_unit_max = 32kB.
Instantly, we have a configuration where atomic writes need to be
split at 16kB boundaries, and so the maximum atomic write size that
can be supported is actually 16kB - the stripe unit of RAID device.

This means the filesystem must, at minimum, align all allocations
for atomic IO to 16kB stripe unit alignment, and must not allow
atomic IOs that are not stripe unit aligned or sized to proceed
because they can't be processed as an atomic IO....


> > >   /**
> > > @@ -183,6 +186,59 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
> > >   }
> > >   EXPORT_SYMBOL(blk_queue_max_discard_sectors);
> > > +/**
> > > + * blk_queue_atomic_write_max_bytes - set max bytes supported by
> > > + * the device for atomic write operations.
> > > + * @q:  the request queue for the device
> > > + * @size: maximum bytes supported
> > > + */
> > > +void blk_queue_atomic_write_max_bytes(struct request_queue *q,
> > > +				      unsigned int size)
> > > +{
> > > +	q->limits.atomic_write_max_bytes = size;
> > > +}
> > > +EXPORT_SYMBOL(blk_queue_atomic_write_max_bytes);
> > > +
> > > +/**
> > > + * blk_queue_atomic_write_boundary - Device's logical block address space
> > > + * which an atomic write should not cross.
> > 
> > I have no idea what "logical block address space which an atomic
> > write should not cross" means, especially as the unit is in bytes
> > and not in sectors (which are the units LBAs are expressed in).
> 
> It means that an atomic operation which straddles the atomic boundary is not
> guaranteed to be atomic by the device, so we should (must) not cross it to
> maintain atomic behaviour for an application block. That's one reason that
> we have all these size and alignment rules.

Yes, That much is obvious. What I have no idea diea about is what
this means in practice. When is this ever going to be non-zero, and
what should be we doing at the filesystem allocation level when it
is non-zero to ensure that allocations for atomic writes never cross
such a boundary. i.e. how do we prevent applications from ever
needing this functionality to be triggered? i.e. so the filesystem
can guarantee a single RWF_ATOMIC user IO is actually dispatched
as a single REQ_ATOMIC IO....

> ...
> 
> > > +static inline unsigned int queue_atomic_write_unit_max(const struct request_queue *q)
> > > +{
> > > +	return q->limits.atomic_write_unit_max << SECTOR_SHIFT;
> > > +}
> > > +
> > > +static inline unsigned int queue_atomic_write_unit_min(const struct request_queue *q)
> > > +{
> > > +	return q->limits.atomic_write_unit_min << SECTOR_SHIFT;
> > > +}
> > 
> > Ah, what? This undocumented interface reports "unit limits" in
> > bytes, but it's not using the physical device sector size to convert
> > between sector units and bytes. This really needs some more
> > documentation and work to make it present all units consistently and
> > not result in confusion when devices have 4kB sector sizes and not
> > 512 byte sectors...
> 
> ok, we'll look to fix this up to give a coherent and clear interface.
> 
> > 
> > Also, I think all the byte ranges should support full 64 bit values,
> > otherwise there will be silent overflows in converting 32 bit sector
> > counts to byte ranges. And, eventually, something will want to do
> > larger than 4GB atomic IOs
> > 
> 
> ok, we can do that but would also then make statx field 64b. I'm fine with
> that if it is wise to do so - I don't don't want to wastefully use up an
> extra 2 x 32b in struct statx.

Why do we need specific varibles for DIO atomic write alignment
limits? We already have direct IO alignment and size constraints in statx(),
so why wouldn't we just reuse those variables when the user requests
atomic limits for DIO?

i.e. if STATX_DIOALIGN is set, we return normal DIO alignment
constraints. If STATX_DIOALIGN_ATOMIC is set, we return the atomic
DIO alignment requirements in those variables.....

Yes, we probably need the dio max size to be added to statx for
this. Historically speaking, I wanted statx to support this in the
first place because that's what we were already giving userspace
with XFS_IOC_DIOINFO and we already knew that atomic IO when it came
along would require a bound maximum IO size much smaller than normal
DIO limits.  i.e.:

struct dioattr {
        __u32           d_mem;          /* data buffer memory alignment */
        __u32           d_miniosz;      /* min xfer size                */
        __u32           d_maxiosz;      /* max xfer size                */
};

where d_miniosz defined the alignment and size constraints for DIOs.

If we simply document that STATX_DIOALIGN_ATOMIC returns minimum
(unit) atomic IO size and alignment in statx->dio_offset_align (as
per STATX_DIOALIGN) and the maximum atomic IO size in
statx->dio_max_iosize, then we don't burn up anywhere near as much
space in the statx structure....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
