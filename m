Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569F6257473
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 09:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgHaHny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 03:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaHno (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:43:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12398C061573;
        Mon, 31 Aug 2020 00:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bfowcr23SYGjmFeTw4H76pW95oh2o32vfH0LetHgQjc=; b=xLz/MI7zWVACfq30X1AW+abMBo
        HeCMQDoRVE1SlW/H4dbBPUuhXK+uepKoxfrpNEYosAevt2YY6IdEHuNPjZeLgUA+mrzGaDCLbjRZk
        LzcfoH7V0pTifpM9/SM+fW9zPoSBjnzD8npqlgh6L2TjrUMHe55X8Pdzrdgna/V5ee7K+Etp5lRQ2
        YuZxEL4vVRmAIhQcCsK18rgc8wq1/ICKA4Ny8OV84pU8+jf5qP5okxyX1fbPuJdWYa2oIARKKhp/0
        TVzWTBIa+pyKpF1FQfb/M9HMF3jjLLoC4zwf1gm93SyasbdrwMgeYV0PqlDtv26/WZIddhBKRGKha
        JDCtQ6Vw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCeTS-0001Ar-IH; Mon, 31 Aug 2020 07:43:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7B9323003E5;
        Mon, 31 Aug 2020 09:43:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60BD7202A3F54; Mon, 31 Aug 2020 09:43:28 +0200 (CEST)
Date:   Mon, 31 Aug 2020 09:43:28 +0200
From:   peterz@infradead.org
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     syzbot <syzbot+db9cdf3dd1f64252c6ef@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        christian@brauner.io, gladkov.alexey@gmail.com,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        walken@google.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, jannh@google.com
Subject: Re: possible deadlock in proc_pid_syscall (2)
Message-ID: <20200831074328.GN1362448@hirez.programming.kicks-ass.net>
References: <00000000000063640c05ade8e3de@google.com>
 <87mu2fj7xu.fsf@x220.int.ebiederm.org>
 <20200828123720.GZ1362448@hirez.programming.kicks-ass.net>
 <87v9h0gvro.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9h0gvro.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 30, 2020 at 07:31:39AM -0500, Eric W. Biederman wrote:

> I am thinking that for cases where we want to do significant work it
> might be better to ask the process to pause at someplace safe (probably
> get_signal) and then do all of the work when we know nothing is changing
> in the process.
> 
> I don't really like the idea of checking and then checking again.  We
> might have to do it but it feels like the model is wrong somewhere.
> 
> Given that this is tricky to hit in practice, and given that I am
> already working the general problem of how to sort out the locking I am
> going to work this with the rest of the thorny issues of in exec.  This
> feels like a case where the proper solution is that we simply need
> something better than a mutex.

One possible alternative would be something RCU-like, surround the thing
with get_task_cred() / put_cred() and then have commit_creds() wait for
the usage of the old creds to drop to 0 before continuing.

(Also, get_cred_rcu() is disgusting for casting away const)

But this could be complete garbage, I'm not much familiar with any of
thise code.
