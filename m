Return-Path: <linux-fsdevel+bounces-75051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOHiOFs+cmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:12:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 573936878B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5327094C8A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 14:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5FE341AD8;
	Thu, 22 Jan 2026 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ilMlLs86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021903191D3;
	Thu, 22 Jan 2026 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090478; cv=none; b=LqAoXkxP3rfJszYxmMJHXBT/kabYV0cBWGI7GfPn2qxplMV+gUWKN017gRD3WcUwG0XwnhlypOVzZClEGs7zqFGlTo4U2g00qToIBGcK6aFuBQLbeIfOcTbO4g3uYyxYqv5rb960eIOla41Ef5K2OI9nnUTcXUXaBBxD4+Wnat4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090478; c=relaxed/simple;
	bh=Kz+7eHeJHzw9JHwQt10oVdR9TB/izJ5jbSwxzyCkaZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGiNHK8F0rzZn1cKjUW9OC+D+Z5T6YvTBgeIRC1vW7O9vM1GRMq04Tg2NZZ82A1sAPyZzGr3k9eOGjKIeFf+SjfUDyHOmViV/2jseL12AzkmtJVUNAi0WHdO5b4wF6im3KU/LLn5eODds+v5Tm+csR2GjQOdNrX9c2EwVuKN0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ilMlLs86; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769090471; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TvssjtYtiq5dAQbaQwGQ/5ZWXUGw/MpLR2p5AfsB+94=;
	b=ilMlLs86MJDYMxoGpdT7rj7a2XS5uaXCbFQW0w28nzYMaC6QHTtF4J4tSDljTH2Xh+5rfmiR8zAuIvIWDXR2Wf1z+3iSjW9Z3spZqIuW8fI3nNfoWTUm+wF7pun08wVVPeIYsRL+yzJUFxVIpwl6M7BZvH79Kaqj1/Etz1emdUQ=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wxca1-4_1769090469 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 22:01:10 +0800
Message-ID: <a59ef332-fc67-4890-94b1-9c3f2b37a9fa@linux.alibaba.com>
Date: Thu, 22 Jan 2026 22:01:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 06/10] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org
Cc: hch@lst.de, djwong@kernel.org, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260122133718.658056-1-lihongbo22@huawei.com>
 <20260122133718.658056-7-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260122133718.658056-7-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.96 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-75051-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 573936878B
X-Rspamd-Action: no action



On 2026/1/22 21:37, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Currently, reading files with different paths (or names) but the same
> content will consume multiple copies of the page cache, even if the
> content of these page caches is the same. For example, reading
> identical files (e.g., *.so files) from two different minor versions of
> container images will cost multiple copies of the same page cache,
> since different containers have different mount points. Therefore,
> sharing the page cache for files with the same content can save memory.
> 
> This introduces the page cache share feature in erofs. It allocate a
> shared inode and use its page cache as shared. Reads for files
> with identical content will ultimately be routed to the page cache of
> the shared inode. In this way, a single page cache satisfies
> multiple read requests for different files with the same contents.
> 
> We introduce new mount option `inode_share` to enable the page
> sharing mode during mounting. This option is used in conjunction
> with `domain_id` to share the page cache within the same trusted
> domain.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   Documentation/filesystems/erofs.rst |   5 +
>   fs/erofs/Makefile                   |   1 +
>   fs/erofs/inode.c                    |   1 -
>   fs/erofs/internal.h                 |  31 ++++++
>   fs/erofs/ishare.c                   | 167 ++++++++++++++++++++++++++++
>   fs/erofs/super.c                    |  62 ++++++++++-
>   fs/erofs/xattr.c                    |  34 ++++++
>   fs/erofs/xattr.h                    |   3 +
>   8 files changed, 301 insertions(+), 3 deletions(-)
>   create mode 100644 fs/erofs/ishare.c
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 40dbf3b6a35f..bfef8e87f299 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -129,7 +129,12 @@ fsid=%s                Specify a filesystem image ID for Fscache back-end.
>   domain_id=%s           Specify a trusted domain ID for fscache mode so that
>                          different images with the same blobs, identified by blob IDs,
>                          can share storage within the same trusted domain.
> +                       Also used for different filesystems with inode page sharing
> +                       enabled to share page cache within the trusted domain.
>   fsoffset=%llu          Specify block-aligned filesystem offset for the primary device.
> +inode_share            Enable inode page sharing for this filesystem.  Inodes with
> +                       identical content within the same domain ID can share the
> +                       page cache.
>   ===================    =========================================================
>   
>   Sysfs Entries
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 549abc424763..a80e1762b607 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
>   erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
> +erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += ishare.o
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 389632bb46c4..202cbbb4eada 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -203,7 +203,6 @@ static int erofs_read_inode(struct inode *inode)
>   
>   static int erofs_fill_inode(struct inode *inode)
>   {
> -	struct erofs_inode *vi = EROFS_I(inode);

Why this line is in this patch other than
"erofs: add erofs_inode_set_aops helper to set the aops[.]"

And there is an unneeded dot at the end of the subject.

Could you check the patches carefully before sending
out the next version?

Thanks,
Gao Xiang

