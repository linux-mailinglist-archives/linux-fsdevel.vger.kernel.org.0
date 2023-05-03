Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7CB6F4EDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 04:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjECCdt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 22:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjECCdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 22:33:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B84C30E2;
        Tue,  2 May 2023 19:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=pkPRiNpgcA+BA4XuLGFxUCQunbLSHZaA3tE3Dh0LC9s=; b=FouYfGdYkd5pD47/llJH/3W9f1
        kHN8sMMmiVL1RPjgTpRQcLmxriPr5K0FKc3gwbncG9+slHPjZazlQq/IHKNQRFRMVqFy2hzfPJ7HW
        x1qFvRUuskRpBrE8alYulmTaUIj90gAo+h9Z2jZm9BFPZumuynrwlwVb9ZI+nhYHuNz4aqTlKjASb
        d8gVhcAFKFEd2xI/lXLR6uoDdxYMekV3ywcgIMbIM/ckXa6AlWOv0765DgNr/CWhoN6hClj1eJL6r
        Z0FW1FpGR1N4gL6VrPcE/Ks+WI9Ut5ErDAg+YGTbl1d5nTvsxY81bfIOIfd6oALnnLCEjsPwYCyCV
        R/csgQnw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pu2J8-0039fF-2N;
        Wed, 03 May 2023 02:33:30 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        ebiggers@kernel.org, jeffxu@google.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/2] sysctl: death to register_sysctl_paths()
Date:   Tue,  2 May 2023 19:33:27 -0700
Message-Id: <20230503023329.752123-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

As mentioned on my first pull request for sysctl-next, for v6.4-rc1
we're very close to being able to deprecating register_sysctl_paths().
I was going to assess the situation after the first week of the merge
window.

That time is now and things are looking good. We only have one stragglers
on the patch which had already an ACK for so I'm picking this up here now and
the last patch is the one that uses an axe. Some careful eyeballing would
be appreciated by others. If this doesn't get properly reviewed I can also
just hold off on this in my tree for the next merge window. Either way is
fine by me.

I have boot tested the last patch and 0-day build is ongoing. You can give
it a day for a warm fuzzy build test result.

Luis Chamberlain (2):
  kernel: pid_namespace: simplify sysctls with register_sysctl()
  sysctl: remove register_sysctl_paths()

 fs/proc/proc_sysctl.c     | 55 +++------------------------------------
 include/linux/sysctl.h    | 12 ---------
 kernel/pid_namespace.c    |  3 +--
 kernel/pid_sysctl.h       |  3 +--
 scripts/check-sysctl-docs | 16 ------------
 5 files changed, 6 insertions(+), 83 deletions(-)

-- 
2.39.2

