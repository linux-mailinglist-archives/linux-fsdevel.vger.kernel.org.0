Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB67E543DA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 22:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiFHUkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 16:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiFHUkB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 16:40:01 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C54EACEF
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sBov/+hoWgoovglAhBdg5Ve2/eelAY1t2Xmdm3ysqKU=; b=msieBjOO6UCZxcRLPriB2L2SWU
        TAA9sQXQlR7yCGa32gWlN4glmh0Lhd5nDzhohuBiqeUAvG5Os1vRkcelroepNXQ65GsLwsK228La1
        H2M4GYZJh/BbARl+gH+2UojuXD5D0MedC+6nWmPNG0WbeU2ohdukZ9+crOVXFIyg9S4z6DdN4fneh
        mwV2cHsRC9uWuBo9DNCwveII4tEpe4jOEZim116LdL7TYvdI7KCtGXDaMes7pst17LYXsMgbtJh5Q
        kIVxIgV5odHp/Ty1O3j89w5jj/vuyqK3GyVC+kqEFnkyWOTTF8YkUCEZ9Xxt9wFToZWzmCfsQuimG
        wGYYwNmA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nz2Sv-005Eu7-RA; Wed, 08 Jun 2022 20:39:45 +0000
Date:   Wed, 8 Jun 2022 20:39:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC][PATCHES] iov_iter stuff
Message-ID: <YqEJEWWfxbNA6AcC@zeniv-ca.linux.org.uk>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
 <CA+icZUV_kJcwtFK2aACAfKAkx6EdW62u46Qa7kkPXtRhMYCcsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUV_kJcwtFK2aACAfKAkx6EdW62u46Qa7kkPXtRhMYCcsw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 08, 2022 at 09:28:18PM +0200, Sedat Dilek wrote:

> I have pulled this on top of Linux v5.19-rc1... plus assorted patches
> to fix issues with LLVM/Clang version 14.
> No (new) warnings in my build-log.
> Boots fine on bare metal on my Debian/unstable AMD64 system.
> 
> Any hints for testing - to see improvements?

Profiling, basically...  A somewhat artificial microbenchmark would be
to remove read_null()/write_null()/read_zero()/write_zero(), along with
the corresponding .read and .write initializers in drivers/char/mem.c
and see how dd to/from /dev/zero and friends behaves.  On the mainline
it gives a noticable regression, due to overhead in new_sync_{read,write}().
With this series it should get better; pipe reads/writes also should see
reduction of overhead.

	There'd been a thread regarding /dev/random stuff; look for
"random: convert to using iters" and things nearby...
