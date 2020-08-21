Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4785324D3B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 13:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgHULQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 07:16:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38065 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728284AbgHULQV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598008579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ABDyB8/1YGeMfmJ/yBam8ctdBXagiKU/H6XOWCtsLPc=;
        b=S/go+dNNK6wvtgvoRLwbeE6aIRuxJZYWonBxzkK0cIcY3XP+5FRX0qWb/BQ+4PR1mlms5C
        JtEsEBu2GXLmEAqT659WPqGRvrNjief0U6OwgqtQc/Tk7FG1aGoyBvoxl4OppjCanlN1Na
        YZQctPSXU62X6Ksz3dVF+5MiCd8iwNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-zWW6EVJFMqGwA_lUPfjDnQ-1; Fri, 21 Aug 2020 07:16:14 -0400
X-MC-Unique: zWW6EVJFMqGwA_lUPfjDnQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 852DA18B9F01;
        Fri, 21 Aug 2020 11:16:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.73])
        by smtp.corp.redhat.com (Postfix) with SMTP id B090650AC5;
        Fri, 21 Aug 2020 11:16:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 21 Aug 2020 13:16:10 +0200 (CEST)
Date:   Fri, 21 Aug 2020 13:15:59 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
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
Message-ID: <20200821111558.GG4546@redhat.com>
References: <87d03lxysr.fsf@x220.int.ebiederm.org>
 <20200820132631.GK5033@dhcp22.suse.cz>
 <20200820133454.ch24kewh42ax4ebl@wittgenstein>
 <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
 <20200820140054.fdkbotd4tgfrqpe6@wittgenstein>
 <637ab0e7-e686-0c94-753b-b97d24bb8232@i-love.sakura.ne.jp>
 <87k0xtv0d4.fsf@x220.int.ebiederm.org>
 <CAJuCfpHsjisBnNiDNQbm8Yi92cznaptiXYPdc-aVa+_zkuaPhA@mail.gmail.com>
 <20200820162645.GP5033@dhcp22.suse.cz>
 <87r1s0txxe.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1s0txxe.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/20, Eric W. Biederman wrote:
>
> That said if we are going for a small change why not:
>
> 	/*
> 	 * Make sure we will check other processes sharing the mm if this is
> 	 * not vfrok which wants its own oom_score_adj.
> 	 * pin the mm so it doesn't go away and get reused after task_unlock
> 	 */
> 	if (!task->vfork_done) {
> 		struct task_struct *p = find_lock_task_mm(task);
>
> 		if (p) {
> -			if (atomic_read(&p->mm->mm_users) > 1) {
> +			if (atomic_read(&p->mm->mm_users) > p->signal->nr_threads) {

In theory this needs a barrier to avoid the race with do_exit(). And I'd
suggest to use signal->live, I think signal->nr_threads should die...
Something like

	bool probably_has_other_mm_users(tsk)
	{
		return	atomic_read_acquire(&tsk->mm->mm_users) >
			atomic_read(&tsk->signal->live);
	}

The barrier implied by _acquire ensures that if we race with the exiting
task and see the result of exit_mm()->mmput(mm), then we must also see
the result of atomic_dec_and_test(signal->live).

Either way, if we want to fix the race with clone(CLONE_VM) we need other
changes.

Oleg.

