Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2009577064D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 18:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjHDQuI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 12:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjHDQuG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358043C28;
        Fri,  4 Aug 2023 09:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5995620A7;
        Fri,  4 Aug 2023 16:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE00EC433C9;
        Fri,  4 Aug 2023 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691167804;
        bh=ZfGdzIAuhwL7qwEggkWYx0zmGQwPFGXxKE/YKErZ3QQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVivwCU/HejBsQUX67O3IcXu1YfP07Y28/i5qpOmmZALYEQytDTV0wE0ZiABYOTjW
         iw6O4JYtneCAmC2GFEyKNpZR2a7lk8PtWeaH0acZ+IjFTtH//jyGYRRCh5FxHlUWGT
         9cWuoTlFy3ZSlL3RF8MU5sE+FlWA6NocxdxqliEA7/9XdLVEvCEXjHg5zC8QVjzzt5
         q6AD9A/EpQ5sv75rEuQCISzfcaJ9aWezwpbpVaiRd+ga/p3ZhKh+VTUr1Wt/zgUa1/
         LF326lrp8mEIoqSaoKRXA6BA/q3/FMSqWSA+gg7vfqUEmOh3uICto9fM8cS2AU39+X
         MwNO6ZynwIkvg==
From:   Christian Brauner <brauner@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] file: mostly eliminate spurious relocking in __range_close
Date:   Fri,  4 Aug 2023 18:49:58 +0200
Message-Id: <20230804-hubschrauber-hypothek-e8003cd3fbec@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727113809.800067-1-mjguzik@gmail.com>
References: <20230727113809.800067-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=brauner@kernel.org; h=from:subject:message-id; bh=ZfGdzIAuhwL7qwEggkWYx0zmGQwPFGXxKE/YKErZ3QQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSc1TF5J5Zk3bvEP/xDkumuy436T5+y/NMMunRXllX1nW6/ weLcjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIksV2BkWCE3kb/scEWJRPIsUw52eb u91yVLO+Oi396Z1zU98obIP4a/0t6z9qnz8X04dZrt7S3TT8vK9FzVdzblK0351HxuDUMfFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 Jul 2023 13:38:09 +0200, Mateusz Guzik wrote:
> Stock code takes a lock trip for every fd in range, but this can be
> trivially avoided and real-world consumers do have plenty of already
> closed cases.
> 
> Just booting Debian 12 with a debug printk shows:
> (sh) min 3 max 17 closed 15 empty 0
> (sh) min 19 max 63 closed 31 empty 14
> (sh) min 4 max 63 closed 0 empty 60
> (spawn) min 3 max 63 closed 13 empty 48
> (spawn) min 3 max 63 closed 13 empty 48
> (mount) min 3 max 17 closed 15 empty 0
> (mount) min 19 max 63 closed 32 empty 13
> 
> [...]

massaged it a bit

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

[1/1] file: mostly eliminate spurious relocking in __range_close
      https://git.kernel.org/vfs/vfs/c/215baa741614
