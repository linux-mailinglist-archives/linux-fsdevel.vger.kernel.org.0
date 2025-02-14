Return-Path: <linux-fsdevel+bounces-41693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A23BBA353B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 02:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F689188FC86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 01:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78848524B0;
	Fri, 14 Feb 2025 01:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eoqYeFJf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC94224FA
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 01:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739496898; cv=none; b=goevXsT/r6uVFd+vrGM/LAj0z5K3silrvvu5Bb2n8V9i8k9WGnkC4d0DIid/BExQHHpiQ3bkf1x5GfvCI6A1R8uB+r2hiFlFBb8LXe2eEq2tKffldzsZhioXKlK7An9IBulj0BstG5PhGddB0FLnMp50IKbfHFDueUk3ajTpPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739496898; c=relaxed/simple;
	bh=+OSE5Cjqom6njhQUpHIo1JEL5EvmRopP+8UJJR9zXLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrWuNB3TUt9QiC5aSMdzuoHEjSIpzJVWh1nPrDNwasATNqr6iWqNdgHBSvXA68PF6yZt3etkqFKxZhYYIfJCor053i20EtbbF62w7O3Td1Ekfl/f8NLwx+MPK6s4tmHGBC6ldl9VQP3+IqN9r9u8S6EdhkEYBfseWE9hGoNoMZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eoqYeFJf; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739496887; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KZ0sLc/cuClVDixrTTIBGuyAyZDWpQQ+Idy51MsphVQ=;
	b=eoqYeFJftEg1VzNP+Xk6vviVD2HL2XNUjhp7E6E/ZJTrTuVywTyiFAvsrVwf49/PsFHACfKj7l3ZKn5+Cg9sPTuGM2ZxH01hL48xRdpci5VKWDs8571ne2yhu7l1RscSaDjcQsJmdfKcE9mKZ1Fv0GrwnC58DZatc95F2/j9TUU=
Received: from 30.221.128.236(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WPP0Muz_1739496886 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Feb 2025 09:34:47 +0800
Message-ID: <072e3c64-5571-4828-862a-7b431e6e56ce@linux.alibaba.com>
Date: Fri, 14 Feb 2025 09:34:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ocfs2: Remove reference to bh->b_page
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 akpm <akpm@linux-foundation.org>
Cc: Mark Tinguely <mark.tinguely@oracle.com>, ocfs2-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
References: <20250213214533.2242224-1-willy@infradead.org>
 <20250213214533.2242224-2-willy@infradead.org>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20250213214533.2242224-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/2/14 05:45, Matthew Wilcox (Oracle) wrote:
> Buffer heads are attached to folios, not to pages.  Also
> flush_dcache_page() is now deprecated in favour of flush_dcache_folio().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/quota_global.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
> index 15d9acd456ec..e85b1ccf81be 100644
> --- a/fs/ocfs2/quota_global.c
> +++ b/fs/ocfs2/quota_global.c
> @@ -273,7 +273,7 @@ ssize_t ocfs2_quota_write(struct super_block *sb, int type,
>  	if (new)
>  		memset(bh->b_data, 0, sb->s_blocksize);
>  	memcpy(bh->b_data + offset, data, len);
> -	flush_dcache_page(bh->b_page);
> +	flush_dcache_folio(bh->b_folio);
>  	set_buffer_uptodate(bh);
>  	unlock_buffer(bh);
>  	ocfs2_set_buffer_uptodate(INODE_CACHE(gqinode), bh);


