Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B342F24DF05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 20:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHUSAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 14:00:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbgHUSAE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598032803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hfd87vPX7imdizr5awfMVB6fuuvJvnhJKohnbOuYDr0=;
        b=I/ansN58pe3Vt1diNIWBtbOZmFy3SrMyGNagcONimsBQiz0BvXic0eWJO6bMI45qeak8gM
        XkoBZZ6U0ZcXpJrV7q+43WD/vaiRJpBrP/RF/LEDuYwVwc+PNnj4jX0PfQpSA/yqrsHRF6
        7pgdFWzlumwgO9jT0bTILd7dYmJjVQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-tl_K1AAsMAWrM8DCAs5e7Q-1; Fri, 21 Aug 2020 13:59:58 -0400
X-MC-Unique: tl_K1AAsMAWrM8DCAs5e7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77D781006706;
        Fri, 21 Aug 2020 17:59:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.15])
        by smtp.corp.redhat.com (Postfix) with SMTP id D451F7E318;
        Fri, 21 Aug 2020 17:59:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 21 Aug 2020 19:59:54 +0200 (CEST)
Date:   Fri, 21 Aug 2020 19:59:43 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tim Murray <timmurray@google.com>, mingo@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com,
        Shakeel Butt <shakeelb@google.com>, cyphar@cyphar.com,
        adobriyan@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        gladkov.alexey@gmail.com, Michel Lespinasse <walken@google.com>,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de,
        John Johansen <john.johansen@canonical.com>,
        laoar.shao@gmail.com, Minchan Kim <minchan@kernel.org>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
Message-ID: <20200821175943.GD19445@redhat.com>
References: <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
 <20200820140054.fdkbotd4tgfrqpe6@wittgenstein>
 <637ab0e7-e686-0c94-753b-b97d24bb8232@i-love.sakura.ne.jp>
 <87k0xtv0d4.fsf@x220.int.ebiederm.org>
 <CAJuCfpHsjisBnNiDNQbm8Yi92cznaptiXYPdc-aVa+_zkuaPhA@mail.gmail.com>
 <20200820162645.GP5033@dhcp22.suse.cz>
 <87r1s0txxe.fsf@x220.int.ebiederm.org>
 <20200821111558.GG4546@redhat.com>
 <CAJuCfpF_GhTy5SCjxqyqTFUrJNaw3UGJzCi=WSCXfqPAcbThYg@mail.gmail.com>
 <20200821163300.GB19445@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821163300.GB19445@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/21, Oleg Nesterov wrote:
>
> On 08/21, Suren Baghdasaryan wrote:
> >
> > On Fri, Aug 21, 2020 at 4:16 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > >         bool probably_has_other_mm_users(tsk)
> > >         {
> > >                 return  atomic_read_acquire(&tsk->mm->mm_users) >
> > >                         atomic_read(&tsk->signal->live);
> > >         }
> > >
> > > The barrier implied by _acquire ensures that if we race with the exiting
> > > task and see the result of exit_mm()->mmput(mm), then we must also see
> > > the result of atomic_dec_and_test(signal->live).
> > >
> > > Either way, if we want to fix the race with clone(CLONE_VM) we need other
> > > changes.
> >
> > The way I understand this condition in __set_oom_adj() sync logic is
> > that we would be ok with false positives (when we loop unnecessarily)
> > but we can't tolerate false negatives (when oom_score_adj gets out of
> > sync).
>
> Yes,
>
> > With the clone(CLONE_VM) race not addressed we are allowing
> > false negatives and IMHO that's not acceptable because it creates a
> > possibility for userspace to get an inconsistent picture. When
> > developing the patch I did think about using (p->mm->mm_users >
> > p->signal->nr_threads) condition and had to reject it due to that
> > reason.
>
> Not sure I understand... I mean, the test_bit(MMF_PROC_SHARED) you propose
> is equally racy and we need copy_oom_score() at the end of copy_process()
> either way?

On a second thought I agree that probably_has_other_mm_users() above can't
work ;) Compared to the test_bit(MMF_PROC_SHARED) check it is not _equally_
racy, it adds _another_ race with clone(CLONE_VM).

Suppose a single-threaded process P does

	clone(CLONE_VM); // creates the child C

	// mm_users == 2; P->signal->live == 1;

	clone(CLONE_THREAD | CLONE_VM);

	// mm_users == 3; P->signal->live == 2;

the problem is that in theory clone(CLONE_THREAD | CLONE_VM) can increment
_both_ counters between atomic_read_acquire(mm_users) and atomic_read(live)
in probably_has_other_mm_users() so it can observe mm_users == live == 2.

Oleg.

