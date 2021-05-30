Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431F33952F3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 May 2021 23:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhE3VQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 May 2021 17:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhE3VQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 May 2021 17:16:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDE5C061574;
        Sun, 30 May 2021 14:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yW68hQEkpPiNL7uFDxA39zvaW5WfzJ0CVb//k2zxdsE=; b=SvD1BTau2uhxHeBp7pn7JMUXfw
        08wnL7Y1tXf9cpMlwCv5fEUriKCRdaRXANNmc+4lPHvrdbvhJ5GRsWYFfqV/myItaPLvSEyqBdchZ
        6YkKnb560Zk4AGx5nfjel1cWtxU5EEBuRHQrmMoYeaJdfsDNKDpamtsROTId1ZH1KKkHDT+6hBgyU
        +clUPI2COgBZSDGLDYRaW15YSbK3OoeBjICDjc5J1nBvRZWaql0tuDdB0m0cekw13zxgtdo0UW9eb
        TAc0qGlgR1cjgkXYcCzDqE2DDKJLSoylZhoD3fgtglvLEEEzBPax465sN9mpqRZVA0izr6+yi4l+h
        roYFS5/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lnSlK-008Pdd-7c; Sun, 30 May 2021 21:14:25 +0000
Date:   Sun, 30 May 2021 22:14:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ian Campbell <ijc@hellion.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Jaya Kumar <jayakumar.lkml@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] fb_defio: Remove custom address_space_operations
Message-ID: <YLQALv2YENIDh77N@casper.infradead.org>
References: <20210310185530.1053320-1-willy@infradead.org>
 <YLPjwUUmHDRjyPpR@Ryzen-9-3900X.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLPjwUUmHDRjyPpR@Ryzen-9-3900X.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 30, 2021 at 12:13:05PM -0700, Nathan Chancellor wrote:
> Hi Matthew,
> 
> On Wed, Mar 10, 2021 at 06:55:30PM +0000, Matthew Wilcox (Oracle) wrote:
> > There's no need to give the page an address_space.  Leaving the
> > page->mapping as NULL will cause the VM to handle set_page_dirty()
> > the same way that it's handled now, and that was the only reason to
> > set the address_space in the first place.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> 
> This patch in mainline as commit ccf953d8f3d6 ("fb_defio: Remove custom
> address_space_operations") causes my Hyper-V based VM to no longer make
> it to a graphical environment.

Hi Nathan,

Thanks for the report.  I sent Daniel a revert patch with a full
explanation last week, which I assume he'll queue up for a pull soon.
You can just git revert ccf953d8f3d6 for yourself until that shows up.
Sorry for the inconvenience.
