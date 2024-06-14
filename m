Return-Path: <linux-fsdevel+bounces-21714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBC8908F01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 17:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F209E1F283A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ADC15FD08;
	Fri, 14 Jun 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zz54J5am"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47912249FF;
	Fri, 14 Jun 2024 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379600; cv=none; b=twHPmBzJ62RTkE4g8fyPoQLgud/QBUGLYEG3EMXAnr4blLN72Z1+ROvoxwlTTM10nGuT/DrY0ugYyGNuR3znRhKxPB5UPm2plWfxEuhkbC1D20oUO6JvV/y3A7YpoTqmgnRlK4WTZ/QkZ1st2Ag9KkvqklUEJOe2HB+PrCIFTvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379600; c=relaxed/simple;
	bh=J8becv94rthSN2o1eKczQsPquyHD2GaCKXcILs95l9U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=CAYrbZom2DakZdbRpuyD4tyo3ggN0VwIqhwfXz9k9Myh/TefMPMd6CuzU5POue6mvhwJIOldm0zNcgjNGd6KSFswidtEpM2nH7sr7OlXcM53sYddbfY0UvXQkFOnqIFwDDAMDq/t1A0KZ0WNLhX9jfq7nGlMek+UQRuVLGNfH7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zz54J5am; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7042882e741so1950742b3a.2;
        Fri, 14 Jun 2024 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718379598; x=1718984398; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s+66Mw/kLNmlvY+IjdDc0YxJ6wM9FVJbAeqEKIaXtcc=;
        b=Zz54J5am0V1fAQtNP9ZsaO4XfWKZrzOEO3a7mpvTBcS44zpd1V0KE+xMUblEhhgatY
         ssFihoYP8stMZgTtKn6EeJO0TGEA0bpNO5MXckfI4ILEEfQG2/5zOEsgLX4vzoqY/UlL
         HKbHUzVVqHTfPeRZvXIBNbtoMyVVnP/HIXljMvqHT/BqQ5Pm3t/0hf3NZ/SO0cAuCH96
         2F1UlWrkVqNJ8lfoNglN92rbuEY5xPrjSryi8CXeP4Sn+xghvFzAyxIjbWA11tJp0fFm
         6sxKrQc9LUhYsXCl/qYdHTeR2H2Ii6ROPsHq96IqE5Yk4fgGkVN/T3mIfjnE21hC/o/j
         cXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718379598; x=1718984398;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+66Mw/kLNmlvY+IjdDc0YxJ6wM9FVJbAeqEKIaXtcc=;
        b=C0FC7SgH4wfgrnUhf7Hgb7xvNn5FuGvs+p4uAY7f1M1fa8OUiQvoljWEZbkd4sFnNh
         2AL6shwZvPDQx5IGzvewLYP31t0AL/+jt3uzUFOY7P62/lc0d9oaPQkLwtLe8aMkSgn3
         evxzE4LfFAokgij3Ot++Z4rygY/xc9yQJwpPRHi5Sz6QoH1Bd89rZgs4Tb4KOu21FIAV
         COCpVOPf+OdpgyK06/Q3QYv7peKQOG8JJxIVA0gMXBtqSRLjWkV9PEDR5dOb6wazaLcD
         xVyvQzRPvJxeWDUkijcAqiXoRxyzSyHbIFcGos9wjae7ITsRbfl1hjvSc+8k1FlupdBS
         qGLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhzJ/7+FOvS8+NkB1knXuXdUY7ujT3ASsdRWQFrDGbAdhf/7GtEElUPV8y70BOZ5WvbJnGsWFXLckrVbqjjPSTt5NBSB2uy78pgusJK0y+/8kDtenaS3tniLmTzCNIVWB1hZuyrsfhaA==
X-Gm-Message-State: AOJu0YxxW+xAf6qY5SVZoKPSxkkkFZZ9a6yhDdWmOTigijv1ay1UH2bw
	8yBDmH6TePvlu2Rj3uew85ioQit36dKCjzRCC/BH7ZBLsOdaeUQP
X-Google-Smtp-Source: AGHT+IFrqPoRqRGhrR3oB7e/qQ8LQ7u70acC/2LmZkt5D1Vtapng79N9un0fWTyP3uORikbv0VW4Zw==
X-Received: by 2002:a05:6a20:748d:b0:1b6:d9fa:8c9 with SMTP id adf61e73a8af0-1bae7ec72f6mr3764832637.23.1718379598438;
        Fri, 14 Jun 2024 08:39:58 -0700 (PDT)
