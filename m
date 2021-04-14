Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8198F35EFD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 10:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350167AbhDNIif (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 04:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350157AbhDNIi0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:38:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D11C061574;
        Wed, 14 Apr 2021 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HOtc4Cl5BmOPZRqmjAtE1IxvnshDfxYTlqGmfr7o1nE=; b=BwF4H/P2hb8LfuzoAdXv9Wp9Es
        BNHces+QXuyLvlSJ5+FSQeScHQtEIfqpgbDaVqFy7Ge+lgMWEMFs6Whl9ajZcc+K2LuviMV6+dpPd
        dtZgw7fnI43BKmv19Ub7B7Jo9Qv03hRa5F6v+sBVyZnbWWoQ3qnkgiHS4L+T7J+WtD91ErdItBcVf
        bcuHuN0gguJ7qEvj0lUhVLamEsNtiPr5+rI3uocgNqvt116V4I9FjypnB2OGtVUZhfkxKA1LlzO3m
        Fs+tsvcT3QeclXBiRwzyE4cejhBDdMC2h27by3aAdEAdonNbOnSUhk4zJ30llp6d5bhCjfGNxpVp8
        4qbJzL+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWb1w-00C0Hf-DL; Wed, 14 Apr 2021 08:37:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5236300033;
        Wed, 14 Apr 2021 10:37:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60B7D203CF7DB; Wed, 14 Apr 2021 10:37:46 +0200 (CEST)
Date:   Wed, 14 Apr 2021 10:37:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, glider@google.com,
        viro@zeniv.linux.org.uk, arnd@arndb.de, christian@brauner.io,
        dvyukov@google.com, jannh@google.com, axboe@kernel.dk,
        mascasa@google.com, pcc@google.com, irogers@google.com,
        oleg@redhat.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Add support for synchronous signals on perf
 events
Message-ID: <YHap2v/pQJlFVE3W@hirez.programming.kicks-ass.net>
References: <20210408103605.1676875-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408103605.1676875-1-elver@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 12:35:55PM +0200, Marco Elver wrote:
> Marco Elver (9):
>   perf: Apply PERF_EVENT_IOC_MODIFY_ATTRIBUTES to children
>   perf: Support only inheriting events if cloned with CLONE_THREAD
>   perf: Add support for event removal on exec
>   signal: Introduce TRAP_PERF si_code and si_perf to siginfo
>   perf: Add support for SIGTRAP on perf events
>   selftests/perf_events: Add kselftest for process-wide sigtrap handling
>   selftests/perf_events: Add kselftest for remove_on_exec

Thanks!, I've picked up the above 8 patches. Arnaldo, do you want to
carry the last 2 patches or are you fine with me taking them as well?

>   tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
>   perf test: Add basic stress test for sigtrap handling
