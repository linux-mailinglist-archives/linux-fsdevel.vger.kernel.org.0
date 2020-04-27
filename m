Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769F81B9793
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 08:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgD0Gmd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 02:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgD0Gmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:42:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C78BC061A0F;
        Sun, 26 Apr 2020 23:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8XXy6DGHElkvvG3uRrBPJZZu9JuV2U/fqGOHJLpjlME=; b=fxJqCL+rgYyFO2hMnH5w4KcO0W
        e4oSzIclMzPkRxjG8/QAk9z3YkuxqXT3VfOkdyr2OoV65OLqQa0wQ7NipthQ2FBb+KQ8sQ239GF6N
        +6KGZZOeEoPV73F63KUN2awAD4XDdASc8P9N0euTkSQzyUyiIkgTRlXVrWzGEQeQ0Lu/x+WXRkovb
        iuRQUCrZIaRl7oUXgSoGwWZe7KtAE8FwlCVgZV/Bo+v0Cophs30Zbl/Hd4+QwCoESGMtoPry0vO9G
        Zf0EN+r2ZMMKpjq+GJJkJCNfypeh8QEFjUqp06l+YA4GCk9MgYqje4jhKhX3+DNd11kDajyDlKmet
        zNBqMpjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSxTL-0005WD-SY; Mon, 27 Apr 2020 06:42:31 +0000
Date:   Sun, 26 Apr 2020 23:42:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [PATCH 0/5] ext4/overlayfs: fiemap related fixes
Message-ID: <20200427064231.GA19581@infradead.org>
References: <20200425094350.GA11881@infradead.org>
 <ECEA80AE-C2E9-4D5C-8A14-E2A92C720163@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ECEA80AE-C2E9-4D5C-8A14-E2A92C720163@dilger.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 25, 2020 at 10:32:44AM -0700, Andreas Dilger wrote:
> On Apr 25, 2020, at 02:43, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > ﻿On Sat, Apr 25, 2020 at 12:11:59PM +0300, Amir Goldstein wrote:
> >> FWIW, I agree with you.
> >> And seems like Jan does as well, since he ACKed all your patches.
> >> Current patches would be easier to backport to stable kernels.
> > 
> > Honestly, the proper fix is pretty much trivial.  I wrote it up this
> > morning over coffee:
> > 
> >    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/fiemap-fix
> > 
> > Still needs more testing, though.
> 
> The "maxbytes" value should be passed in from the caller, since this
> may be different per inode (for ext4 at least).

We should handle it, but not burden everyone else who has saner limits.
