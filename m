Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0056C223E0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 16:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgGQOby (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 10:31:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41040 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgGQOby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:31:54 -0400
Date:   Fri, 17 Jul 2020 16:31:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594996312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5qoTXWBcC/RBwV2lyrraf8gc543t7TaXqz6mLEITtNo=;
        b=g5zoao9ot8rVV2dGS2XZTiPF0uAiPzY8POJPvjjJR5pOXN5iqF9WGqs1m/abjnfNn/qofx
        0GLYuY58uEN4Wj/8Ht029o30NMYQifLITzxNQJnjNLwmG0kcfd+fc6sruXyCBerSvpv5hY
        TnLoqJlgv0okT/rSJKViSdDLRRRNrKIo23vdO7QaGq8YibXXPOTCyI4hUbwH5d+nZg5ULo
        fBX+Y2LeG4IygCpvytpe83zzATX7xU3CnRoa30AnblEf6qnicATTpBDl45ogvoPtY0+y2L
        72pj1fGftcR2GR6mQCqqMxd3h/kn8zA0qmjl0WmJrY0OJ6yTBSTcoHPH1ALY4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594996312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5qoTXWBcC/RBwV2lyrraf8gc543t7TaXqz6mLEITtNo=;
        b=jRdm3wfxhNXCHfw0CXFIvdcEANSSzup8YRXY/mxzizPCrIdBQ7cajoxL1MBVjnHzh2Evtb
        CftCI3mNCZsYQ2Bw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     Alberto Milone <alberto.milone@canonical.com>,
        linux-fsdevel@vger.kernel.org, mingo@kernel.org
Subject: Re: [PATCH 1/1] radix-tree: do not export radix_tree_preloads as GPL
Message-ID: <20200717143151.d2umpurzatx3kfg2@linutronix.de>
References: <20200717101848.1869465-1-alberto.milone@canonical.com>
 <20200717104300.h7k7ho25hmslvtgy@linutronix.de>
 <ba5d59f6-2e40-d13a-ecc8-d8430a1b6a14@canonical.com>
 <20200717132147.nizfehgvzsdi2tfv@linutronix.de>
 <ea8b14c7-cda9-d0c1-b36a-8f2deea3ca18@canonical.com>
 <20200717142848.GK3644@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200717142848.GK3644@ubuntu-x1>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-07-17 09:28:48 [-0500], Seth Forshee wrote:
> 
> Looks like the driver is not using idr_preload_end() though, it is
> calling radix_tree_preload_end() which uses radix_tree_preloads whether
> or not CONFIG_DEBUG_LOCK_ALLOC is enabled.

static inline void radix_tree_preload_end(void)
 {
         local_unlock(&radix_tree_preloads.lock);
 }

=> 
 #define local_unlock(lock)              __local_unlock(lock)

=>
 #define __local_unlock(lock)                                    \
         do {                                                    \
                 local_lock_release(this_cpu_ptr(lock));         \
                 preempt_enable();                               \
         } while (0)

=>
 static inline void local_lock_release(local_lock_t *l) { }

> Thanks,
> Seth

Sebastian
