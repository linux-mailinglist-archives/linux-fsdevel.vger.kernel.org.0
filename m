Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB41536343
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 15:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbiE0NUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 09:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbiE0NUl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 09:20:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA6F12B025
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=++iGzJ5RyvCbarxonRdx9rs9lIBzvUwOZefKETchJ40=; b=L3b1HkZaxV5cgJNX0whAu3mIuD
        8p2YSC1GscNuTrJCq0H+Ssizimd3yYjyTi6gJCD0TRReIu2YJbyckoCNF6Cs3g6os+1zUfMpLrx8J
        ju3SGciLp3phKIj7M8ascMnJ7QSHQQFhMQRv+PWDJi/B2kVJ8RlgSMAaHF24oOa5yG851Oxav4K5i
        5FKTXqvXSKcpIL+XRbgEnu4Vrgw8JhIwMfVU96m8Ega4o4OuV2SeTXMXBLSKAGxs7+STTTFD94D3c
        n/kHNzUoWoC8S1yusS6fcLUjBHNKPOfKf8moPpUEMk/Rm//8/+s+XDMNhQ8BZF6yPK7Nvho+N4qfc
        Huy03Wjw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuZtL-0027O1-LM; Fri, 27 May 2022 13:20:35 +0000
Date:   Fri, 27 May 2022 14:20:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH 1/9] IOMAP_DIO_NOSYNC
Message-ID: <YpDQI3366vH9Ux2i@casper.infradead.org>
References: <20220526192910.357055-1-willy@infradead.org>
 <20220526192910.357055-2-willy@infradead.org>
 <YpBjD4Y7su+GVSkX@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpBjD4Y7su+GVSkX@infradead.org>
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 26, 2022 at 10:35:11PM -0700, Christoph Hellwig wrote:
> On Thu, May 26, 2022 at 08:29:02PM +0100, Matthew Wilcox (Oracle) wrote:
> > Al's patch.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Hmm, that is a bit of a weird changelog..

I took parts of
https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=new.iov_iter&id=447262443a4dbf88ae5b21de5c77197f084cdca4

and fixed it up a bit but dropped the btrfs parts.

> >  		/* for data sync or sync, we need sync completion processing */
> > -		if (iocb->ki_flags & IOCB_DSYNC)
> > +		if (iocb->ki_flags & IOCB_DSYNC &&
> > +		    !(dio_flags & IOMAP_DIO_NOSYNC))
> >  			dio->flags |= IOMAP_DIO_NEED_SYNC;
> >  
> >  		/*
> 
> I think we also need to skip the setting of IOMAP_DIO_WRITE_FUA below
> (or find a way to communicate back to the that FUA was used, which
> seems way more complicated)

Probably ... I was just looking to avoid the deadlock.  Patch not for
upstream in this form; I'm expecting Al to submit a fixed version before
the JFS code is ready for upstream.
