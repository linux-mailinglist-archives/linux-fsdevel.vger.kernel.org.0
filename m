Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335EE7B053A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 15:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjI0NVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 09:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjI0NVn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:21:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592C110A
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 06:21:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5911C433C7;
        Wed, 27 Sep 2023 13:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695820902;
        bh=Ru+cimIVjqHnk+EQ3z3QOa50OLFzgxA4vtTxrGE551w=;
        h=From:Subject:Date:To:Cc:From;
        b=rjNESEtUyf/0zChn7uKgMNU0R2qdkieNbjARD8bWR3CsD0ySMPVEu8iqA391gjgSL
         R59UUSc+diZT1f9s0xh/Lx/siCjTuwV+1fv+/BhOOxUOBVtlETthH36rH7bVgNE1H2
         8syEFiXxFEsZSb02JvYCl5aYXEFYOnwY7IOPe7dFpuzwDEWLxw/LnIjm6e/6FULyv8
         eNs034RikXZYFVbbtYj2lHOZ6tHSzsLif7xbJuz7/QLqVdrhbAeOZS1TaPdXoghwPw
         eHci3x8czyLHfPirnVPpLV3YEdYDHbwRtSqGFlzloP78yq/cxJIjIzseRlc9cl9WUe
         16d/cDi1cgqfA==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/7] Implement freeze and thaw as holder operations
Date:   Wed, 27 Sep 2023 15:21:13 +0200
Message-Id: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEksFGUC/x3MMQ7CMAxG4atUnrEUggiCqyCGpP1NPRAqGypE1
 bs3MH7Dews5TOF06RYyzOr6rA37XUf9mOsdrEMzxRAP4RxPPIuzvycYiwFfMETSMUhKJSRq2WQ
 Q/fyX11tzyQ4ulms//kaP7C8YresGpWLLsXsAAAA=
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=731; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ru+cimIVjqHnk+EQ3z3QOa50OLFzgxA4vtTxrGE551w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSK6CSLijesSV3ZXbjCQdxHo2r6RAXRmPe2Z69P1Bbv07n8
 0dqyo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKq2xkZbvQ9nMK35Jyintfrb277NE
 KannCyhXr+jbS/Ge4rs8rvECNDu5zMxOpSxbNlbC/NVRMKzNblRjzrrXn2MbeR2bt1+VI2AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Christoph,
Hey Jan,

This implements block device freezing and thawing as holder operations.

Not just does this allow to simplify the current implementation by
removing a few locks and members in struct block_device and getting rid
of a few helpers in the superblock code, it also allows us to implement
block device freezing for multiple devices and not just the main block
device.

This will also allow us to fix block device freezing and thawing for
btrfs which is broken right now but that's just a nice side-effect.

Thanks!
Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>

---
base-commit: 0e945134b680040b8613e962f586d91b6d40292d
change-id: 20230927-vfs-super-freeze-eff650f66b06

