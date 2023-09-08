Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1104C798479
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 10:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjIHIzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 04:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjIHIzQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:55:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9CB1BEA
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 01:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H8K/XrghSHxCL6s/bo9FD1IkrVMvH7WV4gO6kwb9oWI=; b=E5vl7U9ac+Qs05naYWAfjpTo4o
        paN9NxhCtlikWZuR9SUxdcZz8fBxo88NSG3YeJ1xPJpS2dmRC8lv+K0xTDRPXp6Lg2+lD40LpRLT7
        D7M3z0NXcUAEoUoDVg6qwEnCwWz7daF3ya/IAHrAVL7SWlkK/DP3G+yW0f7Tzy1VYGE8ZWCf1T6fy
        8xbAkIvMqh1dQpW5JyuE4oFwb9RE8WbtRJLXu+aQFqQLQKYgTZjyqkxpMOusTADldiTrJ4wftN/TR
        +hxZM1m3+epgGztWecvqGznVRZFxJrHbih5ONUPZleGX4TN7/qY7mA2op64/yOiAsH8P9xRhz7pgr
        PUtYoURg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qeXGh-00DM5M-23;
        Fri, 08 Sep 2023 08:55:11 +0000
Date:   Fri, 8 Sep 2023 01:55:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPrhb9ncxrylmVyP@infradead.org>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPe0bSW10Gj7rvAW@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 09:06:21AM +1000, Dave Chinner wrote:
> I think this completely misses the point of contention of the larger
> syzbot vs filesystem discussion: the assertion that "testing via
> syzbot means the subsystem is secure" where "secure" means "can be
> used safely for operations that involve trust model violations".
> 
> Fundamentally, syzbot does nothing to actually validate the
> filesystem is "secure". Fuzzing can only find existing bugs by
> simulating an attacker, but it does nothing to address the
> underlying issues that allow that attack channel to exist.

I don't think anyone makes that assertation.  Instead the assumptions
is something that is handling untrusted input should be available to
surive fuzzing by syzbot, and that's an assumption I agree with.  That
doesn't imply anything surving syzbot is secure, but it if doesn't
survive syzbot it surely can't deal with untrusted input.

> > unmaintained.  If we want to move the kernel forward by finishing
> > API transitions (new mount API, buffer_head removal for the I/O path,
> > ->writepage removal, etc) these file systems need to change as well
> > and need some kind of testing.  The easiest way forward would be
> > to remove everything that is not fully maintained, but that would
> > remove a lot of useful features.
> 
> Linus has explicitly NACKed that approach.
> 
> https://lore.kernel.org/linux-fsdevel/CAHk-=wg7DSNsHY6tWc=WLeqDBYtXges_12fFk1c+-No+fZ0xYQ@mail.gmail.com/

.. and that is why I'm bring this up in a place where we can have
a proper procedural discussion instead of snarky remarks.  This is
a fundamental problem we;ll need to sort out.

> Which is a problem, because historically we've taken code into
> the kernel without requiring a maintainer, or the people who
> maintained the code have moved on, yet we don't have a policy for
> removing code that is slowly bit-rotting to uselessness.

... and we keep merging crap that goes against all established normal
requirements when people things it's new and shiny and cool :(

