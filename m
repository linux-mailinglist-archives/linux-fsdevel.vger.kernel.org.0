Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C91B9208
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Apr 2020 19:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgDZRWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 13:22:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41363 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726151AbgDZRWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 13:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587921737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=He8PxAEgHbokRcvXYzmdo2Y0iU2EnREdr4OmYbOMUrs=;
        b=BtaFd3XsfyliXIbIaXUhLr3z98eZW6yg4jmVv5EKwW148RZkt+5c2wJ9v8T3KZ6Kvg2of9
        9cAPUnON+2Uq3myk5jtJjb3c2AToLyvhwZUU5cZdkiXR46xuOJ02jdfCx+ctYQp6maGxBP
        +6EPFrDS+t58XOezNNL25nKi9CV4M0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-uUSod9YTPzG1Ko7CrHgXlg-1; Sun, 26 Apr 2020 13:22:13 -0400
X-MC-Unique: uUSod9YTPzG1Ko7CrHgXlg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D7E41005510;
        Sun, 26 Apr 2020 17:22:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.39])
        by smtp.corp.redhat.com (Postfix) with SMTP id 197CC60C05;
        Sun, 26 Apr 2020 17:22:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sun, 26 Apr 2020 19:22:11 +0200 (CEST)
Date:   Sun, 26 Apr 2020 19:22:07 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3 2/6] posix-cpu-timers: Use PIDTYPE_TGID to simplify
 the logic in lookup_task
Message-ID: <20200426172207.GA30118@redhat.com>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org>
 <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <20200424173927.GB26802@redhat.com>
 <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
 <87blnemj5t.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blnemj5t.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric,

I am sick today and can't read the code, but I feel this patch is not
right ... please correct me.

So, iiuc when posix_cpu_timer_create() is called and CPUCLOCK_PERTHREAD
is false we roughly have

	task = pid_task(pid, PIDTYPE_TGID);			// lookup_task()

	/* WINDOW */

	timer->it.cpu.pid = = get_task_pid(task, PIDTYPE_TGID)	// posix_cpu_timer_create()

Now suppose that we race with mt-exec and this "task" is the old leader;
it can be release_task()'ed in the WINDOW above and then get_task_pid()
will return NULL.

That is why I suggested to change lookup_task() to return "struct pid*"
to eliminate the pid -> task -> pid transition.

Apart from the same_thread_group() check for the "thread" case we do not
need task_struct at all, lookup_task() can do

	if (thread) {
		p = pid_task(pid, PIDTYPE_PID);
		if (p && !same_thread_group(p, current))
			pid = NULL;
	} else {
		... gettime check ...

		if (!pid_has_task(pid, PIDTYPE_TGID))
			pid = NULL;
	}

	return pid;

No?

Oleg.

