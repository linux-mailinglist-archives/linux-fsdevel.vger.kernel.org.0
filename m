Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70D93D117C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 16:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbhGUNzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231139AbhGUNzi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:55:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1C1D6121F;
        Wed, 21 Jul 2021 14:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626878174;
        bh=OoSIb5rdAAyByaIH7juDwMpDP+yfFGAa/j+nu8lp9ZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LU8Bd2+gTsPqudTVI86lm3Oh/Qzy07FrWI+64sn8Kx1kZwH3mcW+yyRDK65iO2SUF
         bCZgf1XqQMgHdpn1+VUN3LbvMkivGTSjApejKMjMpIm7059FVpFgyMpGd7vKdrld6n
         +TV3al+pid0aP/b6/Vyw2Q/Nn0B2+aROfZRqmAYpCMNC0CtBk+oc0TJO3dhRUbaOBK
         vThI48NXQuOLknNVAX3MZ/jWLR+ZUHWkJEIyS1vHFF9IWy6/OKzBGPbWwFDNO39jLR
         xZjGxD/IEQjnqpT8iFblS+y/59EIaFKnF3/JDGsqwg+0/bSS3Wb2C9HaruyUftPxOh
         RwJKhAm3Vfv5w==
Date:   Wed, 21 Jul 2021 17:36:08 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v14 011/138] mm/lru: Add folio LRU functions
Message-ID: <YPgw2AVMuK2YkCIT@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-12-willy@infradead.org>
 <YPao+syEWXGhDxay@kernel.org>
 <YPedzMQi+h/q0sRU@casper.infradead.org>
 <YPfdM9dLEsFXZJgf@kernel.org>
 <YPgDne2ORs+tJsk2@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPgDne2ORs+tJsk2@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 12:23:09PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 21, 2021 at 11:39:15AM +0300, Mike Rapoport wrote:
> > On Wed, Jul 21, 2021 at 05:08:44AM +0100, Matthew Wilcox wrote:
> > > I wanted to turn those last two sentences into a list, but my
> > > kernel-doc-fu abandoned me.  Feel free to submit a follow-on patch to
> > > fix that ;-)
> > 
> > Here it is ;-)
> 
> Did you try it?  Here's what that turns into with htmldoc:

Yes, but I was so happy to see bullets that I missed the fact they are in
the wrong section :(
 
> Description
> 
> We would like to get this info without a page flag, but the state needs
> to survive until the folio is last deleted from the LRU, which could be
> as far down as __page_cache_release.
> 
>  * 1 if folio is a regular filesystem backed page cache folio or a
>    lazily freed anonymous folio (e.g. via MADV_FREE).
>  * 0 if folio is a normal anonymous folio, a tmpfs folio or otherwise
>    ram or swap backed folio.
> 
> Return
> 
> An integer (not a boolean!) used to sort a folio onto the right LRU list
> and to account folios correctly.
> 
> Yes, we get a bulleted list, but it's placed in the wrong section!
> 
> Adding linux-doc for additional insight into this problem.
> For their reference, here's the input:
>
> /**
>  * folio_is_file_lru - Should the folio be on a file LRU or anon LRU?
>  * @folio: The folio to test.
>  *
>  * We would like to get this info without a page flag, but the state
>  * needs to survive until the folio is last deleted from the LRU, which
>  * could be as far down as __page_cache_release.
>  *
>  * Return: An integer (not a boolean!) used to sort a folio onto the
>  * right LRU list and to account folios correctly.
>  *
>  * - 1 if @folio is a regular filesystem backed page cache folio
>  *   or a lazily freed anonymous folio (e.g. via MADV_FREE).
>  * - 0 if @folio is a normal anonymous folio, a tmpfs folio or otherwise
>  *   ram or swap backed folio.
>  */
> static inline int folio_is_file_lru(struct folio *folio)

Hmm, there is some contradiction between kernel-doc assumption that
anything after a blank line is the default (i.e. Description) section and
the sphynx ideas where empty blank lines should be:


	if ($state == STATE_BODY_WITH_BLANK_LINE && /^\s*\*\s?\S/) {
		dump_section($file, $section, $contents);
		$section = $section_default;
		$new_start_line = $.;
		$contents = "";
	}

(from scripts/kernel-doc::process_body())

-- 
Sincerely yours,
Mike.
