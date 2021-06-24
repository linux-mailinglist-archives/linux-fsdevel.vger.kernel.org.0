Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D1C3B35E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 20:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhFXSkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 14:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXSkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:40:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E37FC061574;
        Thu, 24 Jun 2021 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E+uLdTeJRbTTNHca4zI78GWb1XhxGHzRHR8t0yMnlDs=; b=sCqo0PLQqL9Uemwsd99lDLlnrO
        ppRBZb+YSjSy6ZehBdwNitdTNNRLyJZs3g9lkwyZ31Mne3wrcykwaRtEzxFCZr46QCCU2Ifwnhmc3
        2fsfYU7mHUOPepEL1Bz9AX0xcqvAyFfuZQ646Ey3YdlzYqp/bB/ZEz1c08SDnIqbbBkmxLuZMC/CB
        +PMqu6RmbKL/fIMzXbQHZkw5CNYauqeMQxolFR0ILlQaOlrFTcQA9THOGi8ktWc4KQllzs6KaQes2
        y64H2b9f2668qetRhHPwsp82Xl9oCj28v3JldJldk1ep/pGQM+o+JGbmBl7Oqq/GSAEsreqFXCP1h
        O/1ZoWLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwUEE-00GsyS-MO; Thu, 24 Jun 2021 18:37:33 +0000
Date:   Thu, 24 Jun 2021 19:37:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 27/46] mm/writeback: Add __folio_mark_dirty()
Message-ID: <YNTQ6o0kxESisBri@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-28-willy@infradead.org>
 <YNL+cHDPMfvvXMUh@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNL+cHDPMfvvXMUh@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 11:27:12AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 22, 2021 at 01:15:32PM +0100, Matthew Wilcox (Oracle) wrote:
> > Turn __set_page_dirty() into a wrapper around __folio_mark_dirty() (which
> > can directly cast from page to folio because we know that set_page_dirty()
> > calls filesystems with the head page).  Convert account_page_dirtied()
> > into folio_account_dirtied() and account the number of pages in the folio.
> 
> Is it really worth micro-optimizing a transitional function like that?
> I'd rather eat the overhead of the compound_page() call over adding hacky
> casts like this.

Fair enough.  There's only three calls to it and one of them goes away
this series.
