Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC64751A04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 09:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjGMHhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 03:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGMHhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:37:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89224C1;
        Thu, 13 Jul 2023 00:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BE2F61A3F;
        Thu, 13 Jul 2023 07:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4078C433C8;
        Thu, 13 Jul 2023 07:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689233837;
        bh=PBcpfrd4eyPK/MBk1PnMg3e/QAH6Rjvk6p84J7Vxn3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hcn7RW6H46BHJdk4Nd06Xh27EHMDQzHazyRRAFTM6WzRMHZUtfYRX4mspqoOunLzP
         4GjG8T4itjME+KrZJCPsHCcxVbQ3JgbQ2ReTn6B2R11cWCGp6jV0Yiwm/Am21wkIG7
         HwgzByIaM4I5X52zY76KmqLu1CYeVSi5kdBPG3oBxiwSlbC+7TKuqRPlaxtO+mbiMZ
         js1bfM31NiRtFjDB0TcC3j6AMcvFtc3WbcagiRKxNjyCnIUC8gCPaRFnZLM5BLCDBR
         vwQK0ZKQL9cKfSVe5n7h+qtZCqgh6ZAKC+r96AEPP0rx6fJ3Rmyf8C/HGSTH0myJ/M
         gyu67ekyWYeCQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH v2] attr: block mode changes of symlinks
Date:   Thu, 13 Jul 2023 09:37:03 +0200
Message-Id: <20230713-solarstrom-autopilot-41444d363fa1@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712-vfs-chmod-symlinks-v2-1-08cfb92b61dd@kernel.org>
References: <20230712-vfs-chmod-symlinks-v2-1-08cfb92b61dd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=brauner@kernel.org; h=from:subject:message-id; bh=PBcpfrd4eyPK/MBk1PnMg3e/QAH6Rjvk6p84J7Vxn3s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSsXznzrck76fSdJZGrQxKXm0Xo7JLuWnUy+9ihp0tnrzwR p6z7pqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiTlEM/wwny1z8/HtZy7z3G/tj05 +9Xr+r3551Vvzh6w08QrZHdsQxMrzZaebV8odpat3iuSdKD2zhmH7mylMHRZPk/MM9mwrflzIAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 12 Jul 2023 20:58:49 +0200, Christian Brauner wrote:
> Changing the mode of symlinks is meaningless as the vfs doesn't take the
> mode of a symlink into account during path lookup permission checking.
> 
> However, the vfs doesn't block mode changes on symlinks. This however,
> has lead to an untenable mess roughly classifiable into the following
> two categories:
> 
> [...]

Let's get this into -next and see whether there's any obvious immediate
fallout because of this.

---

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] attr: block mode changes of symlinks
      https://git.kernel.org/vfs/vfs/c/6be357f00aad
