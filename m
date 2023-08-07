Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF2771CB1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 10:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjHGI43 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 04:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjHGI4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:56:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EF710FE
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 01:56:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CCA36167A
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 08:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E74C433C7;
        Mon,  7 Aug 2023 08:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691398568;
        bh=5RR/2Gwtht+lUSZTGrMyxscAeSiOU/sdIv55M23y7UE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lhBGTN9UlAMQlQaAQ9HfT4pheFALcRl126hPIvgQqLh/YLiYIslfR8uyWrZOo3FFd
         MA033hKJZRFMRcD4oCBGavHqLCJpY15Ml3Oixm73/NJb0BlCBI6HDIzF6gKeU/0puy
         klAmgmFxBp68wRzXblx0eo99IGg+YSSafdU9sG24K8lfKwbcr+fW11jPzlmtuoCm1F
         V7/kFOvyx9REGpuuhfWlpGq9HGoYofurN42UBV80BMXyCKxSeCI7y2CKl1N7aG5FGd
         tLsP3nxqEnQL8kjRltJDRzc2N37BIZo0kotCuj9VTV44+suLpdxhRZaHCvMb/gtma6
         EgM+j9qW/qDTA==
From:   Christian Brauner <brauner@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Jenkins <sethjenkins@google.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH] tmpfs: verify {g,u}id mount options correctly
Date:   Mon,  7 Aug 2023 10:56:03 +0200
Message-Id: <20230807-ozonwerte-aderlass-2c1d8a3a750c@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801-vfs-fs_context-uidgid-v1-1-daf46a050bbf@kernel.org>
References: <20230801-vfs-fs_context-uidgid-v1-1-daf46a050bbf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456; i=brauner@kernel.org; h=from:subject:message-id; bh=5RR/2Gwtht+lUSZTGrMyxscAeSiOU/sdIv55M23y7UE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRc2Ljw0vqe992VKucWP2zOCvz55/Sbt9uXXJWoa7D9/MM8 SbmRpaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiyV4Mf8VrVj49UTBX/rDwontbV/ Sw3DBqOzjXd7Kj2p53HPk531cwMpx6ayDELWAbzfb5vZ5l9I3jvnsfxunsr2HK+pTg+9CLixUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 01 Aug 2023 18:17:04 +0200, Christian Brauner wrote:
> A while ago we received the following report:
> 
> "The other outstanding issue I noticed comes from the fact that
> fsconfig syscalls may occur in a different userns than that which
> called fsopen. That means that resolving the uid/gid via
> current_user_ns() can save a kuid that isn't mapped in the associated
> namespace when the filesystem is finally mounted. This means that it
> is possible for an unprivileged user to create files owned by any
> group in a tmpfs mount (since we can set the SUID bit on the tmpfs
> directory), or a tmpfs that is owned by any user, including the root
> group/user."
> 
> [...]

Applied to the vfs.tmpfs branch of the vfs/vfs.git tree.
Patches in the vfs.tmpfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.tmpfs

[1/1] tmpfs: verify {g,u}id mount options correctly
      https://git.kernel.org/vfs/vfs/c/f90277cb4cae
