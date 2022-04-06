Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B164F6DA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 00:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiDFWFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 18:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiDFWFP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:05:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9841D08C2;
        Wed,  6 Apr 2022 15:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=unkOFpWexeS4UT/zByCK3fk3pwE1DaNzuN7U1pkMO9g=; b=lD7Wp/r5wkfLJQAA4TcMK5XO94
        FNv9lPDi6F8UvSYBnZPcQh9KFtHbxQr8Zp1GIxePCzjodAazY9wZyVviXDw2hIIvTqtGPLg9o80km
        hebv0JKJwQJlBNhzZmJG2O+aSuwHo07ViTxc2MZZxlEQsUp7lnT70sxFz36CHYKvextrrOf9pLUbM
        l17jHRf/KlCKNmKS6KFys/3xefP0U+832A44yDHVD0MB737CY6uF68lfFkdBojAwTDcl1wjkYFAKv
        QdWbmbNExfilCVEe1dGwOivkaOvuCb2E1KzTXA/YwRS/Khpx+TW6Ouq4/HPFscydla8bajiAjVu44
        nlpXp32w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncDjH-002Hwi-Q6; Wed, 06 Apr 2022 22:02:20 +0000
Message-ID: <1a4cdfbd-8056-8cf0-373d-272ea0568577@infradead.org>
Date:   Wed, 6 Apr 2022 15:02:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC 1/3] softirq: Add two parameters to control CPU bandwidth
 for use by softirq
Content-Language: en-US
To:     Liao Chang <liaochang1@huawei.com>, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, tglx@linutronix.de,
        nitesh@redhat.com, edumazet@google.com, clg@kaod.org,
        tannerlove@google.com, peterz@infradead.org, joshdon@google.com,
        masahiroy@kernel.org, nathan@kernel.org, vbabka@suse.cz,
        akpm@linux-foundation.org, gustavoars@kernel.org, arnd@arndb.de,
        chris@chrisdown.name, dmitry.torokhov@gmail.com,
        linux@rasmusvillemoes.dk, daniel@iogearbox.net,
        john.ogness@linutronix.de, will@kernel.org, dave@stgolabs.net,
        frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        heying24@huawei.com, guohanjun@huawei.com, weiyongjun1@huawei.com
References: <20220406022749.184807-1-liaochang1@huawei.com>
 <20220406022749.184807-2-liaochang1@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220406022749.184807-2-liaochang1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

On 4/5/22 19:27, Liao Chang wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index e9119bf54b1f..a63ebc88a199 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -2393,3 +2393,13 @@ config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
>  # <asm/syscall_wrapper.h>.
>  config ARCH_HAS_SYSCALL_WRAPPER
>  	def_bool n
> +
> +config SOFTIRQ_THROTTLE
> +	bool "Softirq Throttling Feature"
> +	help
> +	  Allow to allocate bandwidth for use by softirq handling. This
> +	  saftguard machanism is known as softirq throttling and is controlled

typos:
	  safeguard mechanism

> +	  by two parameters in the /proc/ file system:
> +
> +	  /proc/sysctl/kernel/softirq_period_ms
> +	  /proc/sysctl/kernel/softirq_runtime_ms

These should be documented in...
I guess    Documentation/admin-guide/sysctl/kernel.rst

thanks.
-- 
~Randy
