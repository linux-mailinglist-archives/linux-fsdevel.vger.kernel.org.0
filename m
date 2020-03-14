Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408F4185AE3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 08:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgCOHPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 03:15:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgCOHPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 03:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uEmqxb+PLDhAqiQj+TB1T58aNriZfkwYBvEAt6vKntk=; b=tZb1OlDuQGZDCFk3bfbZFM2yZ+
        turf0R5msUmaz6ORycgL+6YjsdxEgTUhhJqlqugR8FcfXWGyYw+BaMnYlpnaJD5YLXcc2lz9FsfUD
        7dmu/mGfZXX32c8j55Djb2CCmbZYB3DIsLWlb3TKjBPnUBKpXmSAjGJvhMivptM4wBceoL6d9ho3O
        aa+mwEZsGXQgHUyitZx2f1GNmT2L2ptiT/cjbu5vCG2CKAz9wR08Xr5/TAwMqRJlBBeIKnz3rRsLH
        Egc0mZ294nrpoKbXSgH2XijCZIkS0/Hw/y6VsA+FuLLJPY01HEPveyp5SSu3HoEf5Hqgrw477TsBQ
        XZ4BHVdg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDCs1-00032O-Pr; Sat, 14 Mar 2020 19:54:53 +0000
Date:   Sat, 14 Mar 2020 12:54:53 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/8] xarray: Provide xas_erase() helper
Message-ID: <20200314195453.GS22433@bombadil.infradead.org>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204142514.15826-3-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 03:25:08PM +0100, Jan Kara wrote:
> Currently xas_store() clears marks when stored value is NULL. This is
> somewhat counter-intuitive and also causes measurable performance impact
> when mark clearing is not needed (e.g. because marks are already clear).
> So provide xas_erase() helper (similarly to existing xa_erase()) which
> stores NULL at given index and also takes care of clearing marks. Use
> this helper from __xa_erase() and item_kill_tree() in tools/testing.  In
> the following patches, callers that use the mark-clearing property of
> xas_store() will be converted to xas_erase() and remaining users can
> enjoy better performance.

I (finally!) figured out what I don't like about this series.  You're
changing the semantics of xas_store() without changing the name, so
if we have any new users in flight they'll use the new semantics when
they're expecting the old.

Further, while you've split the patches nicely for review, they're not
good for bisection because the semantic change comes right at the end
of the series, so any problem due to this series is going to bisect to
the end, and not tell us anything useful.

What I think this series should do instead is:

Patch 1:
+#define xas_store(xas, entry)	xas_erase(xas, entry)
-void *xas_store(struct xa_state *xas, void *entry)
+void *__xas_store(struct xa_state *xas, void *entry)
-	if (!entry)
-		xas_init_marks(xas);
+void *xas_erase(struct xa_state *xas, void *entry)
+{
+	xas_init_marks(xas);
+	return __xas_store(xas, entry);
+}
(also documentation changes)

Patches 2-n:
Change each user of xas_store() to either xas_erase() or __xas_store()

Patch n+1:
-#define xas_store(xas, entry)  xas_erase(xas, entry)

Does that make sense?  I'll code it up next week unless you want to.
