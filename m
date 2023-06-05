Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD940722CD1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjFEQho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 12:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjFEQhm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:37:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D04ED;
        Mon,  5 Jun 2023 09:37:36 -0700 (PDT)
Date:   Mon, 5 Jun 2023 18:37:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685983055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4e85demDEm6WmdDySFiywaQz/7CD490NkhFomelOdWQ=;
        b=Hivf6YwcDltA1JGZW0JmOcX3KwrP7sz4Mj3bYETJCYdnFhZgIYdRVI5GJvhanql0q17LVK
        GVxnhGVh8mlVdiHAz6crJYtu/ErBoT+DynIQBg2m8ZgguitMjkf/3SjgWGVFx4DVcasTA/
        SLz+JROh+QDOtQyQqyaxFW/8PWgPXczTpmEM4YSbS7Z60I1XBCT55JK4cUReWjuUbTZfut
        lboDhY9SnnBaK2gtuPYBPKcxsNqAs9urCji9BTu+pECxmIFR0syc62sQdLvy1Jfo5Vaq9V
        1FZfuRRZHqIdjakxkmmAVsgSgiuBXS7LNysC7CUDVtvCkUKAQ/2u3HmsCppeRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685983055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4e85demDEm6WmdDySFiywaQz/7CD490NkhFomelOdWQ=;
        b=Pyyv39RIOOIj9xgY32bW/q0b5buQWDzSDuTfjH3NeR5lxNYphX09uWw9JGbPXMNosoADX9
        lGUDPUzl/qf1q3Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3] bpf: Remove in_atomic() from bpf_link_put().
Message-ID: <20230605163733.LD-UCcso@linutronix.de>
References: <20230509132433.2FSY_6t7@linutronix.de>
 <CAEf4BzZcPKsRJDQfdVk9D1Nt6kgT4STpEUrsQ=UD3BDZnNp8eQ@mail.gmail.com>
 <CAADnVQLzZyZ+cPqBFfrqa8wtQ8ZhWvTSN6oD9z4Y2gtrfs8Vdg@mail.gmail.com>
 <CAEf4BzY-MRYnzGiZmW7AVJYgYdHW1_jOphbipRrHRTtdfq3_wQ@mail.gmail.com>
 <20230525141813.TFZLWM4M@linutronix.de>
 <CAEf4Bzaipoo6X_2Fh5WTV-m0yjP0pvhqi7-FPFtGOrSzNpdGJQ@mail.gmail.com>
 <20230526112356.fOlWmeOF@linutronix.de>
 <CAEf4Bzawgrn2DhR9uvXwFFiLR9g+j4RYC6cr3n+eRD_RoKBAJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEf4Bzawgrn2DhR9uvXwFFiLR9g+j4RYC6cr3n+eRD_RoKBAJA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-05-31 12:00:56 [-0700], Andrii Nakryiko wrote:
> > On 2023-05-25 10:51:23 [-0700], Andrii Nakryiko wrote:
> > v2=E2=80=A6v3:
> >   - Drop bpf_link_put_direct(). Let bpf_link_put() do the direct free
> >     and add bpf_link_put_from_atomic() to do the delayed free via the
> >     worker.
>=20
> This seems like an unsafe "default put" choice. I think it makes more
> sense to have bpf_link_put() do a safe scheduled put, and then having
> a separate bpf_link_put_direct() for those special cases where we care
> the most (in kernel/bpf/inode.c and kernel/bpf/syscall.c).

I audited them and ended up with them all being safe except for the one
=66rom inode.c. I can reverse the logic if you want.

> > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > index 9948b542a470e..2e1e9f3c7f701 100644
> > --- a/kernel/bpf/inode.c
> > +++ b/kernel/bpf/inode.c
> > @@ -59,7 +59,10 @@ static void bpf_any_put(void *raw, enum bpf_type typ=
e)
> >                 bpf_map_put_with_uref(raw);
> >                 break;
> >         case BPF_TYPE_LINK:
> > -               bpf_link_put(raw);
> > +               if (may_sleep)
> > +                       bpf_link_put(raw);
> > +               else
> > +                       bpf_link_put_from_atomic(raw);
>=20
> Do we need to do this in two different ways here? The only situation
> that has may_sleep=3Dfalse is when called from superblock->free_inode.
> According to documentation:
>=20
>   Freeing memory in the callback is fine; doing
>   more than that is possible, but requires a lot of care and is best
>   avoided.
>=20
> So it feels like cleaning up link should be safe to do from this
> context as well? I've cc'ed linux-fsdevel@, hopefully they can advise.

This is invoked from the RCU callback (which is usually softirq):
	destroy_inode()
	 -> call_rcu(&inode->i_rcu, i_callback);

Freeing memory is fine but there is a mutex that is held in the process.

Sebastian
