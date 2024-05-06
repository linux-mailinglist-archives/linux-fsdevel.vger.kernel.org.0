Return-Path: <linux-fsdevel+bounces-18866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7B88BD824
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 01:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01311C21894
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 23:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA0C15D5DB;
	Mon,  6 May 2024 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="3FD5U7Cb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CCC15D5C7
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715037590; cv=none; b=r4uHq32sWI1DcGRqPIKdGEgtJR/6rkZuxuaZetaKivDsdhJoYZDFgNSyop8I/7z1xriuBqdrUqCuB6Mf2CkVbvMJu1PQci7TUpmS9vPFSZ9TcCK8WXdxOSJlQbi8Uq2XpMwN3QEf4L3cLT0XCCX3G0Wx2Sb1oJ0rXGhM3wKV6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715037590; c=relaxed/simple;
	bh=UlWB0PiVSaH0032zuWaMnJnFtUn4gBJA/x7Nb2BvVA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsBqgKXDndatdiBZOKyJN1iuqtDPqwROl12LAAMAxXrWVoKjaZVpeR+NgeikVaHqHxSuMTMkT6jOdClMbXtvgDGicqBqZELqIAjMbtEGAEccVROuaHmjMfBfxdGSSX8h4LECHQDJ4fTO0lO4A95MzMZWKLVF9MVd0imuDcyk6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=3FD5U7Cb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e65a1370b7so22854385ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2024 16:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1715037588; x=1715642388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JfmNU7T7Zux55fuk0/ynp0mrkZlbfnBJFtPeSgTSd88=;
        b=3FD5U7CbJLQePT0BVWtbdUWUvNlloshl2hpcD7m8GUCOz/x3Ie0qubI88eKXWyi3tN
         xVKrt4PGH8AFFza0HFc0Etym+7KyuREUD42JdQ+0HeuQKqG79jQ0q5U7j7GNxIn/6qpf
         Ty2OSULrRXd1/gk6aFzdSOy7o6TRyRpXOpVvMyoIv5L2Kdm0CpQKsObv8e8VbQ4B2AEo
         MRB/ME6Xw0bz+bZ5DFTAMoQlJ6MG6Ccn+LHLQE4S1/bklb8OXhmq+HOe4bsc0TtNbmQp
         /DqOPMHMDaL5xZurWAlriSsnOGG1FDncVpcJWErtU+Af7jLuq9604TxCW/7smTBG9rnh
         oGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715037588; x=1715642388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfmNU7T7Zux55fuk0/ynp0mrkZlbfnBJFtPeSgTSd88=;
        b=ZFOKI98bCmev/UJUJ0hPdZGwdv2Xi4DT3SXTouKOl+OTq54KaGersANLxtvqJ4UoqG
         cImMRNas8MJADG3LJXSeT+DVzzWGXeZqmCSwYT+KikdTc+XB+XSDs1NfPQBGIp2RLTf5
         fVkJ7m4gpcK07llF3bjZI8W+sqwxnr5k1bpU0T64xGuRe18BkwANHPFlyvPJgHVZOz3B
         NjpiFy+NTlH8iLKu6FjA1LRMVRpB/sXnz51ddMpMCBulibYXLfwdH5HizQ1QiZilizDo
         9RKd7G+CivDRDCHgdLmpAxcuoIUGisub6FoNKvLL0DIIEQ7wLOVV2xbX6OwdlJkKUfz3
         0s6w==
X-Forwarded-Encrypted: i=1; AJvYcCUDN6ldeY0rrTRPqCyUjz4gvcvWz76VKroRhvFvVLyxvqEZhEy7o/lKNRPB5KK0cZF2oLa9ug56tRIvnuiO5YaVMH12NGXZWHQNKEmdFQ==
X-Gm-Message-State: AOJu0YyRduInie5BlCvmbqanzT6b3C9Doipyowe5KeWIRa0BU1DGCmAA
	019Jtljyv3FMKbJvGt2yJPRcbRdPmSm2nXkX1lR1yvDTj3uLBjhElxViCSMenC0=
