Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B968A2E2151
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 21:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgLWUaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 15:30:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:40006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbgLWUaX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 15:30:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB815221F5;
        Wed, 23 Dec 2020 20:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1608755382;
        bh=EtXG9W3G1+A/sqX2J6p+P/ccEdSEfh0GmM7e1L8HOzo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Uhs0XCwswiiemTYvb3RCjqZxyfSXjWO4N1ogyHWVVaFzEc967RV+4Xa/uMR6y/u5Z
         KzKQvi5P3xcO/JSbFCJv4k2aaMmeAxf8XhsMUtpXIlpGiAq2HjQPcwDBO3xsQymBTA
         e0FQGXGKsfbtsbOmrc1S0hRLlegugx7n+FIKS7Tw=
Date:   Wed, 23 Dec 2020 12:29:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc/wchan: Use printk format instead of
 lookup_symbol_name()
Message-Id: <20201223122942.3650e2fdf74c6e8f0a982010@linux-foundation.org>
In-Reply-To: <b54649ea-1bec-25a9-2c22-35bdfabc89a9@gmx.de>
References: <20201217165413.GA1959@ls3530.fritz.box>
        <20201222181807.360cd9458d50b625608b8b44@linux-foundation.org>
        <b54649ea-1bec-25a9-2c22-35bdfabc89a9@gmx.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 23 Dec 2020 10:48:10 +0100 Helge Deller <deller@gmx.de> wrote:

> >  static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
> >  			  struct pid *pid, struct task_struct *task)
> >  {
> > -	unsigned long wchan;
> > -
> >  	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
> > -		wchan = get_wchan(task);
> > -	else
> > -		wchan = 0;
> > -
> > -	if (wchan)
> > -		seq_printf(m, "%ps", (void *) wchan);
> > +		seq_printf(m, "%ps", (void *)get_wchan(task));
> >  	else
> >  		seq_putc(m, '0');
> 
> get_wchan() does return NULL sometimes, in which case with
> your change now "0x0" instead of "0" gets printed.

Ah, OK, ignore ;)
