Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71B16A8A69
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 21:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCBU3v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 15:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjCBU31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:29:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E5134C11;
        Thu,  2 Mar 2023 12:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9hzZZfqZBmriyiJaRRFgj4vKcu5VdE3XPsN3XWm1Rd4=; b=iSYMdzw9ou8NMD1HPcMFyzy5s0
        diTFd1Lfr6YcI+7S2P/PD9/rt8X7ZZ4aXtAwiDQQU9Czr8pgIG+sHmlxSSqSsRjZdmYUZa0wXhNWe
        PULqRYzYg75JdPSO4vpzSC4bGcyaKSyCCKBW9akOwd+CPv9rMlIVtAq1UqFJrHYTqWcxpV0eREHEe
        FGUh7U7G29xpuctqJE7lWEUkzHR03p77us1n7FYFRDiVCLQ807B3Dcq+amXQtS2jMa+I6JRVK8q2I
        Mivc/SWAWz04eHbs6YV6AXJr3XrqPmQIt2VZDbppPLcVdr6lkhshdKLuUH2DoTAaCmQYi5xdgM/vv
        yBkiKPFg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXpXR-003Fx7-Pa; Thu, 02 Mar 2023 20:28:29 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, jeffxu@google.com,
        ebiggers@kernel.org, tytso@mit.edu, guoren@kernel.org
Cc:     j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 00/11] sysctl: deprecate register_sysctl_paths()
Date:   Thu,  2 Mar 2023 12:28:15 -0800
Message-Id: <20230302202826.776286-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As we trim down the insane kernel/sysctl.c large array and move
sysctls out we're looking to optimize the way we do syctl registrations
so we deal with just flat entries so to make the registration code
much easier to maintain and so it does not recurse. In dealing with
some of these things it reminded us that we will eventually get to the
point of just passing in the ARRAY_SIZE() we want, to get there we
should strive to move away from the older callers that do need the
recursion. Turns out tons of users don't need the recursion already
so we can start converting those over.

register_sysctl_paths() can do recursion when its users have sysctl
entries with directories and and then subdirectories with other entries.
This *typically* was the use case in the large sysctl array in
kernel/sysctl.c but as we trim that down we're phasing out the users
that have subdirectories. This means that the code path that can do
recursion is being mitigated over time and the code can be simplified
as well.

There are however many existing users of register_sysctl_paths() which
don't need to deal with subdirectories, and register_sysctl() and the
init version register_sysctl_init() (used when you don't care for the
initial return value / need to de-register) can create subdirectories
for you if you have no entries in between. So just convert these
users to the simpler APIs and deprecate out register_sysctl_paths().

The next step after this is to to start deprecating slowly the callers
of register_sysctl_table(). I'll send a out second batch for those that
apply on top of this.

Unless folks have an issue, I can offer to take these in the sysctl-next
tree as we sweep these out, but I'm happy for folks to take these into
their tree as well if they want. The only possible conflict would be
timing, ie, if the final patch which removes the API call. That patch
could also just wait another or two cycles later.

Luis Chamberlain (11):
  proc_sysctl: update docs for __register_sysctl_table()
  proc_sysctl: move helper which creates required subdirectories
  sysctl: clarify register_sysctl_init() base directory order
  apparmor: simplify sysctls with register_sysctl_init()
  loadpin: simplify sysctls use with register_sysctl()
  yama: simplfy sysctls with register_sysctl()
  seccomp: simplify sysctls with register_sysctl_init()
  kernel: pid_namespace: simplify sysctls with register_sysctl()
  fs-verity: simplify sysctls with register_sysctl()
  csky: simplify alignment sysctl registration
  proc_sysctl: deprecate register_sysctl_paths()

 arch/csky/abiv1/alignment.c | 15 +-----
 fs/proc/proc_sysctl.c       | 95 +++++++++++++++++++------------------
 fs/verity/signature.c       |  9 +---
 include/linux/sysctl.h      | 11 -----
 kernel/pid_namespace.c      |  3 +-
 kernel/pid_sysctl.h         |  3 +-
 kernel/seccomp.c            | 15 +-----
 security/apparmor/lsm.c     |  8 +---
 security/loadpin/loadpin.c  |  8 +---
 security/yama/yama_lsm.c    |  8 +---
 10 files changed, 56 insertions(+), 119 deletions(-)

-- 
2.39.1

