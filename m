Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1214F744D71
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 13:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjGBLZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 07:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBLZq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 07:25:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2139183;
        Sun,  2 Jul 2023 04:25:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 740F760B63;
        Sun,  2 Jul 2023 11:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D5EC433C8;
        Sun,  2 Jul 2023 11:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688297144;
        bh=yrS093EQED88TibXSSCDpF4IZ4UvbzULHIuRA6406Sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8UMVhKzsKl4V0BNJp/Oh6+OJ+DIPkW7YYTY45z5iyAp7bi76i+53OmYwhc7gjzHP
         ZtzpvklsV0W9Za/3tOPXgAKECPv1lppcoeNiIYGPYPdm3CbUwbd+7JAm5UA/wBDb+m
         fSOkeG+FDANaKE2fXcktx5X+qsIZPQAnQsaw5FByGF52FyttQVTyK4tmycleKTTrCl
         ZjmWnUVCZVbubgc8lH3Jl/QFI4Qyb2gFa8wtRLR2layDHj2AwvFKuFJmbBvvoCgmnq
         fl9FKgypI0aJD5er6JqbjOyxDPST14RRNFfLUd7tMsxJ3MKbZ+q8vnUmah6f94SjRl
         PVU8nDczRyykw==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH] fs: fix invalid-free in init_file()
Date:   Sun,  2 Jul 2023 13:25:35 +0200
Message-Id: <20230702-jazzkonzert-ansiedeln-9756cc5ed995@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701171134.239409-1-amir73il@gmail.com>
References: <20230701171134.239409-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=brauner@kernel.org; h=from:subject:message-id; bh=yrS093EQED88TibXSSCDpF4IZ4UvbzULHIuRA6406Sg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQsjFvyYWMpt/G1drV06dU852PmPvrxJfCLm9b+mX6Gbw0W 7Vls1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARj+8M/71vr1BUdJxyiyvD5bPSlA VzbTZ07v55Wct1u9B3t39zC8QZ/hce1Al2ZOJ/rVoYJXhcoVzd8mF+9cx/pyQlznvzTfnHyAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 01 Jul 2023 20:11:34 +0300, Amir Goldstein wrote:
> The use of file_free_rcu() in init_file() to free the struct that was
> allocated by the caller was hacky and we got what we desreved.
> 
> Let init_file() and its callers take care of cleaning up each after
> their own allocated resources on error.
> 
> 
> [...]

Thanks for the fix! I'll send a pr shortly.

---

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs: move cleanup from init_file() into its callers
      https://git.kernel.org/vfs/vfs/c/dff745c1221a