Received: from dw-tp ([171.76.81.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e56199sm33642215ad.6.2024.06.14.08.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 08:39:57 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] Documentation: document the design of iomap and how to port
In-Reply-To: <20240608001707.GD52973@frogsfrogsfrogs>
Date: Fri, 14 Jun 2024 20:31:55 +0530
Message-ID: <87msnny3do.fsf@gmail.com>
References: <20240608001707.GD52973@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


> +SEEK_DATA
> +---------
> +
> +The ``iomap_seek_data`` function implements the SEEK_DATA "whence" value
> +for llseek.
> +``IOMAP_REPORT`` will be passed as the ``flags`` argument to
> +``->iomap_begin``.
> +
> +For unwritten mappings, the pagecache will be searched.
> +Regions of the pagecache with a folio mapped and uptodate fsblocks
> +within those folios will be reported as data areas.
> +
> +Callers commonly hold ``i_rwsem`` in shared mode.
> +
> +SEEK_HOLE
> +---------
> +
> +The ``iomap_seek_hole`` function implements the SEEK_HOLE "whence" value
> +for llseek.
> +``IOMAP_REPORT`` will be passed as the ``flags`` argument to
> +``->iomap_begin``.
> +
> +For unwritten mappings, the pagecache will be searched.
> +Regions of the pagecache with no folio mapped, or a !uptodate fsblock
> +within a folio will be reported as sparse hole areas.
> +
> +Callers commonly hold ``i_rwsem`` in shared mode.
> +
> +Swap File Activation
> +--------------------
> +
> +The ``iomap_swapfile_activate`` function finds all the base-page aligned
> +regions in a file and sets them up as swap space.
> +The file will be ``fsync()``'d before activation.
> +``IOMAP_REPORT`` will be passed as the ``flags`` argument to
> +``->iomap_begin``.
> +All mappings must be mapped or unwritten; cannot be dirty or shared, and
> +cannot span multiple block devices.
> +Callers must hold ``i_rwsem`` in exclusive mode; this is already
> +provided by ``swapon``.
> +
> +Extent Map Reporting (FS_IOC_FIEMAP)
> +------------------------------------
> +
> +The ``iomap_fiemap`` function exports file extent mappings to userspace
> +in the format specified by the ``FS_IOC_FIEMAP`` ioctl.
> +``IOMAP_REPORT`` will be passed as the ``flags`` argument to
> +``->iomap_begin``.
> +Callers commonly hold ``i_rwsem`` in shared mode.
> +
> +Block Map Reporting (FIBMAP)
> +----------------------------
> +
> +``iomap_bmap`` implements FIBMAP.
> +The calling conventions are the same as for FIEMAP.
> +This function is only provided to maintain compatibility for filesystems
> +that implemented FIBMAP prior to conversion.
> +This ioctl is deprecated; do not add a FIBMAP implementation to
> +filesystems that do not have it.
> +Callers should probably hold ``i_rwsem`` in shared mode, but this is
> +unclear.

looking at fiemap callers is also confusing w.r.t i_rwsem ;)

> +
> +Porting Guide
> +=============
> +
> +Why Convert to iomap?
> +---------------------
> +
> +There are several reasons to convert a filesystem to iomap:
> +
> + 1. The classic Linux I/O path is not terribly efficient.
> +    Pagecache operations lock a single base page at a time and then call
> +    into the filesystem to return a mapping for only that page.
> +    Direct I/O operations build I/O requests a single file block at a
> +    time.
> +    This worked well enough for direct/indirect-mapped filesystems such
> +    as ext2, but is very inefficient for extent-based filesystems such
> +    as XFS.
> +
> + 2. Large folios are only supported via iomap; there are no plans to
> +    convert the old buffer_head path to use them.
> +
> + 3. Direct access to storage on memory-like devices (fsdax) is only
> +    supported via iomap.
> +
> + 4. Lower maintenance overhead for individual filesystem maintainers.
> +    iomap handles common pagecache related operations itself, such as
> +    allocating, instantiating, locking, and unlocking of folios.
> +    No ->write_begin(), ->write_end() or direct_IO
> +    address_space_operations are required to be implemented by
> +    filesystem using iomap.
> +
> +How to Convert to iomap?
> +------------------------
> +
> +First, add ``#include <linux/iomap.h>`` from your source code and add
> +``select FS_IOMAP`` to your filesystem's Kconfig option.
> +Build the kernel, run fstests with the ``-g all`` option across a wide
> +variety of your filesystem's supported configurations to build a
> +baseline of which tests pass and which ones fail.
> +
> +The recommended approach is first to implement ``->iomap_begin`` (and
> +``->iomap->end`` if necessary) to allow iomap to obtain a read-only

