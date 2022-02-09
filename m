Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5DF4AFF72
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 22:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiBIVvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 16:51:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiBIVvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:51:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8F7FC0F8699
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 13:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644443471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cf340JweVJoiHiod04EEzHBmoPbI4MxHx4i63YpUZFY=;
        b=IAR65u/bvVugljkAyyitB+clblu8xr45pNpRbUVXIJsMqCewGfLH0n0cwKaxm1WSrbOAGO
        JuCf99EPQcI3zWUHWEFl3Xy/xZEn5/K8oJE/t/smyfm8kV93xMZck8PNbXqY9hFLuVNtOT
        T6D2k1oRk01R8HrSrjx6Hw6kpefi2do=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-CpgCBT5vNK2JIAd4BOXBlA-1; Wed, 09 Feb 2022 16:51:07 -0500
X-MC-Unique: CpgCBT5vNK2JIAd4BOXBlA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28E00100C665;
        Wed,  9 Feb 2022 21:51:06 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.48.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 891964CEC7;
        Wed,  9 Feb 2022 21:50:07 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Arnd Bergmann <arnd@kernel.org>, stable@vger.kernel.org,
        Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH v1] audit: fix illegal pointer dereference for openat2
Date:   Wed,  9 Feb 2022 16:50:04 -0500
Message-Id: <a112a586b0a7e6a1a2364a284fb50cf8fcbf7351.1644442795.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The user pointer was being illegally dereferenced directly to get the
open_how flags data in audit_match_perm.  Use the previously saved flags
data elsewhere in the context instead.

Coverage is provided by the audit-testsuite syscalls_file test case.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/c96031b4-b76d-d82c-e232-1cccbbf71946@suse.com
Fixes: 1c30e3af8a79 ("audit: add support for the openat2 syscall")
Reported-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index fce5d43a933f..81ab510a7be4 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -185,7 +185,7 @@ static int audit_match_perm(struct audit_context *ctx, int mask)
 	case AUDITSC_EXECVE:
 		return mask & AUDIT_PERM_EXEC;
 	case AUDITSC_OPENAT2:
-		return mask & ACC_MODE((u32)((struct open_how *)ctx->argv[2])->flags);
+		return mask & ACC_MODE((u32)(ctx->openat2.flags));
 	default:
 		return 0;
 	}
-- 
2.27.0

