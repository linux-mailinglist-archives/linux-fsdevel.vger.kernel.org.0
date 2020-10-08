Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3172287C85
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 21:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgJHTdJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 15:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHTdI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:33:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F15BC0613D2
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2020 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BHYNWcWHIFZvVZFOrN5msKH7zebNjbiD4DhvwYAYv8g=; b=WtKqtTYFnWStgYMZ2Ii4ZkWL/J
        5VcSFFsPi/0uUCZ3Bgy/wKp/PsALEneWOFem2MTRPmtdVymmgotP68cHfrWos4OuKduHZzIl2zIJQ
        BOBnSQ4xy9IoePSftqZq5TxYBwXQMESJQV2wHwivsBCp2EbN9chVJcBPnDXfGN5RM6WDESexMEZxb
        TXsk60h68uXyRkqnspvPQW+qo7o1BntcHL6TQunHEk3ssVMKe8dNpqK/lrfAp+s88E4IvchIrBr9H
        YiMRHY+ZMGDBLQSMtL41gw2gCHd2dq1pk93L5VH8nbEUUgkGbIv9QpJSLfgsmkK8HPkgcMOyHVNw0
        ovZZsPHw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQbev-0007bI-Rb; Thu, 08 Oct 2020 19:33:01 +0000
Date:   Thu, 8 Oct 2020 20:33:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 0/4] Remove nrexceptional tracking
Message-ID: <20201008193301.GN20115@casper.infradead.org>
References: <20200804161755.10100-1-willy@infradead.org>
 <898e058f12c7340703804ed9d05df5ead9ecb50d.camel@intel.com>
 <ee26fdf05127b7aea69db9d025d6ba5e677479bb.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee26fdf05127b7aea69db9d025d6ba5e677479bb.camel@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 06, 2020 at 08:16:02PM +0000, Verma, Vishal L wrote:
> On Thu, 2020-08-06 at 19:44 +0000, Verma, Vishal L wrote:
> > > 
> > > I'm running xfstests on this patchset right now.  If one of the DAX
> > > people could try it out, that'd be fantastic.
> > > 
> > > Matthew Wilcox (Oracle) (4):
> > >   mm: Introduce and use page_cache_empty
> > >   mm: Stop accounting shadow entries
> > >   dax: Account DAX entries as nrpages
> > >   mm: Remove nrexceptional from inode
> > 
> > Hi Matthew,
> > 
> > I applied these on top of 5.8 and ran them through the nvdimm unit test
> > suite, and saw some test failures. The first failing test signature is:
> > 
> >   + umount test_dax_mnt
> >   ./dax-ext4.sh: line 62: 15749 Segmentation fault      umount $MNT
> >   FAIL dax-ext4.sh (exit status: 139)

Thanks.  Fixed:

+++ b/fs/dax.c
@@ -644,7 +644,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
                goto out;
        dax_disassociate_entry(entry, mapping, trunc);
        xas_store(&xas, NULL);
-       mapping->nrpages -= dax_entry_order(entry);
+       mapping->nrpages -= 1UL << dax_entry_order(entry);
        ret = 1;
 out:
        put_unlocked_entry(&xas, entry);

Updated git tree at
https://git.infradead.org/users/willy/pagecache.git/

It survives an xfstests run on an fsdax namespace which supports 2MB pages.
