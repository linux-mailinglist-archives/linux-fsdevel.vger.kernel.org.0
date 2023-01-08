Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CFB661759
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 18:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjAHRZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 12:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbjAHRZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:25:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A865DBE1B
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jan 2023 09:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=byuqeNBFeGwiG3KemLYvzxt1yG39oV5oBxrawdDvlG8=; b=sXNuyo4EtJt5hkYEprkTwy0ZPQ
        0cJAItOmg18zyRIqSCgkUS5tGFPJzgrIYW3cptSpAKH+CgRRZGIiFN1P0mSumx8/dlJJCPaaACpPr
        p8rm4THH/IVjXMLm+QikjmEAudKiVl4M97cLLQ47SL6eKfDS98++ucvOv29h5xj1TQ1zSm53NOXbF
        Ug8vzryiLby6UIUu+tqepTTZqEkm9Iw3m7NlQKCzC0a3QvZjT1EdCKgPeuVKWFAdP/pC1Apel1wUI
        RKXzJdUqrObiObrKDgFqUbMaqp5ZE1GhDmhlhWTLhAeaBz3KmYFSAga5lljRCJ44hBpv1DplOLtne
        JvKTcFIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEZPy-00EZIs-Oo; Sun, 08 Jan 2023 17:25:10 +0000
Date:   Sun, 8 Jan 2023 09:25:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fs: don't allocate blocks beyond EOF from
 __mpage_writepage
Message-ID: <Y7r8dsLV0dcs+jBw@infradead.org>
References: <20230103104430.27749-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103104430.27749-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:44:30AM +0100, Jan Kara wrote:
> When __mpage_writepage() is called for a page beyond EOF, it will go and
> allocate all blocks underlying the page. This is not only unnecessary
> but this way blocks can get leaked (e.g. if a page beyond EOF is marked
> dirty but in the end write fails and i_size is not extended).

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
