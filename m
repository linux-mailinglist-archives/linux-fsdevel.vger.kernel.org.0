Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF9C48319A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 14:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiACNyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 08:54:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57736 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiACNye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 08:54:34 -0500
Date:   Mon, 3 Jan 2022 14:54:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641218073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s+KBghPb4YbTCFpwaI5dNaX5KTm96nhcPYF43GxcRUE=;
        b=LZxNq96AE4KdjkEMj14zH5gBv0W/V0Xf/m18z9vsXdjyEt9F/rLAPhL8hl4BPl0txT1/oD
        AlE4YvaWdvjuzlfnQF1q/z9hzbPGO9TECk9C+Sjz8PIjTrrGcuk6EFv/fT1uZKBgQWroQe
        ypLCj3W63QKmmo+rf1+GOhpgy6sRV4HFBbUumq4FTP9VmWUTbPnOfYUD3016jv4K5hQzo9
        EoHz/6AeCMABBsLJHjqXqnID+72t0Zhocb19eJiTt7wGkzLxacSwMe09DDvh+j97zfYrkb
        Tk39BeftMXApsLFHAJczpzbzRqtD/ZvY2e/YXMv9LUiERbZNb72zADpBr+VXgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641218073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s+KBghPb4YbTCFpwaI5dNaX5KTm96nhcPYF43GxcRUE=;
        b=H9NxDqcnSvrEm5479zg41Jb+DYGrdr0PKZVyHCr87aEQmaGDVJ/3Vb/BCGi23jrGqMDrun
        azQRhMJUZeKId4CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Gregor Beck <gregor.beck@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH REPOST REPOST v2] fscache: Use only one
 fscache_object_cong_wait.
Message-ID: <YdMAF7vPKZTXE1FW@linutronix.de>
References: <20211223163500.2625491-1-bigeasy@linutronix.de>
 <901885.1640279829@warthog.procyon.org.uk>
 <YcS8rc64cVIckeW0@linutronix.de>
 <20211226162030.fc5340c2278c95342690467d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211226162030.fc5340c2278c95342690467d@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-12-26 16:20:30 [-0800], Andrew Morton wrote:
> On Thu, 23 Dec 2021 19:15:09 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2021-12-23 17:17:09 [+0000], David Howells wrote:
> > > Thanks, but this is gone in the upcoming fscache rewrite.  I'm hoping that
> > > will get in the next merge window.
> > 
> > Yes, I noticed that. What about current tree, v5.16-rc6 and less?
> > Shouldn't this be addressed?
> 
> If the bug is serious enough to justify a -stable backport then yes, we
> should merge a fix such as this ahead of the fscache rewrite, so we
> have something suitable for backporting.
> 
> Is the bug serious enough?
> 
> Or is the bug in a not-yet-noticed state?  In other words, is it
> possible that four years from now, someone will hit this bug in a
> 5.15-based kernel and will then wish we'd backported a fix?

I can't answer how serious it is but:
- with CONFIG_DEBUG_PREEMPT enabled there has to be a visible backtrace
  due this_cpu_ptr() usage.
- because of schedule_timeout(60 * HZ) there is no visible hang. It
  should be either woken up properly (via the waitqueue) or after a
  minute due to the timeout.

both things don't look good in general.

Sebastian
