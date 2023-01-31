Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA05D6830F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 16:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjAaPKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 10:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjAaPKM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:10:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EB41EFC8;
        Tue, 31 Jan 2023 07:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nnISUeD7Myml+nomxC97ujFe7tLxq4ETjq8I3WolSKc=; b=poi+M+FmKuNkElvagkC9xZC+es
        /lhFW1SI+9FfH4lFdcDIfXOTqZSd4LKnl4sq4+TOlLx50RVMaME14KWog5ULIUZ7xEDwdwP/lfkoG
        pvQggsCBbMLCz8+evhmJdgkRB9fhhGNYWKnzn6pieAuQb79gPYTCZgA4eKqkvpAONi14WjN8v+6Au
        vPnaIwwk57x+QuvnhFbjBr5lTZlbtLBml+UXw2tPxBdK+7ZCqESSfcUyZqBGl0ssUv+4EywbONDXA
        wVoutOqorSAxwY/5SgTIK3hYjraDkIkXQLqn5f5FRFDg4aV0iV5YM/0LHflJRWkYkbpSk1HD6iAq5
        blCR7Elw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMsDt-008QMi-QF; Tue, 31 Jan 2023 15:07:01 +0000
Date:   Tue, 31 Jan 2023 07:07:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 2/3] iomap: Change uptodate variable name to state
Message-ID: <Y9kulWxXxcYye09a@infradead.org>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <bf30b7bfb03ef368e6e744b3c63af3dbfa11304d.1675093524.git.ritesh.list@gmail.com>
 <20230130215623.GP360264@dread.disaster.area>
 <Y9hDu8hVBa3qJTNw@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9hDu8hVBa3qJTNw@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:24:59PM +0000, Matthew Wilcox wrote:
> > a single bitmap of undefined length, then change the declaration and
> > the structure size calculation away from using array notation and
> > instead just use pointers to the individual bitmap regions within
> > the allocated region.
> 
> Hard to stomach that solution when the bitmap is usually 2 bytes long
> (in Ritesh's case).  Let's see a version of this patchset with
> accessors before rendering judgement.

Yes.  I think what we need is proper helpers that are self-documenting
for every bitmap update as I already suggsted last round.  That keeps
the efficient allocation, and keeps all the users self-documenting.
It just adds a bit of boilerplate for all these helpers, but that
should be worth having the clarity and performance benefits.