X-Google-Smtp-Source: AGHT+IGTdCbkJ6dCeXIlEqW0jHcIBzUUTSQchp3eoxUw0itjwcXxpPE+rnXs+G996BJVeTg/0lgcEQ==
X-Received: by 2002:a17:902:ecc7:b0:1eb:dae:bdab with SMTP id a7-20020a170902ecc700b001eb0daebdabmr16603631plh.46.1715037587536;
        Mon, 06 May 2024 16:19:47 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090332cc00b001ecd2c44ae0sm8800306plr.4.2024.05.06.16.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 16:19:47 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s47cW-0064gO-0e;
	Tue, 07 May 2024 09:19:44 +1000
Date: Tue, 7 May 2024 09:19:44 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, willy@infradead.org,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v4 24/34] ext4: implement buffered write iomap path
Message-ID: <ZjllkHuyOedA/Tzg@dread.disaster.area>
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
 <20240410142948.2817554-25-yi.zhang@huaweicloud.com>
 <ZjH5Ia+dWGss5Duv@dread.disaster.area>
 <ZjH+QFVXLlcDkSdh@dread.disaster.area>
 <96bbdb25-b420-67b1-d4c4-b838a5c70f9f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96bbdb25-b420-67b1-d4c4-b838a5c70f9f@huaweicloud.com>

