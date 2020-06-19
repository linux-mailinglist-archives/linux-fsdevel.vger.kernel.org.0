Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60A9201CFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 23:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgFSVRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 17:17:05 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38222 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgFSVRF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 17:17:05 -0400
Received: by mail-pj1-f68.google.com with SMTP id d6so4814960pjs.3;
        Fri, 19 Jun 2020 14:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7hNihcV3mvm2VbgzMCb3VuZiHFSALZHgtjxranVJTmE=;
        b=dFoRRUIOPhGwq71xQ3P5RaSFVt3bmwjhvl5AdFG+meSI/NEIzNPMMe/xEPhAxzdJ2r
         d50+IrkTF9f1gGmcHySTy01RmU8QPumj3DOkYArg6zbHLPBcw8QAg2cFZul0l3Sfs5Ob
         NVZGBZgPzPK/dF4mW9jtu+ycQkiChDdC242EIgLwTR5vM4A45huK/cVwNkPc7kfAs1FK
         m7UJxPpQrCKNg5x8vWei+3cZ5f2S2K93IBHb8+03qBUtQ3soUjocdfODW8pK0tITf5Vj
         D4165oNfL+4ZtFffGDbWOQc0n+3yUNv/uGpxRsf6guBFMPf8m7zetLKit9qzowIDS4L/
         BPFw==
X-Gm-Message-State: AOAM53268EVEXHpnR3d9xMFMIGRV9mClDCGDRBXanluYcF3KQrPbMdqW
        AL+PA3LJMsLIrsDQrzB1QNQ=
X-Google-Smtp-Source: ABdhPJzVFn2+ANNt35xVqck48K2jzOLKssbmFAqliq16/KCjcWBHQm/+K7WAIhdQVl6WxrZdgzhwhg==
X-Received: by 2002:a17:90a:7a8f:: with SMTP id q15mr4751132pjf.116.1592601423167;
        Fri, 19 Jun 2020 14:17:03 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s188sm6551320pfb.118.2020.06.19.14.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 14:17:01 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0E5884063E; Fri, 19 Jun 2020 21:17:00 +0000 (UTC)
Date:   Fri, 19 Jun 2020 21:17:00 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Brian Gerst <brgerst@gmail.com>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] kernel: add a kernel_wait helper
Message-ID: <20200619211700.GS11244@42.do-not-panic.com>
References: <20200618144627.114057-1-hch@lst.de>
 <20200618144627.114057-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618144627.114057-7-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 18, 2020 at 04:46:27PM +0200, Christoph Hellwig wrote:
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1626,6 +1626,22 @@ long kernel_wait4(pid_t upid, int __user *stat_addr, int options,
>  	return ret;
>  }
>  
> +int kernel_wait(pid_t pid, int *stat)
> +{
> +	struct wait_opts wo = {
> +		.wo_type	= PIDTYPE_PID,
> +		.wo_pid		= find_get_pid(pid),
> +		.wo_flags	= WEXITED,
> +	};
> +	int ret;
> +
> +	ret = do_wait(&wo);
> +	if (ret > 0 && wo.wo_stat)
> +		*stat = wo.wo_stat;

Since all we care about is WEXITED, that could be simplified
to something like this:

if (ret > 0 && KWIFEXITED(wo.wo_stat)
 	*stat = KWEXITSTATUS(wo.wo_stat)

Otherwise callers have to use W*() wrappers.

> +	put_pid(wo.wo_pid);
> +	return ret;
> +}

Then we don't get *any* in-kernel code dealing with the W*() crap.
I just unwrapped this for the umh [0], given that otherwise we'd
have to use KW*() callers elsewhere. Doing it upshot one level
further would be even better.

[0] https://lkml.kernel.org/r/20200610154923.27510-1-mcgrof@kernel.org              

  Luis
