Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE5A20B11E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 14:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgFZMG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 08:06:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40427 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgFZMG2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:06:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id e18so4869287pgn.7;
        Fri, 26 Jun 2020 05:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rerp7T349z5d/bW667Qe6hL4Bacoz0qeIOMjhkul/co=;
        b=dzaaOShOAmxU7pqtsQ/HChxP1Sf0asrYtz3jHqzpDLPzVQjij8KNxtGPwI9Bo8MQOQ
         x2FNGhxgi9SlYQUeukehswkSMM8JRwhaitZ5xrN9xXhITCbQHjwHcgYVQnLRCrIToJc9
         A4l43ljro0aPdTwuSu9u2AACKO8pFYS5aR3Q3C7MT5A6r+VASkgNzzZh6QXndVOa9wDk
         LcBgoccbUN+q4RJJJfRPCWZvyv01Vt/08Kse+MN3WZDh0s1gYgb78WYTDchIP38BVk0F
         XPnGq5eaGt6WvNMzOz6WFu57Ry15gAcxTUzKd8SoaYrn1Ixrc3h3ER1T76Hln+1KHG90
         zFFg==
X-Gm-Message-State: AOAM533uCzdCdRbauY0v+ZJxrB8CtsZGDFw4bMrmiggnJTSxLW3qcOC6
        DYzRol29gUPtyQjnw3yG1zk=
X-Google-Smtp-Source: ABdhPJz4l8fsxkNBK2YDCOZe0ILtzyxwGvlDSbndekipkn5Rz8sUNYiaYM7n9+8mglpbQeyLydM1fw==
X-Received: by 2002:a63:4d53:: with SMTP id n19mr2545086pgl.60.1593173187188;
        Fri, 26 Jun 2020 05:06:27 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id w6sm11058707pjy.15.2020.06.26.05.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:06:25 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E368940B24; Fri, 26 Jun 2020 12:06:24 +0000 (UTC)
Date:   Fri, 26 Jun 2020 12:06:24 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] proc: add a read_iter method to proc proc_ops
Message-ID: <20200626120624.GL4332@42.do-not-panic.com>
References: <20200626075836.1998185-1-hch@lst.de>
 <20200626075836.1998185-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626075836.1998185-3-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 09:58:29AM +0200, Christoph Hellwig wrote:
> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> index 28d6105e908e4c..fa86619cebc2be 100644
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -297,6 +297,29 @@ static loff_t proc_reg_llseek(struct file *file, loff_t offset, int whence)
>  	return rv;
>  }
>  
> +static ssize_t pde_read_iter(struct proc_dir_entry *pde, struct kiocb *iocb,
> +		struct iov_iter *iter)
> +{
> +	if (!pde->proc_ops->proc_read_iter)
> +		return -EINVAL;

When is this true?

> +	return pde->proc_ops->proc_read_iter(iocb, iter);
> +}
> +

  Luis
