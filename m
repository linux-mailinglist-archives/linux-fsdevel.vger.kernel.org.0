Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563A024C005
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 16:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgHTOCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 10:02:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47579 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgHTOBZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:01:25 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k8l7f-0000JS-Nv; Thu, 20 Aug 2020 14:00:55 +0000
Date:   Thu, 20 Aug 2020 16:00:54 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, timmurray@google.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, oleg@redhat.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, gladkov.alexey@gmail.com,
        walken@google.com, daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, minchan@kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
Message-ID: <20200820140054.fdkbotd4tgfrqpe6@wittgenstein>
References: <20200820002053.1424000-1-surenb@google.com>
 <87zh6pxzq6.fsf@x220.int.ebiederm.org>
 <20200820124241.GJ5033@dhcp22.suse.cz>
 <87lfi9xz7y.fsf@x220.int.ebiederm.org>
 <87d03lxysr.fsf@x220.int.ebiederm.org>
 <20200820132631.GK5033@dhcp22.suse.cz>
 <20200820133454.ch24kewh42ax4ebl@wittgenstein>
 <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 20, 2020 at 10:48:43PM +0900, Tetsuo Handa wrote:
> On 2020/08/20 22:34, Christian Brauner wrote:
> > On Thu, Aug 20, 2020 at 03:26:31PM +0200, Michal Hocko wrote:
> >> If you can handle vfork by other means then I am all for it. There were
> >> no patches in that regard proposed yet. Maybe it will turn out simpler
> >> then the heavy lifting we have to do in the oom specific code.
> > 
> > Eric's not wrong. I fiddled with this too this morning but since
> > oom_score_adj is fiddled with in a bunch of places this seemed way more
> > code churn then what's proposed here.
> 
> I prefer simply reverting commit 44a70adec910d692 ("mm, oom_adj: make sure
> processes sharing mm have same view of oom_score_adj").
> 
>   https://lore.kernel.org/patchwork/patch/1037208/

I guess this is a can of worms but just or the sake of getting more
background: the question seems to be whether the oom adj score is a
property of the task/thread-group or a property of the mm. I always
thought the oom score is a property of the task/thread-group and not the
mm which is also why it lives in struct signal_struct and not in struct
mm_struct. But

44a70adec910 ("mm, oom_adj: make sure processes sharing mm have same view of oom_score_adj")

reads like it is supposed to be a property of the mm or at least the
change makes it so.

Christian
