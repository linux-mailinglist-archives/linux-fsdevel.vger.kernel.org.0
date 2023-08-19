Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDF1781946
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Aug 2023 13:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjHSLiz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Aug 2023 07:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjHSLiy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Aug 2023 07:38:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F18D2EC97;
        Sat, 19 Aug 2023 04:38:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D58460B52;
        Sat, 19 Aug 2023 11:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A760C433C8;
        Sat, 19 Aug 2023 11:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692445098;
        bh=8Xb1sXpK5Czzw+xGJmlX3j6jz4r9B4+2GgzRkwc9Qx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d9imIt/XhSq5NYpp+4zuMr6YIgg2dHGSIFCpFwJJyd2GJTKLypz9X65P9AV1V7dNx
         N1s11sNw/pwSLkZlPmzw/O5CIj/9cSkN3vK2iMtiqbUaXrRSt7199vYxbNTUt42Fl7
         kuwSOwFR5mQiQVTQM44BcoE9lsQfGTtVrs4e5ucgUSxkVsPRZ1knEu+CSSMoqsT8EH
         IxjMtHy4w59/aOd54hT8LKoPmfQwqKD/UxYQc5PBNYPaMoksNO2+fe72EnDZeEbFyj
         +uZ057iQpDIi1DDpa5VMiBMvOr9hkbrAts38/OymHt2AsSLXdqlbVDZjvn1EbnzokJ
         EW6bR+eeJVYnw==
From:   Christian Brauner <brauner@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][next] fs/pipe: remove redundant initialization of pointer buf
Date:   Sat, 19 Aug 2023 13:38:12 +0200
Message-Id: <20230819-mundschutz-neuanfang-4dc2a6524c56@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818144556.1208082-1-colin.i.king@gmail.com>
References: <20230818144556.1208082-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=brauner@kernel.org; h=from:subject:message-id; bh=8Xb1sXpK5Czzw+xGJmlX3j6jz4r9B4+2GgzRkwc9Qx8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8WDnz83WD4LNmCus8HK68mqqYs/RK79sjdcy39ELmZ3qd WZ29rKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiP+Yy/FP5cPx+rPCuc9n2kVadT7 7N2L0nXerSQkWfzYoeLEF3fjowMvw6ahvUfPOydPv2JX2JH/4+TbrSkLFA+N3iiNWN7gGMxiwA
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

On Fri, 18 Aug 2023 15:45:56 +0100, Colin Ian King wrote:
> The pointer buf is being initializated with a value that is never read,
> it is being re-assigned later on at the pointer where it is being used.
> The initialization is redundant and can be removed. Cleans up clang scan
> build warning:
> 
> fs/pipe.c:492:24: warning: Value stored to 'buf' during its
> initialization is never read [deadcode.DeadStores]
> 
> [...]

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

[1/1] fs/pipe: remove redundant initialization of pointer buf
      https://git.kernel.org/vfs/vfs/c/241a71ef5d91
