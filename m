Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E25224C003
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 16:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgHTOFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 10:05:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42621 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726951AbgHTOFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597932310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5p4rUADjrxj0quQ4r1R4b8tfd7Ji6lrJ8BtKV8Z9CAA=;
        b=Po+Z69Yz6Gs3/qHXRLOYLInQmp6nps4j8EzUGswcOCvt6G4SdOihqCGMOGpZYDglfrDuuV
        mODcqa+khM3OMW2/IuuZA6Mcc8SKLIBzWkpnwNQvt4DY8bu29K3ljtkhDakqk+FR8DwwRl
        Y3MnqPJEY2xO1trrV0D6RFtApFarxpQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-8E1A4lmTPeuPwwq67Mji5A-1; Thu, 20 Aug 2020 10:05:06 -0400
X-MC-Unique: 8E1A4lmTPeuPwwq67Mji5A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8908186A57D;
        Thu, 20 Aug 2020 14:05:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.73])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7B67419D6C;
        Thu, 20 Aug 2020 14:04:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 20 Aug 2020 16:05:02 +0200 (CEST)
Date:   Thu, 20 Aug 2020 16:04:52 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        christian.brauner@ubuntu.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, adobriyan@gmail.com, akpm@linux-foundation.org,
        gladkov.alexey@gmail.com, walken@google.com,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, timmurray@google.com, minchan@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
Message-ID: <20200820140451.GC4546@redhat.com>
References: <20200820002053.1424000-1-surenb@google.com>
 <87zh6pxzq6.fsf@x220.int.ebiederm.org>
 <20200820124241.GJ5033@dhcp22.suse.cz>
 <87lfi9xz7y.fsf@x220.int.ebiederm.org>
 <87d03lxysr.fsf@x220.int.ebiederm.org>
 <20200820132631.GK5033@dhcp22.suse.cz>
 <874koxxwn5.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874koxxwn5.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/20, Eric W. Biederman wrote:
>
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1139,6 +1139,10 @@ static int exec_mmap(struct mm_struct *mm)
>  	vmacache_flush(tsk);
>  	task_unlock(tsk);
>  	if (old_mm) {
> +		mm->oom_score_adj = old_mm->oom_score_adj;
> +		mm->oom_score_adj_min = old_mm->oom_score_adj_min;
> +		if (tsk->vfork_done)
> +			mm->oom_score_adj = tsk->vfork_oom_score_adj;

too late, ->vfork_done is NULL after mm_release().

And this can race with __set_oom_adj(). Yes, the current code is racy too,
but this change adds another race, __set_oom_adj() could already observe
->mm != NULL and update mm->oom_score_adj.

Oleg.

