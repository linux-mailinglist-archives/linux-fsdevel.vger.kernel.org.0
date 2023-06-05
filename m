Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A41722F5A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 21:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjFETKH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 15:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbjFETJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:09:48 -0400
X-Greylist: delayed 406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 12:09:46 PDT
Received: from forward202a.mail.yandex.net (forward202a.mail.yandex.net [178.154.239.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BAB1A8;
        Mon,  5 Jun 2023 12:09:46 -0700 (PDT)
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
        by forward202a.mail.yandex.net (Yandex) with ESMTP id 443814A48F;
        Mon,  5 Jun 2023 22:03:03 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:4c8e:0:640:3460:0])
        by forward103a.mail.yandex.net (Yandex) with ESMTP id E5B1F42B17;
        Mon,  5 Jun 2023 22:02:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id k2Y4EiCDXOs0-wyUCMDug;
        Mon, 05 Jun 2023 22:02:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1685991776;
        bh=d2A7a/fXdJ0HjFXvaIDBfJccZIVLybmyhd3Ml8uMPl8=;
        h=Message-Id:Date:Subject:To:From;
        b=vlX7aUUym6OiLqJo1vzOwZQebF2A87eqINyFK8QRZ2kFXHDYWuV1dkXFc3WzsroCg
         HL3EIidYcs4s4reIg/mcheFHbs1fXQrFz/6qLbTCL2+oBlaMRK7C6+oeCsNG3i18jD
         5a6FRObcYyOLT6GWimAnCJPy7GkKAKe9hiDPECMU=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From:   Kirill Tkhai <tkhai@ya.ru>
To:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com,
        david@fromorbit.com
Subject: [PATCH v2 0/3] mm: Make unregistration of super_block shrinker more faster
Date:   Mon,  5 Jun 2023 22:02:46 +0300
Message-Id: <168599103578.70911.9402374667983518835.stgit@pro.pro>
X-Mailer: git-send-email 2.40.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch set introduces a new scheme of shrinker unregistration. It allows to split
the unregistration in two parts: fast and slow. This allows to hide slow part from
a user, so user-visible unregistration becomes fast.

This fixes the -88.8% regression of stress-ng.ramfs.ops_per_sec noticed
by kernel test robot:

https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/

---

Kirill Tkhai (2):
      mm: Split unregister_shrinker() in fast and slow part
      fs: Use delayed shrinker unregistration

Qi Zheng (1):
      mm: vmscan: move shrinker_debugfs_remove() before synchronize_srcu()


 fs/super.c               |    3 ++-
 include/linux/shrinker.h |    4 ++++
 mm/vmscan.c              |   39 +++++++++++++++++++++++++++++++--------
 3 files changed, 37 insertions(+), 9 deletions(-)

--
Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
