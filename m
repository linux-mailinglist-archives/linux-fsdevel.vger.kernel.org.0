Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174BF746B07
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 09:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjGDHse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 03:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjGDHsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:48:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB8310C1;
        Tue,  4 Jul 2023 00:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31AC86116F;
        Tue,  4 Jul 2023 07:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39BEC433C8;
        Tue,  4 Jul 2023 07:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688456878;
        bh=BCxbBhFB2fnEQ3pj32Jfe5AEZv8PluDo4D3PXB5YwjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VSAy8yxR/eorq8EuqoYe3jaj5zC5NTbuXA6V0wUvh6CfyRJJt0Q+oyZfhzuTrfoOP
         IhlNLxx8OgQlQoVb/fVdj/wU69AO1MOWzX/bCE7wwXuIYAglABM313BEjR8rgETE/R
         7RkYl7gOVumDLTWGKCqLDJSPz5q9NkYGh928ZJpU2jvRs63BnYvqOp/E9RtyxgRwPs
         9Ky5QxZRDOzfN/Rn95QtJnGZmFHKIIDTXMATMzTCDNncSk1ZnoUIJE4hLD9ppfce5x
         56UegCwBrFiMsaLphC7UhNPUiCRCmFCHtf9UIQCM5neTda3wpulhxCKVVL6cYhllBO
         gCVSMlHlbvejQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libfs: fix table format warning
Date:   Tue,  4 Jul 2023 09:47:51 +0200
Message-Id: <20230704-yacht-pfeffer-567bbd67d7f7@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704044643.8622-1-rdunlap@infradead.org>
References: <20230704044643.8622-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=brauner@kernel.org; h=from:subject:message-id; bh=BCxbBhFB2fnEQ3pj32Jfe5AEZv8PluDo4D3PXB5YwjU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQsPjdvSWlg+3/psg7d0KhEhbXq1/guaPrESu1ncCvMebny nMyUjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkcs2dkuMRa82TOaeYa/yv2CTqZ7C HJUgf2PP70/Wcx70flrOnhHAz/a7hdftkW+NxbsfW4kLZZfuWPeZ0i84ttd/+atNfq1/mHfAA=
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

On Mon, 03 Jul 2023 21:46:43 -0700, Randy Dunlap wrote:
> Drop the unnecessary colon to make the table formatting correct.
> The colons are not needed and this file uses them sometimes and
> doesn't at other times. Generally they are not preferred in
> documentation tables IMO.
> 
> Also extend the table line widths to match the table text.
> 
> [...]

I've folded this fix into Chuck's series. Thanks!

---

Applied to the vfs.readdir branch of the vfs/vfs.git tree.
Patches in the vfs.readdir branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.readdir

[1/1] libfs: Add directory operations for stable offsets
      https://git.kernel.org/vfs/vfs/c/2b1732fc0a7c
