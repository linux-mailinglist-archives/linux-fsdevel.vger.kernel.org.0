Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055BDA518A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 10:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfIBI07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 04:26:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:53910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729382AbfIBI06 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:26:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF187AF0D;
        Mon,  2 Sep 2019 08:26:56 +0000 (UTC)
Date:   Mon, 2 Sep 2019 10:26:53 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Diana Craciun <diana.craciun@nxp.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 3/6] powerpc/perf: consolidate read_user_stack_32
Message-ID: <20190902102653.6d477e16@naga>
In-Reply-To: <877e6rtkhe.fsf@mpe.ellerman.id.au>
References: <cover.1567198491.git.msuchanek@suse.de>
        <ea3783a1640b707ef9ce4740562850ef1152829b.1567198491.git.msuchanek@suse.de>
        <87a7bntkum.fsf@mpe.ellerman.id.au>
        <877e6rtkhe.fsf@mpe.ellerman.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 02 Sep 2019 14:01:17 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Michael Ellerman <mpe@ellerman.id.au> writes:
> > Michal Suchanek <msuchanek@suse.de> writes:  
> ...
> >> @@ -295,6 +279,12 @@ static inline int current_is_64bit(void)
> >>  }
> >>  
> >>  #else  /* CONFIG_PPC64 */
> >> +static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
> >> +{
> >> +	return 0;
> >> +}
> >> +#endif /* CONFIG_PPC64 */  
> >
> > Ending the PPC64 else case here, and then restarting it below with an
> > ifndef means we end up with two parts of the file that define 32-bit
> > code, with a common chunk in the middle, which I dislike.
> >
> > I'd rather you add the empty read_user_stack_slow() in the existing
> > #else section and then move read_user_stack_32() below the whole ifdef
> > PPC64/else/endif section.
> >
> > Is there some reason that doesn't work?  
> 
> Gah, I missed that you split the whole file later in the series. Any
> reason you did it in two steps rather than moving patch 6 earlier in the
> series?

To make this patch readable.

Thanks

Michal
