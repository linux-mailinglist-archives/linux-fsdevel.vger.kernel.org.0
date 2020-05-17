Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9901D6560
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 04:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgEQCnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 May 2020 22:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgEQCnT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 May 2020 22:43:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAF3C05BD09
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2020 19:43:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p21so2978693pgm.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2020 19:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PQbWte+9OK/nLNDqarqOgSaVb57KOMwmsLKM5RcSivI=;
        b=OXjpn524jciuJ+MwLJD3qHyQSe9O545X8knfqGRrCTEgEAjzU4X6X0hTZVT3BfEM39
         05iAL3cXXMJGy3YcDCA2cR3ijkbTE2liaGnyLYKEByCq/LgHYhWN7sn5LvBTeM5QqSgI
         Z0ytD2W2896oRxw+DUyIf2wnt5lmGCIvqyOiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PQbWte+9OK/nLNDqarqOgSaVb57KOMwmsLKM5RcSivI=;
        b=DatvILCOEcd/K6BFQvNnOALhAaTXblXkLTQwcqEJjiHkuYYWZ6vWn2Tjq0cxQmPs9A
         7m1i5m47sEDpQq4zo9gYCzV5MmLKPjesh4ua2Oz2LvK6hASuSKwgNl6GzU/AEwe8hS32
         Uyegac9jymw9BPM6oxVzyZ9EIGJooPPZ2wMKLaXGLuYvXFqgWqQ0OwO7u+VM/bFP++VM
         uikQ396BsM8Ce5lcWUwk3Y09xDB6DQQHbL4VsZS7kQweqn8YvXBabfp3aUWD+IMnhSIW
         j+dm0F6MlYW5R6j5YEmx0NHezTXvb5oaW6N9QjoomF5zNfWcfUvMQyapUn2SOxNWJ8Ha
         KmdQ==
X-Gm-Message-State: AOAM533+plEH8FtPrHutP/lDa/n5D9H7UKQrh799erT9MjziQ5MJQXAz
        iIuoNmkePYqB+cMlLlBML0wI2g==
X-Google-Smtp-Source: ABdhPJy1RXvKH0mAU9GGmLdbQPD2jWqMfq66q4h3kKvUeq/f7u9fSAD7Wp2pGagWZRyz92SSaiHZlg==
X-Received: by 2002:aa7:9093:: with SMTP id i19mr10541447pfa.152.1589683398054;
        Sat, 16 May 2020 19:43:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p62sm5223387pfb.93.2020.05.16.19.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 19:43:16 -0700 (PDT)
Date:   Sat, 16 May 2020 19:43:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        peterz@infradead.org, mingo@kernel.org, patrick.bellasi@arm.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        Jisheng.Zhang@synaptics.com, bigeasy@linutronix.de,
        pmladek@suse.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        wangle6@huawei.com
Subject: Re: [PATCH v2 3/4] hung_task: Move hung_task sysctl interface to
 hung_task.c
Message-ID: <202005161942.682497BF@keescook>
References: <1589619315-65827-1-git-send-email-nixiaoming@huawei.com>
 <1589619315-65827-4-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589619315-65827-4-git-send-email-nixiaoming@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 16, 2020 at 04:55:14PM +0800, Xiaoming Ni wrote:
> +/*
> + * This is needed for proc_doulongvec_minmax of sysctl_hung_task_timeout_secs
> + * and hung_task_check_interval_secs
> + */
> +static unsigned long hung_task_timeout_max = (LONG_MAX / HZ);

Please make this const. With that done, yes, looks great!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
