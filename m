Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80571E765F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 09:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgE2HJH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 03:09:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44850 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE2HJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 03:09:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id bh7so723755plb.11;
        Fri, 29 May 2020 00:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=izb4AXomeV4nhRoa/kLIpNkINoxthQhgyKrp7sV45uQ=;
        b=lJT3CrFhl7DFfjokxorfwJ5U0KTfzulSvvHkky1gyAZNrVIkTGzzOlGE0WI7XT+HMq
         L1pL0Qc8HW3xPplfG640wGXrgMj/G9j5tYqw/5zWAzUzgMOGB8uTws9CB6gutwx4GfS5
         KOGkB5AgS74gYjLwQR267X3CZUTGqPTghF4o1TJktkXHYDhb8NgZXwQKx+rf/GYdoyRI
         6Xj0itibh+8V56mQOMStV2eM38tsu0PFJHPVyPRYqrfXhWPTnefa4guJUlr6Y0xu5MFN
         khOqm0LdK6hP5RBDwkd2a8thCjOib9OhgTvxq8We6wIANRXtkGUWRtYpVtFVgGiN2d9S
         Bs3g==
X-Gm-Message-State: AOAM530Ab2EOsCSKQ9eB8XMhyHGCseygXhelvgbjCAvO0WFRhmgHx5D/
        Yg+nfe9lKy24x4DyEkxd5e4=
X-Google-Smtp-Source: ABdhPJzyw/EmLS6P6gA+UXFUO2+GOJKytJKtXYwmn15KMxZO6/5Ci4PhPjByG8xtYUqfMCS/DLKzeA==
X-Received: by 2002:a17:90a:b00d:: with SMTP id x13mr8040370pjq.11.1590736146458;
        Fri, 29 May 2020 00:09:06 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id gd1sm7290749pjb.14.2020.05.29.00.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:09:04 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id F422440605; Fri, 29 May 2020 07:09:03 +0000 (UTC)
Date:   Fri, 29 May 2020 07:09:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     keescook@chromium.org, yzaikin@google.com, adobriyan@gmail.com,
        mingo@kernel.org, gpiccoli@canonical.com, rdna@fb.com,
        patrick.bellasi@arm.com, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, mhocko@suse.com,
        penguin-kernel@i-love.sakura.ne.jp, vbabka@suse.cz,
        tglx@linutronix.de, peterz@infradead.org,
        Jisheng.Zhang@synaptics.com, khlebnikov@yandex-team.ru,
        bigeasy@linutronix.de, pmladek@suse.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        wangle6@huawei.com, alex.huangjianhui@huawei.com
Subject: Re: [PATCH v4 1/4] sysctl: Add register_sysctl_init() interface
Message-ID: <20200529070903.GV11244@42.do-not-panic.com>
References: <1589859071-25898-1-git-send-email-nixiaoming@huawei.com>
 <1589859071-25898-2-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589859071-25898-2-git-send-email-nixiaoming@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 11:31:08AM +0800, Xiaoming Ni wrote:
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -3358,6 +3358,25 @@ int __init sysctl_init(void)
>  	kmemleak_not_leak(hdr);
>  	return 0;
>  }
> +
> +/*
> + * The sysctl interface is used to modify the interface value,
> + * but the feature interface has default values. Even if register_sysctl fails,
> + * the feature body function can also run. At the same time, malloc small
> + * fragment of memory during the system initialization phase, almost does
> + * not fail. Therefore, the function return is designed as void
> + */

Let's use kdoc while at it. Can you convert this to proper kdoc?

> +void __init register_sysctl_init(const char *path, struct ctl_table *table,
> +				 const char *table_name)
> +{
> +	struct ctl_table_header *hdr = register_sysctl(path, table);
> +
> +	if (unlikely(!hdr)) {
> +		pr_err("failed when register_sysctl %s to %s\n", table_name, path);
> +		return;

table_name is only used for this, however we can easily just make
another _register_sysctl_init() helper first, and then use a macro
which will concatenate this to something useful if you want to print
a string. I see no point in the description for this, specially since
the way it was used was not to be descriptive, but instead just a name
followed by some underscore and something else.

> +	}
> +	kmemleak_not_leak(hdr);

Is it *wrong* to run kmemleak_not_leak() when hdr was not allocated?
If so, can you fix the sysctl __init call itself?

PS. Since you have given me your series, feel free to send me a patch
as a follow up to this in privae and I can integrate it into my tree.

  Luis
