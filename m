Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEF41EC8FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 07:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgFCFxC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 01:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgFCFwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 01:52:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C449AC05BD43;
        Tue,  2 Jun 2020 22:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VTC5z9WT+GGVGPYd/YpFD1cmXsGsFb5+ORKTNAOuro8=; b=o1mSU51CZ8EA5+r7DZyaRGWlZE
        jMupoQn720fhh6NupmpEMc8l/DcA23ZRWOV5LW3ZW1ZwCPuuXiUc/TY9L9wbpcHIvCNL7CBXaMIDQ
        7DH1shYafh37ZtG0OTN/VcxG4PPUVDLkuOwYj0zJn5ju97VncPMDkMedmW/Fet64lKgHX3uejyR0U
        Xb81DVpqW5NX5Veq4HcsMUnZpQEzcBmC3NgE/cI/0E7WEc4D3yk6G4lWLGB9xOWiJzCz6YqsUQu+B
        Cs/vtNoa495GDnmyfad3wBqAkUvTtNjBUR/uMjhJkv9sPfPuZfKU17CMdtRdI+k3bpHg8vTaRUFxb
        Us44Nk8w==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgMKW-0003op-0j; Wed, 03 Jun 2020 05:52:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        build test robot <lkp@intel.com>
Subject: [PATCH 3/4] random: fix an incorrect __user annotation on proc_do_entropy
Date:   Wed,  3 Jun 2020 07:52:36 +0200
Message-Id: <20200603055237.677416-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603055237.677416-1-hch@lst.de>
References: <20200603055237.677416-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No user pointers for sysctls anymore.

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Reported-by: build test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 1e0db78b83baa..cf8a43f5eb2a0 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2087,7 +2087,7 @@ static int proc_do_uuid(struct ctl_table *table, int write,
  * Return entropy available scaled to integral bits
  */
 static int proc_do_entropy(struct ctl_table *table, int write,
-			   void __user *buffer, size_t *lenp, loff_t *ppos)
+			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table fake_table;
 	int entropy_count;
-- 
2.26.2

