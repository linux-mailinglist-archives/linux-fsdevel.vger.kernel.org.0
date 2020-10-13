Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D6A28C9C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 10:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390763AbgJMIJb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 04:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389340AbgJMIJa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:09:30 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD4A720789;
        Tue, 13 Oct 2020 08:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602576568;
        bh=f6N2ojf5+mWCW6TFQPCqHlfXt5lY6lHpBrc5iWga6bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xHfUNxssmEr6CDdgb/5Rw18nCZdaPCyC4OqyXymRPwLls6LIN2g8k3qzshlYXO3Xh
         Q/EZO0Fsk0vHjst2V6xswpzwElrL6Ogx7Lbn08QHUlnAG82F/XfddTuCNuE2QshccE
         TaqxEa0BlPGwU5X2aO8P2olA57R37aQH86s6/rO0=
Date:   Tue, 13 Oct 2020 11:09:06 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
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
        Randy Dunlap <rdunlap@infradead.org>,
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
Message-ID: <20201013080906.GD4251@kernel.org>
References: <20201010103854.66746-1-songmuchun@bytedance.com>
 <CAM_iQpUQXctR8UBNRP6td9dWTA705tP5fWKj4yZe9gOPTn_8oQ@mail.gmail.com>
 <CAMZfGtUhVx_iYY3bJZRY5s1PG0N1mCsYGS9Oku8cTqPiMDze-g@mail.gmail.com>
 <CANn89iKprp7WYeZy4RRO5jHykprnSCcVBc7Tk14Ui_MA9OK7Fg@mail.gmail.com>
 <CAMZfGtXVKER_GM-wwqxrUshDzcEg9FkS3x_BaMTVyeqdYPGSkw@mail.gmail.com>
 <9262ea44-fc3a-0b30-54dd-526e16df85d1@gmail.com>
 <CAMZfGtVF6OjNuJFUExRMY1k-EaDS744=nKy6_a2cYdrJRncTgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMZfGtVF6OjNuJFUExRMY1k-EaDS744=nKy6_a2cYdrJRncTgQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 12, 2020 at 05:53:01PM +0800, Muchun Song wrote:
