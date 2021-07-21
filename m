Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6743D0B2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 11:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbhGUIUT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 04:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237227AbhGUIAA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:00:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFBED61363;
        Wed, 21 Jul 2021 08:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626856762;
        bh=cdGZXToDNH3wVRvcOvtaAq0f15eiAAgnqELHYuf3ux0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9tql+kl9M4zdDGconByR3ww+a1DLQWAzJyLwN+vp7jgz0IIi9XCVV7uD3VBRFaHB
         cridxMan6pAFb00mOYww18hDJGQYpQyHanrwsD366rbo9j+bBfrTS2liAlb25fIad5
         psyqbUnh2rfNOQPW7BgLNIDbnbuCpwkoNGP1eaYZcG6Sw+LObdy2EKe9LCoRPmWyqr
         0MqTMDm8CcOmGFZS2x8bJGRjoyqKNWGIf3M+fI3oAUKkqAwxuOqahrCn0SvXACo/y3
         6vYonx/lxEjmQHs3ZZMIC1MU4ejcxCCgOJWfWpL+Wa0cDmtzfPwfHQ0rdYBHswRaCg
         CW8coEWoSz+Xg==
Date:   Wed, 21 Jul 2021 11:39:15 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v14 011/138] mm/lru: Add folio LRU functions
Message-ID: <YPfdM9dLEsFXZJgf@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-12-willy@infradead.org>
 <YPao+syEWXGhDxay@kernel.org>
 <YPedzMQi+h/q0sRU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPedzMQi+h/q0sRU@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 05:08:44AM +0100, Matthew Wilcox wrote:
> On Tue, Jul 20, 2021 at 01:44:10PM +0300, Mike Rapoport wrote:
> > It seems mm_inline.h is not a part of generated API docs, otherwise
> > kerneldoc would be unhappy about missing Return: description.
> 
> It isn't, but I did add mm_inline.h to Documentation as part of this
> patch (thanks!) and made this change:
> 
>  /**
> - * folio_is_file_lru - should the folio be on a file LRU or anon LRU?
> - * @folio: the folio to test
> - *
> - * Returns 1 if @folio is a regular filesystem backed page cache folio
> - * or a lazily freed anonymous folio (e.g. via MADV_FREE).  Returns 0 if
> - * @folio is a normal anonymous folio, a tmpfs folio or otherwise ram or
> - * swap backed folio.  Used by functions that manipulate the LRU lists,
> - * to sort a folio onto the right LRU list.
> + * folio_is_file_lru - Should the folio be on a file LRU or anon LRU?
> + * @folio: The folio to test.
>   *
>   * We would like to get this info without a page flag, but the state
>   * needs to survive until the folio is last deleted from the LRU, which
>   * could be as far down as __page_cache_release.
> + *
> + * Return: An integer (not a boolean!) used to sort a folio onto the
> + * right LRU list and to account folios correctly.
> + * 1 if @folio is a regular filesystem backed page cache folio
> + * or a lazily freed anonymous folio (e.g. via MADV_FREE).
> + * 0 if @folio is a normal anonymous folio, a tmpfs folio or otherwise
> + * ram or swap backed folio.
>   */
> 
> I wanted to turn those last two sentences into a list, but my
> kernel-doc-fu abandoned me.  Feel free to submit a follow-on patch to
> fix that ;-)

Here it is ;-)

Feel free to fold it into the original commit if you'd like to.

From 636d1715252f7bd1e87219797153b8baa28774af Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Wed, 21 Jul 2021 11:35:15 +0300
Subject: [PATCH] mm/docs: folio_is_file_lru: make return description a list

Reformat return value description of folio_is_file_lru() so that will be
presented as a list in the generated output.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/mm_inline.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index d39537c5471b..b263ac0a2c3a 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -15,10 +15,11 @@
  *
  * Return: An integer (not a boolean!) used to sort a folio onto the
  * right LRU list and to account folios correctly.
- * 1 if @folio is a regular filesystem backed page cache folio
- * or a lazily freed anonymous folio (e.g. via MADV_FREE).
- * 0 if @folio is a normal anonymous folio, a tmpfs folio or otherwise
- * ram or swap backed folio.
+ *
+ * - 1 if @folio is a regular filesystem backed page cache folio
+ *   or a lazily freed anonymous folio (e.g. via MADV_FREE).
+ * - 0 if @folio is a normal anonymous folio, a tmpfs folio or otherwise
+ *   ram or swap backed folio.
  */
 static inline int folio_is_file_lru(struct folio *folio)
 {
-- 
2.31.1

-- 
Sincerely yours,
Mike.
