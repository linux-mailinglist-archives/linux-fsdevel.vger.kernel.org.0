Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5645521AD8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 05:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgGJDbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 23:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgGJDbo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:31:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A28C08C5CE;
        Thu,  9 Jul 2020 20:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=zouGvWxWBT0wxNaFx3ilX6K+72vX502NQC1RPD8NseQ=; b=osZSK816BsPK/giJQuGntSny3j
        jb2W0Ht34tJhWh3EQ6vwYlmCQMcGgk/f6YOj2w6pyVj//6CU41PpyPrIZVXyXnGM4DQpSYWdr716b
        2SYoYiast/LkktLNjbbaZneql+TtulDgulexzAC5SgI6nVYbvoWnOCjf28vIEhXuRYxwat2nmncRb
        5tWt58Zuvz4k+/UrCIsS+aSDNpkFKCWtCoHFY2NC4Okm4g93DOtD15n6rVrE2SzcP50hckiJfJWh5
        qME3Tl4Y5Bnpra6zBnlOsDut5BGoDWHxmsxpUm5/dEkZqqPXi7bTpKW12DmvDaeirMiGcSZ8erli3
        xT2z5Ykw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtjlG-0001L7-0P; Fri, 10 Jul 2020 03:31:42 +0000
Subject: Re: [PATCH] sysctl: add bound to panic_timeout to prevent overflow
To:     Changming Liu <charley.ashbringer@gmail.com>, keescook@chromium.org
Cc:     mcgrof@kernel.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1594351343-11811-1-git-send-email-charley.ashbringer@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b50e8198-ca2e-eb44-ed71-e4ca27f48232@infradead.org>
Date:   Thu, 9 Jul 2020 20:31:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594351343-11811-1-git-send-email-charley.ashbringer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/9/20 8:22 PM, Changming Liu wrote:
> Function panic() in kernel/panic.c will use panic_timeout
> multiplying 1000 as a loop boundery. So this multiplication

                             boundary.

> can overflow when panic_timeout is greater than (INT_MAX/1000).
> And this results in a zero-delay panic, instead of a huge
> timeout as the user intends.
> 
> Fix this by adding bound check to make it no bigger than
> (INT_MAX/1000).
> 
> Signed-off-by: Changming Liu <charley.ashbringer@gmail.com>
> ---
>  kernel/sysctl.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index db1ce7a..e60cf04 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -137,6 +137,9 @@ static int minolduid;
>  static int ngroups_max = NGROUPS_MAX;
>  static const int cap_last_cap = CAP_LAST_CAP;
>  
> +/* this is needed for setting boundery for panic_timeout to prevent it from overflow*/

                                 boundary (or max value)                       overflow */

> +static int panic_time_max = INT_MAX / 1000;
> +
>  /*
>   * This is needed for proc_doulongvec_minmax of sysctl_hung_task_timeout_secs
>   * and hung_task_check_interval_secs
> @@ -1857,7 +1860,8 @@ static struct ctl_table kern_table[] = {
>  		.data		= &panic_timeout,
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra2		= &panic_time_max,
>  	},
>  #ifdef CONFIG_COREDUMP
>  	{
> 

thanks.
-- 
~Randy

