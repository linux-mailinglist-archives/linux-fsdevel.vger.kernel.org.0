Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBBC3F6FB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 08:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbhHYGld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 02:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbhHYGla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:41:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE461C061757;
        Tue, 24 Aug 2021 23:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wwqc+zlpZGVWv443QpD/4AYHkmaNpxQkxiVuNbJuNzY=; b=WHUZ/i1haxgYWOz/PEBlGBLX++
        ghSazm9VoZ/t+9OplOg6sDgUbKJu5h6aKxmGAiFnJeqWpcYpgS8Yq2yvZGEzzexoZd4NQx2Si4qsZ
        spEMZATV2k6j74ih9qBI4JpKg1fPh0fYN7EiphdjD7IKDpvP4YhCUYvFn0MYDX059LOxNcwm6REd6
        SsFz1xZppsSvJJTHaZeCA3k8YX0TlH9SNSf1M23MoYYBnBPd8wzmQVVjSzSZmrcDnq61POMRZlWfU
        UiJ1yq24wmlAkg0of1QvBzXo1eTXC6EAgkwww4NLJmLSSt42ScqO4Q/9W+8rj/QWIGy/p6fX0n4fp
        CdTUsV1Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mImZ5-00Bz9a-22; Wed, 25 Aug 2021 06:39:25 +0000
Date:   Wed, 25 Aug 2021 07:39:11 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSXljxYnKg+6P1At@infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YSQeFPTMn5WpwyAa@casper.infradead.org>
 <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
 <CAHk-=wgkA=RKJ-vke0EoOUK19Hv1f=47Da6pWAWQZPhjKD6WOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgkA=RKJ-vke0EoOUK19Hv1f=47Da6pWAWQZPhjKD6WOg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 11:59:52AM -0700, Linus Torvalds wrote:
> But it is a lot of churn. And it basically duplicates all our page
> functions, just to have those simplified versions. And It's very core
> code, and while I appreciate the cleverness of the "folio" name, I do
> think it makes the end result perhaps subtler than it needs to be.

Maybe I'm biassed by looking at the file system and pagecache side
mostly, but if you look at the progress willy has been making a lot
of the relevant functionality will exist in either folio or page
versions, not both.  A lot of the duplication is to support the
following:

> The one thing I do like about it is how it uses the type system to be
> incremental.
