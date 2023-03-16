Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEE46BD13B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 14:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCPNrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 09:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjCPNrJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:47:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24D4CD655;
        Thu, 16 Mar 2023 06:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D17F62039;
        Thu, 16 Mar 2023 13:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E162BC433EF;
        Thu, 16 Mar 2023 13:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678974387;
        bh=1gVsUfRdT5Jio1KktPVUW54d8HJOPU8c6DUTVfKOJJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IiRzRXv0Aygh7lxTWPgSOwS0YFasS46i/H/xEVf4HV3XSQ/wqzAVuWc48sZZ/ZBWh
         /2mLoXnBAPbPNav/XKofl3QhYuG+hl24Aadmo3jTDMua3XXUJczwpALbkhqwjuwnT0
         B7k1XM5kVp24w9rX4H5m7/JR3eiQzaAiVx76SrLooikKWFzMQ2TBGj0MixvMiaBPNJ
         NTU+I5DhXKcY6aGBWnQklylmteMZWa9qqzMAhSYbLoq6BBXbfsszAFCK+njdem7L7k
         +JC5PK7ufH9jzHjr5ZNwE6ZHEsS36RVW9+LKGVKnkLGCvdPkyGd+0SzQ+zBhgocvXS
         VT14Q4xFDX9iA==
From:   Christian Brauner <brauner@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RESEND] fs_context: drop the unused lsm_flags member
Date:   Thu, 16 Mar 2023 14:46:17 +0100
Message-Id: <167897413798.1242423.2984314832830103642.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316130751.334227-1-omosnace@redhat.com>
References: <20230316130751.334227-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=712; i=brauner@kernel.org; h=from:subject:message-id; bh=2EaFAKesLtNFKDCybmgNbFYVs7Vix+i69ySP2/aagBo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQIyy4Kn2x66t2rhCurLP2mf3GJiN/ZpiElVrshUON1/73G N5eiOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYS4Mvwv/5cS9/iVHefkrQ/BlFmer NvSM5t8/7izHrgyexFxstNyhj+Jz++zrz2e9zVqyZFIZw7u0+7ZwsrOvlyFXLMFbJ+dzWdHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner (Microsoft) <brauner@kernel.org>


On Thu, 16 Mar 2023 14:07:51 +0100, Ondrej Mosnacek wrote:
> This isn't ever used by VFS now, and it couldn't even work. Any FS that
> uses the SECURITY_LSM_NATIVE_LABELS flag needs to also process the
> value returned back from the LSM, so it needs to do its
> security_sb_set_mnt_opts() call on its own anyway.
> 
> 

Seems indeed unused currently. I don't see fc->lsm_flags being used after
having been set. So applied. Please yell, if there's some subtle place where
this should matter after all,

tree: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
branch: fs.misc

[1/1] fs_context: drop the unused lsm_flags member
      commit: 4e04143c869c5b6d499fbd5083caa860d5c942c3
