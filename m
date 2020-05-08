Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B541CB8BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 22:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEHUDY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 16:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgEHUDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 16:03:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F4FC061A0C;
        Fri,  8 May 2020 13:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=UYn2z6n+L+AvMY1L8ilIOE7d4kxYCxQt3oTadxSZ8JM=; b=kAKMdwcDXsnJ6b5ZZPP6IUxiN1
        swzM8MoBxnXH+rIiVrEsFr0TG6OTx1BkuzcMj5jixIBC2q12I6tRxTQ3MvMDDFHXPyZPU8hb9lmcW
        C24Dc/oNRvVu4LxAKP5R4YyCOKM0RWFusSl/Ftctlji996tdHp5HV40WdLOF3RwNHt12WpvMG9gvw
        CIHUyJ3vNDagdhVbbzpyqCaO9JDj8THmKTvaXxKSWon/0BS03t3TyJgXpA9yCI2mDbUVmaH9VVZ/I
        tm9+wCWtmhxMR4OBugJShTNCaQJHwnR7zwIS6Swz2oW14UzSTY0bIs0xSBBjvR4TUyhz0PkItE+ek
        /IHL1eTw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX9DM-0007kI-8X; Fri, 08 May 2020 20:03:20 +0000
Date:   Fri, 8 May 2020 13:03:20 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RFC 1/8] dcache: show count of hash buckets in sysctl
 fs.dentry-state
Message-ID: <20200508200320.GS16070@bombadil.infradead.org>
References: <158893941613.200862.4094521350329937435.stgit@buzz>
 <158894059427.200862.341530589978120554.stgit@buzz>
 <7c1cef87-2940-eb17-51d4-cbc40218b770@redhat.com>
 <ac1ece33-46ea-175a-98ef-c79fcd1ced90@yandex-team.ru>
 <741172f7-a0d2-1428-fb25-789e38978d4e@redhat.com>
 <1f137f70-3d37-eb70-2e85-2541e504afbd@yandex-team.ru>
 <34ed1b12-1bee-8158-3084-fb1059b6686a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34ed1b12-1bee-8158-3084-fb1059b6686a@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 08, 2020 at 04:00:08PM -0400, Waiman Long wrote:
> On 5/8/20 3:38 PM, Konstantin Khlebnikov wrote:
> > On 08/05/2020 22.05, Waiman Long wrote:
> > > On 5/8/20 12:16 PM, Konstantin Khlebnikov wrote:
> > > > On 08/05/2020 17.49, Waiman Long wrote:
> > > > > On 5/8/20 8:23 AM, Konstantin Khlebnikov wrote:
> > > > > > Count of buckets is required for estimating average
> > > > > > length of hash chains.
> > > > > > Size of hash table depends on memory size and printed once at boot.
> > > > > > 
> > > > > > Let's expose nr_buckets as sixth number in sysctl fs.dentry-state
> > > > > 
> > > > > The hash bucket count is a constant determined at boot time.
> > > > > Is there a need to use up one dentry_stat entry for that?
> > > > > Besides one can get it by looking up the kernel dmesg log
> > > > > like:
> > > > > 
> > > > > [    0.055212] Dentry cache hash table entries: 8388608
> > > > > (order: 14, 67108864 bytes)
> > > > 
> > > > Grepping logs since boot time is a worst API ever.
> > > > 
> > > > dentry-state shows count of dentries in various states.
> > > > It's very convenient to show count of buckets next to it,
> > > > because this number defines overall scale.
> > > 
> > > I am not against using the last free entry for that. My only concern
> > > is when we want to expose another internal dcache data point via
> > > dentry-state, we will have to add one more number to the array which
> > > can cause all sort of compatibility problem. So do we want to use
> > > the last free slot for a constant that can be retrieved from
> > > somewhere else?
> > 
> > I see no problem in adding more numbers into sysctl.
> > Especially into such rarely used.
> > This interface is designed for that.
> > 
> > Also fields 'age_limit' and 'want_pages' are unused since kernel 2.2.0
> 
> Well, I got rebuke the last time I want to reuse one of age_limit/want_pages
> entry for negative dentry count because of the potential of breaking some
> really old applications or tools. Changing dentry-state to output one more
> number can potentially break compatibility too. That is why I am questioning
> if it is a good idea to use up the last free slot.

I'd rather see the nr_buckets exposed some other way, leaving this file
for dynamic state.
