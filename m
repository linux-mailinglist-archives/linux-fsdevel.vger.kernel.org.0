Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B10A3A72A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 01:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhFNXt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 19:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhFNXt4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 19:49:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AEE161029;
        Mon, 14 Jun 2021 23:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623714473;
        bh=3PXUwWDZG9BaxUzmt23LPHFCVJ6xBR+RRYvvKbQzKCg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n36r22X6R3faAoySpcTRluBNKOws+AJrfKnUQlkNySzb+oMAOHVCnnuMYNQtbRJN5
         tOs6hK3s6iSd+e19cyZtw1cpRFUBOEBuN6wELr3STv60OdOrCjkzyykIdfZa6rC8Xt
         hF7xUgPiY3h9LHK1w3bLUmpIB6eK+Pw6wCCI1QnQ=
Date:   Mon, 14 Jun 2021 16:47:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] afs: fix tracepoint string placement with built-in AFS
Message-Id: <20210614164752.12438695a27203c8e7c9eaea@linux-foundation.org>
In-Reply-To: <YLAXfvZ+rObEOdc/@localhost.localdomain>
References: <YLAXfvZ+rObEOdc/@localhost.localdomain>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 28 May 2021 01:04:46 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> I was adding custom tracepoint to the kernel, grabbed full F34 kernel
> .config, disabled modules and booted whole shebang as VM kernel.
> 
> Then did
> 
> 	perf record -a -e ...
> 
> It crashed:
> 
> 	general protection fault, probably for non-canonical address 0x435f5346592e4243: 0000 [#1] SMP PTI
> 	CPU: 1 PID: 842 Comm: cat Not tainted 5.12.6+ #26
> 	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
> 	RIP: 0010:t_show+0x22/0xd0
> 
> Then reproducer was narrowed to 
> 
> 	# cat /sys/kernel/tracing/printk_formats
> 
> Original F34 kernel with modules didn't crash.
> 
> So I started to disable options and after disabling AFS everything
> started working again.
> 
> The root cause is that AFS was placing char arrays content into a section
> full of _pointers_ to strings with predictable consequences.
> 
> Non canonical address 435f5346592e4243 is "CB.YFS_" which came from
> CM_NAME macro.
> 
> The fix is to create char array and pointer to it separatedly.
> 
> Steps to reproduce:
> 
> 	CONFIG_AFS=y
> 	CONFIG_TRACING=y
> 
> 	# cat /sys/kernel/tracing/printk_formats

I'll add

Fixes: 8e8d7f13b6d5a9 ("afs: Add some tracepoints")

although Andi's d2abfa86ff373 gets in the way a bit.

> --- a/fs/afs/cmservice.c
> +++ b/fs/afs/cmservice.c
> @@ -30,8 +30,9 @@ static void SRXAFSCB_TellMeAboutYourself(struct work_struct *);
>  static int afs_deliver_yfs_cb_callback(struct afs_call *);
>  
>  #define CM_NAME(name) \
> -	char afs_SRXCB##name##_name[] __tracepoint_string =	\
> -		"CB." #name
> +	const char afs_SRXCB##name##_name[] = "CB." #name;		\
> +	static const char *_afs_SRXCB##name##_name __tracepoint_string =\
> +		afs_SRXCB##name##_name

Should/can afs_SRXCB##name##_name[] be static?


__tracepoint_string is very rarely used.  I wonder if there's much
point in it existing?


kernel/rcu/tree.h does

static char rcu_name[] = RCU_NAME_RAW;
static const char *tp_rcu_varname __used __tracepoint_string = rcu_name;

which is asking the compiler to place a copy of these into each
compilation unit which includes tree.h, which probably isn't what was
intended.
