Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C1C1B9224
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Apr 2020 19:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgDZRki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 13:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726157AbgDZRki (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 13:40:38 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42A1C061A10
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 10:40:37 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h6so11898724lfc.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 10:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dtrc1LxUXrGUTeYL+CIuPg7oi+xXAsX+zAakCRKGiTs=;
        b=gWkMPLVnPEbeWIBml8xtUosL0GHDXmBQiDAFLjIwwAlYDi29kGpQkrjnC64dJybCS7
         BiJ+6Syhkqkbm6+KIFNNzKiJeiMMp5xN3JWU/LjVbJIt4pWvSyvfzWxfecXPDDM7OAJ6
         lflbEU3okvfCmduQIp/pfmXaU9P0WDZ7eJ6ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dtrc1LxUXrGUTeYL+CIuPg7oi+xXAsX+zAakCRKGiTs=;
        b=fDLcPZScjSxRVJLB0+IV8dBrwIJ370k9T67/gAOLb5Iefl1Qq82XbdpgsBa3wcDUY1
         nvB54afz3doPs1yWP//ReAZIx6T8dIc7iYRjbCcx0B/7qs9zHaTydbsz0Za26vztPw22
         DQJmiPoJ99WyqMSDW/IH2f6fVAWOC4G+2sKTqBUxpEsk03qTcu61XMWwY4k2WRT8WNiD
         igsIdreLCsxm9D6UFID33KHFEqrxJTlg3UBN7Y1QS3sSKfjCzygVSVgHnDTFQnPXA9JC
         XU9ar6d/Iz9y8frHjqqxq34usr14lkB/OltbMaYUa057DgqiHfdVZymNOD/qv84f9TxR
         8/dA==
X-Gm-Message-State: AGi0PuZqHpOMmo0BgouIV0FnNwY2HNdh+izFgIkTAOXufDEGd4NSIl/4
        2nRXEJMvpT/4lAlrnhyhSwGd6EZWCLA=
X-Google-Smtp-Source: APiQypLOaP+Qq/U4GkYT4DTTZRBsHjGTYzA/57BuJzEB2uyR99pFa49dnfhTjWRnJf3YEahiRD2MMw==
X-Received: by 2002:a19:b10:: with SMTP id 16mr13118752lfl.133.1587922834998;
        Sun, 26 Apr 2020 10:40:34 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id a28sm9440615lfo.47.2020.04.26.10.40.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 10:40:33 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id f18so15107262lja.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 10:40:33 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr10321031ljj.265.1587922833220;
 Sun, 26 Apr 2020 10:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <20200424173927.GB26802@redhat.com> <87mu6ymkea.fsf_-_@x220.int.ebiederm.org> <875zdmmj4y.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <875zdmmj4y.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Apr 2020 10:40:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
Message-ID: <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] rculist: Add hlist_swap_before_rcu
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 26, 2020 at 7:14 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> To support this add hlist_swap_before_rcu.  An hlist primitive that
> will allow swaping the leading sections of two tasks.  For exchanging
> the task pids it will just be swapping the hlist_heads of two single
> entry lists.  But the functionality is more general.

So I have no problems with the series now - the code is much more
understandable. Partly because of the split-up, partly because of the
comments, and partly because you explained the special case and why it
was a valid thing to do...

However, I did start thinking about this case again.

I still don't think the "swap entry" macro is necessarily useful in
_general_ - any time it's an actual individual entry, that swap macro
doesn't really work.

So the only reason it works here is because you're actually swapping
the whole list.

But that, in turn, shouldn't be using that "first node" model at all,
it should use the hlist_head. That would have made it a lot more
obvious what is actually going on to me.

Now, the comment very much talks about the head case, but the code
still looks like it's swapping a non-head thing.

I guess the code technically _works_ with "swap two list ends", but
does that actually really make sense as an operation?

So I no longer hate how this patch looks, but I wonder if we should
just make the whole "this node is the *first* node" a bit more
explicit in both the caller and in the swapping code.

It could be as simple as replacing just the conceptual types and
names, so instead of some "pnode1" double-indirect node pointer, we'd
have

        struct hlist_head *left_head = container_of(left->pprev,
struct hlist_head, first);
        struct hlist_head *right_head = container_of(right->pprev,
struct hlist_head, first);

and then the code would do

        rcu_assign_pointer(right_head->first, left);
        rcu_assign_pointer(left_head->first, right);
        WRITE_ONCE(left->pprev,  &right_head->first);
        WRITE_ONCE(right->pprev,  &left_head->first);

which should generate the exact same code, but makes it clear that
what we're doing is switching the whole hlist when given the first
entries.

Doesn't that make what it actually does a lot more understandable? The
*pnode1/pnode2 games are somewhat opaque, but with that type and name
change and using "container_of()", the code now fairly naturally reads
as "oh, we're changing the first pointers in the list heads, and
making the nodes point back to them" .

Again - the current function _works_ with swapping two hlists in the
middle (not two entries - it swaps the whole list starting at that
entry!), so your current patch is in some ways "more generic". I'm
just suggesting that the generic case doesn't make much sense, and
that the "we know the first entries, swap the lists" actually is what
the real use is, and writing it as such makes the code easier to
understand.

But I'm not going to insist on this, so this is more an RFC. Maybe
people disagree, and/or have an actual use case for that "break two
hlists in the middle, swap the ends" that I find unlikely...

(NOTE: My "convert to hlist_head" code _works_ for that case too
because the code generation is the same! But it would be really really
confusing for that code to be used for anything but the first entry).

                       Linus
