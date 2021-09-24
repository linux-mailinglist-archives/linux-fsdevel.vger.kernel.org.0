Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B6A41760B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 15:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbhIXNkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 09:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344482AbhIXNkO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:40:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523B0C0614ED;
        Fri, 24 Sep 2021 06:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5eUm/3BocFnd6jqw8ryBk2FLBZ1MGOAGbJXeqs1dooA=; b=BjCdxAtrap7UL9wsq/2CwCsa67
        +ukKcoaDAqitwzOvAeOc6RHcdzo2P0AI2VV6yMliXQjzK/ZNnVikF1Ea0ohyOxLld/H5gnHBL5Ld7
        oOLXqUG+NvkrCV4NAk9/00veGCfGKXNfOJ+Cw3Ijcg76dBS241OzsvjhsVX8kvqxjMy7ua+cih6CT
        N/k/u/UMwWGeSnUofEdTBXnvrYefFp+RGje4X6pepKKyNym5uZ+mKxJx3N2Wj0iao/OSqxR66ANvG
        kdbr9bcr3vgtg5IT7S6aieRH3K3huMnV4iMvn6mZuORnochk5lChpBLXDBpEwbs0KePGts+kamAHo
        DHvN/YmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTlIn-007Edy-Sv; Fri, 24 Sep 2021 13:32:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 068E0300273;
        Fri, 24 Sep 2021 15:31:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E201D2C5DFD92; Fri, 24 Sep 2021 15:31:44 +0200 (CEST)
Date:   Fri, 24 Sep 2021 15:31:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <YU3TQBIBnrbzWS30@hirez.programming.kicks-ass.net>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <202109231636.C233D6D82@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109231636.C233D6D82@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 04:38:26PM -0700, Kees Cook wrote:
> On Thu, Sep 23, 2021 at 04:31:05PM -0700, Kees Cook wrote:

> If the fair scheduler would actually benefit from still using get_wchan,
> I think this patch:
> https://lore.kernel.org/all/20210831083625.59554-1-zhengqi.arch@bytedance.com/
> should still be applied too.
> 
> If not, we can rip get_wchan() out completely (across all
> architectures).

The scheduler doesn't care, it's kernel/profile.c and please kill that
right along with wchan, good riddance.
