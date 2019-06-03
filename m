Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F299F32B83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 11:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfFCJJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 05:09:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50756 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfFCJJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iobI5d9Bso591kV58BjXAIxSTdpA85EgSWXJbRVwlpc=; b=DYUs+VwWkb9nlcxm1xlXveOuO
        5OoKiJg+743cp3Ima8IPoEhhu4gRanbLY7KcisLRKyDuTOtQU5DOpjWx+ZALCoTLcO54X0gak0zRV
        ClaNKdIeEvARzHksnzVln8+aqVBfQBIiah4N77u69VFZXBEDgfn7cE4VUO7Zgu1rAEeXXhS60i0gD
        H3Wh0plIS6Qa2mLlrZF0F+ZL4lCquZK3eW9R0HvYtdFow4l7D3uhzDAu/nZ2S+RKH1BC5grVnvZKS
        gCeRpiBTibJNyaFSbgsrLAeDrOh+R3UZhoqpHIram1rK4B4C+vYlz7Qqtd4WaiTqHXu+XN+A014X/
        hmAds8eUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hXixo-0001lG-JX; Mon, 03 Jun 2019 09:09:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F9E12025480C; Mon,  3 Jun 2019 11:09:06 +0200 (CEST)
Date:   Mon, 3 Jun 2019 11:09:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/13] epoll: introduce helpers for adding/removing
 events to uring
Message-ID: <20190603090906.GE3436@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-7-rpenyaev@suse.de>
 <20190531095607.GC17637@hirez.programming.kicks-ass.net>
 <274e29d102133f3be1f309c66cb0af36@suse.de>
 <20190531125636.GZ2606@hirez.programming.kicks-ass.net>
 <98e74ceeefdffc9b50fb33e597d270f7@suse.de>
 <20190531165144.GE2606@hirez.programming.kicks-ass.net>
 <9e13f80872e5b6c96e9cd3343e27b1f1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e13f80872e5b6c96e9cd3343e27b1f1@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 31, 2019 at 08:58:19PM +0200, Roman Penyaev wrote:
> On 2019-05-31 18:51, Peter Zijlstra wrote:

> > But like you show, it can be done. It also makes the thing wait-free, as
> > opposed to merely lockless.
> 
> You think it's better?  I did not like this variant from the very
> beginning because of the unnecessary complexity.  But maybe you're
> right.  No busy loops on user side makes it wait-free.  And also
> I can avoid c11 in kernel using cmpxchg along with atomic_t.

Imagine the (v)CPU going for an extended nap right between publishing the
new tail and writing the !0 entry. Then your userspace is stuck burning
cycles without getting anything useful done.


