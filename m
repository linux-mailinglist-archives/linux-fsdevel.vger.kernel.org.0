Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD2D24B952
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 13:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbgHTLmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 07:42:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29647 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730792AbgHTLmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597923731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8vEp/WxacvOv6ZdyDKY3cZWkxN9u8Xjr1oigvpamBg=;
        b=e0QKLl2fPjabv1KvFpmTTQhCZydT1PwtBlvHDCGxr1/IEiKgb7JgbXWTPE/aUk3z/76Pcb
        pyAjjNghlXHa35K32G8ptt/lIAcMNvz0GfxDfQd0o5qA3T9TUenOPQR/SbbZCT8NMJRSl1
        46Y7RCyGJkJ8xD5bU6hUAHqC/KdNYfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-Dlb0DBYcO-mYVZnltAxoNg-1; Thu, 20 Aug 2020 07:42:07 -0400
X-MC-Unique: Dlb0DBYcO-mYVZnltAxoNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D981A186A568;
        Thu, 20 Aug 2020 11:42:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.73])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0657A7B8F4;
        Thu, 20 Aug 2020 11:41:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 20 Aug 2020 13:42:03 +0200 (CEST)
Date:   Thu, 20 Aug 2020 13:41:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        christian.brauner@ubuntu.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, adobriyan@gmail.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, gladkov.alexey@gmail.com, walken@google.com,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, timmurray@google.com, minchan@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
Message-ID: <20200820114153.GB4546@redhat.com>
References: <20200820002053.1424000-1-surenb@google.com>
 <20200820105555.GA4546@redhat.com>
 <20200820111349.GE5033@dhcp22.suse.cz>
 <20200820112932.GG5033@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820112932.GG5033@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/20, Michal Hocko wrote:
>
> On Thu 20-08-20 13:13:55, Michal Hocko wrote:
> > On Thu 20-08-20 12:55:56, Oleg Nesterov wrote:
> > > On 08/19, Suren Baghdasaryan wrote:
> > > >
> > > > Since the combination of CLONE_VM and !CLONE_SIGHAND is rarely
> > > > used the additional mutex lock in that path of the clone() syscall should
> > > > not affect its overall performance. Clearing the MMF_PROC_SHARED flag
> > > > (when the last process sharing the mm exits) is left out of this patch to
> > > > keep it simple and because it is believed that this threading model is
> > > > rare.
> > >
> > > vfork() ?
> >
> > Could you be more specific?

I meant, vfork() is not rare and iiuc MMF_PROC_SHARED will be set in this
case and never cleared.

> > > > --- a/kernel/fork.c
> > > > +++ b/kernel/fork.c
> > > > @@ -1403,6 +1403,15 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
> > > >  	if (clone_flags & CLONE_VM) {
> > > >  		mmget(oldmm);
> > > >  		mm = oldmm;
> > > > +		if (!(clone_flags & CLONE_SIGHAND)) {
> > >
> > > I agree with Christian, you need CLONE_THREAD
> >
> > This was my suggestion to Suren, likely because I've misrememberd which
> > clone flag is responsible for the signal delivery. But now, after double
> > checking we do explicitly disallow CLONE_SIGHAND && !CLONE_VM. So
> > CLONE_THREAD is the right thing to check.
>
> I have tried to remember but I have to say that after reading man page I
> am still confused. So what is the actual difference between CLONE_THREAD
> and CLONE_SIGHAND?

Well, CLONE_THREAD creates a sub-thred, it needs CLONE_SIGHAND/VM.

> Essentially all we care about from the OOM (and
> oom_score_adj) POV is that signals are delivered to all entities and
> that thay share signal struct.

Yes, but CLONE_SIGHAND doesn't share the signal struct.

CLONE_SIGHAND shares sighand_struct, iow it shares the signal handlers.
so that if (say) the child does signal(SIG, handler) this equally affects
the parent. This obviously means that CLONE_SIGHAND needs CLONE_VM.

Oleg.

