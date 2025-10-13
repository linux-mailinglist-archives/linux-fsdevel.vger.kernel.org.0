Return-Path: <linux-fsdevel+bounces-63938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 065F0BD22EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D79454EDBAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 08:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A125E2FB964;
	Mon, 13 Oct 2025 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h3LaqdNR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788AB22157B;
	Mon, 13 Oct 2025 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345963; cv=none; b=Z1sgO8RyEdajwvfvbQzNKebQtQisJ+mAvoih0zQ8G7rANvpr5EYO6L8k+Ega9ihbQZ2LwMbl1yJURS+Pn0QQPQITRzf/DzVEthH2m6+m1LOVCc61z8tKCoNgL8BQgvfVuRgM50eGCgbFLCJKTMuwVUtY9koa2Fqw/o/z6hf0bt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345963; c=relaxed/simple;
	bh=EXvJRkz0VSwDTyo3GX8GBzx1dSMrLhm3KkeVbCu6644=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1TcnuwrrGMjNiI/PhpY9nMEb87QudbrihmDBUH9jENXRo9/LhVnQBB0qO6p92roURWrei7tIFy25QsZiH7hRA3bqfF7jGAf/QRBTZl/rwCA+m7JcsLxuhS72x4/CkhxGH/nHIUzlNVhAslYGcV3OCLeDBTNwFWIo7yJiKs6XrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h3LaqdNR; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760345956; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gGIOd7Ex2m90KckglAwHsiXkn+YFnTKWdf60l+zhCdc=;
	b=h3LaqdNRHndzkRMufqmKcgJ7nMw9gmr2DxCZkxLSn3tWuuMOUs5UOAOrxr7OSasAqIqROY4s+gg5v27gKZvRZjfwJPoEox0HTVXN/EeCGzzliOwlBrqVy3lSbuTOloh2RYeLZSiQMEQHDszJQlShZYIONDMhzIq8OPMurstPjV4=
Received: from 30.221.129.221(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Wq2ERPx_1760345954 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Oct 2025 16:59:15 +0800
Message-ID: <9b8abc79-8605-4c13-9d9f-972f90418cd2@linux.alibaba.com>
Date: Mon, 13 Oct 2025 16:59:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] ocfs2: don't opencode filemap_fdatawrite_range in
 ocfs2_journal_submit_inode_data_buffers
To: Christoph Hellwig <hch@lst.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, v9fs@lists.linux.dev,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-4-hch@lst.de>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20251013025808.4111128-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/10/13 10:57, Christoph Hellwig wrote:
> Use filemap_fdatawrite_range instead of opencoding the logic using
> filemap_fdatawrite_wbc.  There is a slight change in the conversion
> as nr_to_write is now set to LONG_MAX instead of double the number
> of the pages in the range.  LONG_MAX is the usual nr_to_write for
> WB_SYNC_ALL writeback, and the value expected by lower layers here.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine to me.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/journal.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index e5f58ff2175f..85239807dec7 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -902,15 +902,8 @@ int ocfs2_journal_alloc(struct ocfs2_super *osb)
>  
>  static int ocfs2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
>  {
> -	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
> -	struct writeback_control wbc = {
> -		.sync_mode =  WB_SYNC_ALL,
> -		.nr_to_write = mapping->nrpages * 2,
> -		.range_start = jinode->i_dirty_start,
> -		.range_end = jinode->i_dirty_end,
> -	};
> -
> -	return filemap_fdatawrite_wbc(mapping, &wbc);
> +	return filemap_fdatawrite_range(jinode->i_vfs_inode->i_mapping,
> +			jinode->i_dirty_start, jinode->i_dirty_end);
>  }
>  
>  int ocfs2_journal_init(struct ocfs2_super *osb, int *dirty)


