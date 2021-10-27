Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358F443CC3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 16:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbhJ0Oae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 10:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242556AbhJ0Oad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:30:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A83BC061570;
        Wed, 27 Oct 2021 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1KiXvZSEv7u0TMNxDkm/8GeTyuUOS2eLIKnX1ZpOfDU=; b=raBwmGRGud2Nulo6ceSvmmFwxW
        765wjTHu35TF/PK97lqZlBigzDF0BesGgPJBxXHTFPhVHqwVMCxbbpc/axD2wxN5QkGHRlFfWe75u
        Vi/uDG6hPXh3o69NhQEd3aNW62Hpb5ovqPBifM+Alunt1AcfBZSDhGaba0wsKfa68ttzsuT0sOlZS
        D9YmborK2KVSDHFIAGXBMSAUTk5axrvJvSTdhseh9MXkOzRSr25d/LCUOQw7WpoP5AGd0fvxrig4u
        Ub2+MYpgmXtvQySsHJ0Wf0Bi/eSvLkYsz0GI9EDSNcEkyLBGmfK/9x8o3+AuavxpZO8nQaushinyG
        X6LqMnTg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfju8-00579x-Pc; Wed, 27 Oct 2021 14:27:48 +0000
Date:   Wed, 27 Oct 2021 07:27:48 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Petr Mladek <pmladek@suse.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YXlh5K7FyeBXNafM@bombadil.infradead.org>
References: <alpine.LSU.2.21.2110190820590.15009@pobox.suse.cz>
 <YW6OptglA6UykZg/@T590>
 <alpine.LSU.2.21.2110200835490.26817@pobox.suse.cz>
 <YW/KEsfWJMIPnz76@T590>
 <alpine.LSU.2.21.2110201014400.26817@pobox.suse.cz>
 <YW/q70dLyF+YudyF@T590>
 <YXfA0jfazCPDTEBw@alley>
 <YXgguuAY5iEUIV0u@T590>
 <YXg0dFZ+6qHw7d0g@bombadil.infradead.org>
 <alpine.LSU.2.21.2110271343290.3655@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2110271343290.3655@pobox.suse.cz>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27, 2021 at 01:57:40PM +0200, Miroslav Benes wrote:
> On Tue, 26 Oct 2021, Luis Chamberlain wrote:
> 
> > On Tue, Oct 26, 2021 at 11:37:30PM +0800, Ming Lei wrote:
> > > OK, then Luis shouldn't consider livepatching as one such issue to solve
> > > with one generic solution.
> > 
> > It's not what I was told when the deadlock was found with zram, so I was
> > informed quite the contrary.
> 
> From my perspective, it is quite easy to get it wrong due to either a lack 
> of generic support, or missing rules/documentation.

Indeed. I agree some level of guidence is needed, even if subtle, rather
than tribal knowledge. I'll start off with the test_sysfs demo'ing what
not to do and documenting this there. I don't think it makes sense to
formalize yet documentation for "though shalt not do this" generically
until a full depth search is done with Coccinelle.

> So if this thread 
> leads to "do not share locks between a module removal and a sysfs 
> operation" strict rule, it would be at least something.

I think that's where we are at. I'll wait to complete my coccinelle
deadlock hunt patch to complete the full search, and that could be
useful to *warn* aboute new use cases, so to prevent this deadlock
in the future. Until then I agree that the complexity introduced is
not worth it given the evidence of users, but the full evidence of
actual users still remains to be determined. A perfect job left to
advances with Coccinelle.

> In the same 
> manner as Luis proposed to document try_module_get() expectations.

Right and so sysfs ops using try_module_get() *still* remains safe,
and so will keep that patch in my next iteration because there *are*
*many* uses cases for that.

  Luis
