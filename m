Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE3A6B36E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 07:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCJGxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 01:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCJGwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 01:52:49 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEA4F6907
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 22:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7qEqX21YRrsvSJ/y6xQPPg458jfKZDfNP3maNMRHlbE=; b=I57JSnLN/KuTBHkJec9Ueg23yO
        WAuEjYh4TxVA/K+1XP40YCn8q1pC9rah1z/C5JRl760MBSQ18t1rwiNtXtOfbkTFUh67Ff/TFuBbc
        /NjFtEP/8cAAacdHIxs2xqLC0/SKHBDPMsQhhdQf6PluDJlNqCNQrUnUCENhCLFgKgSIXgn8m+Jje
        hCY2o+SPIIq8bKhUjqA+aIhN2gCj77LAVZTv9wjofmBQ4hG4FJp1CVi6xMZADp1B26bzZtiltycOd
        gqoT/aiNmcqLg0X30jmk17GqkAGIkWuEOiWSJ5S0ZodWyOIxRq1IrDyKZ89EQ0UujH6sqc7MKuCBf
        JY9DvpUA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paWcF-00FEGC-2u;
        Fri, 10 Mar 2023 06:52:35 +0000
Date:   Fri, 10 Mar 2023 06:52:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/3] ufs: don't flush page immediately for DIRSYNC
 directories
Message-ID: <20230310065235.GR3390869@ZenIV>
References: <20230307143125.27778-1-hch@lst.de>
 <20230307143125.27778-2-hch@lst.de>
 <20230310035353.GM3390869@ZenIV>
 <20230310063756.GA13484@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310063756.GA13484@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 10, 2023 at 07:37:56AM +0100, Christoph Hellwig wrote:
> On Fri, Mar 10, 2023 at 03:53:53AM +0000, Al Viro wrote:
> > On Tue, Mar 07, 2023 at 03:31:23PM +0100, Christoph Hellwig wrote:
> > > We do not need to writeout modified directory blocks immediately when
> > > modifying them while the page is locked. It is enough to do the flush
> > > somewhat later which has the added benefit that inode times can be
> > > flushed as well. It also allows us to stop depending on
> > > write_one_page() function.
> > > 
> > > Ported from an ext2 patch by Jan Kara.
> > 
> > Umm...  I'll throw it in ufs pile, I guess (tomorrow - I'll need to
> > sort out Fabio's patches in the area as well; IIRC, the latest
> > had been in late December).
> 
> Well, the three patches really should go together, otherwise we miss
> yet another merge window.

Umm...  Do you need them in the same (never-rebased?) branch, or would
it suffice to have all of them reach mainline by 6.4-rc1?
