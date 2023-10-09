Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76D87BE1DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 15:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377588AbjJINys (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 09:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377570AbjJINyq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:54:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7568ECF;
        Mon,  9 Oct 2023 06:54:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A043C433CB;
        Mon,  9 Oct 2023 13:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696859684;
        bh=ompOgLLvmlaZ/tZHb2NKNh+AWkXSSBfmdsowsHpjK1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9o9dDnp3E7CyoCXUH0vvzI9zyOVbFPT79OCHoI+Ops84d00hoDR+hLMweUsU2oEb
         1KNscg7x7tj+4tD46Fz/Rx75OlaYlkypHxdpCCfTx5gw3XnqDh+AmmC9ICw9upSA2s
         X/d+VnTA/XzHoblJdENjh1ej6qTpgotK7bCtJK0td03/kIw+2o5mLrP8OHEjoc9esi
         Xh7KpUyBTP0rV6mW1kQI21C8tmD9fod1PHGfTu/5EHd4epEkubnNLFkQjXRzJGVJVC
         1WqO2LAL3+/pDlolNKPS34ybeTYj6anBHy24XnV6vdCFe8lt0gYzYPr/Iee2BIBiwp
         EC7BDRB7YGYqQ==
From:   Christian Brauner <brauner@kernel.org>
To:     jack@suse.cz,
        syzbot+23bc20037854bb335d59@syzkaller.appspotmail.com,
        Lizhi Xu <lizhi.xu@windriver.com>
Cc:     Christian Brauner <brauner@kernel.org>, axboe@kernel.dk,
        dave.kleikamp@oracle.com, hare@suse.de, hch@lst.de,
        jfs-discussion@lists.sourceforge.net, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: fix log->bdev_handle null ptr deref in lbmStartIO
Date:   Mon,  9 Oct 2023 15:54:36 +0200
Message-Id: <20231009-vielsagend-halbmarathon-2c0c448544db@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009094557.1398920-1-lizhi.xu@windriver.com>
References: <0000000000005239cf060727d3f6@google.com> <20231009094557.1398920-1-lizhi.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043; i=brauner@kernel.org; h=from:subject:message-id; bh=ompOgLLvmlaZ/tZHb2NKNh+AWkXSSBfmdsowsHpjK1Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSqsIldct10g/m5hvdFjvWpMi8eV+r9PKmnnHh43gHrtwwe 8xucO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiEMrwT3H38iLBBev7S5eWTD3H81 f0zAnuJWk/urcZbgo6y1GXLszIsERhh8bvVO37ifPzrFIPFYQq2jOY3pWPO7zAtq9tT/5PfgA=
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

On Mon, 09 Oct 2023 17:45:57 +0800, Lizhi Xu wrote:
> When sbi->flag is JFS_NOINTEGRITY in lmLogOpen(), log->bdev_handle can't
> be inited, so it value will be NULL.
> Therefore, add the "log ->no_integrity=1" judgment in lbmStartIO() to avoid such
> problems.
> 
> 

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

[1/1] jfs: fix log->bdev_handle null ptr deref in lbmStartIO
      https://git.kernel.org/vfs/vfs/c/dc869ef84f26
