Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E06E21C40B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jul 2020 13:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGKLrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jul 2020 07:47:10 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12937 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgGKLrJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jul 2020 07:47:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f09a64f0000>; Sat, 11 Jul 2020 04:45:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 11 Jul 2020 04:47:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 11 Jul 2020 04:47:09 -0700
Received: from [10.26.72.26] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 11 Jul
 2020 11:47:06 +0000
Subject: Re: [PATCH 15/23] seq_file: switch over direct seq_read method calls
 to seq_read_iter
To:     Christoph Hellwig <hch@lst.de>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20200707174801.4162712-1-hch@lst.de>
 <20200707174801.4162712-16-hch@lst.de>
 <5a2a97f1-58b5-8068-3c69-bb06130ffb35@nvidia.com>
 <20200711064857.GA29078@lst.de>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b838bf55-bd1e-7ff8-fcf5-fe372944dc9f@nvidia.com>
Date:   Sat, 11 Jul 2020 12:47:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200711064857.GA29078@lst.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594467919; bh=YjartdxmO2Ad0/uwBSdPTgr7N6l+g/YEyWPmF+u3P6Y=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MYAxXTbGMgtXmRbAqCTI1xHuhZ+jBhMxajcPgk7oOIlbM5E6ZxI7IBhFMLGEpxpuR
         6GMkWwtlyo+rgXBPGf2gxg4Rcm1HNGsKvh7jpLPLn1ODf+7A6KvzGDQ4+DzhsMG+uZ
         m/OonsizWyXvkhEiOA4p1sahWWTzlJK8Ti4OpBd5jw/qRAAkSlSoIteaDDvijSiYe3
         A0gpO1+xw3KCzFjjWES/6ycNSQ59bJicO0587qYfpZlgM8Ks7B0PqCEAi69krf/R5r
         FwYbXCiV0J4jppRWxQPx6kEsEfU51p2tyR5PeviIxmpvv9wF5rBI3MlVxIDrDqHoAA
         TCyWFnEpU+s5A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/07/2020 07:48, Christoph Hellwig wrote:
> Please try this one:
> 
> ---
> From 5e86146296fbcd7593da1d9d39b9685a5e6b83be Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Sat, 11 Jul 2020 08:46:10 +0200
> Subject: debugfs: add a proxy stub for ->read_iter
> 
> debugfs registrations typically go through a set of proxy ops to deal
> with refcounting, which need to support every method that can be
> supported.  Add ->read_iter to the proxy ops to prepare for seq_file to
> be switch to ->read_iter.
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/debugfs/file.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 8ba32c2feb1b73..dcd7bdaf67417f 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -231,6 +231,10 @@ FULL_PROXY_FUNC(read, ssize_t, filp,
>  			loff_t *ppos),
>  		ARGS(filp, buf, size, ppos));
>  
> +FULL_PROXY_FUNC(read_iter, ssize_t, iocb->ki_filp,
> +		PROTO(struct kiocb *iocb, struct iov_iter *iter),
> +		ARGS(iocb, iter));
> +
>  FULL_PROXY_FUNC(write, ssize_t, filp,
>  		PROTO(struct file *filp, const char __user *buf, size_t size,
>  			loff_t *ppos),
> @@ -286,6 +290,8 @@ static void __full_proxy_fops_init(struct file_operations *proxy_fops,
>  		proxy_fops->llseek = full_proxy_llseek;
>  	if (real_fops->read)
>  		proxy_fops->read = full_proxy_read;
> +	if (real_fops->read_iter)
> +		proxy_fops->read_iter = full_proxy_read_iter;
>  	if (real_fops->write)
>  		proxy_fops->write = full_proxy_write;
>  	if (real_fops->poll)
> 


Thanks! Works for me.

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
