Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE28158E90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgBKMeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:34:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgBKMeb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uIlXDShEskfTvbYftNPC1eqkJUsB5szLvdV7iweWe4s=; b=SeyBbYthoa6L+1pKSTBoqxCFni
        wTJRyOqUnVlYvD37j4HGWVkO1X/D0fyafdbCfsynh7E7Nd3cyOFPC/SIb5jUOMZyzdEvncdXAzReF
        vQYgsmrVkB4zwfd6rrwB1SvDqqK2SKFVfjZfVMxT8s5K4GJS8hhniBqwoUBwsteVgZNIUfpPcQ5aP
        0IPMIzBXCcgmYEtwqCZOxnn68TEw92XrWsLDyQuhAe5AlzAF01rYALZpzjl8uENQAqVFM68FPSZW4
        JFup/EfcWoR5+TyIkZIBfhMJ9badlt8+Epn37DVY1zowNGoeUikWKpJqKg7VeqVpO/jC94HcPn328
        u1r5UcAQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1UkI-0006ev-Kh; Tue, 11 Feb 2020 12:34:30 +0000
Date:   Tue, 11 Feb 2020 04:34:30 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v5 01/13] mm: Fix the return type of
 __do_page_cache_readahead
Message-ID: <20200211123430.GT8731@bombadil.infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-2-willy@infradead.org>
 <SN4PR0401MB3598602411B75B46F5267B829B180@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598602411B75B46F5267B829B180@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:19:14AM +0000, Johannes Thumshirn wrote:
> On 11/02/2020 02:05, Matthew Wilcox wrote:
> > even though I'm pretty sure we're not going to readahead more than 2^32
> > pages ever.
> 
> And 640K is more memory than anyone will ever need on a computer *scnr*

Sure, but bandwidth just isn't increasing quickly enough to have
this make sense.  2^32 pages even on our smallest page size machines
is 16GB.  Right now, we cap readahead at just 256kB.  If we did try to
readahead 16GB, we'd be occupying a PCIe gen4 x4 drive for two seconds,
just satisfying this one readahead.  PCIe has historically doubled in
bandwidth every three years or so, so to get this down to something
reasonable like a hundredth of a second, we're looking at PCIe gen12 in
twenty years or so.  And I bet we still won't do it (also, I doubt PCIe
will continue doubling bandwidth every three years).

And Linus has forbidden individual IOs over 2GB anyway, so not happening
until he's forced to see the error of his ways ;-)
