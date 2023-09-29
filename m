Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3787B3C91
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 00:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjI2WYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 18:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2WY3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:24:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E2A1A8;
        Fri, 29 Sep 2023 15:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N4F2QfXt0qCvJT+KbS3ZaeUVFr/M0rdBm91MXelB3ww=; b=Nj8Q+hBv5VWBtOtoQ2qjL5pO5Z
        UzC6KFuZP4qUCUCH8d+zuiytkGx9+IrACFoQLP9WinUO46iUBl8P1jjmuogqeBDRUIC2uQyb7xckY
        XnANjE/5B2paNEFkfzos6qypBuSRDTW1ohstRa59pshV+T3ihWQSPE7/2WxYmKysGU6iOM4GbdxMK
        kLb9kNK8nVA9YmYIw6hWWZiGYVFWU4qn0NHbpFMmfWF9c3mIAY3nrV3uujoF6F2x2QM+Sb2Yg1gaa
        RpMhboXmDEies74dLbUPrekbZPPYK5sRynRUHL2+sSVenmvv0whk57ag+nsIJRw3HFSFwOQ5pBxAh
        aTeTFvMw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qmLuE-00BIgB-NK; Fri, 29 Sep 2023 22:24:18 +0000
Date:   Fri, 29 Sep 2023 23:24:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: shave work on failed file open
Message-ID: <ZRdOkpXUva8UHfEJ@casper.infradead.org>
References: <ZRR1Kc/dvhya7ME4@f>
 <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
 <20230928-kulleraugen-restaurant-dd14e2a9c0b0@brauner>
 <20230928-themen-dilettanten-16bf329ab370@brauner>
 <CAG48ez2d5CW=CDi+fBOU1YqtwHfubN3q6w=1LfD+ss+Q1PWHgQ@mail.gmail.com>
 <CAHk-=wj-5ahmODDWDBVL81wSG-12qPYEw=o-iEo8uzY0HBGGRQ@mail.gmail.com>
 <20230929-kerzen-fachjargon-ca17177e9eeb@brauner>
 <CAG48ez2cExy+QFHpT01d9yh8jbOLR0V8VsR8_==O_AB2fQ+h4Q@mail.gmail.com>
 <20230929-test-lauf-693fda7ae36b@brauner>
 <CAGudoHHwvOMFqYoBQAoFwD9mMmtq12=EvEGQWeToYT0AMg9V0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHHwvOMFqYoBQAoFwD9mMmtq12=EvEGQWeToYT0AMg9V0A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:23:04PM +0200, Mateusz Guzik wrote:
> Extending struct file is not ideal by any means, but the good news is that:
> 1. there is a 4 byte hole in there, if one is fine with an int-sized counter
> 2. if one insists on 8 bytes, the struct is 232 bytes on my kernel
> (debian). still some room up to 256, so it may be tolerable?

256 isn't quite the magic number for slabs ... at 256 bytes, we'd get 16
per 4kB page, but at 232 bytes we get 17 objects per 4kB page (or 35 per
8kB pair of pages).

That said, I thik a 32-bit counter is almost certainly sufficient.
