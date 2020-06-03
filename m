Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCC51EC8F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 07:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgFCFwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 01:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgFCFwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 01:52:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55290C05BD1E;
        Tue,  2 Jun 2020 22:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9xSJyTCnmOFnoeTw5DYF1pLBCTjN1a9aWOgqqyu87SA=; b=fmJ7r4GApABmWyYi50Df2Mbsxk
        YdvT5dRIM9PPbaEED6f8lLSZSY58sKEKwjxq+SxUDrp4P5qG5V0TSPFxNzfx7f7EYdUlhKVQYWQnl
        u0vmRyVQuXMbG84dX43uK/32+eRCvjSSk2kGuQoALO3aHRxE6l+bOW+6v9NqB09QcOqIC0MwQBLr9
        CDkEfstsG4Gm5OC4Gu8VzpEVx60EGyyxHYeE3muDf6JYZQFZumn9wkKVA9cP6lvc63/3PcapccrLt
        INa1dn2cfNitFyq9IPKRm4Hrmu10EKbAK6HBZSksRGQad4Dg8aA0jeZaYuEILKNuh+Ca4K5QB6ar7
        7jWY/LDQ==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgMKQ-0003na-Iy; Wed, 03 Jun 2020 05:52:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        build test robot <lkp@intel.com>
Subject: [PATCH 1/4] net/sysctl: use cpumask_parse in flow_limit_cpu_sysctl
Date:   Wed,  3 Jun 2020 07:52:34 +0200
Message-Id: <20200603055237.677416-2-hch@lst.de>
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

cpumask_parse_user works on __user pointers, so this is wrong now.

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Reported-by: build test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/core/sysctl_net_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 0ddb13a6282b0..d14d049af52ae 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -126,7 +126,7 @@ static int flow_limit_cpu_sysctl(struct ctl_table *table, int write,
 		return -ENOMEM;
 
 	if (write) {
-		ret = cpumask_parse_user(buffer, *lenp, mask);
+		ret = cpumask_parse(buffer, mask);
 		if (ret)
 			goto done;
 
-- 
2.26.2

