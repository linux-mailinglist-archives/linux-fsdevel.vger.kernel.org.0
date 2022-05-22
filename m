Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B93530328
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 14:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245208AbiEVMsv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 08:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241064AbiEVMst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 08:48:49 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC9F3BA5A
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 05:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hs1XUTFIsiLVgz5quDsIYYAJ1tIcNKXIQOLsOQtLLhk=; b=ZejShq1sXNeOiBmZ1IqrXEHuwp
        jLiTzWPpWuibp5mVIvUPL+/lsU38XwqlZM11w9Byc/J7BDRByOu9+kKpAusdjuOVChgN9BsrBaULY
        F/MwOg1Ffn7zlHvu7GZyjNA/4mJ0ywj0AvcqOvlN19loSL6bB0gOmJfNOmEBn1fG36YJ8T4ixAbOt
        pwz46FMnVFFTi6c6pNUasENvtw+ZazCTXKZJ5jQLrWvYDfJA1FS518siXQZJgiNRMGRjnkveUn+pL
        atp72bSZunIea4AJM9gF4PCtMuLcb+6vHpIkdg2bRwLF44gqJa56sVAMRWWZBKd5+X4mQvYvIUG75
        lgFQOU2g==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsl0n-00HB6z-6H; Sun, 22 May 2022 12:48:45 +0000
Date:   Sun, 22 May 2022 12:48:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YooxLS8Lrt6ErwIM@zeniv-ca.linux.org.uk>
References: <20210621143501.GA3789@lst.de>
 <Yokl+uHTVWFxoQGn@zeniv-ca.linux.org.uk>
 <70b5e4a8-1daa-dc75-af58-9d82a732a6be@kernel.dk>
 <f2547f65-1a37-793d-07ba-f54d018e16d4@kernel.dk>
 <20220522074508.GB15562@lst.de>
 <YooPLyv578I029ij@casper.infradead.org>
 <YooSEKClbDemxZVy@zeniv-ca.linux.org.uk>
 <Yoobb6GZPbNe7s0/@casper.infradead.org>
 <20220522114540.GA20469@lst.de>
 <e563d92f-7236-fbde-14ee-1010740a0983@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e563d92f-7236-fbde-14ee-1010740a0983@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 06:39:39AM -0600, Jens Axboe wrote:
> On 5/22/22 5:45 AM, Christoph Hellwig wrote:
> > On Sun, May 22, 2022 at 12:15:59PM +0100, Matthew Wilcox wrote:
> >>> 	Direct kernel pointer, surely?  And from a quick look,
> >>> iov_iter_is_kaddr() checks for the wrong value...
> >>
> >> Indeed.  I didn't test it; it was a quick patch to see if the idea was
> >> worth pursuing.  Neither you nor Christoph thought so at the time, so
> >> I dropped it.  if there are performance improvements to be had from
> >> doing something like that, it's a more compelling idea than just "Hey,
> >> this removes a few lines of code and a bit of stack space from every
> >> caller".
> > 
> > Oh, right I actually misremembered what the series did.  But something
> > similar except for user pointers might help with the performance issues
> > that Jens sees, and if it does it might be worth it to avoid having
> > both the legacy read/write path and the iter path in various drivers.
> 
> Right, ITER_UADDR or something would useful. I'll try and test that,
> should be easy to wire up.

Careful - it's not just iov_iter_advance() and __iterate_and_advance() (that
one should use the same "callback" argument as iovec case).  /dev/random is
not the only thing we use read(2) and write(2) on...

I can cook a patch doing that, just let me get some caffeine into the
bloodstream first...
