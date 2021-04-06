Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0A7354A9D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 03:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242259AbhDFBud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 21:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238926AbhDFBud (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:50:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF54F61380;
        Tue,  6 Apr 2021 01:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617673826;
        bh=n41zLqFSWMk5LVeXau5m8v+zEL6Zomzq3+NzTcVtBbY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V0rbPNQlutiRtvp28JhOXlBIPWXwQ8EmKXMQEBpZbZMvFpC6QppYLwiRMe7kBe1N3
         EqWLAbWFbPWLfAsqBFvXd+f1UD6f5KLjlvqXcD/PKNxlj5q8ZYW8sSa+ymVhXhXtYO
         GNv4k81O+rdpwqL+JTbuXJKRex1/sSCU0EbgbIE8=
Date:   Mon, 5 Apr 2021 18:50:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     jbaron@akamai.com, rpenyaev@suse.de, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] fs/epoll: restore waking from ep_done_scan()
Message-Id: <20210405185018.40d437d392863f743131fcda@linux-foundation.org>
In-Reply-To: <20210405231025.33829-3-dave@stgolabs.net>
References: <20210405231025.33829-1-dave@stgolabs.net>
        <20210405231025.33829-3-dave@stgolabs.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon,  5 Apr 2021 16:10:25 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:

> 339ddb53d373 (fs/epoll: remove unnecessary wakeups of nested epoll) changed
> the userspace visible behavior of exclusive waiters blocked on a common
> epoll descriptor upon a single event becoming ready. Previously, all tasks
> doing epoll_wait would awake, and now only one is awoken, potentially causing
> missed wakeups on applications that rely on this behavior, such as Apache Qpid.
> 
> While the aforementioned commit aims at having only a wakeup single path in
> ep_poll_callback (with the exceptions of epoll_ctl cases), we need to restore
> the wakeup in what was the old ep_scan_ready_list() such that the next thread
> can be awoken, in a cascading style, after the waker's corresponding ep_send_events().
> 

Tricky.  339ddb53d373 was merged in December 2019.  So do we backport
this fix?  Could any userspace code be depending upon the
post-339ddb53d373 behaviour?

Or do we just leave the post-339ddb53d373 code as-is?  Presumably the
issue is very rarely encountered, and changeing it back has its own
risks.

