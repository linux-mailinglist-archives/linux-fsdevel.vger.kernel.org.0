Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB293E1B2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 20:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbhHESYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 14:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241011AbhHESYw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:24:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727CC061765;
        Thu,  5 Aug 2021 11:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7ZEtilizO2+Pq/XgaczvBZxUkMnqeoxhTTdNMd/Upys=; b=rD69JWPQ77F+RpxlOuXiLX8+ms
        pPoxsSeYzCB6md9pz+ZHu1zFjwPr5EaA5Mz4gnLSgqe2I+di4Mfjb3QRPNZ1/yP4V60+66ztpP502
        TqPuO1CJI4sYGcn1xWwxXG+939qRy0m+Sk76GkjpCMWhxi3S4gnVxMermg9Hfiqrs8AnA0mmbokWX
        WbOgrIvAM9vyLP2k4xRs+09qTi9fLhaaFRok7tuHq64HTOsLRq5HzDTyvZDljbMjXFU6c3dJOLDj9
        AQlExOFuQ1QcqaqgSt5z3Atqeq7WUdyHLj9Tlvv/VhwH7d0dbPrNn7df4FNOPilFtTWpYQL7V6mmd
        Vv5jDpUA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBi2e-007Nls-32; Thu, 05 Aug 2021 18:24:33 +0000
Date:   Thu, 5 Aug 2021 19:24:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] iomap: Use kmap_local_page instead of kmap_atomic
Message-ID: <YQws3DQyk6pnyiBY@casper.infradead.org>
References: <20210803193134.1198733-1-willy@infradead.org>
 <20210805173104.GF3601405@magnolia>
 <20210805173903.GH3601405@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805173903.GH3601405@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 05, 2021 at 10:39:03AM -0700, Darrick J. Wong wrote:
> Though now that I think about it: Why does iomap_write_actor still use
> copy_page_from_iter_atomic?  Can that be converted to use regular
> copy_page_from_iter, which at least sometimes uses kmap_local_page?

I suspect copy_page_from_iter_atomic() should be converted to use
kmap_local_page(), but I don't know.  generic_perform_write() uses
the _atomic() version, so I'm not doing anything different without
understanding more than I currently do.
