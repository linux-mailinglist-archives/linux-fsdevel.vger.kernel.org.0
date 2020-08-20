Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB50724C13B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 17:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgHTPHm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 11:07:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50849 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgHTPHl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:07:41 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k8m9Y-0005rd-Um; Thu, 20 Aug 2020 15:06:57 +0000
Date:   Thu, 20 Aug 2020 17:06:55 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>, timmurray@google.com,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        esyr@redhat.com, christian@kellner.me, areber@redhat.com,
        shakeelb@google.com, cyphar@cyphar.com, oleg@redhat.com,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        gladkov.alexey@gmail.com, walken@google.com,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, minchan@kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
Message-ID: <20200820150655.ewjqommxs3axrsf6@wittgenstein>
References: <87zh6pxzq6.fsf@x220.int.ebiederm.org>
 <20200820124241.GJ5033@dhcp22.suse.cz>
 <87lfi9xz7y.fsf@x220.int.ebiederm.org>
 <87d03lxysr.fsf@x220.int.ebiederm.org>
 <20200820132631.GK5033@dhcp22.suse.cz>
 <20200820133454.ch24kewh42ax4ebl@wittgenstein>
 <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
 <20200820140054.fdkbotd4tgfrqpe6@wittgenstein>
 <637ab0e7-e686-0c94-753b-b97d24bb8232@i-love.sakura.ne.jp>
 <87k0xtv0d4.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87k0xtv0d4.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 20, 2020 at 09:49:11AM -0500, Eric W. Biederman wrote:
> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
> 
> > On 2020/08/20 23:00, Christian Brauner wrote:
> >> On Thu, Aug 20, 2020 at 10:48:43PM +0900, Tetsuo Handa wrote:
> >>> On 2020/08/20 22:34, Christian Brauner wrote:
> >>>> On Thu, Aug 20, 2020 at 03:26:31PM +0200, Michal Hocko wrote:
> >>>>> If you can handle vfork by other means then I am all for it. There were
> >>>>> no patches in that regard proposed yet. Maybe it will turn out simpler
> >>>>> then the heavy lifting we have to do in the oom specific code.
> >>>>
> >>>> Eric's not wrong. I fiddled with this too this morning but since
> >>>> oom_score_adj is fiddled with in a bunch of places this seemed way more
> >>>> code churn then what's proposed here.
> >>>
> >>> I prefer simply reverting commit 44a70adec910d692 ("mm, oom_adj: make sure
> >>> processes sharing mm have same view of oom_score_adj").
> >>>
> >>>   https://lore.kernel.org/patchwork/patch/1037208/
> >> 
> >> I guess this is a can of worms but just or the sake of getting more
> >> background: the question seems to be whether the oom adj score is a
> >> property of the task/thread-group or a property of the mm. I always
> >> thought the oom score is a property of the task/thread-group and not the
> >> mm which is also why it lives in struct signal_struct and not in struct
> >> mm_struct. But
> >> 
> >> 44a70adec910 ("mm, oom_adj: make sure processes sharing mm have same view of oom_score_adj")
> >> 
> >> reads like it is supposed to be a property of the mm or at least the
> >> change makes it so.
> >
> > Yes, 44a70adec910 is trying to go towards changing from a property of the task/thread-group
> > to a property of mm. But I don't think we need to do it at the cost of "__set_oom_adj() latency
> > Yong-Taek Lee and Tim Murray have reported" and "complicity for supporting
> > vfork() => __set_oom_adj() => execve() sequence".
> 
> The thing is commit 44a70adec910d692 ("mm, oom_adj: make sure processes
> sharing mm have same view of oom_score_adj") has been in the tree for 4
> years.
> 
> That someone is just now noticing a regression is their problem.  The
> change is semantics is done and decided.  We can not reasonably revert
> at this point without risking other regressions.
> 
> Given that the decision has already been made to make oom_adj
> effectively per mm.  There is no point on have a debate if we should do
> it.

I mean yeah, I think no-one really was going to jump on the revert-train.

At least for me the historical background was quite important to know
actually. The fact that by sharing the mm one can effectively be bound
to the oom score of another thread-group is kinda suprising and the
oom_score_adj section in man proc doesn't mention this.

And I really think we need to document this. Either on the clone() or on
the oom_score_adj page...

Christian
