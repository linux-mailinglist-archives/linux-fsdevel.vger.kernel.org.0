Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B2D4E477C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 21:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiCVU3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 16:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiCVU3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:29:14 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9336661B
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 13:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1647980864;
        bh=EJXT/9AlvFp0di+VBt0n+rgZk07sShJSmHtb5RgXDtU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=qc13ztGyVKCiTnojPpCFyGaAV9Qz42w/BAFrgBr8/9KaQAEjw+DiHA1OHPaWxiiL6
         OSXhnxWdb8pHPpwS2+/GTFcBsPwhbVMYvp7OkO69h/BjRp7XHpdgMt/X22kDd73F4L
         +/+OsV+V7BmlrqO98qdVIYD8DHhIy2B8ncZdx9jg=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 968001286EB2;
        Tue, 22 Mar 2022 16:27:44 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KfCZc2ZIYSZ2; Tue, 22 Mar 2022 16:27:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1647980864;
        bh=EJXT/9AlvFp0di+VBt0n+rgZk07sShJSmHtb5RgXDtU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=qc13ztGyVKCiTnojPpCFyGaAV9Qz42w/BAFrgBr8/9KaQAEjw+DiHA1OHPaWxiiL6
         OSXhnxWdb8pHPpwS2+/GTFcBsPwhbVMYvp7OkO69h/BjRp7XHpdgMt/X22kDd73F4L
         +/+OsV+V7BmlrqO98qdVIYD8DHhIy2B8ncZdx9jg=
Received: from [172.20.40.85] (unknown [12.247.251.114])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8B5291286EB1;
        Tue, 22 Mar 2022 16:27:43 -0400 (EDT)
Message-ID: <948a74b09e63a32d566778d1ba535df8883e5129.camel@HansenPartnership.com>
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Colin Walters <walters@verbum.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Date:   Tue, 22 Mar 2022 16:27:42 -0400
In-Reply-To: <42d92c6f-28f2-459b-bc2a-13dd655dd4ae@www.fastmail.com>
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
         <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
         <YjFGVxImP/nVyprQ@B-P7TQMD6M-0146.local>
         <20220316025223.GR661808@dread.disaster.area>
         <YjnmcaHhE1F2oTcH@casper.infradead.org>
         <a8f6ea9ec9b8f4d9b48e97fe1236f80b62b76dc1.camel@HansenPartnership.com>
         <42d92c6f-28f2-459b-bc2a-13dd655dd4ae@www.fastmail.com>
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

On Tue, 2022-03-22 at 16:17 -0400, Colin Walters wrote:
> 
> On Tue, Mar 22, 2022, at 3:19 PM, James Bottomley wrote:
> > Well, firstly what is the exact problem?  People maliciously
> > looking up nonexistent files
> 
> Maybe most people have seen it, but for those who haven't:
> https://bugzilla.redhat.com/show_bug.cgi?id=1571183
> was definitely one of those things that just makes one recoil in
> horror.
> 
> TL;DR NSS used to have code that tried to detect "is this a network
> filesystem" by timing `stat()` calls to nonexistent paths, and this
> massively boated the negative dentry cache and caused all sorts of
> performance problems.
> It was particularly confusing because this would just happen as a
> side effect of e.g. executing `curl https://somewebsite`.
> 
> That code wasn't *intentionally* malicious but...

Right, understood.  That's why I think keeping track of negative
dentries coming back to kill_dentry/retain_dentry is a good way of
detecting something like this, so we can get a signal for "some process
bloating the negative dentry cache" and act on it.  My suspicion is
that if we see the signal we can agressively remove old negative
dentries in this same routine, thus penalizing the problem process for
cleaning the caches.  However, it's a very narrow solution somewhat
decoupled from making the dentry cache a better memory management
citizen.

James