small correction: ``->iomap_end``

> +mapping of a file range.
> +In most cases, this is a relatively trivial conversion of the existing
> +``get_block()`` function for read-only mappings.
> +``FS_IOC_FIEMAP`` is a good first target because it is trivial to
> +implement support for it and then to determine that the extent map
> +iteration is correct from userspace.
> +If FIEMAP is returning the correct information, it's a good sign that
> +other read-only mapping operations will do the right thing.
> +
> +Next, modify the filesystem's ``get_block(create = false)``
> +implementation to use the new ``->iomap_begin`` implementation to map
> +file space for selected read operations.
> +Hide behind a debugging knob the ability to switch on the iomap mapping
> +functions for selected call paths.
> +It is necessary to write some code to fill out the bufferhead-based
> +mapping information from the ``iomap`` structure, but the new functions
> +can be tested without needing to implement any iomap APIs.
> +
> +Once the read-only functions are working like this, convert each high
> +level file operation one by one to use iomap native APIs instead of
> +going through ``get_block()``.
> +Done one at a time, regressions should be self evident.
> +You *do* have a regression test baseline for fstests, right?
> +It is suggested to convert swap file activation, ``SEEK_DATA``, and
> +``SEEK_HOLE`` before tackling the I/O paths.
> +A likely complexity at this point will be converting the buffered read
> +I/O path because of bufferheads.
> +The buffered read I/O paths doesn't need to be converted yet, though the
> +direct I/O read path should be converted in this phase.
> +
> +At this point, you should look over your ``->iomap_begin`` function.
> +If it switches between large blocks of code based on dispatching of the
> +``flags`` argument, you should consider breaking it up into
> +per-operation iomap ops with smaller, more cohesive functions.
> +XFS is a good example of this.
> +
> +The next thing to do is implement ``get_blocks(create == true)``
> +functionality in the ``->iomap_begin``/``->iomap_end`` methods.
> +It is strongly recommended to create separate mapping functions and
> +iomap ops for write operations.
> +Then convert the direct I/O write path to iomap, and start running fsx
> +w/ DIO enabled in earnest on filesystem.
> +This will flush out lots of data integrity corner case bugs that the new
> +write mapping implementation introduces.
> +
> +Now, convert any remaining file operations to call the iomap functions.
> +This will get the entire filesystem using the new mapping functions, and
> +they should largely be debugged and working correctly after this step.
> +
> +Most likely at this point, the buffered read and write paths will still
> +to be converted.
> +The mapping functions should all work correctly, so all that needs to be
> +done is rewriting all the code that interfaces with bufferheads to
> +interface with iomap and folios.
> +It is much easier first to get regular file I/O (without any fancy
> +features like fscrypt, fsverity, compression, or data=journaling)
> +converted to use iomap.
> +Some of those fancy features (fscrypt and compression) aren't
> +implemented yet in iomap.
> +For unjournalled filesystems that use the pagecache for symbolic links
> +and directories, you might also try converting their handling to iomap.
> +
> +The rest is left as an exercise for the reader, as it will be different
> +for every filesystem.
> +If you encounter problems, email the people and lists in
> +``get_maintainers.pl`` for help.
> +
> +Bugs and Limitations
> +====================
> +
> + * No support for fscrypt.
> + * No support for compression.
> + * No support for fsverity yet.
> + * Strong assumptions that IO should work the way it does on XFS.
> + * Does iomap *actually* work for non-regular file data?
> +
> +Patches welcome!
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8754ac2c259d..2ddd94d43ecf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8483,6 +8483,7 @@ R:	Darrick J. Wong <djwong@kernel.org>
>  L:	linux-xfs@vger.kernel.org
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Supported
> +F:	Documentation/filesystems/iomap.txt
>  F:	fs/iomap/
>  F:	include/linux/iomap.h
>  

Rest looks good to me.

-ritesh

