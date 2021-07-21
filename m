Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79053D0DC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 13:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbhGUKxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 06:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbhGUKmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:42:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A898DC061574;
        Wed, 21 Jul 2021 04:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tjKLXf0Ng52UH5nHxMTM/eP+9xIaqoGvYekhvlgulkU=; b=ml92iat7e/0Z0zUSXyBKWCFT/T
        +LyfOBlYqxlteYRIYhfLZunuiaY0K4ewec4QNxKTsAhIvGnLKyEVhhQanm/af+BF2OtFcRhk4GElJ
        5a3qkimaAA9z/UuwPVhjWwfSHWIRErSBHjJL2JkvMkmBc4Ceclrfn77wnaYSomg+bKyW7LR23ZWw5
        SfrPRbkNbOVXp2zoGMtiZYFHSqjVuP96NiR3So0JPPEWP/nd/By1Hku3hx2ymY4pO1kMLzEYCbI9Q
        LI5fLcJlj77T+vGjXJtV8j+oeZfRQ1PDsGlSIZCUVZStjZsZeWA0daIESAeCtuBMJlF/PReDVvnGc
        fQJ7Kptw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6AJh-0097oC-3n; Wed, 21 Jul 2021 11:23:10 +0000
Date:   Wed, 21 Jul 2021 12:23:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v14 011/138] mm/lru: Add folio LRU functions
Message-ID: <YPgDne2ORs+tJsk2@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-12-willy@infradead.org>
 <YPao+syEWXGhDxay@kernel.org>
 <YPedzMQi+h/q0sRU@casper.infradead.org>
 <YPfdM9dLEsFXZJgf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPfdM9dLEsFXZJgf@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 11:39:15AM +0300, Mike Rapoport wrote:
> On Wed, Jul 21, 2021 at 05:08:44AM +0100, Matthew Wilcox wrote:
> > I wanted to turn those last two sentences into a list, but my
> > kernel-doc-fu abandoned me.  Feel free to submit a follow-on patch to
> > fix that ;-)
> 
> Here it is ;-)

Did you try it?  Here's what that turns into with htmldoc:

Description

We would like to get this info without a page flag, but the state needs
to survive until the folio is last deleted from the LRU, which could be
as far down as __page_cache_release.

 * 1 if folio is a regular filesystem backed page cache folio or a
   lazily freed anonymous folio (e.g. via MADV_FREE).
 * 0 if folio is a normal anonymous folio, a tmpfs folio or otherwise
   ram or swap backed folio.

Return

An integer (not a boolean!) used to sort a folio onto the right LRU list
and to account folios correctly.

Yes, we get a bulleted list, but it's placed in the wrong section!

Adding linux-doc for additional insight into this problem.
For their reference, here's the input:

/**
 * folio_is_file_lru - Should the folio be on a file LRU or anon LRU?
 * @folio: The folio to test.
 *
 * We would like to get this info without a page flag, but the state
 * needs to survive until the folio is last deleted from the LRU, which
 * could be as far down as __page_cache_release.
 *
 * Return: An integer (not a boolean!) used to sort a folio onto the
 * right LRU list and to account folios correctly.
 *
 * - 1 if @folio is a regular filesystem backed page cache folio
 *   or a lazily freed anonymous folio (e.g. via MADV_FREE).
 * - 0 if @folio is a normal anonymous folio, a tmpfs folio or otherwise
 *   ram or swap backed folio.
 */
static inline int folio_is_file_lru(struct folio *folio)

