Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92CD701004
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 22:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjELU6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 16:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjELU6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 16:58:40 -0400
Received: from out-59.mta0.migadu.com (out-59.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6DF3A84
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 13:58:39 -0700 (PDT)
Date:   Fri, 12 May 2023 16:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683925117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s3XsAale2pLEJviZ0m+jYrI+Fj0fMfY+mvCKD6YJX4A=;
        b=o0JZgBDUVO05o2TV2PjvcCm6Z2IjhphHnZiekpZFctWBBg+HahHJf1W6NIhprP6jCoRsKM
        ABbGnIU5/cNUb+QGeDbRAheohdJNRitSlYhUF+VdMTg/8u9N6iH7Wj93RPQeba8ViuoziU
        UNnv+w4Af2P9bJn8MagslTkrFdHzNtk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 04/32] locking: SIX locks (shared/intent/exclusive)
Message-ID: <ZF6oejsUGUC0gnYx@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-5-kent.overstreet@linux.dev>
 <7233p553-861o-9772-n4nr-rr5424prq1r@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7233p553-861o-9772-n4nr-rr5424prq1r@vanv.qr>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 11, 2023 at 02:14:08PM +0200, Jan Engelhardt wrote:
> 
> On Tuesday 2023-05-09 18:56, Kent Overstreet wrote:
> >--- /dev/null
> >+++ b/include/linux/six.h
> >@@ -0,0 +1,210 @@
> >+ * There are also operations that take the lock type as a parameter, where the
> >+ * type is one of SIX_LOCK_read, SIX_LOCK_intent, or SIX_LOCK_write:
> >+ *
> >+ *   six_lock_type(lock, type)
> >+ *   six_unlock_type(lock, type)
> >+ *   six_relock(lock, type, seq)
> >+ *   six_trylock_type(lock, type)
> >+ *   six_trylock_convert(lock, from, to)
> >+ *
> >+ * A lock may be held multiple types by the same thread (for read or intent,
> 
> "multiple times"

Thanks, fixed

> >+// SPDX-License-Identifier: GPL-2.0
> 
> The currently SPDX list only knows "GPL-2.0-only" or "GPL-2.0-or-later",
> please edit.

Where is that list?
