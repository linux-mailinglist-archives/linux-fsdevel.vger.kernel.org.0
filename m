Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B6B4074F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Sep 2021 05:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhIKEAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Sep 2021 00:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhIKEAl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Sep 2021 00:00:41 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF3CC061574;
        Fri, 10 Sep 2021 20:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=EeWDSOzPpkK+UnEs+nG0+SawgJfrWjwQscwpYCDslFQ=; b=i/wXHjCUILBREcH+opGlyK7RKU
        wWWgnuGL1pwAagievX2WD02bMzClfmPi977+ocXB950lulLs+BcXx9LKsR2uR5gy/lfBm1tkAcKJa
        2BQP9Q5vSSVwmldPYQrPFWzRRtYgS0XgAaCHah7qPCsT3MHGxyA9IrrQTUXQhtRYixu/bd/XMs5me
        Rgb/JmCPpo+LbFAWv5K+qtlc+ZArEG/qX3Dbbx1o6jgHe8JVjaknAMTYG2mRdnzYVdGbWy8NmHYtC
        5OLxD1/WatkF50/wwfvg3wrTwQ9d4k0t0/7h5QZwnuBVi0GQVt5QWnuQSXtbzJPYmlUYMsgczt3bU
        VANBEshA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOuAp-00EEfZ-7k; Sat, 11 Sep 2021 03:59:27 +0000
Subject: Re: [PATCH 7/7] docs: proc.rst: stat: Note the interrupt counter
 wrap-around
To:     Alexei Lozovsky <me@ilammy.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <06F4B1B0-E4DE-4380-A8E1-A5ACAD285163@ilammy.net>
 <20210911034808.24252-1-me@ilammy.net> <20210911034808.24252-8-me@ilammy.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a3aa1c2e-fabe-8911-d3ad-555a39ba3234@infradead.org>
Date:   Fri, 10 Sep 2021 20:59:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210911034808.24252-8-me@ilammy.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/10/21 8:48 PM, Alexei Lozovsky wrote:
> Let's make wrap-around documented behavior so that userspace has no
> excuses for not handling it properly if they want accurate values.
> 
> Both "intr" and "softirq" counters (as well as many others, actually)
> can and will wrap-around, given enough time since boot.
> 
> Signed-off-by: Alexei Lozovsky <me@ilammy.net>
> ---
>   Documentation/filesystems/proc.rst | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 042c418f4090..06a0e3aa2e0e 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1513,6 +1513,13 @@ interrupts serviced  including  unnumbered  architecture specific  interrupts;
>   each  subsequent column is the  total for that particular numbered interrupt.
>   Unnumbered interrupts are not shown, only summed into the total.
>   
> +.. note::
> +
> +   Interrupt counters on most platforms are 32-bit, including the total count.
> +   Depending on the system load, ths values will sooner or later wrap around.

                                     these

> +   If you want accurate accouting of the rate and *real* number of interrupts

                            accounting

> +   serviced, you should monitor the value closely and handle wrap-arounds.
> +
>   The "ctxt" line gives the total number of context switches across all CPUs.
>   
>   The "btime" line gives  the time at which the  system booted, in seconds since
> 

thanks.
-- 
~Randy

