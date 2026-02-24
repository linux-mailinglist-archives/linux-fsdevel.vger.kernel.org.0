Return-Path: <linux-fsdevel+bounces-78224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA/KEuZfnWkDPAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 09:23:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBF7183968
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 09:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7AE23025E65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 08:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C697836656E;
	Tue, 24 Feb 2026 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K6m8qqJI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E9A2749E6;
	Tue, 24 Feb 2026 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921372; cv=none; b=bB/i1M1DEw9thsIOINZBZd1SddGnOBdbqNVT9T8mudjOJcuXeJrLWiJ6j5xfqQMnptJN4jw4mQJ1v0QsdB+cB1LSQU/TRFdPs1SWX+LWOGWF0tQqyj6wh5NaRy059KRhZH+Ye6gmjZc78Ct2i6fPchD+RM4ktkwCOM1CGixlLII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921372; c=relaxed/simple;
	bh=nmbZbIPX51eHjC7O7pK8XWcf1Q+BcDdEcjkSqCjGFqM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qNRQlvVobJM2Ay724+ATI4uyuJL63RcgHIni9gQbYjJ3rlOSyH1M3E46Nk4bYhUH6m1hsT9IlnQMOyTBZKthTP0uM8eIaJLJpdBnBxqMuhwYyUKi/mrsORrfdvreGnnddFSN05BA+6v6jZ2KL1wrviPgNgrATNyX1C7k9du9bSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K6m8qqJI; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771921367; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=GT0fDPV2Sxzx+vQwQ0Ad2qGDKQko9bLl+a+Q++P/5yk=;
	b=K6m8qqJIjuPdVHUtnnJLyU4hGOjnpfTZ2qjZzjVJELLlwhENcdrRnr3NLKYzelNXZIZQ7jRQLn/7KdogZhAceAN9zT/yjMpR1LS5rfWUpjYKwq9mCXjtzV9ZLbZRv3KGsnQLPk/bTSm02rL52Z8rTJ/LZo5cPJIrwN3TEQj9Bu8=
Received: from 30.221.147.152(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WziqUeN_1771921366 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Feb 2026 16:22:46 +0800
Message-ID: <eb6ed223-c36c-4268-a6bd-e0a7ffbffaf0@linux.alibaba.com>
Date: Tue, 24 Feb 2026 16:22:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fuse: fix premature writetrhough request for large
 folio
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, horst@birthelmer.de,
 joseph.qi@linux.alibaba.com, Joanne Koong <joannelkoong@gmail.com>
References: <20260115023607.77349-1-jefflexu@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20260115023607.77349-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78224-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,birthelmer.de,linux.alibaba.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jefflexu@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,ddn.com:email]
X-Rspamd-Queue-Id: AFBF7183968
X-Rspamd-Action: no action



On 1/15/26 10:36 AM, Jingbo Xu wrote:
> When large folio is enabled and the initial folio offset exceeds
> PAGE_SIZE, e.g. the position resides in the second page of a large
> folio, after the folio copying the offset (in the page) won't be updated
> to 0 even though the expected range is successfully copied until the end
> of the folio.  In this case fuse_fill_write_pages() exits prematurelly
> before the request has reached the max_write/max_pages limit.
> 
> Fix this by eliminating page offset entirely and use folio offset
> instead.
> 
> Fixes: d60a6015e1a2 ("fuse: support large folios for writethrough writes")
> Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> changes since v2:
> - drop stable CC tag; add Reviewed-by tag by Joanne
> 
> v1: https://lore.kernel.org/all/20260114055615.17903-1-jefflexu@linux.alibaba.com/
> v2: https://lore.kernel.org/all/20260114124514.62998-1-jefflexu@linux.alibaba.com/

gentle ping...

> ---
>  fs/fuse/file.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 625d236b881b..6aafb32338b6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1272,7 +1272,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  {
>  	struct fuse_args_pages *ap = &ia->ap;
>  	struct fuse_conn *fc = get_fuse_conn(mapping->host);
> -	unsigned offset = pos & (PAGE_SIZE - 1);
>  	size_t count = 0;
>  	unsigned int num;
>  	int err = 0;
> @@ -1299,7 +1298,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  		if (mapping_writably_mapped(mapping))
>  			flush_dcache_folio(folio);
>  
> -		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
> +		folio_offset = offset_in_folio(folio, pos);
>  		bytes = min(folio_size(folio) - folio_offset, num);
>  
>  		tmp = copy_folio_from_iter_atomic(folio, folio_offset, bytes, ii);
> @@ -1329,9 +1328,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  		count += tmp;
>  		pos += tmp;
>  		num -= tmp;
> -		offset += tmp;
> -		if (offset == folio_size(folio))
> -			offset = 0;
>  
>  		/* If we copied full folio, mark it uptodate */
>  		if (tmp == folio_size(folio))
> @@ -1343,7 +1339,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  			ia->write.folio_locked = true;
>  			break;
>  		}
> -		if (!fc->big_writes || offset != 0)
> +		if (!fc->big_writes)
> +			break;
> +		if (folio_offset + tmp != folio_size(folio))
>  			break;
>  	}
>  

-- 
Thanks,
Jingbo