On Mon, May 06, 2024 at 07:44:44PM +0800, Zhang Yi wrote:
> On 2024/5/1 16:33, Dave Chinner wrote:
> > On Wed, May 01, 2024 at 06:11:13PM +1000, Dave Chinner wrote:
> >> On Wed, Apr 10, 2024 at 10:29:38PM +0800, Zhang Yi wrote:
> >>> From: Zhang Yi <yi.zhang@huawei.com>
> >>>
> >>> Implement buffered write iomap path, use ext4_da_map_blocks() to map
> >>> delalloc extents and add ext4_iomap_get_blocks() to allocate blocks if
> >>> delalloc is disabled or free space is about to run out.
> >>>
> >>> Note that we always allocate unwritten extents for new blocks in the
> >>> iomap write path, this means that the allocation type is no longer
> >>> controlled by the dioread_nolock mount option. After that, we could
> >>> postpone the i_disksize updating to the writeback path, and drop journal
> >>> handle in the buffered dealloc write path completely.
> > .....
> >>> +/*
> >>> + * Drop the staled delayed allocation range from the write failure,
> >>> + * including both start and end blocks. If not, we could leave a range
> >>> + * of delayed extents covered by a clean folio, it could lead to
> >>> + * inaccurate space reservation.
> >>> + */
> >>> +static int ext4_iomap_punch_delalloc(struct inode *inode, loff_t offset,
> >>> +				     loff_t length)
> >>> +{
> >>> +	ext4_es_remove_extent(inode, offset >> inode->i_blkbits,
> >>> +			DIV_ROUND_UP_ULL(length, EXT4_BLOCK_SIZE(inode->i_sb)));
> >>>  	return 0;
> >>>  }
> >>>  
> >>> +static int ext4_iomap_buffered_write_end(struct inode *inode, loff_t offset,
> >>> +					 loff_t length, ssize_t written,
> >>> +					 unsigned int flags,
> >>> +					 struct iomap *iomap)
> >>> +{
> >>> +	handle_t *handle;
> >>> +	loff_t end;
> >>> +	int ret = 0, ret2;
> >>> +
> >>> +	/* delalloc */
> >>> +	if (iomap->flags & IOMAP_F_EXT4_DELALLOC) {
> >>> +		ret = iomap_file_buffered_write_punch_delalloc(inode, iomap,
> >>> +			offset, length, written, ext4_iomap_punch_delalloc);
> >>> +		if (ret)
> >>> +			ext4_warning(inode->i_sb,
> >>> +			     "Failed to clean up delalloc for inode %lu, %d",
> >>> +			     inode->i_ino, ret);
> >>> +		return ret;
> >>> +	}
> >>
> >> Why are you creating a delalloc extent for the write operation and
> >> then immediately deleting it from the extent tree once the write
> >> operation is done?
> > 
> > Ignore this, I mixed up the ext4_iomap_punch_delalloc() code
> > directly above with iomap_file_buffered_write_punch_delalloc().
> > 
> > In hindsight, iomap_file_buffered_write_punch_delalloc() is poorly
> > named, as it is handling a short write situation which requires
> > newly allocated delalloc blocks to be punched.
> > iomap_file_buffered_write_finish() would probably be a better name
> > for it....
> > 
> >> Also, why do you need IOMAP_F_EXT4_DELALLOC? Isn't a delalloc iomap
> >> set up with iomap->type = IOMAP_DELALLOC? Why can't that be used?
> > 
> > But this still stands - the first thing
> > iomap_file_buffered_write_punch_delalloc() is:
> > 
> > 	if (iomap->type != IOMAP_DELALLOC)
> >                 return 0;
> > 
> 
> Thanks for the suggestion, the delalloc and non-delalloc write paths
> share the same ->iomap_end() now (i.e. ext4_iomap_buffered_write_end()),
> I use the IOMAP_F_EXT4_DELALLOC to identify the write path.

Again, you don't need that. iomap tracks newly allocated
IOMAP_DELALLOC extents via the IOMAP_F_NEW flag that should be
getting set in the ->iomap_begin() call when it creates a new
delalloc extent.

Please look at the second check in
iomap_file_buffered_write_punch_delalloc():

	if (iomap->type != IOMAP_DELALLOC)
                return 0;

        /* If we didn't reserve the blocks, we're not allowed to punch them. */
        if (!(iomap->flags & IOMAP_F_NEW))
                return 0;

> For
> non-delalloc path, If we have allocated more blocks and copied less, we
> should truncate extra blocks that newly allocated by ->iomap_begin().

Why? If they were allocated as unwritten, then you can just leave
them there as unwritten extents, same as XFS. Keep in mind that if
we get a short write, it is extremely likely the application is
going to rewrite the remaining data immediately, so if we allocated
blocks they are likely to still be needed, anyway....

> If we use IOMAP_DELALLOC, we can't tell if the blocks are
> pre-existing or newly allocated, we can't truncate the
> pre-existing blocks, so I have to introduce IOMAP_F_EXT4_DELALLOC.
> But if we split the delalloc and non-delalloc handler, we could
> drop IOMAP_F_EXT4_DELALLOC.

As per above: IOMAP_F_NEW tells us -exactly- this.

IOMAP_F_NEW should be set on any newly allocated block - delalloc or
real - because that's the flag that tells the iomap infrastructure
whether zero-around is needed for partial block writes. If ext4 is
not setting this flag on delalloc regions allocated by
->iomap_begin(), then that's a serious bug.

> I also checked xfs, IIUC, xfs doesn't free the extra blocks beyond EOF
> in xfs_buffered_write_iomap_end() for non-delalloc case since they will
> be freed by xfs_free_eofblocks in some other inactive paths, like
> xfs_release()/xfs_inactive()/..., is that right?

XFS doesn't care about real blocks beyond EOF existing -
xfs_free_eofblocks() is an optimistic operation that does not
guarantee that it will remove blocks beyond EOF. Similarly, we don't
care about real blocks within EOF because we alway allocate data
extents as unwritten, so we don't have any stale data exposure
issues to worry about on short writes leaving allocated blocks
behind.

OTOH, delalloc extents without dirty page cache pages over them
cannot be allowed to exist. Without dirty pages, there is no trigger
to convert those to real extents (i.e. nothing to write back). Hence
the only sane thing that can be done with them on a write error or
short write is remove them in the context where they were created.

This is the only reason that the
iomap_file_buffered_write_punch_delalloc() exists - it abstracts
this nasty corner case away from filesystems that support delalloc
so they don't have to worry about getting this right. That's whole
point of having delalloc aware infrastructure - individual
filesysetms don't need to handle all these weird corner cases
themselves because the infrastructure takes care of them...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

