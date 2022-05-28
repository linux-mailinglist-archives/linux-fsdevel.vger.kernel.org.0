Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB247536B0E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 08:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiE1GMa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 02:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiE1GM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 02:12:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F632DD5D
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 23:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XRCyrfsOL2PXgIyjGTvYC1oF+7LmRBgFYCVBlEy3SLM=; b=JCJwFEd4qJ37PkLpdR/dcR6Hyi
        U/gUarqXwImt2//XtGeUXO5SC78Z4QRBmgIb5HCbIB4fXOhV4b3Cjz01ZjPqxqNSCTAdiX4x1dsip
        VtwhHFCiSQme/BZKiP5sJ0HwAUzW3LNqhHprG4nafN8t1RTJPpwwhxlHfdjz36PCDTN2NBLh1NPp2
        xBVKYnMrb27Yn+B/Mo597bALnMCN0Q8JgfSXE5HFzCnl9pVR3dBAFslSC6qPCPEKMF4dpaxwZwrkz
        5hYqYJjPUyvywBTL+IqzxD5xhjZlbDDEbtPmzNZPaZCa644NPPp65nuVU4dwDQyD3vNO+gf4c+Fq5
        Y+A2L+xA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupgZ-001XvQ-Qt; Sat, 28 May 2022 06:12:27 +0000
Date:   Fri, 27 May 2022 23:12:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/24] Begin removing PageError
Message-ID: <YpG9S/OTOLcles0j@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:12PM +0100, Matthew Wilcox (Oracle) wrote:
> After this series, there are some places which still use it.  Lots of
> the converted places are trivial -- they should have been checking the
> uptodate flag.  The trickiest are the ones which have multiple steps
> and signal "hey, something went wrong with one step in the read of this
> page/folio" by setting the error flag.

How many of those do we have left, and how many of those can't be
changed to just return them through errors or other on-stack means?

> I'm thinking about (ab)using PageChecked == PG_owner_priv_1 for this
> purpose.  It'd be nice to be able to use page->private for this, but
> that's not always available.  I know some filesystems already ascribe
> a meaning to PG_owner_priv_1, but those can be distinguished by whether
> the uptodate flag is set.

I suspect what to do will be very ad-hoc depending on the actual user.
The first priority is probably to isolate PageError so that it is only
used for that kind of communication insid a single file system so that
all the generic uses can go away.
