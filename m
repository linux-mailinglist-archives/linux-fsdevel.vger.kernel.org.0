Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3E570D37A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 07:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjEWF7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 01:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjEWF7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 01:59:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A129119;
        Mon, 22 May 2023 22:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/WVokBxhTBM7fgzlxwTSo8ZoWub9nLCKavh/fJGPmTg=; b=ZtMzahsDLNj/1/G4+AkEti4ClQ
        md5fmrWPShF8RCEnihsbQFIPe2mczdzO0UQFFLrmAdpUyYJLGnyFPsXDEl7wtvrzL4nrpHAPEhBCy
        OgriDff7LBs6/cnMSn9ONxsnjAHHFl2jYEnsgxSLxYHHctYFNu4Bc4L9hByatEDKNMzoCkgk8pqQD
        UcO4ewymZ5E0oIX2x5NvjdFQXi05ipZVfafLJuZiB1aAxEl7T0dz5VOS1iJGjwKu024CAsbsRSSBM
        K8pC/PMVrsVp4pMRYtDtR8DbQOEXVS+3TNxMZv2QjTQtFMBTEJIdEpIq9Xo0gTVhawIKg5YkeGl8o
        1eq7Wfsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1L3F-0091k4-2u;
        Tue, 23 May 2023 05:59:17 +0000
Date:   Mon, 22 May 2023 22:59:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 1/3] filemap: Allow __filemap_get_folio to allocate large
 folios
Message-ID: <ZGxWNRNt6sCoTqf9@infradead.org>
References: <20230520163603.1794256-1-willy@infradead.org>
 <20230520163603.1794256-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520163603.1794256-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 05:36:01PM +0100, Matthew Wilcox (Oracle) wrote:
> +#define FGP_ORDER(fgp)		((fgp) >> 26)	/* top 6 bits */

Why don't we just add a new argument for the order?

