Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76F17171AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 01:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjE3X3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 19:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjE3X3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 19:29:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A94AA;
        Tue, 30 May 2023 16:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8kZDmW7u1BAwE+M5sWH6dCUNdnC2eoBRZLZS/mk42z4=; b=FpoywbOee5kJx6j7BsroAWkapc
        C8vpYY7F0mBdwtR9djLjY1oi4UXRWCW8OjSs0qYtgy3atfS47cAhj6mhbBP+9J4UMCCCGohcAunY4
        x3yRDL/6/zJZPiqVxcqZt/lvFNyWOiruXvpDHPp3OcRvHq3KYyfv5qPULQO4qZ7x0XtVxU+9f4g/t
        3j4PhZWEuZaJzfz0C30Kmwbs2XobhTuO+/Z1F8dhsUUi2XKs3AaiVYC6l+ZhXWSX3GqWCJ+tJE6ll
        2dKpTX0UglWP6jBS25td4J+tS0IIfCWgk1/GgBEhZpcqMyjkHGv2nMMFvPJemJEF0NtJfV3in9ZiO
        uLb6Nv2Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q48mB-00FTri-0j;
        Tue, 30 May 2023 23:29:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org, yzaikin@google.com, dhowells@redhat.com,
        jarkko@kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, j.granados@samsung.com, brauner@kernel.org
Cc:     ebiederm@xmission.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/2] sysctl: move umh and keys sysctls
Date:   Tue, 30 May 2023 16:29:12 -0700
Message-Id: <20230530232914.3689712-1-mcgrof@kernel.org>
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

If you look at kernel/sysctl.c there are two sysctl arrays which
are declared in header files but registered with no good reason now
on kernel/sysctl.c instead of the place they belong. So just do
the registration where it belongs.

The penalty of this is just 66 bytes for moving both registrations
to its own file, but soon we'll be removing all sysctl empty entries
at each array, and we've already done tons of cleanup on fs/proc/proc_sysctl.c
which saved us hundreds of bytes so we have few karma points.

With this, we no now only have two sysctl arrays left to start clearing
up the kernel one and the vm one.

Luis Chamberlain (2):
  sysctl: move umh sysctl registration to its own file
  sysctl: move security keys sysctl registration to its own file

 include/linux/key.h    |  3 ---
 include/linux/umh.h    |  2 --
 kernel/sysctl.c        |  5 -----
 kernel/umh.c           | 11 ++++++++++-
 security/keys/sysctl.c |  7 +++++++
 5 files changed, 17 insertions(+), 11 deletions(-)

-- 
2.39.2

