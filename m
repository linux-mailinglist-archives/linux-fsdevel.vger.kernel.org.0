Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F552AB943
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 15:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388785AbfIFNbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 09:31:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfIFNbQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1I/BDeipPTsBBKFqmhtdSKTL8wmnK5I8ff1DW4dGwsk=; b=V47IwCs/6Zdz87+2Y+fx3VoxW
        NQNn7HC9fks9UENezH02Z7WWQogRGy0L4HNH5TsGknGf5MAigLI45z5qEcnoNWBOJhlUfFXcaL7qZ
        qq4htdq3dGM2/XNENTNC7N10Bj3TGH3mq2rpu3sBHrFhNZuQ0k79p4H/SIDAICIXzLWANsKy6+kvt
        ULbylV3e/dh4C2TDIAxMW1/UTmjOPRTXpku4blD+jMU1dpm3hKF5bnfOm1EYMboNbUXe9MlZDMcgn
        2u3XflNiLfXK4W3ZD0e4fmKdK/vr004hhakL8WoyW9FK13sgw3oFB9g0iJD5oHAPXCS6RIrH04g3m
        nT/jysphQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i6EKZ-0008Dk-EH; Fri, 06 Sep 2019 13:31:15 +0000
Date:   Fri, 6 Sep 2019 06:31:15 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [PATCH 2/3] mm: Allow large pages to be added to the page cache
Message-ID: <20190906133115.GV29434@bombadil.infradead.org>
References: <20190905182348.5319-1-willy@infradead.org>
 <20190905182348.5319-3-willy@infradead.org>
 <20190906120944.gm6lncxmkkz6kgjx@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906120944.gm6lncxmkkz6kgjx@box>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 03:09:44PM +0300, Kirill A. Shutemov wrote:
> On Thu, Sep 05, 2019 at 11:23:47AM -0700, Matthew Wilcox wrote:
> > +next:
> > +		xas_store(&xas, page);
> > +		if (++i < nr) {
> > +			xas_next(&xas);
> > +			goto next;
> >  		}
> 
> Can we have a proper loop here instead of goto?
> 
> 		do {
> 			xas_store(&xas, page);
> 			/* Do not move xas ouside the range */
> 			if (++i != nr)
> 				xas_next(&xas);
> 		} while (i < nr);

We could.  I wanted to keep it as close to the shmem.c code as possible,
and this code is scheduled to go away once we're using a single large
entry in the xarray instead of N consecutive entries.

