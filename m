Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579D3575664
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 22:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiGNUhG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 16:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGNUhF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:37:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35893ED42;
        Thu, 14 Jul 2022 13:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=r34t2dkJs6BauaDSmiqcG3RpPOCpjuABQcyajNTUCZ0=; b=sS+ulQPK+Ee7+6p6UIG+7ZxPAZ
        fOHqIKnCg5qMLRZqlTpV1Wld0tGXRiMnnNWu7ceI2eMXiP5czu0S83NlYGlbVAQKZIU0J9sYI5k+Z
        dEtEjOjAeBQZhTTLcXJikMreAUzuFHPfp44MvS9T/p36cUCame835KosMovzg/un43VzL+d9ZKLN3
        WshYLFEHZHiIOL/p3z1Ui7HeXONOIr9zXXpQnUJRNKVgKc1XRvrdz4TCrDekwbOS3g4KO5XpRe1zc
        8UNimPSm+H3pJwZxtMX3k07fKtr4GBwFW1GBJiRTX/o4hfsNIhpf87R5Eoeh2niSeP5R7ZEdLnXT4
        T+eeKxMQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oC5Zp-001Vr8-Cg; Thu, 14 Jul 2022 20:36:49 +0000
Date:   Thu, 14 Jul 2022 13:36:49 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     keescook@chromium.org, songmuchun@bytedance.com,
        yzaikin@google.com, mhocko@suse.com, mgorman@techsingularity.net,
        Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
        kuba@kernel.org, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
Subject: [GIT PULL] sysctl fixes for v5.19-rc7
Message-ID: <YtB+YayGeq/KgOqK@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

I've only received one fix for sysctls for v5.19-rc cycle. It's perhaps
silly to send a pull request for just one patch but oh well.

I'll take that time given I am sending a pull request to note that
Kuniyuki Iwashima has posted a trove of fixes with races for when a
subsystem does not do proper locking for read/write to the variables and
so has put effort to do this where applicable by ensuring the sysctl
proc stuff uses READ_ONCE/WRITE_ONCE helpers. Since most of the issues
there have been identified on networking side Dave has picked all that
up. I'll let him decide if he wants that on the rc or not.

I figured I'd mention I don't have much cleanups for kernel/sysctl.c queued up
for v5.20 so expect little work there later for the next cycle. That
should also help with deciding if Kuniyuki's fixes get merged on v5.19
or v5.20 as there shouldn't be any expected conflicts either way.

  Luis

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-fixes-5.19-rc7

for you to fetch changes up to 43b5240ca6b33108998810593248186b1e3ae34a:

  mm: sysctl: fix missing numa_stat when !CONFIG_HUGETLB_PAGE (2022-07-14 13:13:49 -0700)

----------------------------------------------------------------
Only one fix for sysctl

----------------------------------------------------------------
Muchun Song (1):
      mm: sysctl: fix missing numa_stat when !CONFIG_HUGETLB_PAGE

 kernel/sysctl.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)
