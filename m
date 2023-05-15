Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308AB702B41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 13:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbjEOLSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 07:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240305AbjEOLSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 07:18:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D46114;
        Mon, 15 May 2023 04:18:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DB9F622A2;
        Mon, 15 May 2023 11:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE52C433EF;
        Mon, 15 May 2023 11:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684149486;
        bh=XPqJC1famnX99qOLE2B4jz1Qeg8LKXnvOXIOuG7G6eA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EzxVXexVyRZzIVNPG9xjRIgvqeXwwbX6DzX6d5RbrXLvTBWCJZkk9AOhtCK4Q+8WL
         0wlxTCQ1rmytwtxnfMZo7ajHpNGqWpCF3tOWFzuHJr5mmhVYjt8zohuYmGoatKf2uA
         zOT3HwwIShqtRovw+U6MHRN3K5JAjQ3SNa1i/58PCUxATt6VlFdJV0wsIIn68DZhM6
         mkzLa8RbsyVzySA/B+IwhGqXVF09FKyZchx6h3Sr33AOKZvOf1DKeQ0/2R2//USd3g
         6gl6C08iO3Rrz6BG12sPLgs2QeGfu5Zq0iUpoArX6nv/JAxIPb+Mg3bamCvgpugGej
         QkCBBhRBXZDng==
From:   Christian Brauner <brauner@kernel.org>
To:     Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] fs: fix incorrect fmode_t casts
Date:   Mon, 15 May 2023 13:17:58 +0200
Message-Id: <20230515-hirsch-robust-fb5b936fb943@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502232210.119063-1-minhuadotchen@gmail.com>
References: <20230502232210.119063-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=brauner@kernel.org; h=from:subject:message-id; bh=XPqJC1famnX99qOLE2B4jz1Qeg8LKXnvOXIOuG7G6eA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQkiTw4sO3m3kSZS7+a6u8+j/DV3+GwU1p5WgDHxqZDcz1O 7dLk6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIbWtGhnWM1TdmsCfWHTrp0tn7Uv rJquhZaVummj4uVtZ06RFfc4GR4X5ljVjnthMzywWrL+xdqRgT/eHGqZ8z7371fqzjFDCjjxsA
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

On Wed, 03 May 2023 07:22:08 +0800, Min-Hua Chen wrote:
> Use __FMODE_NONOTIFY instead of FMODE_NONOTIFY to fixes
> the following sparce warnings:
> fs/overlayfs/file.c:48:37: sparse: warning: restricted fmode_t degrades to integer
> fs/overlayfs/file.c:128:13: sparse: warning: restricted fmode_t degrades to integer
> fs/open.c:1159:21: sparse: warning: restricted fmode_t degrades to integer
> 
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: fix incorrect fmode_t casts
      https://git.kernel.org/vfs/vfs/c/079ad16ded46
