Return-Path: <linux-fsdevel+bounces-74406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF94D3A195
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5705B30EBD95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F2F33CE8C;
	Mon, 19 Jan 2026 08:23:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30A33D4E3;
	Mon, 19 Jan 2026 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811016; cv=none; b=nXduCBpvS6wP1RDgU+ETRwDt4uyy1Rh1+kd2Agp4YQDZAWm4SBhWkj/JwKIYghhc5Dd8bBRQPuHPtv46sGPvZW9nmtxfvmIVySaAhBd3dqFi8aySUKo4+P/9hTCTe5Fd8AohFVQ/OT7jq3yt8TQhZv9RqU0ZddQut8+h/z7VQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811016; c=relaxed/simple;
	bh=sR8yNeP/IfT6cVqzsF+1DkSDqZUaSUQEyTdW13m0r0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aoirK9WPApPwURDv8rQS+I4PBHTZcAxKiwLH0We74WUFnvz938AwGUu6fNoAmvkjMogAMsqKR/RFX9V/Qeay0O/bfebxyKWtPs3klK6s8siVzdpk81QBDcsIDzZ8eqk9+8T9g90UoX7ijD18lhFltbURVK5Elc/kdHBJ97qReOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.22.11.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3121de02f;
	Mon, 19 Jan 2026 16:23:28 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] fuse: use offset_in_folio() for large folio offset calculations
Date: Mon, 19 Jan 2026 16:23:27 +0800
Message-ID: <20260119082327.2029-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bd55a10eb03a2kunm20b89206315479
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQh4aVhlKHh5KGUNCSxgfTVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VJSVVKSlVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0pVSktLVUtZBg
	++

On 1/17/26 7:56 AM, Joanne Koong wrote:
> Use offset_in_folio() instead of manually calculating the folio offset.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>   fs/fuse/dev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 698289b5539e..4dda4e24cc90 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1812,7 +1812,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>           if (IS_ERR(folio))
>               goto out_iput;
>   -        folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
> +        folio_offset = offset_in_folio(folio, outarg.offset);

offset is a loop variable, and later offset maybe set to 0. Replacing it
with outarg.offset here would change the behavior. The same below.
Will this cause any problems?

Thanks,
Chunsheng Luo

>           nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
>           nr_pages = DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
>   @@ -1916,7 +1916,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
>           if (IS_ERR(folio))
>               break;
>   -        folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
> +        folio_offset = offset_in_folio(folio, outarg->offset);
>           nr_bytes = min(folio_size(folio) - folio_offset, num);
>           nr_pages = DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
>   


