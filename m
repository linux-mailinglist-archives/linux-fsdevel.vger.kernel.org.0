Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05023165F1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 14:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgBTNsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 08:48:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35948 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbgBTNsu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zBQV1Nvl6gQ7063nOMO4bl4Qit9dtUsePu9xZtdIUpM=; b=igtOB94RI8XKtzVTmpl7adfTBc
        nUPRfeBQAn6qgMu2mIMXdqdemGWBPZM6m1mk0JRQ4gln6YP021QrTz7JW7WriTW9kQd9HhefrWodr
        DPdZE7ea3rkTiKxZzjV2rfZFsVohFeCSeKjLKjW2laQNPicIuou8l8cd1nA0LgsCPlX64i0y7yahW
        32HPR3UOUNpTTE89QggDpsf9Uy+G746NO+E5c6nPo49C7MXOyuBpobo2jZnaHlZEfffwdWw5lxpdO
        LXm98qt8lqtRm5JiZBti5MLazqN7XkI5SW89icHM4E2rVuaoGC9UJqrtuJmXRDlbntv0SnHwa7P6h
        mNHva41Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4mC9-0006TC-8A; Thu, 20 Feb 2020 13:48:49 +0000
Date:   Thu, 20 Feb 2020 05:48:49 -0800
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
Subject: Re: [PATCH v7 14/24] btrfs: Convert from readpages to readahead
Message-ID: <20200220134849.GV24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-15-willy@infradead.org>
 <SN4PR0401MB35987D7B76007B93B1C5CE5E9B130@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35987D7B76007B93B1C5CE5E9B130@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 09:42:19AM +0000, Johannes Thumshirn wrote:
> On 19/02/2020 22:03, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Use the new readahead operation in btrfs.  Add a
> > readahead_for_each_batch() iterator to optimise the loop in the XArray.
> 
> OK I must admit I haven't followed this series closely, but what 
> happened to said readahead_for_each_batch()?
> 
> As far as I can see it's now:
> 
> [...]
> > +	while ((nr = readahead_page_batch(rac, pagepool))) {

Oops, forgot to update the changelog there.  Yes, that's exactly what it
changed to.  That discussion was here:

https://lore.kernel.org/linux-fsdevel/20200219144117.GP24185@bombadil.infradead.org/

... and then Christoph pointed out the iterators weren't really adding
much value at that point, so they got deleted.  New changelog for
this patch:

btrfs: Convert from readpages to readahead
  
Implement the new readahead method in btrfs.  Add a readahead_page_batch()
to optimise fetching a batch of pages at once.

