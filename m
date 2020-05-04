Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2191C477E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 21:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgEDT7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 15:59:40 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53902 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgEDT7k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 15:59:40 -0400
Received: by mail-pj1-f68.google.com with SMTP id hi11so439230pjb.3;
        Mon, 04 May 2020 12:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2HN8tcXcP8sTZ5bpyK/yzSNJcHfHQaQMKR7YqmFkps4=;
        b=JkdTT8ZHdQCAkK6pi2ETmP/+iSXP3XVcSdjpG9iUMPVee9YIAS5XYA6uriWfuqUJnY
         hx9JvKhaKJ4d3CCf5ZmVGKNSPOj+0E3ciSlp8y6CzkDVJK0ZvGH5KotNbiiWdgZ976gL
         cQNrz/wEr+UUmdTXHF37aDk02A48CeYUPtEl7j53jOuZYypp0PhTB+AWIp0GqpzJlFtQ
         eD0XumRgNsVvYKalPoQAk2SflzHVWpm9gaAqpKjIJZN99bKbPOSW81ZowwlHwiSymbQi
         CWDw58RmtHqdfKVgpopUX16TUHTJ2hUqDGYLx9DRK3wVLIsh0eJA8r6h42WYQ2ReWPgT
         5qIQ==
X-Gm-Message-State: AGi0Pua+XTvUwmg1tXoM0bicX4qo3ZSjGXv93i1Q/JhiBtkHDlfCGM13
        k26aJITd0/MQAwydtERkHdxSuJUPa4c=
X-Google-Smtp-Source: APiQypKQ32QT2JrrMxB8ivGMiqkf3Ny/hgAQfR22DVkN0RH8YxwDoAr1Z4aoy+5pePZsHy20Hu32cw==
X-Received: by 2002:a17:902:728f:: with SMTP id d15mr855258pll.285.1588622379392;
        Mon, 04 May 2020 12:59:39 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j13sm299187pje.1.2020.05.04.12.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:59:38 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7416E403EA; Mon,  4 May 2020 19:59:37 +0000 (UTC)
Date:   Mon, 4 May 2020 19:59:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Make sure proc handlers can't expose heap memory
Message-ID: <20200504195937.GS11244@42.do-not-panic.com>
References: <202005041205.C7AF4AF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005041205.C7AF4AF@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 04, 2020 at 12:08:55PM -0700, Kees Cook wrote:
> Just as a precaution, make sure that proc handlers don't accidentally
> grow "count" beyond the allocated kbuf size.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This applies to hch's sysctl cleanup tree...
> ---
>  fs/proc/proc_sysctl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 15030784566c..535ab26473af 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -546,6 +546,7 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
>  	struct inode *inode = file_inode(filp);
>  	struct ctl_table_header *head = grab_header(inode);
>  	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
> +	size_t count_max = count;
>  	void *kbuf;
>  	ssize_t error;
>  
> @@ -590,6 +591,8 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
>  
>  	if (!write) {
>  		error = -EFAULT;
> +		if (WARN_ON(count > count_max))
> +			count = count_max;

That crash a system with panic-on-warn. I don't think we want that?

 Luis
