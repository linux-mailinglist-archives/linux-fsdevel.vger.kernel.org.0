Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA26340500
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 12:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhCRL4p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 07:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhCRL4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:56:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202AAC06175F;
        Thu, 18 Mar 2021 04:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+h+1SEFLQocK4YdwZr5ZhyO0T/XQZ84VjFxo5ntY0qY=; b=DZOQLTECX0ocX/h5/zrr4GvzO4
        c59O5cTkJbfatnIkLIxkals+Dxfs6zpeNOUbf1+cELaVD8x9H3INyd8ojHcPnyBfbFmXRS43rYgiW
        2Coh61QNQUVqu8oa4IbAbrszIbpKwYzOyYVu5uvLxODCF66gffv7xoOqUMMVu3E13+L4/53/+cvUk
        ytGpPVMB9LgpqUwyoPhwYfcsu0qGtCdiHlIMnQQHls5n853Aaz8ncnKLGNCnKYA0dNNmvYaaAakJ7
        EyUEjc1A+PgXBww46OxoPYD0u+ZS+gtLl9NMoy5oVjmFr+amPv2085Cg/N1MHlBUTfBdVEZyDn+2Q
        hdFF6ulQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMrFf-002vQq-9c; Thu, 18 Mar 2021 11:55:46 +0000
Date:   Thu, 18 Mar 2021 11:55:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>
Subject: Re: fuse: kernel BUG at mm/truncate.c:763!
Message-ID: <20210318115543.GM3420@casper.infradead.org>
References: <YEsryBEFq4HuLKBs@suse.de>
 <CAJfpegu+T-4m=OLMorJrZyWaDNff1eviKUaE2gVuMmLG+g9JVQ@mail.gmail.com>
 <YEtc54pWLLjb6SgL@suse.de>
 <20210312131123.GZ3479805@casper.infradead.org>
 <YE8tQc66C6MW7EqY@suse.de>
 <20210315110659.GT2577561@casper.infradead.org>
 <YFMct4z1gEa8tXkh@suse.de>
 <CAJfpeguX7NrdTH4JLbCtkQ1u7TFvUh+8s7RmwB_wmuPHJsQyiA@mail.gmail.com>
 <20210318110302.nxddmrhmgmlw4adq@black.fi.intel.com>
 <YFM5mEZ8dZBhZWLI@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFM5mEZ8dZBhZWLI@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 11:29:28AM +0000, Luis Henriques wrote:
> On Thu, Mar 18, 2021 at 02:03:02PM +0300, Kirill A. Shutemov wrote:
> > On Thu, Mar 18, 2021 at 11:59:59AM +0100, Miklos Szeredi wrote:
> > > > [16247.536348] page:00000000dfe36ab1 refcount:673 mapcount:0 mapping:00000000f982a7f8 index:0x1400 pfn:0x4c65e00
> > > > [16247.536359] head:00000000dfe36ab1 order:9 compound_mapcount:0 compound_pincount:0
> > > 
> > > This is a compound page alright.   Have no idea how it got into fuse's
> > > pagecache.
> > 
> > 
> > Luis, do you have CONFIG_READ_ONLY_THP_FOR_FS enabled?
> 
> Yes, it looks like Tumbleweed kernels have that config option enabled by
> default.  And it this feature was introduced in 5.4 (the bug doesn't seem
> to be reproducible in 5.3).

Can you try adding this patch?

https://git.infradead.org/users/willy/pagecache.git/commitdiff/369a4fcd78369b7a026bdef465af9669bde98ef4
