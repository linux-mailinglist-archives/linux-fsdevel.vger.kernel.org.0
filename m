Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8991BC767
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 20:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgD1SDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 14:03:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59645 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728023AbgD1SD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588097008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dTCb6h0ts+855lZZgZ/+Y8y8vm128LBY9jBSlKrK60Q=;
        b=CjkvQD4e1blAqDr3UUEcbjwwKHfLIrQIhXn4XbJ9d3pSWZ2GtbRD4sbt9rcooQqQs9PuPA
        vUVeAxAoBwYG3+phQ5OGZnA4aWv44tsykqJDnmM6gnLF3nQ3/psJajA2VcTS5Q1pWesGtV
        fePuoe0bIRkY44nHPYCoHRVsv1MsPVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-emIfdwxqPbqHIUL8CbYtHA-1; Tue, 28 Apr 2020 14:03:24 -0400
X-MC-Unique: emIfdwxqPbqHIUL8CbYtHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78BA313A1A3;
        Tue, 28 Apr 2020 18:03:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.231])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0A58A5D9F7;
        Tue, 28 Apr 2020 18:03:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 28 Apr 2020 20:03:22 +0200 (CEST)
Date:   Tue, 28 Apr 2020 20:03:17 +0200
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
Message-ID: <20200428180316.GA29960@redhat.com>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org>
 <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <20200424173927.GB26802@redhat.com>
 <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
 <87blnemj5t.fsf_-_@x220.int.ebiederm.org>
 <20200426172207.GA30118@redhat.com>
 <878sihjgec.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sihjgec.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/27, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > Eric,
> >
> > I am sick today and can't read the code, but I feel this patch is not
> > right ... please correct me.
>
>
> > So, iiuc when posix_cpu_timer_create() is called and CPUCLOCK_PERTHREAD
> > is false we roughly have
> >
> > 	task = pid_task(pid, PIDTYPE_TGID);			// lookup_task()
> >
> > 	/* WINDOW */
> >
> > 	timer->it.cpu.pid = = get_task_pid(task, PIDTYPE_TGID)	// posix_cpu_timer_create()
> >
> > Now suppose that we race with mt-exec and this "task" is the old leader;
> > it can be release_task()'ed in the WINDOW above and then get_task_pid()
> > will return NULL.
>
> Except it is asking for PIDTYPE_TGID.
>
> task->signal

Ah yes, I knew I missed something...

Oleg.

