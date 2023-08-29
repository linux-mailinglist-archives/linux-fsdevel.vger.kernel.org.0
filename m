Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C2378C88C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 17:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbjH2PZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 11:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237242AbjH2PYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:24:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A7F1BB
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 08:24:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E266C624EB
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 15:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5578C433C7;
        Tue, 29 Aug 2023 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693322679;
        bh=0J79MYwesloO87sHfsfNb5UbrDUMiHStKUKZT2Ru3lQ=;
        h=From:Subject:Date:To:Cc:From;
        b=Y7ULLt89pFjGe5JxsXlkeZuxtv84J/BSU03pnGbYw0XJuEWff5UYJFQPobVDvMdWm
         djR4sZ6warxJIiNAtrKmSNSV87Rxfmc7mGQEutIwDAnH0YlSDCWxUE9RbBSZnE7ZA8
         2IrsDm22cjbHS9UZcq2crt7VbEEP5FcI8cJAttHXcbMLc0imD9JXwUrnf6CQKXePv5
         4TgJvgSLy5aVrmfGjfSgqtbD6by2Rk+3yGqltNCSl1W1r5um5rZfz7uDqUbt5bodr7
         7JbtmPROmA6ctJpluHTAdYK9g9BrPQ43jzQIzPmLGM6KQ3c5XsQYkNB0x3/DngMmlw
         NFy6CzwdWBz1w==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] mtd: switch to keying by dev_t
Date:   Tue, 29 Aug 2023 17:23:55 +0200
Message-Id: <20230829-vfs-super-mtd-v1-0-fecb572e5df3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIsN7mQC/x3MQQrCQAxA0auUrI2kI4h6FXExmWZsFo4lsUUov
 buxy794fwUXU3G4dSuYLOr6bhH9oYMy5vYU1CEaEqUTXdIVl+ro8ySGr8+APfOZUuZaiCDMZFL
 1u//uj2jOLsiWWxn/l8DHHcO2/QDwnRz4ewAAAA==
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=openpgp-sha256; l=763; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0J79MYwesloO87sHfsfNb5UbrDUMiHStKUKZT2Ru3lQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS8493Kc/38g5BM3gmb9L9tXbD9Rt4by4tWk68JJs24eEdB
 fefh5o5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJzPRg+O/OvmtOe6/45a73IpeKQ1
 Jn5Jo66G7eHm6v1C521pfPTpaR4eBM32Nbfk7bzJL5KefyL5nFRk9dOZZ6cFe/Kqi+PPnuXSYA
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

Hey,

For this cycle Jan, Christoph, and myself switched the generic super
code to key superblocks for block devices by device number (sb->s_dev)
instead of block device pointers (sb->s_bdev).

Not just does this allow us to defer opening block devices after we
allocated a superblock it also allows us to move closing block devices
to a later point to avoid various deadlocks.

Similar to the generic code for block devices we need to switch mtd
devices to rely on sb->s_dev instead of sb->s_mtd to avoid potential
use-after-free issues.

I plan on taking this upstream as a fix during the merge window.

Thanks!
Christian

---



---
base-commit: dc3216b1416056b04712e53431f6e9aefdc83177
change-id: 20230829-vfs-super-mtd-1bb602abfc00

