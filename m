Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B511B6F5F06
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 21:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjECTSL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 15:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjECTSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 15:18:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0D410D2;
        Wed,  3 May 2023 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4ZmM4HTiK/znMvvowe1LUd4PXCYNKLo7UX2p4qgTXGU=; b=VOJAVkEssu13qwWK2bqnx1KNc1
        GZOztv8i2scsmcBqy1XJuLA7jOp8fZ5iN9T0EgmHYFXY0yTYipLKabV+U2edQrMvVEaN1TAVLpjeb
        J6u02nSaz1f6pUu/q13fENzJCV/2VrXRNRRZquKp5PlaZ0BSYwTA6A/X6ph81tFdjzGSPNmI+jsPW
        H0J5Cog8m3/n8MlP8061pfzaWc5+YdXBOhOE99YdAYPr+1luMCswGomVXPmxeUgUUK3ieEsZYMd4X
        Sp+Z5Vg3WaBmIj77MONOGh37xsRghjira2MU4x7F/n01heKmwQohqL6ouIdyLpmT16BaLavGhgqpw
        7ltG5cEQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1puHzB-005ZOl-2h;
        Wed, 03 May 2023 19:17:57 +0000
Date:   Wed, 3 May 2023 12:17:57 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        ebiggers@kernel.org, jeffxu@google.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
Subject: [GIT PULL] sysctl changes for v6.4-rc4 v2
Message-ID: <ZFKzZeAs5Mdfv5ha@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit 348551ddaf311c76b01cdcbaf61b6fef06a49144:

  Merge tag 'pinctrl-v6.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl (2023-05-02 15:40:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.4-rc1-v2

for you to fetch changes up to 0199849acd07d07e2a8e42757653ca8b14a122f5:

  sysctl: remove register_sysctl_paths() (2023-05-02 19:24:16 -0700)

----------------------------------------------------------------
sysctl-6.4-rc1-v2

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

I have boot tested the last patch and 0-day build completed successfully.

----------------------------------------------------------------
Luis Chamberlain (2):
      kernel: pid_namespace: simplify sysctls with register_sysctl()
      sysctl: remove register_sysctl_paths()

 fs/proc/proc_sysctl.c     | 55 ++++-------------------------------------------
 include/linux/sysctl.h    | 12 -----------
 kernel/pid_namespace.c    |  3 +--
 kernel/pid_sysctl.h       |  3 +--
 scripts/check-sysctl-docs | 16 --------------
 5 files changed, 6 insertions(+), 83 deletions(-)
