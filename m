Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C90C191A1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 20:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCXTik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 15:38:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:42494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgCXTik (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:38:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DEFC2AAB8;
        Tue, 24 Mar 2020 19:38:35 +0000 (UTC)
Date:   Tue, 24 Mar 2020 20:38:33 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michael Neuling <mikey@neuling.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v11 3/8] powerpc/perf: consolidate read_user_stack_32
Message-ID: <20200324193833.GH25468@kitsune.suse.cz>
References: <20200225173541.1549955-1-npiggin@gmail.com>
 <cover.1584620202.git.msuchanek@suse.de>
 <184347595442b4ca664613008a09e8cea7188c36.1584620202.git.msuchanek@suse.de>
 <1585039473.da4762n2s0.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585039473.da4762n2s0.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 24, 2020 at 06:48:20PM +1000, Nicholas Piggin wrote:
> Michal Suchanek's on March 19, 2020 10:19 pm:
> > There are two almost identical copies for 32bit and 64bit.
> > 
> > The function is used only in 32bit code which will be split out in next
> > patch so consolidate to one function.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > ---
> > v6:  new patch
> > v8:  move the consolidated function out of the ifdef block.
> > v11: rebase on top of def0bfdbd603
> > ---
> >  arch/powerpc/perf/callchain.c | 48 +++++++++++++++++------------------
> >  1 file changed, 24 insertions(+), 24 deletions(-)
> > 
> > diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
> > index cbc251981209..c9a78c6e4361 100644
> > --- a/arch/powerpc/perf/callchain.c
> > +++ b/arch/powerpc/perf/callchain.c
> > @@ -161,18 +161,6 @@ static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
> >  	return read_user_stack_slow(ptr, ret, 8);
> >  }
> >  
> > -static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
> > -{
> > -	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> > -	    ((unsigned long)ptr & 3))
> > -		return -EFAULT;
> > -
> > -	if (!probe_user_read(ret, ptr, sizeof(*ret)))
> > -		return 0;
> > -
> > -	return read_user_stack_slow(ptr, ret, 4);
> > -}
> > -
> >  static inline int valid_user_sp(unsigned long sp, int is_64)
> >  {
> >  	if (!sp || (sp & 7) || sp > (is_64 ? TASK_SIZE : 0x100000000UL) - 32)
> > @@ -277,19 +265,9 @@ static void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
> >  }
> >  
> >  #else  /* CONFIG_PPC64 */
> > -/*
> > - * On 32-bit we just access the address and let hash_page create a
> > - * HPTE if necessary, so there is no need to fall back to reading
> > - * the page tables.  Since this is called at interrupt level,
> > - * do_page_fault() won't treat a DSI as a page fault.
> > - */
> > -static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
> > +static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
> >  {
> > -	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> > -	    ((unsigned long)ptr & 3))
> > -		return -EFAULT;
> > -
> > -	return probe_user_read(ret, ptr, sizeof(*ret));
> > +	return 0;
> >  }
> >  
> >  static inline void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
> > @@ -312,6 +290,28 @@ static inline int valid_user_sp(unsigned long sp, int is_64)
> >  
> >  #endif /* CONFIG_PPC64 */
> >  
> > +/*
> > + * On 32-bit we just access the address and let hash_page create a
> > + * HPTE if necessary, so there is no need to fall back to reading
> > + * the page tables.  Since this is called at interrupt level,
> > + * do_page_fault() won't treat a DSI as a page fault.
> > + */
> 
> The comment is actually probably better to stay in the 32-bit
> read_user_stack_slow implementation. Is that function defined
> on 32-bit purely so that you can use IS_ENABLED()? In that case
It documents the IS_ENABLED() and that's where it is. The 32bit
definition is only a technical detail.
> I would prefer to put a BUG() there which makes it self documenting.
Which will cause checkpatch complaints about introducing new BUG() which
is frowned on.

Thanks

Michal
