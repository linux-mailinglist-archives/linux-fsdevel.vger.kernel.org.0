Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972324EF79F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 18:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349423AbiDAQV2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 12:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354279AbiDAQTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:19:55 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3662908A4
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Apr 2022 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1648827953;
        bh=1HFcOv9yGn8/lngEG08p2V7uQ1M/YP1S+7dLLsR72iQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=NsqsxbxOURRoJuUAz+qpdsMDHoXP6dEiwIXoLpvY/2vZH6lF+NRPAsV7w4d98lAIa
         XnML0sieFlns9M2ykUHygzUciQfhQmUbD9+FBO+HlFOMR16VqGCDQsGrBy7G97oRT1
         DZ2w8NclU+HRAD5NNJQjA6VqJQp48lR7UtGjXtoI=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4370F1288A1B;
        Fri,  1 Apr 2022 11:45:53 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z5kXgOLI7dlj; Fri,  1 Apr 2022 11:45:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1648827953;
        bh=1HFcOv9yGn8/lngEG08p2V7uQ1M/YP1S+7dLLsR72iQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=NsqsxbxOURRoJuUAz+qpdsMDHoXP6dEiwIXoLpvY/2vZH6lF+NRPAsV7w4d98lAIa
         XnML0sieFlns9M2ykUHygzUciQfhQmUbD9+FBO+HlFOMR16VqGCDQsGrBy7G97oRT1
         DZ2w8NclU+HRAD5NNJQjA6VqJQp48lR7UtGjXtoI=
Received: from [IPv6:2601:5c4:4300:c551::c14] (unknown [IPv6:2601:5c4:4300:c551::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 27874128880F;
        Fri,  1 Apr 2022 11:45:52 -0400 (EDT)
Message-ID: <0617b867836a81ba51a8f0abf27b59a5c2409f07.camel@HansenPartnership.com>
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Date:   Fri, 01 Apr 2022 11:45:50 -0400
In-Reply-To: <87o81l6hxi.fsf@stepbren-lnx.us.oracle.com>
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
         <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
         <YjFGVxImP/nVyprQ@B-P7TQMD6M-0146.local>
         <20220316025223.GR661808@dread.disaster.area>
         <YjnmcaHhE1F2oTcH@casper.infradead.org>
         <a8f6ea9ec9b8f4d9b48e97fe1236f80b62b76dc1.camel@HansenPartnership.com>
         <42d92c6f-28f2-459b-bc2a-13dd655dd4ae@www.fastmail.com>
         <YjozgfjcNLXIQKhG@casper.infradead.org>
         <3a7abaca-e20f-ad59-f6f0-caedd8450f9f@oracle.com>
         <f849f7f981ef76b30b4d91457752b3740b1f6d51.camel@HansenPartnership.com>
         <87o81l6hxi.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-03-31 at 12:27 -0700, Stephen Brennan wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
> > On Tue, 2022-03-22 at 14:08 -0700, Stephen Brennan wrote:
> [snip]
> > > If we're looking at issues like [1], then the amount needs to be
> > > on a per-directory basis, and maybe roughly based on CPU speed.
> > > For other priorities or failure modes, then the policy would need
> > > to be completely different. Ideally a solution could work for
> > > almost all scenarios, but failing that, maybe it is worth
> > > allowing policy to be set by administrators via sysctl or even a
> > > BPF?
> > 
> > Looking at [1], you're really trying to contain the parent's child
> > list from exploding with negative dentries.  Looking through the
> > patch, it still strikes me that dentry_kill/retain_dentry is still
> > a better place, because if a negative dentry comes back there, it's
> > unlikely to become positive (well, fstat followed by create would
> > be the counter example, but it would partly be the app's fault for
> > not doing open(O_CREAT)).
> 
> I actually like the idea of doing the pruning during d_alloc().
> Basically, if you're creating dentries, you should also be working on
> the cache management for them.

Agreed, but all of the profligate negative dentry creators do 

lookup ... dput

The final dput causes a dentry_kill() (if there are no other
references), so they still get to work on cache management, plus you
get a better signal for "I just created a negative dentry".

I'm not saying either is right: doing it in d_alloc shares the work
among all things that create dentries which may produce better
throughput.  Doing it in dentry_kill allows you to shovel more work on
to the negative dentry creators which can cause a greater penalty for
creating them.

James


