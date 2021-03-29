Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D6234D259
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 16:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhC2O1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 10:27:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230359AbhC2O1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617028040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EqaKeR15hrRm51GbIjdwaRPlkul2MMX60iIFRxZ1Rns=;
        b=SN2S1VhjdaBmncB0xfmpDCmLnjXo1X+2JeG/yV1aFrZdwdwAhze8MPN7jpkFwJAIUQBD0R
        Hm9aU3aPK1CP4SUzrw5dgOG6cVApAyantKPDFkiF9IcG3KKYTVw5z5VzL9sHFMGA6Vy0HD
        waL3LLLOiBGvD6xRCjWoODLeR/F9QqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-UHzIechdPAaIBPxsNiYvwg-1; Mon, 29 Mar 2021 10:27:16 -0400
X-MC-Unique: UHzIechdPAaIBPxsNiYvwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C40D8874998;
        Mon, 29 Mar 2021 14:27:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id B271B60916;
        Mon, 29 Mar 2021 14:27:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 29 Mar 2021 16:27:13 +0200 (CEST)
Date:   Mon, 29 Mar 2021 16:27:06 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, alexander.shishkin@linux.intel.com,
        acme@kernel.org, mingo@redhat.com, jolsa@redhat.com,
        mark.rutland@arm.com, namhyung@kernel.org, tglx@linutronix.de,
        glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v3 06/11] perf: Add support for SIGTRAP on perf events
Message-ID: <20210329142705.GA24849@redhat.com>
References: <20210324112503.623833-1-elver@google.com>
 <20210324112503.623833-7-elver@google.com>
 <YFxGb+QHEumZB6G8@elver.google.com>
 <YGHC7V3bbCxhRWTK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGHC7V3bbCxhRWTK@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/29, Peter Zijlstra wrote:
>
> On Thu, Mar 25, 2021 at 09:14:39AM +0100, Marco Elver wrote:
> > @@ -6395,6 +6395,13 @@ static void perf_sigtrap(struct perf_event *event)
> >  {
> >  	struct kernel_siginfo info;
> >
> > +	/*
> > +	 * This irq_work can race with an exiting task; bail out if sighand has
> > +	 * already been released in release_task().
> > +	 */
> > +	if (!current->sighand)
> > +		return;

This is racy. If "current" has already passed exit_notify(), current->parent
can do release_task() and destroy current->sighand right after the check.

> Urgh.. I'm not entirely sure that check is correct, but I always forget
> the rules with signal. It could be we ought to be testing PF_EXISTING
> instead.

Agreed, PF_EXISTING check makes more sense in any case, the exiting task
can't receive the signal anyway.

Oleg.

