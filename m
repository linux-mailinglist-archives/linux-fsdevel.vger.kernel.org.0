Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BA83206EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 20:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhBTTd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Feb 2021 14:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhBTTd1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Feb 2021 14:33:27 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2C5C061574;
        Sat, 20 Feb 2021 11:32:47 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDXzg-00GPWm-Gc; Sat, 20 Feb 2021 19:32:44 +0000
Date:   Sat, 20 Feb 2021 19:32:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Denis Kirjanov <kda@linux-powerpc.org>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/8] af_unix: take address assignment/hash insertion into
 a new helper
Message-ID: <YDFj3OZ4DMQSqylH@zeniv-ca.linux.org.uk>
References: <CAOJe8K0MC-TCURE2Gpci1SLnLXCbUkE7q6SS0fznzBA+Pf-B8Q@mail.gmail.com>
 <20210129082524.GA2282796@infradead.org>
 <CAOJe8K0iG91tm8YBRmE_rdMMMbc4iRsMGYNxJk0p9vEedNHEkg@mail.gmail.com>
 <20210129131855.GA2346744@infradead.org>
 <YClpVIfHYyzd6EWu@zeniv-ca.linux.org.uk>
 <CAOJe8K00srtuD+VAJOFcFepOqgNUm0mC8C=hLq2=qhUFSfhpuw@mail.gmail.com>
 <YCwIQmsxWxuw+dnt@zeniv-ca.linux.org.uk>
 <YC86WeSTkYZqRlJY@zeniv-ca.linux.org.uk>
 <YC88acS6dN6cU1y0@zeniv-ca.linux.org.uk>
 <CAM_iQpVpJwRNKjKo3p1jFvCjYAXAY83ux09rd2Mt0hKmvx=RgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpVpJwRNKjKo3p1jFvCjYAXAY83ux09rd2Mt0hKmvx=RgQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 20, 2021 at 11:12:33AM -0800, Cong Wang wrote:
> On Thu, Feb 18, 2021 at 8:22 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Duplicated logics in all bind variants (autobind, bind-to-path,
> > bind-to-abstract) gets taken into a common helper.
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  net/unix/af_unix.c | 30 +++++++++++++++---------------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 41c3303c3357..179b4fe837e6 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -262,6 +262,16 @@ static void __unix_insert_socket(struct hlist_head *list, struct sock *sk)
> >         sk_add_node(sk, list);
> >  }
> >
> > +static void __unix_set_addr(struct sock *sk, struct unix_address *addr,
> > +                           unsigned hash)
> > +       __releases(&unix_table_lock)
> > +{
> > +       __unix_remove_socket(sk);
> > +       smp_store_release(&unix_sk(sk)->addr, addr);
> > +       __unix_insert_socket(&unix_socket_table[hash], sk);
> > +       spin_unlock(&unix_table_lock);
> 
> Please take the unlock out, it is clearly an anti-pattern.

Why?  "Insert into locked and unlock" is fairly common...

> And please Cc netdev for networking changes.

Sorry about that - I'd ended up emulating git send-email by hand
and missed the Cc.  Sorted out by now...
