Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D402C78AEC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjH1L1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 07:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjH1L0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:26:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B364792
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 04:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 515BD6450B
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 11:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B0AC433C9;
        Mon, 28 Aug 2023 11:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693222011;
        bh=7Z5iH25Vzb/YHQ3m8Ay5BvVLL/t5rN/arzAUFhZovPM=;
        h=From:Subject:Date:To:Cc:From;
        b=Xca1tVRoEl/g4Pn9NYJHyBmuySZLAggb6yN5Y6Uanb6hdYs1zw5RepKtGHWum4bLz
         Xtw4dOHtffOjQ0elaZdH7U1TJJi6naD7hF6PbtDOKNxwdylfYYV/TLv99X31pWzW13
         th7H3YFznPfvxGQ1wX8fOqoN52BqENV0iB/ACZL2RYTpweXMQyuUQKTs9U7Hgc5NNN
         mNu7JukbS4Y+ii3jjO12obzTwN4L26fTkVJeA17uusORrtV1lF6khbUgyM0x+o8E+Q
         AsTNzdL9U5+1bnpu6Fi6bb3DL5Ysix0SDapbcohqTtrA3UUcCUI31m0lLyCiGNocdz
         nVsjIaBUwMD3g==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] Small follow-up fixes for this cycle
Date:   Mon, 28 Aug 2023 13:26:22 +0200
Message-Id: <20230828-vfs-super-fixes-v1-0-b37a4a04a88f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF6E7GQC/x2MQQqDQAwAvyI5m9ZdLYpfkR52bVYDskqCUhD/3
 tTjMMycoCRMCn1xgtDByms2cGUB4xzyRMgfY/CVr6vOd3gkRd03Ekz8JUXXtDG9XGpjU4NVm9A
 tLBrexjEoYZSQx/n/WYUnzhiW5Wmnx32C6/oBS2LNLogAAAA=
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=openpgp-sha256; l=539; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7Z5iH25Vzb/YHQ3m8Ay5BvVLL/t5rN/arzAUFhZovPM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS8aamy55f4tsy89/6OV+rpz7tvKvpNV/ptnx2zm1nmkFdu
 wiu9jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkEuDIyfK+2+rI1sXDlNqmGK9NrZC
 bkurAydC6SfH6rtitkG2/KEUaG+8Wz+DVY/TSCVi6bkW9xiSlcXkTX+g/vtLa9mdsCtmpyAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Jan & Christoph,

Two small follow-up fixes for two brainos.
I plan on getting this merged tomorrow if there aren't any objections.

Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (2):
      super: move lockdep assert
      super: ensure valid info

 fs/super.c | 51 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 20 deletions(-)
---
base-commit: cd4284cfd3e11c7a49e4808f76f53284d47d04dd
change-id: 20230828-vfs-super-fixes-147bf51f7b43

