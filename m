Return-Path: <linux-fsdevel+bounces-74369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3803DD39E7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3537830133FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 06:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C34026E708;
	Mon, 19 Jan 2026 06:29:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BD026E175
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 06:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804183; cv=none; b=oQVENLR6odhx/RKxOO196nSgz5dohb9hTUW3zqNmUgDYftS4Od8eva/ftxBDWPZXcdR0pvvkhSZ5BqLWxXG+uaukNLP93IlXJVxgDhiA4Z9zbXK2migzrBog0SahvZUSh7ZZhlousdP4h0QON7W54SGbi7LtZtWRFXr0ln4+nWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804183; c=relaxed/simple;
	bh=sR8yNeP/IfT6cVqzsF+1DkSDqZUaSUQEyTdW13m0r0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgyECsvsn9uwS5UX6D2a5Ick8t9qdt1QCiYC3Gf+RW6TWl/XTTF8Ld320w9b410uZ54IgF4lkKaLWZKzGVYmy39esIZmwXAO3+ALTAZG0GCMpOjH8XkoTgYVtI9HCJY6UeRuTLGHFjMjOQwW0o1bx15p+CzITd0zleGTW/dEumg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.22.11.161])
	by smtp.qiye.163.com (Hmail) with ESMTP id 311cfcc20;
	Mon, 19 Jan 2026 14:24:26 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: joannelkoong@gmail.com
Cc: jefflexu@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu
Subject: Re: [PATCH v1 2/3] fuse: use offset_in_folio() for large folio offset calculations
Date: Mon, 19 Jan 2026 14:24:25 +0800
Message-ID: <20260119062425.1820-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116235606.2205801-3-joannelkoong@gmail.com>
References: <20260116235606.2205801-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bd4ed166503a2kunm3afe885d30e560
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQxkdVk5JTxpKGBhNTE5JTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VJSVVKSlVKTUpZV1kWGg8SFR0UWUFZS1VLVUtVS1kG

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


