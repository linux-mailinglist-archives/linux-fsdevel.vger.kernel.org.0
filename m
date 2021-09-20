Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB56412A90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 03:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhIUBni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 21:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhIUBjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:39:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC88C125F90;
        Mon, 20 Sep 2021 12:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qVmGn1sB2+Ujqg7/u2BgWKG/M74nLAjBwZQeoBTm6k4=; b=n2OSSolklt7gOYko3iITzFkPyC
        0CFZmnl1pIhaRTm5YGVOzTbvRlCC/5cbJo6Ol5dXncFos6LOkeVEHLM2n+RzZEn05VnTKrq3zRWzU
        XDWlcRZQv+COitTH6USEtWmqcFGeK1vFJZ3+qDzVy3ZT5JivVC2bgCRk+JDE2V/ndiijQRC9gq9TM
        wAdJ6bsCsa+zWJT6BzVz7DVLWlV3w9BDPq9VkZFJbjaXUJupVY1vq3XYUHtOJ2Zie/nuGNE/RNHOI
        I95WQELiKoXkadSIaUtm+tDhfcClRPWgG9P9yXMv0rjhNcG8v2yzd/k9dv1zwPaZV0rcYjNrJrQTT
        wax8de8w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSP77-002wrK-SH; Mon, 20 Sep 2021 19:38:05 +0000
Date:   Mon, 20 Sep 2021 12:38:05 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        rdunlap@infradead.org, rafael@kernel.org, masahiroy@kernel.org,
        ndesaulniers@google.com, yzaikin@google.com, nathan@kernel.org,
        ojeda@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        vitor@massaru.org, elver@google.com, jarkko@kernel.org,
        glider@google.com, rf@opensource.cirrus.com,
        stephen@networkplumber.org, David.Laight@aculab.com,
        bvanassche@acm.org, jolsa@kernel.org,
        andriy.shevchenko@linux.intel.com, trishalfonso@google.com,
        andreyknvl@gmail.com, jikos@kernel.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, daniel.vetter@ffwll.ch, bhelgaas@google.com,
        kw@linux.com, dan.j.williams@intel.com, senozhatsky@chromium.org,
        hch@lst.de, joe@perches.com, hkallweit1@gmail.com, axboe@kernel.dk,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org
Subject: Re: [PATCH v7 09/12] sysfs: fix deadlock race with module removal
Message-ID: <YUjjHRHWCso1tjeX@bombadil.infradead.org>
References: <20210918050430.3671227-1-mcgrof@kernel.org>
 <20210918050430.3671227-10-mcgrof@kernel.org>
 <YUjKjLzqpcxjRyit@slm.duckdns.org>
 <YUjdytEDkCughtSz@bombadil.infradead.org>
 <YUjfeGuSVVq84iHc@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUjfeGuSVVq84iHc@mtj.duckdns.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 09:22:32AM -1000, Tejun Heo wrote:
> On Mon, Sep 20, 2021 at 12:15:22PM -0700, Luis Chamberlain wrote:
> 
> > Right, the reason I mention the alternative is that we technically don't
> > need to use try in this case since during a kernfs op it is implied the
> > module will be pinned, but we have further motivations to use a try
> 
> I'm confused. If the module is already pinned, why are we getting an
> extra reference? 

Sorry, I meant its pinned implicitly not through an actual refcount. A module
exit can happen then in that case, it just that the sysfs removal will
have to wait until the active reference for the kernfs ops go down.

> Also, I don't understand how this has that much to do
> with preventing ddoses. I mean, it does cut down the duration of one
> operation but the eventual gating is through whoever acquiring the
> initial reference through try_module_get(), which again is the *only*
> way to acquire a fresh reference.

True. I can just leave that out from the commit log. But it is perhaps
an implicit gain here that using try alows module exit to trump use
of an kernfs op. Maybe's that's sufficient to mention.

  Luis
