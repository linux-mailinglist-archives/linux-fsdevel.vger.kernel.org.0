Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED446FCF2E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 22:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjEIULa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 16:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjEIUL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 16:11:29 -0400
Received: from out-9.mta1.migadu.com (out-9.mta1.migadu.com [IPv6:2001:41d0:203:375::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5444BCF;
        Tue,  9 May 2023 13:11:24 -0700 (PDT)
Date:   Tue, 9 May 2023 16:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683663082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qR8mXUsmyLZCiZdDl00ZNRj2ZwtIGrMAWuqZ870emdI=;
        b=tzk89pqsaQffwTt8Mrhcs6CEIbfrMOrJ+KCOOGcFaeqbS81YDGBEbvOAyDyYl/7Wxby90O
        rRhD4S5o2bYXAEHoP7iUOxQwnr/lV9H7n9+gmdp4K4rrWHmCzoHnW8i/xHU2ce6idfOB1E
        fU75mFjBGzdRG+FKE8Xm68w1ghPVKCk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 02/32] locking/lockdep: lock_class_is_held()
Message-ID: <ZFqo50Gg3jFB1OEU@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-3-kent.overstreet@linux.dev>
 <20230509193039.GB2148518@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509193039.GB2148518@hirez.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 09:30:39PM +0200, Peter Zijlstra wrote:
> On Tue, May 09, 2023 at 12:56:27PM -0400, Kent Overstreet wrote:
> > From: Kent Overstreet <kent.overstreet@gmail.com>
> > 
> > This patch adds lock_class_is_held(), which can be used to assert that a
> > particular type of lock is not held.
> 
> How is lock_is_held_type() not sufficient? Which is what's used to
> implement lockdep_assert_held*().

I should've looked at that before - it returns a tristate, so it's
closer than I thought, but this is used in contexts where we don't have
a lock or lockdep_map to pass and need to pass the lock_class_key
instead.

e.g, when initializing a btree_trans, or waiting on btree node IO, we
need to assert that no btree node locks are held.

Looking at the code, __lock_is_held() -> match_held_lock() has to care
about a bunch of stuff related to subclasses that doesn't seem relevant
to lock_class_is_held() - lock_class_is_held() is practically no code in
comparison, so I'm inclined to think they should just be separate.

But I'm not the lockdep expert :) Thoughts?
