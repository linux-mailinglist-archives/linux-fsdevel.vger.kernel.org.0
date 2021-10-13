Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499BC42C045
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 14:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhJMMoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 08:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhJMMoG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:44:06 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F66C061570;
        Wed, 13 Oct 2021 05:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZOJVOG5TPmwro9XVUCu0WLliPWZ0LeekD1uGNl5wZzs=; b=i37otEyCeSc+Ed6QP63HmDUoeK
        nyEGtCVCdea+zOQT3MR2vMjX2N3nEbH6VeajvaqJCNsy2JKhrs2y7pEZ6SnXyi0QVj23aRsJm6PVa
        FFIw6hc6ynV2EdXjiuKjytahoIVKcLkHtM9zf6rTdMwn1ujChgk8BK98xOHLJlU791WlJaBfkX35w
        QxDIXQ3KnNEoAiP4hLSrp68oE1SGAt8phequyiaYWDLk0w3FbCbiOfkLJWj+Nxt8/wQxqec558jly
        NLNdHzyapNsqVZEXn+FxmyOwcMsL8R55I5P/W4dVtbvPSAjDAcaAsQ8RPgbSUn1QwKImLleH3Ysyd
        ucatYAkQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mada2-00GdSy-Jx; Wed, 13 Oct 2021 12:41:58 +0000
Date:   Wed, 13 Oct 2021 05:41:58 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/12] sysfs: fix deadlock race with module removal
Message-ID: <YWbUFnway11HwuZl@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-10-mcgrof@kernel.org>
 <202110051315.B2165F455@keescook>
 <YWS5+uyDQ4qklTcT@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWS5+uyDQ4qklTcT@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 03:26:02PM -0700, Luis Chamberlain wrote:
> On Tue, Oct 05, 2021 at 01:50:31PM -0700, Kees Cook wrote:
> > For example, why does this not work?
> 
> It does for the write case for sure,

I mispoke, just for the record, the changes you mentioned actually don't
suffice for the test cases in question for test_sysfs, the deadlock
still occurs with those changes. At first I thought it did but I had failed
to remove my own fix first on fs/kernfs/dir.c. After removing that and
just trying the proposed changes I confirm it does not fix the deadlock.

  Luis
