Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3965C153DDC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 05:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgBFE2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 23:28:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBFE2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 23:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3srDzlj3vxXLns6YOc9QAbtKzzZ9q6dWVHo3WgMGcfE=; b=kN55My+Qc29t3mB+G7VtG28zKU
        QPddywk7j32t/qKFPhIEecZ/Y1HFbE1bh9fUIoRMGF9XPYVHZDHe+sT90Px7GjsfPP+1+R2TQhQes
        qbhSurGhedq6RWNWYDB8YptU7dqwOtnmrxB3e9XO0aDPij8InGckr6+3O8WlfDwPbTUkZmVlB+VPX
        Gimi4W+eCWLmmeYBoctZ5wqlxeu4FoIV8DfteeFCVW6I06a8OxIdKeGEmJ488CwihlRYRN8jiqyRr
        b+UBXOctrUZl6GZoF10UuYuwdYEgnRtQLJ8+in8kyKibW+cIpY7pUdirbIsR7ZCk//n+O+BXp1mpR
        8kDUVSrQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izYll-0008QL-Gy; Thu, 06 Feb 2020 04:28:01 +0000
Date:   Wed, 5 Feb 2020 20:28:01 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 8/8] xarray: Don't clear marks in xas_store()
Message-ID: <20200206042801.GV8731@bombadil.infradead.org>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-9-jack@suse.cz>
 <8ea2682b-7240-dca3-b123-2df7d0c994ba@nvidia.com>
 <20200206022144.GU8731@bombadil.infradead.org>
 <01e577b2-3349-15bc-32c7-b556e9f08536@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01e577b2-3349-15bc-32c7-b556e9f08536@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 07:48:57PM -0800, John Hubbard wrote:
> You can then set entries using xa_store() and get entries
> using xa_load().  xa_store will overwrite any entry with the
> new entry and return the previous entry stored at that index.  You can
> use xa_erase(), instead of calling xa_store() with a
> ``NULL`` entry followed by xas_init_marks().  There is no difference between
> an entry that has never been stored to and one that has been erased. Those,
> in turn, are the same as an entry that has had ``NULL`` stored to it and
> also had its marks erased via xas_init_marks().

There's a fundamental misunderstanding here.  If you store a NULL, the
marks go away.  There is no such thing as a marked NULL entry.  If you
observe such a thing, it can only exist through some kind of permitted
RCU race, and the entry must be ignored.  If you're holding the xa_lock,
there is no way to observe a NULL entry with a search mark set.

What Jan is trying to do is allow code that knows what it's doing
the ability to say "Skip clearing the marks for performance reasons.
The marks are already clear."

I'm still mulling over the patches from Jan.  There's something I don't
like about them, but I can't articulate it in a useful way yet.  I'm on
board with the general principle, and obviously the xas_for_each_marked()
bug needs to be fixed.
