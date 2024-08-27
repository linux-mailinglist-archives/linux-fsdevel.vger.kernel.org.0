Return-Path: <linux-fsdevel+bounces-27380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A07A960F54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B481F2482B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A551C9458;
	Tue, 27 Aug 2024 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAZoXD6W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294B773466;
	Tue, 27 Aug 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770595; cv=none; b=Uc7srxfTBghQb6s7gcz4a+V+Kkhgf68wczYsiIRfo23wXX6GMVjpl3fvkmLbvZkjS9KFXs110Y0y17ocGVdF8Tw1OXE6OAHOzt4hSUJLJiNrUrH3SUl5G0H6zUplXOw51z3zm28gZdIY4QWaGHR7NsvsU1Pq/EA+c6Nj2v0vahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770595; c=relaxed/simple;
	bh=2O6IH8ai0xJ7us92Aem2/HZ6Jpz9GH7V9xoHtpmzGEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlZJoBnlyIwXSaLXm+JmTcBuw6V0Gdd6M8GL2KeRIxK4Y6xZw6vxpx4fbW9Ottq+zfSBtD7ZbP7flvewL6bTd2kRVUTUU6CWPwwfy5GRA+Boedb8XWv86TgrqJU1PB/ROIPaD1HENruY1okeMjONVVdEC65dWXaTcmEX7eMhD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAZoXD6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DB9C4FE01;
	Tue, 27 Aug 2024 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724770594;
	bh=2O6IH8ai0xJ7us92Aem2/HZ6Jpz9GH7V9xoHtpmzGEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qAZoXD6W5UU42yk87YRqWYj4iX/GVCvhmZQBrlmOTkyyaOXowWDLsfiVVa9YrwK2e
	 mDPdFsHaPgF+gglv68M2JFWcQCDVETsXIvN6fUYUAOZtdBLwAOcls2LcAtFjZY/HtJ
	 wEQW8S5GfzpXwlicUSyqPtW96VuSpZNHNN8oZ7FzM4sdY3sD64QD4xE9RUIQhNlbzE
	 vqL+qToo3AQrilG+DZRrHA2f9Xp67kX0o4doH3pbfFdZl31SioH+T9+rQ2Y5hzBbxE
	 dCL1XFRtmZWbDMi+UKNavsjwBYC574pO2OntgYr2zcy/FsIPsbd8kIYdX/TFux1FD/
	 D7J0/U2cBFhLg==
Date: Tue, 27 Aug 2024 07:56:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/6] ext4: remove tracing for FALLOC_FL_NO_HIDE_STALE
Message-ID: <20240827145634.GR865349@frogsfrogsfrogs>
References: <20240827065123.1762168-1-hch@lst.de>
 <20240827065123.1762168-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827065123.1762168-3-hch@lst.de>

On Tue, Aug 27, 2024 at 08:50:46AM +0200, Christoph Hellwig wrote:
> FALLOC_FL_NO_HIDE_STALE can't make it past vfs_fallocate (and if the
> flag does what the name implies that's a good thing as it would be
> highly dangerous).  Remove the dead tracing code for it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/trace/events/ext4.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index cc5e9b7b2b44e7..156908641e68f1 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -91,7 +91,6 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
>  #define show_falloc_mode(mode) __print_flags(mode, "|",		\
>  	{ FALLOC_FL_KEEP_SIZE,		"KEEP_SIZE"},		\
>  	{ FALLOC_FL_PUNCH_HOLE,		"PUNCH_HOLE"},		\
> -	{ FALLOC_FL_NO_HIDE_STALE,	"NO_HIDE_STALE"},	\

If we're going to drop this flag that has never been accepted by any of
the fallocate implementations, then can we remove it from the uapi?

--D

>  	{ FALLOC_FL_COLLAPSE_RANGE,	"COLLAPSE_RANGE"},	\
>  	{ FALLOC_FL_ZERO_RANGE,		"ZERO_RANGE"})
>  
> -- 
> 2.43.0
> 
> 

