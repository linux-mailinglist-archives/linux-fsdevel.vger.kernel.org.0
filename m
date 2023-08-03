Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003DA76EB51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 15:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbjHCN6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjHCN6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:58:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF8DE57
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 06:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E51DB61DAC
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 13:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510ABC433C8;
        Thu,  3 Aug 2023 13:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691071099;
        bh=T0QSSsspQgIm1yZCAzZjPKfOcLS1Ltq4w5TZzUiuWFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IjCH7RUpK8WmYe5tE7AEV29Lph9FutwGK4MXnmQlnc6VsdOGguK1UQuc4iViLE6KH
         zAGhRQItWdHs9y2Ua17MVS97Cpfl9/Prybqb/zWvG/I4UBvNt4I5W2kt33Ti9SfxHR
         MctcA8T0mr0UKiTr4Lh+miqni2TXHGqIt+mOAIPTWgWHv7+uVslR7Q052jGmJnK/ft
         DsejQZnajIhUF+tvjHGLQYR+SDI3nAw8wlWS6hVYQQ8OCPcTuO1k0na5uAfpZo2rk7
         qqIlsZE4Epei6H4sdnvEAjDJRmJIZpelXHnf6eZPPjRFJwMi+VDbGXPjPpn0g0eCnq
         fiteXKukba9UA==
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 0/4] fs: add FSCONFIG_CMD_CREATE_EXCL
Date:   Thu,  3 Aug 2023 15:58:12 +0200
Message-Id: <20230803-asphalt-tochter-3479dea9a967@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802-vfs-super-exclusive-v2-0-95dc4e41b870@kernel.org>
References: <20230802-vfs-super-exclusive-v2-0-95dc4e41b870@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368; i=brauner@kernel.org; h=from:subject:message-id; bh=T0QSSsspQgIm1yZCAzZjPKfOcLS1Ltq4w5TZzUiuWFQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSc3lQYd0E5fEubNuvzBOn+ax3LZJ6mOFjM3mi3f4aE2AMb caYdHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5eYaR4Whc6iLjyUaGR45VeWd2tG Z923NnscWpiKkO/GuSrqRv7mT4Z35UJj3X0/iH1uKwqVsW8/M/MGDtCr571XSdyK41sxZe5QcA
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

On Wed, 02 Aug 2023 13:57:02 +0200, Christian Brauner wrote:
> Summary
> =======
> 
> This introduces FSCONFIG_CMD_CREATE_EXCL which will allows userspace to
> implement something like mount -t ext4 --exclusive /dev/sda /B which
> fails if a superblock for the requested filesystem does already exist:
> 
> [...]

Thank you all.

---

Applied to the vfs.super branch of the vfs/vfs.git tree.
Patches in the vfs.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.super

[1/4] super: remove get_tree_single_reconf()
      https://git.kernel.org/vfs/vfs/c/bd868d262fff
[2/4] fs: add vfs_cmd_create()
      https://git.kernel.org/vfs/vfs/c/bcf7017a4241
[3/4] fs: add vfs_cmd_reconfigure()
      https://git.kernel.org/vfs/vfs/c/514d7988640b
[4/4] fs: add FSCONFIG_CMD_CREATE_EXCL
      https://git.kernel.org/vfs/vfs/c/984f30e04bfd
