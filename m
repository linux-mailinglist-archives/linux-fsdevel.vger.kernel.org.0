Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F75654D32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 09:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiLWIID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 03:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiLWIIC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:08:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DC412623;
        Fri, 23 Dec 2022 00:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fbFBDoUTr0Hz3vXP45guCPqzXQAzMtYZDFQbW7aV/7M=; b=E51cHrJYUYXCLQJ6msKO9XaW+8
        SzQjBaBALne5fVjvNAvOV5qoAzJhYusiS9APVbPLZRIMgmJ7vHa2pr+LksdjkiUicoqtpUYZXNLFN
        9bDjsW51Plzixgfu/1HQwqxSRbvphYEqPWc08mBxLgstgTi4TqffHWvFVor42sHep04aR2QZoiHJ9
        cydEsdBmqvFVWSWR3FsMvKU0hkKQBd8bHu6sdY4gbMqcF3OiPiol9TM3x7/sFIBON+zQeq5GNAJry
        xu016McQd+WlF9525pZjlgYolVF64q6K95fNFFNOvo3JJyco1IHDzd6tNVkz7jyKmnvciMq4Uhlf9
        38vhvqTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8d5y-0054Xp-JZ; Fri, 23 Dec 2022 08:07:58 +0000
Date:   Fri, 23 Dec 2022 00:07:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        fengnanchang@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] f2fs: Convert f2fs_write_cache_pages() to use
 filemap_get_folios_tag()
Message-ID: <Y6Vh3iu1xD7jgF9/@infradead.org>
References: <0a95ba7b-9335-ce03-0f47-5d9f4cce988f@kernel.org>
 <20221212191317.9730-1-vishal.moola@gmail.com>
 <6770f692-490e-34fc-46f8-4f65aa071f58@kernel.org>
 <Y5trNfldXrM4FIyU@casper.infradead.org>
 <CAOzc2pzoyBg=jgYNNfsmum9tKFOAy65zVsEyDE3vKoiti7FZDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzc2pzoyBg=jgYNNfsmum9tKFOAy65zVsEyDE3vKoiti7FZDA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 21, 2022 at 09:17:30AM -0800, Vishal Moola wrote:
> > That said, folio_ref_inct() is very much MM-internal and filesystems
> > should be using folio_get(), so please make that modification in the
> > next revision, Vishal.
> 
> Ok, I'll go through and fix all of those in the next version.

Btw, something a lot more productive in this area would be to figure out
how we could convert all these copy and paste versions of
write_cache_pages to use common code.  This might need changes to the
common code, but the amount of duplicate and poorly maintained versions
of this loop is a bit alarming:

 - btree_write_cache_pages
 - extent_write_cache_pages
 - f2fs_write_cache_pages
 - gfs2_write_cache_jdata
