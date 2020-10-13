Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5FC28D104
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 17:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbgJMPMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 11:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgJMPMh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:12:37 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3799922280;
        Tue, 13 Oct 2020 15:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602601956;
        bh=xUrl48IjiENObhEfA2T6TtpGq3QfIdTmHF2AmJXs4wQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lpue9pRX6a7Fw6IgRveFHO/EcuqEVB43UfNvKZaho1k/GDSsOLCJAAUfPwWsQtNnG
         YXtRO5GIFfbMxzFSzOGo7rv2KwuQHhMhhXvJsJL1WiH7Lz8mPPL6s/oU6HcH4/PW9H
         oaMji+OeAXmLj0lMUofpEIr2sqWs9Rhooq8XOvSE=
Date:   Tue, 13 Oct 2020 18:12:15 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Shakeel Butt <shakeelb@google.com>,
        Will Deacon <will@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Neil Brown <neilb@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        Florian Westphal <fw@strlen.de>, gustavoars@kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Dexuan Cui <decui@microsoft.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>, dave@stgolabs.net,
        Michel Lespinasse <walken@google.com>,
        Jann Horn <jannh@google.com>, chenqiwu@xiaomi.com,
        christophe.leroy@c-s.fr, Minchan Kim <minchan@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [External] Re: [PATCH] mm: proc: add Sock to /proc/meminfo
Message-ID: <20201013151215.GG4251@kernel.org>
References: <20201010103854.66746-1-songmuchun@bytedance.com>
 <CAM_iQpUQXctR8UBNRP6td9dWTA705tP5fWKj4yZe9gOPTn_8oQ@mail.gmail.com>
 <CAMZfGtUhVx_iYY3bJZRY5s1PG0N1mCsYGS9Oku8cTqPiMDze-g@mail.gmail.com>
 <CANn89iKprp7WYeZy4RRO5jHykprnSCcVBc7Tk14Ui_MA9OK7Fg@mail.gmail.com>
 <CAMZfGtXVKER_GM-wwqxrUshDzcEg9FkS3x_BaMTVyeqdYPGSkw@mail.gmail.com>
 <9262ea44-fc3a-0b30-54dd-526e16df85d1@gmail.com>
 <CAMZfGtVF6OjNuJFUExRMY1k-EaDS744=nKy6_a2cYdrJRncTgQ@mail.gmail.com>
 <20201013080906.GD4251@kernel.org>
 <e059f4b1-e51b-0277-e96b-c178d0cf4fd7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e059f4b1-e51b-0277-e96b-c178d0cf4fd7@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 07:43:59AM -0700, Randy Dunlap wrote:
> On 10/13/20 1:09 AM, Mike Rapoport wrote:
> > On Mon, Oct 12, 2020 at 05:53:01PM +0800, Muchun Song wrote:
> >> On Mon, Oct 12, 2020 at 5:24 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >>>
> >>> On 10/12/20 10:39 AM, Muchun Song wrote:
> >>>> On Mon, Oct 12, 2020 at 3:42 PM Eric Dumazet <edumazet@google.com> wrote:
> >>
> >> We are not complaining about TCP using too much memory, but how do
> >> we know that TCP uses a lot of memory. When I firstly face this problem,
> >> I do not know who uses the 25GB memory and it is not shown in the /proc/meminfo.
> >> If we can know the amount memory of the socket buffer via /proc/meminfo, we
> >> may not need to spend a lot of time troubleshooting this problem. Not everyone
> >> knows that a lot of memory may be used here. But I believe many people
> >> should know /proc/meminfo to confirm memory users.
> > 
> > If I undestand correctly, the problem you are trying to solve is to
> > simplify troubleshooting of memory usage for people who may not be aware
> > that networking stack can be a large memory consumer.
> > 
> > For that a paragraph in 'man 5 proc' maybe a good start:
> > 
> >>From ddbcf38576d1a2b0e36fe25a27350d566759b664 Mon Sep 17 00:00:00 2001
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > Date: Tue, 13 Oct 2020 11:07:35 +0300
> > Subject: [PATCH] proc.5: meminfo: add not anout network stack memory
> >  consumption
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  man5/proc.5 | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/man5/proc.5 b/man5/proc.5
> > index ed309380b..8414676f1 100644
> > --- a/man5/proc.5
> > +++ b/man5/proc.5
> > @@ -3478,6 +3478,14 @@ Except as noted below,
> >  all of the fields have been present since at least Linux 2.6.0.
> >  Some fields are displayed only if the kernel was configured
> >  with various options; those dependencies are noted in the list.
> > +.IP
> > +Note that significant part of memory allocated by the network stack
> > +is not accounted in the file.
> > +The memory consumption of the network stack can be queried
> > +using
> > +.IR /proc/net/sockstat
> > +or
> > +.BR ss (8)
> >  .RS
> >  .TP
> >  .IR MemTotal " %lu"
> 
> Hi Mike,
> 
> Could you tell us what units those values are in?
> or is that already explained somewhere else?

It is described a few lines above and anyway, "MemTotal" is a part of
the diff context ;-)

> thanks.
> -- 
> ~Randy
> 
> 

-- 
Sincerely yours,
Mike.
