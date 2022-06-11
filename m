Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B157547789
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 22:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiFKUfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 16:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiFKUfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 16:35:13 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE108112C;
        Sat, 11 Jun 2022 13:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PH9gW0cpK2qObu3YlWPJYh5FaxuyUfq3uhU9rswQnZ0=; b=Tfa4btwvM7xZGk2UhTCHhNarI0
        XLrnXHWUDleKg0CseOy8Kinwh3a357YVc9PwI0RgG5SekQfEjZDTPN02Vzx4MiVWv1ETj6v/PzehR
        ZY7FnIi3OeiJH0s1d+9nz2UKP57AkldSSNJS2S6yhHLnYjQ7SckjUbzoxXrXaUAPPoCjuT56Al95N
        wu6Qa5su/5ARSkNgLnmp3kxbl5B2tj3v2DgmkquLkUj9qR2tCihHcrKAIvnvdc6sMTNLR3g6dMCiC
        Zg1eGPcH9aahxKIPGo+gKC0tojCBdWE8q/IoW4JqnDOOt2Hp8qUAAN+hhGRot0ia+wSUSF51f/rTS
        hfj//RvA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o07p7-006EA9-UA; Sat, 11 Jun 2022 20:35:10 +0000
Date:   Sat, 11 Jun 2022 20:35:09 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] build fix
Message-ID: <YqT8fYe1PqP9rCRs@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 6c77676645ad42993e0a8bdb8dafa517851a352a:

  iov_iter: Fix iter_xarray_get_pages{,_alloc}() (2022-06-10 15:56:32 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 5632561eee9faa6d8d9f69bf69d083f1847d1abd:

  fix warnings on 32bit caused by ITER_XARRAY fix (2022-06-11 12:43:21 -0400)

----------------------------------------------------------------
minimal fix for build breakage on 32bit
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
There's a bunch of obvious cleanups and improvements in that area; this is
just the braino fix for previous commit.  I wanted to include at least
replacement of weird open-coded count = DIV_ROUND_UP(size + offset, PAGE_SIZE);
in those two functions (it might have started as defense against theoretical
overflows, but if so it's incomplete, the overflows are in practice impossible
*and* this prevention would be in the wrong place anyway), but... let's
keep that separate.

FWIW, in my local tree duplication between iov_iter_get_pages() and
iov_iter_get_pages_alloc() is gone, with a lot of stuff getting considerably
simpler, but I'm still cleaning/reordering/carving that series up.  Will post
tomorrow or on Monday, but those are clearly not 5.19 fodder.

Al Viro (1):
      fix warnings on 32bit caused by ITER_XARRAY fix

 lib/iov_iter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
