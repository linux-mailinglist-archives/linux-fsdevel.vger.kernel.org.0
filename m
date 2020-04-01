Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6847B19AECD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 17:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732918AbgDAPeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 11:34:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37839 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732789AbgDAPeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:34:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so587890wrm.4;
        Wed, 01 Apr 2020 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2xmqhIkgms3NDdu1qlsVKf+BkC4V+OOS1HRZtVEAu4=;
        b=dXfEz2tqSq0A0uKS8WMMW3fcexD5Eam5TUcjz0Wa4rgsfIwZqgRp3/POPt7VOsMRoV
         y6RE57GEWJkU5Y08tV4U0WTaKM6hGIJhvF8fv9n9GHZMSBojXiXiMPxasEQJ8zGPe3Nb
         +tQ8mPIIYrGiDwYv0hgswsMZ1niRU1p3XVMZ6gnsxz1K0Vux2/lRKQWNlGel1e7V2ASn
         atlYAjBhIkOtsdMzhAFmD0zbuk0jw8PV+XGuPwgoCKm55Lxg1g80sHWuPAygpPrY7MQQ
         A9jpIDPB9/+q8WWNCB28P2Icb3nHTIwTWJDA2X4iUJDxOemtre54/wcYPVYj6LNscNsG
         Xiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2xmqhIkgms3NDdu1qlsVKf+BkC4V+OOS1HRZtVEAu4=;
        b=YvVGMGFGmuEiPL0YoOeKbRfbp2kubodVCCDnsQmjXQROPUEyV9uuRsUExndNl/xZvA
         KQ2cSL+7MuswN3NteYUXcwmbHPwyczDRjXetHnqe36yaF5MQI3i1xCr6I8bDbVxxi6cG
         zRNp6zcyt6raIoMW1v+h1qIuzYNxbcYhSqyZ+2qNWaxRmIHw88AiKaf9wdLpPXZMwWiP
         /pbLrmJJChpLhF7VomcXXHoQF6wmwxEepZxRLfslX1zc4n7Z86gG5G/p/P4FncKIxOUl
         vwkraVaH9ToJ8kaSsz36/zaDOJYhTM789OALw9h4JwtREdVNq3pt2DhIbKuRlbFUz2dz
         IRpw==
X-Gm-Message-State: ANhLgQ0BxjnxXKedlHBFugzF4OPIfnBsAdQM8FCyj3s76ZZmj/MS4ieb
        4gCGajIm4vqDFMydyCgzAKyrZfHs93cp
X-Google-Smtp-Source: ADFU+vuoH/j7UWYyGvcYZzuuMhyJjjfDWZOAJY2ULBtVPmlcQjeVjkbPb7b6pQfmfMvPOyTvWKbzGA==
X-Received: by 2002:adf:9022:: with SMTP id h31mr26058270wrh.223.1585755250075;
        Wed, 01 Apr 2020 08:34:10 -0700 (PDT)
Received: from earth.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id d7sm3275741wrr.77.2020.04.01.08.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 08:34:09 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEM DIRECT ACCESS (DAX)),
        linux-nvdimm@lists.01.org (open list:FILESYSTEM DIRECT ACCESS (DAX))
Subject: [PATCH v2] dax: Add missing annotation for wait_entry_unlocked()
Date:   Wed,  1 Apr 2020 16:33:59 +0100
Message-Id: <20200401153400.23610-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sparse reports a warning at wait_entry_unlocked()

warning: context imbalance in wait_entry_unlocked() - unexpected unlock

The root cause is the missing annotation at wait_entry_unlocked()
Add the missing __releases(xas->xa->xa_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/dax.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dax.c b/fs/dax.c
index 35da144375a0..ee0468af4d81 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -244,6 +244,7 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
  * After we call xas_unlock_irq(), we cannot touch xas->xa.
  */
 static void wait_entry_unlocked(struct xa_state *xas, void *entry)
+	__releases(xas->xa->xa_lock)
 {
 	struct wait_exceptional_entry_queue ewait;
 	wait_queue_head_t *wq;
-- 
Change since v2
- gives more accurate lock variable name
2.25.1

