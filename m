Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E5F1CFFE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 22:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbgELUx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 16:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgELUx2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 16:53:28 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C84F20753;
        Tue, 12 May 2020 20:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589316807;
        bh=+TTcFyDq0XtheQ1ckSwcHEdKSr9Tsy4lJ61JXZt7GCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1kePxY4o9dry+qXh58Fw7hM+w8aWVp0CZ4MJzJMYd+1hLq5Jn7xOOvgqbUsJ7BzcH
         DG4zD5JCO6glcX/dqq+y3/KP3Zoz1s0Fe2GFtIcstIKMIoBO8K37cyB/rAyUXbkOuC
         i/GUbOOgD424o2MgcRCJ8a4vzpLA3Ar3T2+Nuyc0=
Date:   Tue, 12 May 2020 13:53:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        tytso@mit.edu
Subject: Re: [PATCH] kernel: sysctl: ignore out-of-range taint bits
 introduced via kernel.tainted
Message-Id: <20200512135326.49daaa924b1fa2fb694e2d74@linux-foundation.org>
In-Reply-To: <20200512174653.770506-1-aquini@redhat.com>
References: <20200512174653.770506-1-aquini@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 12 May 2020 13:46:53 -0400 Rafael Aquini <aquini@redhat.com> wrote:

> The sysctl knob

/proc/sys/kernel/tainted, yes?

> allows users with SYS_ADMIN capability to
> taint the kernel with any arbitrary value, but this might
> produce an invalid flags bitset being committed to tainted_mask.
> 
> This patch introduces a simple way for proc_taint() to ignore
> any eventual invalid bit coming from the user input before
> committing those bits to the kernel tainted_mask.
> 
> ...
>
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -597,6 +597,8 @@ extern enum system_states {
>  #define TAINT_RANDSTRUCT		17
>  #define TAINT_FLAGS_COUNT		18
>  
> +#define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
> +
>  struct taint_flag {
>  	char c_true;	/* character printed when tainted */
>  	char c_false;	/* character printed when not tainted */
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 8a176d8727a3..fb2d693fc08c 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2623,11 +2623,23 @@ static int proc_taint(struct ctl_table *table, int write,
>  		return err;
>  
>  	if (write) {
> +		int i;
> +
> +		/*
> +		 * Ignore user input that would cause the loop below
> +		 * to commit arbitrary and out of valid range TAINT flags.
> +		 */
> +		if (tmptaint > TAINT_FLAGS_MAX) {
> +			tmptaint &= TAINT_FLAGS_MAX;
> +			pr_warn_once("%s: out-of-range taint input ignored."
> +				     " tainted_mask adjusted to 0x%lx\n",
> +				     __func__, tmptaint);
> +		}
> +
>  		/*
>  		 * Poor man's atomic or. Not worth adding a primitive
>  		 * to everyone's atomic.h for this
>  		 */
> -		int i;
>  		for (i = 0; i < BITS_PER_LONG && tmptaint >> i; i++) {

Could simply replace BITS_PER_LONG with TAINT_FLAGS_COUNT here?

(That "&& tmptaint >> i" seems a rather silly optimization?)

>  			if ((tmptaint >> i) & 1)
>  				add_taint(i, LOCKDEP_STILL_OK);

In fact the whole thing could be simplified down to

	for (i = 1; i <= TAINT_FLAGS_COUNT; i <<= 1)
		if (i & tmptaint)
			add_taint(...)

and silently drop out-of-range bits?
