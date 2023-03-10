Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DC36B5559
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCJXNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjCJXND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:13:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEE49EF5;
        Fri, 10 Mar 2023 15:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=R85E7uQimX2SAhrrjoHNWpuZL+HB0XZL3iNXIzJ+Yfs=; b=OeX4YM2GdD8E9RJo04tNLmwNCS
        x0hqiWJ9Z9ahNS7XwVJSZAXDZmPJo9nNWL7aKXjzydSAFrO0m6dO6xG10dB7jQyx1g+t5152jH5iu
        RFr0CdSqQ1zqYuqLq9UzUk6qXWbt0SggkiG/waVG0ox+0oYz4KKQt9TDjTX9C+sU11JxpkXuF5At9
        hqsCniEWdxR4bSmO2f0ffGRd8rtvqjmmhjNVxfRHtdMb6/eiMnLbt7FhrJ58cNFVQurJ9CVvZt6xY
        8FNgLoLk4rFGNlH3BRUowvYNtRZEF3bvPNqNpJCLZt611qS7AsyT0l+T0DRfcoTDg+2wbym9JFlgy
        voypE+7A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paluB-00GaJB-50; Fri, 10 Mar 2023 23:12:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, jack@suse.com,
        jaharkes@cs.cmu.edu, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/5] misc filesystems: simplify sysctl registration
Date:   Fri, 10 Mar 2023 15:12:01 -0800
Message-Id: <20230310231206.3952808-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This simplifies syctl registration for a few misc filesystems according
to our latest preference / guidance [0]. register_sysctl_table() incurs
possible recursion and we can avoid that by dealing with flat
directories with files in them, and having the subdirectories explicitly
named with register_sysctl().

As we phase these callers out we can deprecate / remove register_sysctl_table()
eventually.

If you're a maintainer feel free to pick up the patch or I'm also happy
to take it through sysctl-next if you like. These don't create
conflicts so there is no requirement they go throug sysclt-next at all.

I can pick up stragglers later.

[0] https://lore.kernel.org/all/20230310223947.3917711-1-mcgrof@kernel.org/T/#u     

Luis Chamberlain (5):
  fs/cachefiles: simplify one-level sysctl registration for
    cachefiles_sysctls
  devpts: simplify two-level sysctl registration for pty_kern_table
  quota: simplify two-level sysctl registration for fs_dqstats_table
  coda: simplify one-level sysctl registration for coda_table
  ntfs: simplfy one-level sysctl registration for ntfs_sysctls

 fs/cachefiles/error_inject.c | 11 +----------
 fs/coda/sysctl.c             | 11 +----------
 fs/devpts/inode.c            | 20 +-------------------
 fs/ntfs/sysctl.c             | 12 +-----------
 fs/quota/dquot.c             | 20 +-------------------
 5 files changed, 5 insertions(+), 69 deletions(-)

-- 
2.39.1

