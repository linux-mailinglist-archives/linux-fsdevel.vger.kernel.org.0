Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29814E47A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 21:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiCVUjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 16:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiCVUjH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:39:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB18561A21
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 13:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dv5mPsrTFDOdECSclyFGEOSyR54CIbYfgKo9WOCShhY=; b=VKNujyJH2KnwzcEIlFNkwphEUC
        Ydu9kgNm0CYYte6Py4ib0P9egATdn1S4INBnXa5xkMORWQzIZPO1C1wP/emrlypbz8l5ym39K8T0Z
        ZV7JQEdb47bC/ZuLWs9HYEy5tpIGHB8NjbeaosUz+QDzDiDLHzLctwHLw8vMk2t2kuq1gDXJ49eqA
        zf0TPvV7cYIaEMFys9f258D87wJttsxd2Dy1biwDC0GUzJDUoxa+OIoXj5kvJQ/fnBx8y07DR4IGg
        ni9rIoRqqv83yBl0tGLQQ05HfQKQjPeiSAScTpT3n0ZDMmURqfbJpr6OZBNaJ0dB8hlvEyD7oGoKz
        OwgcLmSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWlFq-00Bv1O-0c; Tue, 22 Mar 2022 20:37:22 +0000
Date:   Tue, 22 Mar 2022 20:37:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Colin Walters <walters@verbum.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dave Chinner <david@fromorbit.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
Message-ID: <YjozgfjcNLXIQKhG@casper.infradead.org>
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
 <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
 <YjFGVxImP/nVyprQ@B-P7TQMD6M-0146.local>
 <20220316025223.GR661808@dread.disaster.area>
 <YjnmcaHhE1F2oTcH@casper.infradead.org>
 <a8f6ea9ec9b8f4d9b48e97fe1236f80b62b76dc1.camel@HansenPartnership.com>
 <42d92c6f-28f2-459b-bc2a-13dd655dd4ae@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42d92c6f-28f2-459b-bc2a-13dd655dd4ae@www.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 04:17:16PM -0400, Colin Walters wrote:
> 
> 
> On Tue, Mar 22, 2022, at 3:19 PM, James Bottomley wrote:
> > 
> > Well, firstly what is the exact problem?  People maliciously looking up
> > nonexistent files
> 
> Maybe most people have seen it, but for those who haven't:
> https://bugzilla.redhat.com/show_bug.cgi?id=1571183
> was definitely one of those things that just makes one recoil in horror.
> 
> TL;DR NSS used to have code that tried to detect "is this a network filesystem"
> by timing `stat()` calls to nonexistent paths, and this massively boated
> the negative dentry cache and caused all sorts of performance problems.
> It was particularly confusing because this would just happen as a side effect of e.g. executing `curl https://somewebsite`.
> 
> That code wasn't *intentionally* malicious but...

Oh, the situation where we encountered the problem was systemd.
Definitely not malicious, and not even stupid (as the NSS example above).
I forget exactly which thing it was, but on some fairly common event
(user login?), it looked up a file in a PATH of some type, failed
to find it in the first two directories, then created it in a third.
At logout, it deleted the file.  Now there are three negative dentries.
Repeat a few million times (each time looking for a different file)
with no memory pressure and you have a thoroughly soggy machine that
is faster to reboot than to reclaim dentries.

