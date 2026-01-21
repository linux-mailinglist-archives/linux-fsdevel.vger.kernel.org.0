Return-Path: <linux-fsdevel+bounces-74769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKcjArY8cGmgXAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:40:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A48664FEE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75A62A2E078
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 02:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62FC301704;
	Wed, 21 Jan 2026 02:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ckKhc5R7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8984723AB95
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963175; cv=none; b=sasSPJL1Ox4BfoYRcyeCfPyCjF5QvuVecFLaLhCxGASiZTMwuosuNsEXMLLsFOY3tcxkr9uSBMwstsfAsU7DmCbI7aoFRNUNLTCu4r2muFNX95GlQ1qTZ1I4rerLLbxZugAlVZQim4SjL0LTZq5qVCctEvOfnX24nKqivhYZxgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963175; c=relaxed/simple;
	bh=O79UpUmBKNYwQViE2sm6k4wl5Flx9hVQfS8VTmVvCHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRojjjsrysmDylEc71Pa+7TMKU4XbCxdIjul2x5RMfAMZ7R//27EMzifbZH+agDX/56vFrcXdSo3gAC69LKdqvy6ZvlN2vF+DcUE4RUVxapUtVdrHUjecnEBwnjeMii/Nax1CGh+xej+IKZQ3gFNYr3gmZ83spP1iiA1nrGKJlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ckKhc5R7; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768963163; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zUA7SHkVQB+UpPDppzUH84dsNOWcCtY7cugaRMJwDnk=;
	b=ckKhc5R7Qc/FKoGme6fTSwJCvTlNkZinGzHObujAs9z06RkvfSIG359F8YFMHEe3i8BiMTdsfXa+0tU/KI0gw5D9CYKZtiFosmYoScFupVnbiiXKYLEXxql/tU4rpQzehdg6D8HDqQasEYe5Pw2+JGkpzN3PKi3DkJKvY5ZOeOI=
Received: from 30.221.146.111(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WxWO3eX_1768963162 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 Jan 2026 10:39:22 +0800
Message-ID: <19ae5f62-4af8-4891-b969-0e52fb2a7544@linux.alibaba.com>
Date: Wed, 21 Jan 2026 10:39:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] fuse: use offset_in_page() for page offset
 calculations
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: luochunsheng@ustc.edu, djwong@kernel.org, horst@birthelmer.de,
 linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
References: <20260120224449.1847176-1-joannelkoong@gmail.com>
 <20260120224449.1847176-5-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20260120224449.1847176-5-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-8.96 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-74769-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,szeredi.hu];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jefflexu@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,ddn.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email]
X-Rspamd-Queue-Id: A48664FEE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/21/26 6:44 AM, Joanne Koong wrote:
> Replace open-coded (x & ~PAGE_MASK) with offset_in_page().
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

The straight conversion LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
>  fs/fuse/readdir.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index c2aae2eef086..c88194e52d18 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -52,7 +52,7 @@ static void fuse_add_dirent_to_cache(struct file *file,
>  	}
>  	version = fi->rdc.version;
>  	size = fi->rdc.size;
> -	offset = size & ~PAGE_MASK;
> +	offset = offset_in_page(size);
>  	index = size >> PAGE_SHIFT;
>  	/* Dirent doesn't fit in current page?  Jump to next page. */
>  	if (offset + reclen > PAGE_SIZE) {
> @@ -392,7 +392,7 @@ static enum fuse_parse_result fuse_parse_cache(struct fuse_file *ff,
>  					       void *addr, unsigned int size,
>  					       struct dir_context *ctx)
>  {
> -	unsigned int offset = ff->readdir.cache_off & ~PAGE_MASK;
> +	unsigned int offset = offset_in_page(ff->readdir.cache_off);
>  	enum fuse_parse_result res = FOUND_NONE;
>  
>  	WARN_ON(offset >= size);
> @@ -518,13 +518,13 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
>  	index = ff->readdir.cache_off >> PAGE_SHIFT;
>  
>  	if (index == (fi->rdc.size >> PAGE_SHIFT))
> -		size = fi->rdc.size & ~PAGE_MASK;
> +		size = offset_in_page(fi->rdc.size);
>  	else
>  		size = PAGE_SIZE;
>  	spin_unlock(&fi->rdc.lock);
>  
>  	/* EOF? */
> -	if ((ff->readdir.cache_off & ~PAGE_MASK) == size)
> +	if (offset_in_page(ff->readdir.cache_off) == size)
>  		return 0;
>  
>  	page = find_get_page_flags(file->f_mapping, index,

-- 
Thanks,
Jingbo


