Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD45858DD08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 19:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244597AbiHIRXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 13:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242624AbiHIRXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A1B524BFE
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660065795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9sZeH8lKi9bZAh82P0JmF9qMY+wf2U70JuiC0qHkpAk=;
        b=SrfpTB6IHHqz+WMHz43UKb0vLND6274e7HMrFmeEw0KRbirS+pWGttPGPev3f/ClBX3LDf
        9iLtVVVBVOhXEe6OkyC3kn/Bc54y9E5W3iebjgeFxL2Ea4OQudqmhtZawVG8ZGiN+IH1oz
        AymZhxLXG6XwNBcSqTJw0Qu2DBzl2jg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-ZM8RAdwANDyd5mygrh_21w-1; Tue, 09 Aug 2022 13:23:12 -0400
X-MC-Unique: ZM8RAdwANDyd5mygrh_21w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C4B03C0F374;
        Tue,  9 Aug 2022 17:23:11 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 911F018EB5;
        Tue,  9 Aug 2022 17:23:09 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 0/4] fanotify: Allow user space to pass back additional audit info
Date:   Tue,  9 Aug 2022 13:22:51 -0400
Message-Id: <cover.1659996830.git.rgb@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

This patchset defines a new flag (FAN_INFO) and new extensions that
define additional information which are appended after the response
structure returned from user space on a permission event.  The appended
information is organized with headers containing a type and size that
can be delegated to interested subsystems.  One new information type is
defined for audit rule number.  

A newer kernel will work with an older userspace and an older kernel
will behave as expected and reject a newer userspace, leaving it up to
the newer userspace to test appropriately and adapt as necessary.

The audit function was updated to log the additional information in the
AUDIT_FANOTIFY record. The following is an example of the new record
format:

type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_info=3F

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

v4:
- scrap FAN_INVALID_RESPONSE_MASK in favour of original to catch invalid response == 0
- introduce FANOTIFY_RESPONSE_* macros
- uapi: remove union
- keep original struct fanotify_response, add fan_info infra starting with audit reason
- uapi add struct fanotify_response_info_header{type/pad/len} and struct fanotify_response_info_audit_rule{hdr/rule}
- rename fan_ctx= to fan_info=, FAN_EXTRA to FAN_INFO
- change event struct from type/buf to len/buf
- enable multiple info extensions in one message
- hex encode fan_info in __audit_fanotify()
- record type FANOTIFY extended to "type=FANOTIFY msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=3F"                                                                                                                     
Link: https://lore.kernel.org/r/cover.1659981772.git.rgb@redhat.com

Richard Guy Briggs (4):
  fanotify: Ensure consistent variable type for response
  fanotify: define struct members to hold response decision context
  fanotify,audit: Allow audit to use the full permission event response
  fanotify,audit: deliver fan_info as a hex-encoded string

 fs/notify/fanotify/fanotify.c      |  13 +++-
 fs/notify/fanotify/fanotify.h      |   4 +-
 fs/notify/fanotify/fanotify_user.c | 106 ++++++++++++++++++++++-------
 include/linux/audit.h              |   9 +--
 include/linux/fanotify.h           |   5 ++
 include/uapi/linux/fanotify.h      |  27 +++++++-
 kernel/auditsc.c                   |  45 +++++++++++-
 7 files changed, 174 insertions(+), 35 deletions(-)

-- 
2.27.0

