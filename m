Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4949164B0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 17:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgBSQwn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 11:52:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgBSQwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cgHnf3SMrTZMA4DpDgtFfVIHiHWSF/Dqsrx7GRLBvxI=; b=H1FNokl1Ks6Q/eFXln6I/UnzU6
        uNPywSHLbBZMMZub1YA6iLdFROQLpb7R/fkeHp2sx0LOh1LezwyK8b9RGHm1SZgBBgV0hcuEYRTAQ
        merEyI+w6w69t8v9PstDfEANDQwcW54pT4F2pguMCpy3hjaFfoP4hfJjnowwZoEaPgkKVPELazSh7
        6MLj14ZI0IkhiXqV5kOdKJZhGS6aIbjkm7qAH2uiQ1ZhpJTCeJ83OSUkPpb8l4bDwSTNNn54WBzkn
        Xy0Vd/PJU5zw6BFXMmfy5bDA3dtZOsOmWEUwuKUFuf61CMwyRMl2Tf/PF4JJ6E7Tim/Qm4mru/2Bl
        SNgQBpHQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4SaX-0004DT-TU; Wed, 19 Feb 2020 16:52:41 +0000
Date:   Wed, 19 Feb 2020 08:52:41 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
        linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 08/19] mm: Add readahead address space operation
Message-ID: <20200219165241.GR24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-14-willy@infradead.org>
 <20200219031044.GA1075@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219031044.GA1075@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 07:10:44PM -0800, Eric Biggers wrote:
> > +``readahead``
> > +	Called by the VM to read pages associated with the address_space
> > +	object.  The pages are consecutive in the page cache and are
> > +	locked.  The implementation should decrement the page refcount
> > +	after starting I/O on each page.  Usually the page will be
> > +	unlocked by the I/O completion handler.  If the function does
> > +	not attempt I/O on some pages, the caller will decrement the page
> > +	refcount and unlock the pages for you.	Set PageUptodate if the
> > +	I/O completes successfully.  Setting PageError on any page will
> > +	be ignored; simply unlock the page if an I/O error occurs.
> > +
> 
> This is unclear about how "not attempting I/O" works and how that affects who is
> responsible for putting and unlocking the pages.  How does the caller know which
> pages were not attempted?  Can any arbitrary subset of pages be not attempted,
> or just the last N pages?

Changed to:

``readahead``
        Called by the VM to read pages associated with the address_space
        object.  The pages are consecutive in the page cache and are
        locked.  The implementation should decrement the page refcount
        after starting I/O on each page.  Usually the page will be
        unlocked by the I/O completion handler.  If the filesystem decides
        to stop attempting I/O before reaching the end of the readahead
        window, it can simply return.  The caller will decrement the page
        refcount and unlock the remaining pages for you.  Set PageUptodate
        if the I/O completes successfully.  Setting PageError on any page
        will be ignored; simply unlock the page if an I/O error occurs.

