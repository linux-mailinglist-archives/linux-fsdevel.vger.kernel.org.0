Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF2B5291ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 22:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbiEPUr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 16:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245317AbiEPUpC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 16:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EDBE4839B
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652732558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=X/hW8heDuAXy8YNMnWK8A1edgrFI+3cNEUxDQuZBP/o=;
        b=Xxi8lf+jum4NhNVwDJ7VxVyggX07XtV1CTH0b8AyUnALYWC6GXHdfmnXJJhOygJ55KnqJ/
        fXYL+LzuVo9bHOrR0mBAq+TdwJTrRiMUwvuAfi1u6amCoXUKxRN1ROloRtgj21hGjWrj/g
        tV2NQym5OYMu7oG0sAgqygPX5UG1Fn0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-0tAPI_2OPfONwKeE-BDOkg-1; Mon, 16 May 2022 16:22:36 -0400
X-MC-Unique: 0tAPI_2OPfONwKeE-BDOkg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26CC1811E75;
        Mon, 16 May 2022 20:22:36 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A783840CF8E2;
        Mon, 16 May 2022 20:22:34 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v3 0/3] fanotify: Allow user space to pass back additional audit info
Date:   Mon, 16 May 2022 16:22:21 -0400
Message-Id: <cover.1652730821.git.rgb@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The Fanotify API can be used for access control by requesting permission
event notification. The user space tooling that uses it may have a
complicated policy that inherently contains additional context for the
decision. If this information were available in the audit trail, policy
writers can close the loop on debugging policy. Also, if this additional
information were available, it would enable the creation of tools that
can suggest changes to the policy similar to how audit2allow can help
refine labeled security.

This patch defines 2 additional fields within the response structure
returned from user space on a permission event. The first field is 32
bits for the context type. The context type will describe what the
meaning is of the second field. The audit system will separate the
pieces and log them individually.

The audit function was updated to log the additional information in the
AUDIT_FANOTIFY record. The following is an example of the new record
format:

type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_ctx=17

changelog:
v1:
- first version by Steve Grubb <sgrubb@redhat.com>
Link: https://lore.kernel.org/r/2042449.irdbgypaU6@x2

v2:
- enhancements suggested by Jan Kara <jack@suse.cz>
- 1/3 change %d to %u in pr_debug
- 2/3 change response from __u32 to __u16
- mod struct fanotify_response and fanotify_perm_event add extra_info_type, extra_info_buf
- extra_info_buf size max FANOTIFY_MAX_RESPONSE_EXTRA_LEN, add struct fanotify_response_audit_rule
- extend debug statements
- remove unneeded macros
- [internal] change interface to finish_permission_event() and process_access_response()
- 3/3 update format of extra information
- [internal] change interface to audit_fanotify()
- change ctx_type= to fan_type=
Link: https://lore.kernel.org/r/cover.1651174324.git.rgb@redhat.com

v3:
- 1/3 switch {,__}audit_fanotify() from uint to u32
- 2/3 re-add fanotify_get_response switch case FAN_DENY: to avoid unnecessary churn
- add FAN_EXTRA flag to indicate more info and break with old kernel
- change response from u16 to u32 to avoid endian issues
- change extra_info_buf to union
- move low-cost fd check earlier
- change FAN_RESPONSE_INFO_AUDIT_NONE to FAN_RESPONSE_INFO_NONE
- switch to u32 for internal and __u32 for uapi
Link: https://lore.kernel.org/r/cover.1652724390.git.rgb@redhat.com

Richard Guy Briggs (3):
  fanotify: Ensure consistent variable type for response
  fanotify: define struct members to hold response decision context
  fanotify: Allow audit to use the full permission event response

 fs/notify/fanotify/fanotify.c      |  6 ++-
 fs/notify/fanotify/fanotify.h      |  4 +-
 fs/notify/fanotify/fanotify_user.c | 76 +++++++++++++++++++-----------
 include/linux/audit.h              |  9 ++--
 include/linux/fanotify.h           |  3 ++
 include/uapi/linux/fanotify.h      | 22 ++++++++-
 kernel/auditsc.c                   | 18 +++++--
 7 files changed, 100 insertions(+), 38 deletions(-)

-- 
2.27.0

