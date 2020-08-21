Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A66324DB50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 18:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgHUQiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 12:38:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58546 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728615AbgHUQhq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598027865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0lJhV0AuRAshzZDQ8A0+XwDhVR+Tf/PekK/bov5/xP8=;
        b=CcEqUJhOI9VtfHgu5KpB1E2K5LXENw7tPB67QpYPih6WNGDc36bgk6JAcahySQ+gj2W7P7
        SRmXjdG3H+jfXIVEP7lpgs55Wj3V7YHQYzqTZJ8NEcC/fGH7uBQQ0cQ9yHSDRDDOH/D0y6
        z5xxiIHu9+nAJjv7+a1ySb9KOKdX1bE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-I75JHwW-NbqN86TNKQBV8Q-1; Fri, 21 Aug 2020 12:37:41 -0400
X-MC-Unique: I75JHwW-NbqN86TNKQBV8Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 837A780733B;
        Fri, 21 Aug 2020 16:37:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.15])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5BE651014186;
        Fri, 21 Aug 2020 16:37:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 21 Aug 2020 18:37:36 +0200 (CEST)
Date:   Fri, 21 Aug 2020 18:37:25 +0200
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
Message-ID: <20200821163724.GC19445@redhat.com>
References: <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
 <20200820140054.fdkbotd4tgfrqpe6@wittgenstein>
 <637ab0e7-e686-0c94-753b-b97d24bb8232@i-love.sakura.ne.jp>
 <87k0xtv0d4.fsf@x220.int.ebiederm.org>
 <CAJuCfpHsjisBnNiDNQbm8Yi92cznaptiXYPdc-aVa+_zkuaPhA@mail.gmail.com>
 <20200820162645.GP5033@dhcp22.suse.cz>
 <87r1s0txxe.fsf@x220.int.ebiederm.org>
 <20200821111558.GG4546@redhat.com>
 <CAJuCfpF_GhTy5SCjxqyqTFUrJNaw3UGJzCi=WSCXfqPAcbThYg@mail.gmail.com>
 <CAJuCfpG06_KLhQyg9N84bRQOdvG27uAZ2oBDEQPR-OnZeNJd1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG06_KLhQyg9N84bRQOdvG27uAZ2oBDEQPR-OnZeNJd1w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

again, don't really understand...

On 08/21, Suren Baghdasaryan wrote:
>
> Actually, reviewing again and considering where list_add_tail_rcu is
> happening, maybe the race with clone(CLONE_VM) does not introduce
> false negatives.

I think it does... Whatever we check, mm_users or MMF_PROC_SHARED,
the task can do clone(CLONE_VM) right after the check.

> However a false negative I think will happen when a
> task shares mm with another task and also has an additional thread.
> Shared mm will increment mm_users without adding to signal->live

Yes,

> and
> the additional thread will advance signal->live without adding to
> mm_users.

No, please note that CLONE_THREAD requires CLONE_VM.

Oleg.

