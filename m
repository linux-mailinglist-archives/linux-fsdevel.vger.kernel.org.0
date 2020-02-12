Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD94E159E4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 01:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgBLArD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 19:47:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbgBLArD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 19:47:03 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 680A620724;
        Wed, 12 Feb 2020 00:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581468422;
        bh=b5/Kny9cJImOUuHhADCWZI8pySPcI8WjgPGzmYXJLvs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pdi2yUhMfT/ufvgDf4nz7m/Us3dBR2ijOxFyhnlLw9lcDNcE37lv8LiiZINqQba+p
         F0bGhLX9k23YHVoRW3Teow2JsQ9nUhs+NiCTx052yQPs7m+CEvrC2QZHfuHjmWLF90
         uMNYvJSsqnIm0C0j4X6DKsYHRdoWyaV0GaAtOeiI=
Date:   Tue, 11 Feb 2020 16:47:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-Id: <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
In-Reply-To: <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
        <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
        <20200211193101.GA178975@cmpxchg.org>
        <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
        <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 11 Feb 2020 16:28:39 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Feb 11, 2020 at 3:44 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > Testing this will be a challenge, but the issue was real - a 7GB
> > highmem machine isn't crazy and I expect the inode has become larger
> > since those days.
> 
> Hmm. I would say that in the intening years a 7GB highmem machine has
> indeed become crazy.
> 
> It used to be something we kind of supported.
> 
> But we really should consider HIGHMEM to be something that is on the
> deprecation list. In this day and age, there is no excuse for running
> a 32-bit kernel with lots of physical memory.
> 
> And if you really want to do that, and have some legacy hardware with
> a legacy use case, maybe you should be using a legacy kernel.
> 
> I'd personally be perfectly happy to start removing HIGHMEM support again.
> 

That would be nice.

What's the situation with highmem on ARM?
