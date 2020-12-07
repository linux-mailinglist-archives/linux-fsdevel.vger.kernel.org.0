Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFA72D110E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 13:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgLGMxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 07:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLGMxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:53:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B519C0613D2;
        Mon,  7 Dec 2020 04:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mVvoWV/eGHM+7kZ0vIXpK/8KdpiU0TSbdMoKFhbFRfw=; b=WwZu2K5cKSFDGRkLU+JwLayF4V
        OrrUcySs8/FY0y/dk1l96lzaG4OLyvC/6/ALtcfbhS8/IcLgRy+wvyyBHRLtKHImb/KP0IZCXXyjf
        Jdp0a4aO+L5m5Q4y5p48z5jk4OCZi0emboNl20hVjXTUL1R54a8OwxGNgReYj7Cmw2CfxdgR+U8lK
        /fGUJxodRV1YluflWKA12yfCggwloFYbws+ULHYCz7sNeo9OgYFA1I0C78lunEtlmXWkKzxjg6Zb2
        6Qy3Q6qNiM93n6YNuxwTYSgEThsYfPPX4Sgccri3icuWDgmYnXEDKBr/7YQsnm5WihBj+vBMC35DS
        ASP+uxRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmFzX-0004VA-Uf; Mon, 07 Dec 2020 12:51:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91681304B92;
        Mon,  7 Dec 2020 13:51:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65A36200BB76A; Mon,  7 Dec 2020 13:51:45 +0100 (CET)
Date:   Mon, 7 Dec 2020 13:51:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joe Perches <joe@perches.com>,
        Rafael Aquini <aquini@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michel Lespinasse <walken@google.com>,
        Jann Horn <jannh@google.com>, chenqiwu <chenqiwu@xiaomi.com>,
        Minchan Kim <minchan@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] do_exit(): panic() recursion detected
Message-ID: <20201207125145.GM3040@hirez.programming.kicks-ass.net>
References: <20201207124050.4016994-1-vladimir.kondratiev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207124050.4016994-1-vladimir.kondratiev@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 07, 2020 at 02:40:49PM +0200, Vladimir Kondratiev wrote:
> From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
> 
> Recursive do_exit() is symptom of compromised kernel integrity.
> For safety critical systems, it may be better to
> panic() in this case to minimize risk.

You've not answered the previously posed question on why panic_on_oops
isn't more suitable for your type of systems.

> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
> Change-Id: I42f45900a08c4282c511b05e9e6061360d07db60

This Change-ID crap doesn't belong in kernel patches.
