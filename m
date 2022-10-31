Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D026138A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 15:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiJaOFm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 10:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiJaOFl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:05:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E7C1057A
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 07:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u9q3nKtdqzG108S92XrevVbBzshG76NKdyV3yAA/Bt8=; b=2VlqPq5q0enFop7HE+mxsNO1BM
        lbZ9clPRqnArVmferFvu8vUlJd4svX4GD3grG8m9B/bc4vq02eQmNqWd3HZu+FqZgMTVrn+BAq9PM
        D1jgug22T1fa7eAPfjK/xTITAn1ziOYLJesuceFE0KhXEQ46rnFLYwl7dMW12cn1eWQBhmmo2zYlp
        v/9c3n35PVY+t5i02tn8xerf0r/RjO8PxERnVoWSvsQly1b253Yd7RTZQ3W9NPwifuxREbrPHyhOh
        7aBQG9U5yzERQEwvvIQ8nfYwkDb0yGFs+1cOcj4wQ1tnO7TKXMNn3hUbyx6srzSCv/xIg1iPn/5nX
        wNIdf1Og==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opVPw-00CCX6-7c; Mon, 31 Oct 2022 14:05:32 +0000
Date:   Mon, 31 Oct 2022 07:05:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>, hch@infradead.org,
        viro@zeniv.linux.org.uk, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: fix undefined behavior in bit shift for SB_NOUSER
Message-ID: <Y1/WLC3s7HHbSoSt@infradead.org>
References: <20221031134811.178127-1-cuigaosheng1@huawei.com>
 <Y1/TWdY//yUgXGck@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1/TWdY//yUgXGck@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 01:53:29PM +0000, Matthew Wilcox wrote:
> On Mon, Oct 31, 2022 at 09:48:11PM +0800, Gaosheng Cui wrote:
> > +++ b/include/linux/fs.h
> > @@ -1384,19 +1384,19 @@ extern int send_sigurg(struct fown_struct *fown);
> >  #define SB_NOATIME	1024	/* Do not update access times. */
> >  #define SB_NODIRATIME	2048	/* Do not update directory access times */
> >  #define SB_SILENT	32768
> 
> Shouldn't those ^^^ also be marked as unsigned?  And it's confusing to
> have the style change halfway through the sequence; can you convert them
> to (1U << n) as well?

I was planning on just sending a followup instead of blowing up the
scope even more, but yes - they should.
