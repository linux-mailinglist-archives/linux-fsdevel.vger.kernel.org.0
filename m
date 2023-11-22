Return-Path: <linux-fsdevel+bounces-3472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 992A37F518F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F82B281592
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 20:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5EE54BE0;
	Wed, 22 Nov 2023 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGjin5zD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E051BD;
	Wed, 22 Nov 2023 12:25:38 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cf7a8ab047so1337015ad.1;
        Wed, 22 Nov 2023 12:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700684737; x=1701289537; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hzi/6nr8G3rFSkHQnNd7E57nhi4Dd5Gq1IEfsvXSnMY=;
        b=OGjin5zDyu7MbEUL3lvWSnSAsPKm+f2UZguvxYg9YnjDilLM3rDKvoRpT2FCBn0aJT
         P2sEe8lTX9dOaq0IN/TLRQ+3FfBTdX8SGBP1Dd2RVhzCni5WkAI3Dmk5rfd8wB2vbw7l
         X/fDCuUVbVtZg+bfPOI5IFeDgPWV1O5Fga5NJMUuje48/beEktxpVlOXSNLTO66EMA4N
         D5RC+cRKKJEgmIvED45xVzF3v4T/Ja4tQYxHnPvqArIOEArxuheoBPeVKRWKpGE6E/ay
         ul7zMzSDA0v3rSukOR98gEWl+t/HdY0i8jgd1+KbYWUFn4G1n9Ch0CrvW8HnCHTqaYH3
         Jyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700684737; x=1701289537;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzi/6nr8G3rFSkHQnNd7E57nhi4Dd5Gq1IEfsvXSnMY=;
        b=vpdB5J7mY4kxIivZLPgHuqkfe8TeF06HFh0wNC1fZ8OT3i4g2iZZQCqh0oXFkZHt26
         aHzL44yqbLrqsvASXVScsM/FF5+RfCiAyngCW3MFyYSEucrutyyNN1nXy6qpgDgx3m1o
         AEAik7yGbWw/sVKO7cziJEuYxgBIVOtcLCBHKA7r7rAr7PcnzQ1AEEAUtpE5RSHnh278
         aDP3rVt219WsdAaql9+WeVhauI2o3xAsPF3uaeXaiQYjgwElwlJNOzNC8aWDiZbb7yNG
         OVbY2PF69R18Hr9aCU01P+ikp/BNCyZD09h+Wznp/xBmf1JaGmOuOIIsyyltz1SAWzsC
         iKaw==
X-Gm-Message-State: AOJu0Yxtv0AEiEfn9TYVFhf5MOTlzsK1WJQz+2CXZVOtL4z+PAzoOVi3
	rWd2mdnyEYTAUylslXd5NHIyW6jxIPE=
X-Google-Smtp-Source: AGHT+IGZK7/rcOxH21viffOSIaWdySK067OXhrnWtIvcdQ5ZsN7BDo0OHpzbSoPRrMut8Aq+az+6Yw==
X-Received: by 2002:a17:903:124b:b0:1cf:5cf3:b180 with SMTP id u11-20020a170903124b00b001cf5cf3b180mr4388851plh.8.1700684737613;
        Wed, 22 Nov 2023 12:25:37 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id ij14-20020a170902ab4e00b001bdeedd8579sm83935plb.252.2023.11.22.12.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:25:36 -0800 (PST)
Date: Thu, 23 Nov 2023 01:55:27 +0530
Message-Id: <87pm01r0w8.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use iomap
In-Reply-To: <20231122122946.wg3jqvem6fkg3tgw@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Jan Kara <jack@suse.cz> writes:

> On Tue 21-11-23 00:35:20, Ritesh Harjani (IBM) wrote:
>> This patch converts ext2 regular file's buffered-io path to use iomap.
>> - buffered-io path using iomap_file_buffered_write
>> - DIO fallback to buffered-io now uses iomap_file_buffered_write
>> - writeback path now uses a new aops - ext2_file_aops
>> - truncate now uses iomap_truncate_page
>> - mmap path of ext2 continues to use generic_file_vm_ops
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
> Looks nice and simple. Just one comment below:
>
>> +static void ext2_file_readahead(struct readahead_control *rac)
>> +{
>> +	return iomap_readahead(rac, &ext2_iomap_ops);
>> +}
>
> As Matthew noted, the return of void here looks strange.
>

yes, I will fix it.

>> +static int ext2_write_map_blocks(struct iomap_writepage_ctx *wpc,
>> +				 struct inode *inode, loff_t offset)
>> +{
>> +	if (offset >= wpc->iomap.offset &&
>> +	    offset < wpc->iomap.offset + wpc->iomap.length)
>> +		return 0;
>> +
>> +	return ext2_iomap_begin(inode, offset, inode->i_sb->s_blocksize,
>> +				IOMAP_WRITE, &wpc->iomap, NULL);
>> +}
>
> So this will end up mapping blocks for writeback one block at a time if I'm
> understanding things right because ext2_iomap_begin() never sets extent
> larger than 'length' in the iomap result. Hence the wpc checking looks
> pointless (and actually dangerous - see below). So this will probably get
> more expensive than necessary by calling into ext2_get_blocks() for each
> block? Perhaps we could first call ext2_iomap_begin() for reading with high
> length to get as many mapped blocks as we can and if we find unmapped block
> (should happen only for writes through mmap), we resort to what you have
> here... Hum, but this will not work because of the races with truncate
> which could remove blocks whose mapping we have cached in wpc. We can
> safely provide a mapping under a folio only once it is locked or has
> writeback bit set. XFS plays the revalidation sequence counter games
> because of this so we'd have to do something similar for ext2. Not that I'd
> care as much about ext2 writeback performance but it should not be that
> hard and we'll definitely need some similar solution for ext4 anyway. Can
> you give that a try (as a followup "performance improvement" patch).
>

Yes, looking into ->map_blocks was on my todo list, since this RFC only
maps 1 block at a time which can be expensive. I missed adding that as a
comment in cover letter.

But also thanks for providing many details on the same. I am taking a
look at it and will get back with more details on how can we get this
working, as it will be anyway required for ext4 too.

-ritesh

