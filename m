Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E435077CA8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 11:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjHOJgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 05:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236121AbjHOJfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:35:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBC119B1;
        Tue, 15 Aug 2023 02:35:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BECDC61AB6;
        Tue, 15 Aug 2023 09:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19DCC433C9;
        Tue, 15 Aug 2023 09:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692092142;
        bh=hi0VtnpzEboHQQj5C2ezCxwMb9TBeAcg+ylZ1XN8Qqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aQbtPMt+4r84phbA4Mc8Snl96/e695YtdcLzvlACgI7u0zroRxF66989IfNG2ecw/
         6qc5zi70HzwnaB7KIOLQHkPM8J5GaPOcoAW6TJS2Ilf1E2L07JtEVG44O7tvlvh2aP
         FhyLImSkdA3SwUQgy/29A6N9IqTpaQldMnDeK6oglrsh6+9OdrN/JkREmlvXCRdKgR
         aSgJq7TlzvdyOYur6THuqfNYTDnY3Co7BNnp//0ckoSduTJVdqogKSnoYjSlBhIuvP
         bRucofBX60tX+keQv7uyJWtuleNt0bF+m3XKemmk8DjD2+ds2PI52nEOyTa9r9QbtR
         LyeLPNw5K3TeA==
From:   Christian Brauner <brauner@kernel.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        rdunlap@infradead.org, viro@zeniv.linux.org.uk, corbet@lwn.net
Subject: Re: [PATCH v4] init: Add support for rootwait timeout parameter
Date:   Tue, 15 Aug 2023 11:35:28 +0200
Message-Id: <20230815-verfechten-magisch-a9cfa1bd6a4e@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230813082349.513386-1-loic.poulain@linaro.org>
References: <20230813082349.513386-1-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626; i=brauner@kernel.org; h=from:subject:message-id; bh=hi0VtnpzEboHQQj5C2ezCxwMb9TBeAcg+ylZ1XN8Qqk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTcdrt1qHOKKzPb/pO+LG1nKl+tb3yQvqTwz2K9u1pcJndN PGqndpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkykWGv4KX6h+ZLXcN3Tov3nFvw3 fZozNaopcG1Xce3LiVZ42JeRTD/6wTl5+fSt7uqHxaKv+m6/a+p0zVArb3J94sP/h4X9IXGSYA
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

On Sun, 13 Aug 2023 10:23:49 +0200, Loic Poulain wrote:
> Add an optional timeout arg to 'rootwait' as the maximum time in
> seconds to wait for the root device to show up before attempting
> forced mount of the root filesystem.
> 
> Use case:
> In case of device mapper usage for the rootfs (e.g. root=/dev/dm-0),
> if the mapper is not able to create the virtual block for any reason
> (wrong arguments, bad dm-verity signature, etc), the `rootwait` param
> causes the kernel to wait forever. It may however be desirable to only
> wait for a given time and then panic (force mount) to cause device reset.
> This gives the bootloader a chance to detect the problem and to take some
> measures, such as marking the booted partition as bad (for A/B case) or
> entering a recovery mode.
> 
> [...]

Hmkay, let's give this some -next exposure.

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

[1/1] init: Add support for rootwait timeout parameter
      https://git.kernel.org/vfs/vfs/c/3b0086ced97f
