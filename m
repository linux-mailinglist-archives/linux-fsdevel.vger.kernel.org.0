Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6A315CF9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 02:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgBNB51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 20:57:27 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:56174 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgBNB51 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 20:57:27 -0500
Received: by mail-pj1-f67.google.com with SMTP id d5so3188103pjz.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 17:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JO4y/6MaFZheen66oWQucxnEdEIlR1nhxOdTJqIrCJg=;
        b=esOQL3ZxPZRNFgMxXot4e6w5SuWoluCox1qjbeQpUwZPdAdbxdAh2r/LHOsA5DNvJE
         oGuprcDysRMrPdfE+PxmjkA8697OsiL8ATnux5ZQtJ/K0G87i+CasQq6tWsKahhBWML5
         93pjsltlnYVLtGIGxOUnYhrRqt8jAyTNC/bCL0yLAsIlNfl3nESIrXZ6PN9mkYswZ9sE
         EIs7Gv9E1JahQVMvw5Nv8iMmYfdLqgfmioPLPSxa8MYpvw5imj6Vu0YbWFucBLZ+HQM8
         zSd7JjiuMAOj1Avq2v03sxtx/MIf8T4Ybr+zaBjuWhJ37Dwdhz4cBEduUGlN/HClXecT
         FDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JO4y/6MaFZheen66oWQucxnEdEIlR1nhxOdTJqIrCJg=;
        b=A/2Vv5foDw0CsAxVKE1TQW1NaLFqA8Ukv9BYpc8hFDfFEYD2niSPeI0uPoWuEk8sVa
         Ce9sYsoT8GGCLrd1o71Oq7H+z/HG5bZDp1++yVAysTXir04ojE7NPGATJWey4IrYSniW
         4zDQN1tNwj8AdI9wDxVYkmcLiM8Mh0IWCe+ohW0xE2irg0fcP8/s1Um++Y5B1aez418Q
         zpKUb+MddUOLAWCNv60ZTt5zHSBqQfixAffNIe6dD+LWVq1RLrbL34xJ9gdmBcuczpLk
         /zQ09noRw8U2J9OIt8b5UQly8FqKUlcg2nq2RlP7C6cEsPCtCKVbCVywI0EvFRTjxBBc
         9ILg==
X-Gm-Message-State: APjAAAVjTEmezHLps2/5zhCkvEZ7y+FK2uzW7Ox9okpvL/dmg92blc9p
        T4k9Ryg1UDSDQRZ/6rUCAto=
X-Google-Smtp-Source: APXvYqywm/rW6fw8KYt8j5BP6CAIbEeVAlBKZ3m1iIbF7YgfU+a6cCBU4ceZAv1G5f0m5XtKr3nWhg==
X-Received: by 2002:a17:902:bb93:: with SMTP id m19mr895500pls.310.1581645446734;
        Thu, 13 Feb 2020 17:57:26 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id o19sm11204330pjr.2.2020.02.13.17.57.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Feb 2020 17:57:26 -0800 (PST)
Date:   Fri, 14 Feb 2020 09:57:23 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Cc:     linux-fsdevel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH 1/2] pstore/platform: fix potential mem leak if
 pstore_init_fs failed
Message-ID: <20200214015723.GA22907@cqw-OptiPlex-7050>
References: <1581068800-13817-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581068800-13817-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 05:46:39PM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> There is a potential mem leak when pstore_init_fs failed,
> since the pstore compression maybe unlikey to initialized
> successfully. We must clean up the allocation once this
> unlikey issue happens.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  fs/pstore/platform.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index d896457..114dbdf15 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -822,10 +822,10 @@ static int __init pstore_init(void)
>  	allocate_buf_for_compression();
>  
>  	ret = pstore_init_fs();
> -	if (ret)
> -		return ret;
> +	if (ret < 0)
> +		free_buf_for_compression();
>  
> -	return 0;
> +	return ret;
>  }
>  late_initcall(pstore_init);
>
Deal all,
Any update about two fixes?

BRs,
Qiwu
