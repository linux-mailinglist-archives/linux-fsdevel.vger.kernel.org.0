Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1803651CCD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 01:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386847AbiEEXrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 19:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241016AbiEEXrJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 19:47:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BDD443C7;
        Thu,  5 May 2022 16:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qAb22uIhpCH8ILir3+ikE/8BOp9F07i0dHC7d945NL4=; b=LuMxZlQ+G6TwddhCM85yWQZFwB
        qfbmGMGs5MB7XX9WbXARI6fuUgg3zI0HmvhGSu3gUmkmvzPmehG9K2l3QgOZ8dU37Ue0BCsnVY0N5
        NrnPEOdZyczOWqmECZz8PF2SOrtfM1tPpKCxZ6Q2IORN5NeqwVRksX/tElouL3Pk6uSIgdaHjeAQr
        aSfEzwT8Rl2IOEcu3anXUQVFeBN+pjWgkoZfW2UkY3+VvV5XHAJ8zUpf9WKmpNCgQ3ggtASo8GTkY
        AGJATSy8luhySo+HutKvjQ5kuUXXapgJ3iSBG88/gRBXC4jpUkft2+Osd6PE0WQ7hbOpnAv3Bu+0N
        PEmN24zw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nml7u-000RDh-7A; Thu, 05 May 2022 23:43:18 +0000
Date:   Fri, 6 May 2022 00:43:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Two folio fixes for 5.18
Message-ID: <YnRhFrLuRM5SY+hq@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick and Brian have done amazing work debugging the race I created
in the folio BIO iterator.  The readahead problem was deterministic,
so easy to fix.

The following changes since commit a7391ad3572431a354c927cf8896e86e50d7d0bf:

  Merge tag 'iomm-fixes-v5.18-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu (2022-05-04 11:04:52 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18f

for you to fetch changes up to b9ff43dd27434dbd850b908e2e0e1f6e794efd9b:

  mm/readahead: Fix readahead with large folios (2022-05-05 00:47:29 -0400)

----------------------------------------------------------------
Two folio fixes for 5.18:

 - Fix a race when we were calling folio_next() in the BIO folio iter
   without holding a reference, meaning the folio could be split or freed,
   and we'd jump to the next page instead of the intended next folio.

 - Fix readahead creating single-page folios instead of the intended
   large folios when doing reads that are not a power of two in size.

----------------------------------------------------------------
Matthew Wilcox (Oracle) (2):
      block: Do not call folio_next() on an unreferenced folio
      mm/readahead: Fix readahead with large folios

 include/linux/bio.h |  5 ++++-
 mm/readahead.c      | 15 +++++++++------
 2 files changed, 13 insertions(+), 7 deletions(-)


