Return-Path: <linux-fsdevel+bounces-74652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANF6E9uAcGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:31:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B48B952D4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B088254C846
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EA843CEF8;
	Tue, 20 Jan 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XlrA2Uwd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBA83E9F73;
	Tue, 20 Jan 2026 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918782; cv=none; b=AkCut6r2KSGiUd0DCxyC6oq0hjyjvTd7puuGJDJbGkYtWjh4Jx4JlOetEYwu4RGLDej4h6XXPc6HbGTxir0jSIkQpfuKNjFZwPS08k6MtjudR4eYZ/KrYad+VLwfFfDS1UqcKW60hsuFSRBUQZANRlulieAselglTxSxX2Bc3cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918782; c=relaxed/simple;
	bh=CkoN3pJyVayyY7vGsoVsedSA34+68B/nNH30simPsgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzpaokmF7JoGQQHnBWKPesankt1K8ueCyD8XZEiQkRJSmz+jwnTr0NwpTr5gncapzASLO24lpJJaqFfLjBuzBGe02NuBciaug379saO3m3NjBicK+CBOOfAWSR3Y22LwXm1fkUM3i9gfRBjtvIgj2Rj7NTPLj4i2m8r5Tn97Cgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XlrA2Uwd; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768918770; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=t9XjF+Fp4ZzFE08s04Xje48JD6vfHmVMwLgm8p8DZjA=;
	b=XlrA2UwdVp5nkF/pVjGqVqzl5F6VpZ7zaH5c4EiWQnvOMM9rxqxubNiQ4pSx1ejiJ/3whrkDQrvhImA3AoHFay121K4UFHl+J39Yv1weVL5P9TOCVTfXjmgHd/x0WuFd+HqnlNHs9i0Yd/wVHZ5RXjZqVhgS945Qo/mfqh/zj0s=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxUjUbr_1768918768 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Jan 2026 22:19:29 +0800
Message-ID: <3ae9078a-ba5c-460d-89ea-8fdbdf190a10@linux.alibaba.com>
Date: Tue, 20 Jan 2026 22:19:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-6-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260116095550.627082-6-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-8.96 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lst.de,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-74652-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,alibaba.com:email,huawei.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: B48B952D4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/1/16 17:55, Hongbo Li wrote:
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
> deduplicated inode and use its page cache as shared. Reads for files
> with identical content will ultimately be routed to the page cache of
> the deduplicated inode. In this way, a single page cache satisfies
> multiple read requests for different files with the same contents.
> 
> We introduce inode_share mount option to enable the page sharing mode
> during mounting.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   Documentation/filesystems/erofs.rst |   5 +
>   fs/erofs/Makefile                   |   1 +
>   fs/erofs/inode.c                    |  24 +----
>   fs/erofs/internal.h                 |  57 ++++++++++
>   fs/erofs/ishare.c                   | 161 ++++++++++++++++++++++++++++
>   fs/erofs/super.c                    |  56 +++++++++-
>   fs/erofs/xattr.c                    |  34 ++++++
>   fs/erofs/xattr.h                    |   3 +
>   8 files changed, 316 insertions(+), 25 deletions(-)
>   create mode 100644 fs/erofs/ishare.c
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 08194f194b94..27d3caa3c73c 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -128,7 +128,12 @@ device=%s              Specify a path to an extra device to be used together.
>   fsid=%s                Specify a filesystem image ID for Fscache back-end.
>   domain_id=%s           Specify a domain ID in fscache mode so that different images
>                          with the same blobs under a given domain ID can share storage.
> +                       Also used for inode page sharing mode which defines a sharing
> +                       domain.

I think either the existing or the page cache sharing
here, `domain_id` should be protected as sensitive
information, so it'd be helpful to protect it as a
separate patch.

And change the description as below:
                            Specify a trusted domain ID for fscache mode so that
                            different images with the same blobs, identified by blob IDs,
                            can share storage within the same trusted domain.
                            Also used for different filesystems with inode page sharing
                            enabled to share page cache within the trusted domain.


>   fsoffset=%llu          Specify block-aligned filesystem offset for the primary device.
> +inode_share            Enable inode page sharing for this filesystem.  Inodes with
> +                       identical content within the same domain ID can share the
> +                       page cache.
>   ===================    =========================================================

...


>   	erofs_exit_shrinker();
> @@ -1062,6 +1111,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>   		seq_printf(seq, ",domain_id=%s", sbi->domain_id);

I think we shouldn't show `domain_id` to the userspace
entirely.

Also, let's use kfree_sentitive() and no_free_ptr() to
replace the following snippet:

          case Opt_domain_id:
                 kfree(sbi->domain_id); -> kfree_sentitive
                 sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
                      -> sbi->domain_id = no_free_ptr(param->string);
                 if (!sbi->domain_id)
                         return -ENOMEM;
                 break;

And replace with kfree_sentitive() for domain_id everywhere.

Thanks,
Gao Xiang