> On Mon, Oct 12, 2020 at 5:24 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >
> > On 10/12/20 10:39 AM, Muchun Song wrote:
> > > On Mon, Oct 12, 2020 at 3:42 PM Eric Dumazet <edumazet@google.com> wrote:
> > >>
> > >> On Mon, Oct 12, 2020 at 6:22 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >>>
> > >>> On Mon, Oct 12, 2020 at 2:39 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > >>>>
> > >>>> On Sat, Oct 10, 2020 at 3:39 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >>>>>
> > >>>>> The amount of memory allocated to sockets buffer can become significant.
> > >>>>> However, we do not display the amount of memory consumed by sockets
> > >>>>> buffer. In this case, knowing where the memory is consumed by the kernel
> > >>>>
> > >>>> We do it via `ss -m`. Is it not sufficient? And if not, why not adding it there
> > >>>> rather than /proc/meminfo?
> > >>>
> > >>> If the system has little free memory, we can know where the memory is via
> > >>> /proc/meminfo. If a lot of memory is consumed by socket buffer, we cannot
> > >>> know it when the Sock is not shown in the /proc/meminfo. If the unaware user
> > >>> can't think of the socket buffer, naturally they will not `ss -m`. The
> > >>> end result
> > >>> is that we still don’t know where the memory is consumed. And we add the
> > >>> Sock to the /proc/meminfo just like the memcg does('sock' item in the cgroup
> > >>> v2 memory.stat). So I think that adding to /proc/meminfo is sufficient.
> > >>>
> > >>>>
> > >>>>>  static inline void __skb_frag_unref(skb_frag_t *frag)
> > >>>>>  {
> > >>>>> -       put_page(skb_frag_page(frag));
> > >>>>> +       struct page *page = skb_frag_page(frag);
> > >>>>> +
> > >>>>> +       if (put_page_testzero(page)) {
> > >>>>> +               dec_sock_node_page_state(page);
> > >>>>> +               __put_page(page);
> > >>>>> +       }
> > >>>>>  }
> > >>>>
> > >>>> You mix socket page frag with skb frag at least, not sure this is exactly
> > >>>> what you want, because clearly skb page frags are frequently used
> > >>>> by network drivers rather than sockets.
> > >>>>
> > >>>> Also, which one matches this dec_sock_node_page_state()? Clearly
> > >>>> not skb_fill_page_desc() or __skb_frag_ref().
> > >>>
> > >>> Yeah, we call inc_sock_node_page_state() in the skb_page_frag_refill().
> > >>> So if someone gets the page returned by skb_page_frag_refill(), it must
> > >>> put the page via __skb_frag_unref()/skb_frag_unref(). We use PG_private
> > >>> to indicate that we need to dec the node page state when the refcount of
> > >>> page reaches zero.
> > >>>
> > >>
> > >> Pages can be transferred from pipe to socket, socket to pipe (splice()
> > >> and zerocopy friends...)
> > >>
> > >>  If you want to track TCP memory allocations, you always can look at
> > >> /proc/net/sockstat,
> > >> without adding yet another expensive memory accounting.
> > >
> > > The 'mem' item in the /proc/net/sockstat does not represent real
> > > memory usage. This is just the total amount of charged memory.
> > >
> > > For example, if a task sends a 10-byte message, it only charges one
> > > page to memcg. But the system may allocate 8 pages. Therefore, it
> > > does not truly reflect the memory allocated by the above memory
> > > allocation path. We can see the difference via the following message.
> > >
> > > cat /proc/net/sockstat
> > >   sockets: used 698
> > >   TCP: inuse 70 orphan 0 tw 617 alloc 134 mem 13
> > >   UDP: inuse 90 mem 4
> > >   UDPLITE: inuse 0
> > >   RAW: inuse 1
> > >   FRAG: inuse 0 memory 0
> > >
> > > cat /proc/meminfo | grep Sock
> > >   Sock:              13664 kB
> > >
> > > The /proc/net/sockstat only shows us that there are 17*4 kB TCP
> > > memory allocations. But apply this patch, we can see that we truly
> > > allocate 13664 kB(May be greater than this value because of per-cpu
> > > stat cache). Of course the load of the example here is not high. In
> > > some high load cases, I believe the difference here will be even
> > > greater.
> > >
> >
> > This is great, but you have not addressed my feedback.
> >
> > TCP memory allocations are bounded by /proc/sys/net/ipv4/tcp_mem
> >
> > Fact that the memory is forward allocated or not is a detail.
> >
> > If you think we must pre-allocate memory, instead of forward allocations,
> > your patch does not address this. Adding one line per consumer in /proc/meminfo looks
> > wrong to me.
> 
> I think that the consumer which consumes a lot of memory should be added
> to the /proc/meminfo. This can help us know the user of large memory.
> 
> >
> > If you do not want 9.37 % of physical memory being possibly used by TCP,
> > just change /proc/sys/net/ipv4/tcp_mem accordingly ?
> 
> We are not complaining about TCP using too much memory, but how do
> we know that TCP uses a lot of memory. When I firstly face this problem,
> I do not know who uses the 25GB memory and it is not shown in the /proc/meminfo.
> If we can know the amount memory of the socket buffer via /proc/meminfo, we
> may not need to spend a lot of time troubleshooting this problem. Not everyone
> knows that a lot of memory may be used here. But I believe many people
> should know /proc/meminfo to confirm memory users.

If I undestand correctly, the problem you are trying to solve is to
simplify troubleshooting of memory usage for people who may not be aware
that networking stack can be a large memory consumer.

For that a paragraph in 'man 5 proc' maybe a good start:

From ddbcf38576d1a2b0e36fe25a27350d566759b664 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Tue, 13 Oct 2020 11:07:35 +0300
Subject: [PATCH] proc.5: meminfo: add not anout network stack memory
 consumption

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 man5/proc.5 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/man5/proc.5 b/man5/proc.5
index ed309380b..8414676f1 100644
--- a/man5/proc.5
+++ b/man5/proc.5
@@ -3478,6 +3478,14 @@ Except as noted below,
 all of the fields have been present since at least Linux 2.6.0.
 Some fields are displayed only if the kernel was configured
 with various options; those dependencies are noted in the list.
+.IP
+Note that significant part of memory allocated by the network stack
+is not accounted in the file.
+The memory consumption of the network stack can be queried
+using
+.IR /proc/net/sockstat
+or
+.BR ss (8)
 .RS
 .TP
 .IR MemTotal " %lu"
-- 
2.25.4


