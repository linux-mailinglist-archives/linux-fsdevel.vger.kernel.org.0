Return-Path: <linux-fsdevel+bounces-27637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A6C9631CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 22:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A108F1C21252
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 20:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196021AC89D;
	Wed, 28 Aug 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bUAqS/qx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875EE15666A
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877031; cv=none; b=CSULOmQ0wcpmavqoKO4jXM/Bjy+SOt3WA+9v5YkUplZLcwKz6tCadhU/F8umvCsD86+EU1BS2xOEKYgQfBF3fgnPPjPXvXA0MPljyBJucGFSPrdTBLlwKBrGD0z7Gz7eIe39x2KYLMxTNSfuLafPPu7b/dBmVnNjnlj79kGKu9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877031; c=relaxed/simple;
	bh=1q8h7W77tT7QwX67u1L1S5LQWRLHUPmrza4IiEQPmZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btY8G0D8IZnwquQ9JJmCp2yzekHQps0Z01MSw4MUBKi+tmbQ1vxluERzFDhacOc6gexJftYZtki65fjoPDPqG9ErCVrtAJrTVJ9+3cKMNgnEMDqajXeXbjueQTIpvkdGR5zRW304pq1ZW4eXWbUuc5CVQ9jTs6FzquxAy20DkkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=bUAqS/qx; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-709485aca4bso4822112a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724877028; x=1725481828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgG1mfxIpWvm4mgXjkzULET6ID0AunG3mljQyqT1QIk=;
        b=bUAqS/qxV24OTw6Ux+NlkmBmGm7zKi+Tqy/32rdbftvSIU448lrAkYvVphBHZmy1Wy
         UAyia5xT05kMgtO7o2VBS2Nx2uvQnM7blMyMWCz2T6tWP/4aRqgjVMZFJA5exNg2mysi
         6+W1x/yN7FIjiEaq7F7238stTQpe3hmdYKdTLs9YKQSkK+zNpJ7dp6SfVVorbejqHkcG
         uhaNe4+GLvufuZ44zengc8kIfP951P2edq1zmPI3yzn9kAOw8tH4VzZgG0BWP0uCRtPu
         Zl4Ekxpi0xDsPz5fICEKTSTLclCXG0jRp20fcfoiu+IrwAWPZgADUdc1wtayzQqkbse+
         SyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724877028; x=1725481828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgG1mfxIpWvm4mgXjkzULET6ID0AunG3mljQyqT1QIk=;
        b=TnmH1LsrsGhg88D5OZFz8BfMoPcaubq1PRX7aODqIpwOw9lcMG+rUqEbGqpJtHpHUY
         NcyOEvAa2NHEU1jC4b+CJCirDVUuAAG+Wd+8EtgAXt6HrrUHUmHLO6dQth1XmDlt4RQb
         XP+LS48rTI8Y3rfJAGTLkGqzWvLTt74SukkkcX8itRnu6uXyWuSNHg5pEhcrkkYabxKa
         mnt28PpX2GQjTfUGjgX3YsZOYHz7S70cDRlxaHcVvHmXpC1BAUYymBwyHEOOcdoAMjZN
         odKiX0bwd13CrZG1UMN54ohXhasVPYCu32aB/JHt1B8Ca39rvAcS7p1rO1rG2ys8K2Fy
         eMRw==
X-Gm-Message-State: AOJu0YxsgUm//MTgDaXBvUlTkcP92JE7QFEt69i9TFT61CgpNGwT+Qn/
	+sAXvkbk6FxLts1dD4d1WJNrH1EBuhNXrCTjJzCUX1g1ZTGNxL+A2f0PB2TgzsI=
X-Google-Smtp-Source: AGHT+IE1mDs13GfbH7wLqrsJMk5WaRt5JhfsqzuPKKcEoD46T4AuxK6HxHnrayDl7Q6/+TjFbzqqrw==
X-Received: by 2002:a05:6830:6d89:b0:709:2fa3:1337 with SMTP id 46e09a7af769-70f5c37cc6cmr1080596a34.14.1724877028508;
        Wed, 28 Aug 2024 13:30:28 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4568170504dsm78721cf.41.2024.08.28.13.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:30:27 -0700 (PDT)
Date: Wed, 28 Aug 2024 16:30:26 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>
Subject: Re: VFS caching of file extents
Message-ID: <20240828203026.GA2974106@perftesting>
References: <Zs97qHI-wA1a53Mm@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs97qHI-wA1a53Mm@casper.infradead.org>

On Wed, Aug 28, 2024 at 08:34:00PM +0100, Matthew Wilcox wrote:
> Today it is the responsibility of each filesystem to maintain the mapping
> from file logical addresses to disk blocks (*).  There are various ways
> to query that information, eg calling get_block() or using iomap.
> 
> What if we pull that information up into the VFS?  Filesystems obviously
> _control_ that information, so need to be able to invalidate entries.
> And we wouldn't want to store all extents in the VFS all the time, so
> would need to have a way to call into the filesystem to populate ranges
> of files.  We'd need to decide how to lock/protect that information
> -- a per-file lock?  A per-extent lock?  No locking, just a seqcount?
> We need a COW bit in the extent which tells the user that this extent
> is fine for reading through, but if there's a write to be done then the
> filesystem needs to be asked to create a new extent.
> 

At least for btrfs we store a lot of things in our extent map, so I'm not sure
if everybody wants to share the overhead of the amount of information we keep
cached in these entries.

We also protect all that with an extent lock, which again I'm not entirely sure
everybody wants to adopt our extent locking.  If we pushed the locking
responsibility into the file system then hooray, but that makes the generic
implementation more complex.

> There are a few problems I think this can solve.  One is efficient
> implementation of NFS READPLUS.  Another is the callback from iomap
> to the filesystem when doing buffered writeback.  A third is having a
> common implementation of FIEMAP.  I've heard rumours that FUSE would like
> something like this, and maybe there are other users that would crop up.
> 

For us we actually stopped using our in memory cache for FIEMAP because it ended
up being way slower and kind of a pain to work with all the different ways we'll
update the cache based on io happening.  Our FIEMAP implementation just reads
the extents on disk because it's easier/cleaner to just walk through the btree
than the cache.

> Anyway, this is as far as my thinking has got on this topic for now.
> Maybe there's a good idea here, maybe it's all a huge overengineered mess
> waiting to happen.  I'm sure other people know this area of filesystems
> better than I do.

Maybe it's fine for simpler file systems, and it could probably be argued that
btrfs is a bit over-engineered in this case, but I worry it'll turn into one of
those "this seemed like a good idea at the time, but after we added all the
features everybody needed we ended up with something way more complex"
scenarios.  Thanks,

Josef

