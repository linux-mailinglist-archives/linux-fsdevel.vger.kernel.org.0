Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520B91B1B6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 03:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDUByV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 21:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgDUByU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 21:54:20 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 810692078C;
        Tue, 21 Apr 2020 01:54:19 +0000 (UTC)
Date:   Mon, 20 Apr 2020 21:54:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH 03/15] print_integer: new and improved way of printing
 integers
Message-ID: <20200420215417.6e2753ee@oasis.local.home>
In-Reply-To: <20200420212723.GE185537@smile.fi.intel.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
        <20200420205743.19964-3-adobriyan@gmail.com>
        <20200420211911.GC185537@smile.fi.intel.com>
        <20200420212723.GE185537@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 21 Apr 2020 00:27:23 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> >   
> > > 	TODO
> > > 	benchmark with mainline because nouveau is broken for me -(
> > > 	vsnprintf() changes make the code slower  
> > 
> > Exactly main point of this exercise. I don't believe that algos in vsprintf.c
> > are too dumb to use division per digit (yes, division by constant which is not
> > power of two is a heavy operation).
> >   
> 
> And second point here, why not to use existing algos from vsprintf.c?

Exactly. The code in _print_integer_u32() doesn't look as fast as the
code in vsprintf() that happens to use lookup tables and converts
without any loops.

Hint, loops are bad, they cause the CPU to slow down.

Anyway, this patch series would require a pretty good improvement, as
the code replacing the sprintf() usages is pretty ugly compared to a
simple sprintf() call.

Randomly picking patch 6:

 static int loadavg_proc_show(struct seq_file *m, void *v)
 {
 	unsigned long avnrun[3];
 
 	get_avenrun(avnrun, FIXED_1/200, 0);
 
	seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu %u/%d %d\n",
		LOAD_INT(avnrun[0]), LOAD_FRAC(avnrun[0]),
		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
		nr_running(), nr_threads,
		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
 	return 0;
 }

  *vs* 

 static int loadavg_proc_show(struct seq_file *m, void *v)
 {
 	unsigned long avnrun[3];
	char buf[3 * (LEN_UL + 1 + 2 + 1) + 10 + 1 + 10 + 1 + 10 + 1];
	char *p = buf + sizeof(buf);
	int i;

	*--p = '\n';
	p = _print_integer_u32(p, idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
	*--p = ' ';
	p = _print_integer_u32(p, nr_threads);
	*--p = '/';
	p = _print_integer_u32(p, nr_running());

 	get_avenrun(avnrun, FIXED_1/200, 0);
	for (i = 2; i >= 0; i--) {
		*--p = ' ';
		--p;		/* overwritten */
		*--p = '0';	/* conditionally overwritten */
		(void)_print_integer_u32(p + 2, LOAD_FRAC(avnrun[i]));
		*--p = '.';
		p = _print_integer_ul(p, LOAD_INT(avnrun[i]));
	}
 
	seq_write(m, p, buf + sizeof(buf) - p);
 	return 0;
 }


I much rather keep the first version.

-- Steve
