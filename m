Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E0B5F7142
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 00:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiJFWmk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 18:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiJFWmi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:42:38 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC7FF2528;
        Thu,  6 Oct 2022 15:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3DIFj9UhDQc8Es3b0mNPMgQ7Igff36zxWr0mRst60bM=; b=C19vW2Xhm85s+6iglDJp3BxxbG
        2sUU9/1Svm7CcfAta9Nt50fy7RpO0b5RTsFVOerQz1QzgqTtSSgEpE7I7xLwBDmoIh0pU+7gmXwek
        UHjdzvVxtY8seMZRShC6nxxTvi3fKE3x0IAMDgb9JME2dlGIZTEH/eKnmgo/jBaLoGkXRTx9APpej
        CqYoxq29/lnHPSltuK4oWHUhsqYeW/GpiWPdS/k9ehaIItbBSAgzXgsm1zrjpAabzSk/Sb2yZk1hC
        bzaYZU0dKVOPNqljlBUdaV20gEpRP/+Y0co7iuXNi0Q8S51/Xb1SSw+NbsPUZ7Hrg9Cupevm7A3ex
        JCKLnHdg==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1ogZZV-00C4HG-8z; Fri, 07 Oct 2022 00:42:30 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/8] Some pstore improvements
Date:   Thu,  6 Oct 2022 19:42:04 -0300
Message-Id: <20221006224212.569555-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi pstore maintainers, this is a small series with some improvements
overall. Most of them are minors, but the implicit conversion thing
is a bit more "relevant" in a sense it's more invasive and would fit
more as a "fix".

The code is based on v6.0, and it was tested with multiple compression
algorithms (zstd, deflate, lz4, lzo, 842) and two backends (ramoops and
efi_pstore) - I've used a QEMU UEFI guest and Steam Deck for this goal.

My plan is to also work some ramoops improvements (for example, related
to [0]); they're more complex so it's deferred for a second series,
specific for that.

Reviews and comments are greatly appreciated!
Thanks in advance,

Guilherme


[0] https://lore.kernel.org/lkml/a21201cf-1e5f-fed1-356d-42c83a66fa57@igalia.com/


Guilherme G. Piccoli (8):
  pstore: Improve error reporting in case of backend overlap
  pstore: Expose kmsg_bytes as a module parameter
  pstore: Inform unregistered backend names as well
  pstore: Alert on backend write error
  pstore: Fix long-term implicit conversions in the compression routines
  MAINTAINERS: Add a mailing-list for the pstore infrastructure
  efi: pstore: Follow convention for the efi-pstore backend name
  efi: pstore: Add module parameter for setting the record size

 MAINTAINERS                       |  1 +
 drivers/firmware/efi/efi-pstore.c | 17 +++++---
 fs/pstore/platform.c              | 64 ++++++++++++++++---------------
 3 files changed, 46 insertions(+), 36 deletions(-)

-- 
2.38.0

