Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2C72930CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 23:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgJSVwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 17:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727902AbgJSVwg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 17:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603144355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K0AR8c3WEBAX3LYMgEPEXyjVlvMHIffs2XAsuKM9jqk=;
        b=MLarhEIfmYvRQReu2c7ur1Gng8473gySjBq/UE51/fSTii/l2x4r3N20hFRfRGxffFOzSF
        rEgyZxvSq2BEDXQP9afP/XT7BNSKiglgEoikbRE8L+UW6O7uFWDhGvndOVrHWcZAreptnc
        fnthojAmW1MckdVTtkbParR8TaNwDik=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-Mqsc6H5QMe2QarfSTQRERQ-1; Mon, 19 Oct 2020 17:52:33 -0400
X-MC-Unique: Mqsc6H5QMe2QarfSTQRERQ-1
Received: by mail-oi1-f198.google.com with SMTP id i128so673573oib.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2020 14:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0AR8c3WEBAX3LYMgEPEXyjVlvMHIffs2XAsuKM9jqk=;
        b=dBPtHgcF3UwpxgW1IpeDEI9Pj+0Prq/hvhBRMgQ1+6T08bskOmKIQlzu4l5r6wbJUk
         rZT9gFotP2w/fDqeHvq7kOsbsottlzXRJH32lOPALSi0875uncC9rNVVcDzqktORS7se
         ejuxgZIYs+o7KVcVRVEt5g3WAcSZfyCnwB8s3/+KkrmJFUKttAB3cabygfnmjZ3PydjM
         1U9qDO8b/wcxjo0iziR5ERJ5vodcgZk+CNYVZln4Q+xwOou3cm+nF2XPb95PLFBdw9mg
         aptDtxmwISQj68sv7JpKsvff2JD+kgPQGVJ0yYAP+pYGdQBIXpvNKl/k71LxBRUQPs3/
         ZvMA==
X-Gm-Message-State: AOAM532uJXQROJPOcAD82siu2BlZ+slx+l29ogZ5ZBAfF7EvWi9Sir3a
        rU7pdoNzCmnbUjrh4hAaIZm9ajSwLD4TDfnWuEPOocDA42OxfWCaFJhuCt/i1F+5oarwVIZKGFX
        /k0KTjMMOYCAMdmujQAXw1r5oqg==
X-Received: by 2002:a05:6808:28c:: with SMTP id z12mr1010198oic.70.1603144352857;
        Mon, 19 Oct 2020 14:52:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs6E13hx8BH1gEjJKTnBbLjLAdsnM7i2gF7Jgk1fTLRs36wSELsmZwxOmR3918xk7MGh9APw==
X-Received: by 2002:a05:6808:28c:: with SMTP id z12mr1010187oic.70.1603144352654;
        Mon, 19 Oct 2020 14:52:32 -0700 (PDT)
Received: from respighi.redhat.com (c-24-9-17-161.hsd1.co.comcast.net. [24.9.17.161])
        by smtp.gmail.com with ESMTPSA id w75sm301559oia.20.2020.10.19.14.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:52:31 -0700 (PDT)
From:   Charles Haithcock <chaithco@redhat.com>
To:     adobriyan@gmail.com
Cc:     trivial@kernel.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org,
        Charles Haithcock <chaithco@redhat.com>
Subject: [PATCH net-next] mm, oom: keep oom_adj under or at upper limit when printing
Date:   Mon, 19 Oct 2020 15:52:29 -0600
Message-Id: <20201019215229.225386-1-chaithco@redhat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For oom_score_adj values in the range [942,999], the current
calculations will print 16 for oom_adj. This patch simply limits the
output so output is inline with docs.

Signed-off-by: Charles Haithcock <chaithco@redhat.com>
---
 fs/proc/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 617db4e0faa0..37e57b21dbe5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1048,6 +1048,8 @@ static ssize_t oom_adj_read(struct file *file, char __user *buf, size_t count,
 	else
 		oom_adj = (task->signal->oom_score_adj * -OOM_DISABLE) /
 			  OOM_SCORE_ADJ_MAX;
+	if (oom_adj > OOM_ADJUST_MAX)
+		oom_adj = OOM_ADJUST_MAX;
 	put_task_struct(task);
 	len = snprintf(buffer, sizeof(buffer), "%d\n", oom_adj);
 	return simple_read_from_buffer(buf, count, ppos, buffer, len);
-- 
2.25.1

