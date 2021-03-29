Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF60334D75A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 20:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhC2Seb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 14:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231641AbhC2SeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617042845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pDaHHzh6SdLVte/qI+KKbIrazg9pPxb7giE0iRBcJy4=;
        b=b6999D+6qaAwvhbvFlcUk+JpkW3dCC+VsXSCFlUUbVjxX2s47P6I9rxPPLIU9szC6IudE1
        J3mPs13+ao4CvhWQ0Fvth90/Nn501L23Du3rFV0zUYrtoNoJMvU8zspeuGdl/8YfH8mYY3
        rWWlh2MphnlP+1kXLes/3Rpwmz6u2sc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-6CvGnPCoONa9AJSA2KRzUg-1; Mon, 29 Mar 2021 14:34:03 -0400
X-MC-Unique: 6CvGnPCoONa9AJSA2KRzUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C03F87A82A;
        Mon, 29 Mar 2021 18:34:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4D0395D6A1;
        Mon, 29 Mar 2021 18:33:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 29 Mar 2021 20:34:00 +0200 (CEST)
Date:   Mon, 29 Mar 2021 20:33:52 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v3 06/11] perf: Add support for SIGTRAP on perf events
Message-ID: <20210329183351.GD24849@redhat.com>
References: <20210324112503.623833-1-elver@google.com>
 <20210324112503.623833-7-elver@google.com>
 <YFxGb+QHEumZB6G8@elver.google.com>
 <YGHC7V3bbCxhRWTK@hirez.programming.kicks-ass.net>
 <20210329142705.GA24849@redhat.com>
 <CANpmjNN=dpMmanU1mzigUscZQ6_Bx6u4u5mS4Ukhy0PTiexgDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNN=dpMmanU1mzigUscZQ6_Bx6u4u5mS4Ukhy0PTiexgDA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/29, Marco Elver wrote:
>
> So, per off-list discussion, it appears that I should ask to clarify:
> PF_EXISTING or PF_EXITING?

Aaaaaaah, sorry Marco.

PF_EXITING, of course.

Oleg.

