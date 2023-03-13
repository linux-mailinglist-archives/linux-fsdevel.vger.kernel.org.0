Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2716B8495
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 23:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCMWO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 18:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCMWO5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:14:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D64637E5;
        Mon, 13 Mar 2023 15:14:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13D6B61515;
        Mon, 13 Mar 2023 22:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BB2C433D2;
        Mon, 13 Mar 2023 22:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678745695;
        bh=rKfoy93hJj4VmXsCDkmnDS18pShi6/5/H6xgS4gamWM=;
        h=From:To:Cc:Subject:Date:From;
        b=iEsfmcR3a2R4Fk1BqVASdexJ2zfUlIGIvG3+gSmHWAz9rKxU0McJkXxgxZ3RTwJN9
         L57Q6ZY64D9kwhpgn2fXRU7O5iQ3edrwZKRzxxfkR21y480c4ylAMWP0eLaLIdpkeQ
         L9o3oU+L4b2S1mF7E48S5hpDHHWNiGjmkZc4CTG7m9eBVcXD/acHcCygC5esK4T6eT
         OOIohSJ38k1Z41Hstruu05DEXHjyz3APx6bqDdxQHRg/Cxa9D9SSDFV0UQu0/uAMCQ
         xcVraiTkBO4IA/yJgUAPI0+Bj6wER6fptal1ynTdgoDgwlV3/nbVVia8Z/rSklVnrF
         EepX/M6JMxstw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 0/3] Fix crash with fscrypt + Landlock
Date:   Mon, 13 Mar 2023 15:12:28 -0700
Message-Id: <20230313221231.272498-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series fixes a bug, found by syzbot, where when a filesystem was
being unmounted, the fscrypt keyring was destroyed before inodes have
been released by the Landlock LSM.

Eric Biggers (3):
  fscrypt: destroy keyring after security_sb_delete()
  fscrypt: improve fscrypt_destroy_keyring() documentation
  fscrypt: check for NULL keyring in fscrypt_put_master_key_activeref()

 fs/crypto/keyring.c | 23 +++++++++++++----------
 fs/super.c          | 15 ++++++++++++---
 2 files changed, 25 insertions(+), 13 deletions(-)


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

