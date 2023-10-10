Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D60C7BF622
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 10:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbjJJIh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 04:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442925AbjJJIhO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:37:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE972D56;
        Tue, 10 Oct 2023 01:36:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55C8C433C7;
        Tue, 10 Oct 2023 08:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696926968;
        bh=r0acTdpPV43k03AaibK8ATvRg6OuKldRVbxez5OV1Wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUiMo2sfK8qNVzn9S67WuqpPL2z6FHIjcroFF4t4NDlVwiy7cASY1qTQbZ2waULx4
         WICp1oJvJ+jLU3bRzuvIKn8qQZF68dJgv4ZY4MsELgva/xckA9qr3cplpIsPpfiE3k
         h/+b8fZ7x33UQTHaxbpQTisEzCCqX9Ll5yqIm+GE7AR9SCgM9+LTJOZP5Tt4iQlLjt
         Z2Z7djbu17Ep61ac0KGRM4IWAcFmvcGU4cMrEbu7d5nAvxWgE+KA78GR+lzTaADYdM
         AEC0Ve6geMd/9/u0NxNcT6PuSN0W8Rw1ul7AaHRGmbR2D0Qgb3TeBcpNjEskt4eqIu
         GXRVsp7e+HfcQ==
From:   Christian Brauner <brauner@kernel.org>
To:     amir73il@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>,
        syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Pass AT_GETATTR_NOSEC flag to getattr interface function
Date:   Tue, 10 Oct 2023 10:35:47 +0200
Message-Id: <20231010-erhaben-kurznachrichten-d91432c937ee@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002125733.1251467-1-stefanb@linux.vnet.ibm.com>
References: <20231002125733.1251467-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448; i=brauner@kernel.org; h=from:subject:message-id; bh=r0acTdpPV43k03AaibK8ATvRg6OuKldRVbxez5OV1Wk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSq8tx16f98NfBy1Y1JS77aKfi5bJzIabXYSt5z28s6t+09 nLM9O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyM43hv5uhRoDqs59z7B7kLDvH46 8SIGA1Oay4ZJYMy7Nt+ux/vjEy7D34aNKqW3GGQdk2POvXM3SLsPbs23G9iOG5m9h6S8VYJgA=
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

On Mon, 02 Oct 2023 08:57:33 -0400, Stefan Berger wrote:
> When vfs_getattr_nosec() calls a filesystem's getattr interface function
> then the 'nosec' should propagate into this function so that
> vfs_getattr_nosec() can again be called from the filesystem's gettattr
> rather than vfs_getattr(). The latter would add unnecessary security
> checks that the initial vfs_getattr_nosec() call wanted to avoid.
> Therefore, introduce the getattr flag GETATTR_NOSEC and allow to pass
> with the new getattr_flags parameter to the getattr interface function.
> In overlayfs and ecryptfs use this flag to determine which one of the
> two functions to call.
> 
> [...]

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

[1/1] fs: Pass AT_GETATTR_NOSEC flag to getattr interface function
      https://git.kernel.org/vfs/vfs/c/6ea042691c74
