Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0AE27EEA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 18:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgI3QMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 12:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgI3QMb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:12:31 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601482350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VRC4C4b2jNcQOEWL2pH6VjUsE4SE12G1nNAW+RTvV2w=;
        b=ZPLrnvNoN4IeNHiCz508cn3/dn18jHIrNdPowXd9wzOyld+7Llj3tABIiBF26QdMKc2exh
        +SqiFDfYK3dSSao4qnsrBB6LwdsTHuecPMrbrxlHQVZVmOgBF8KkUqljYtERtj/EyzquSo
        fUxlZQ1elKmb9Jj+QEu6pOFpbjgkJ2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-4885p7OJNTmQMRSambbOFQ-1; Wed, 30 Sep 2020 12:12:28 -0400
X-MC-Unique: 4885p7OJNTmQMRSambbOFQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5DCB80F058;
        Wed, 30 Sep 2020 16:12:26 +0000 (UTC)
Received: from x2.localnet (ovpn-117-41.rdu2.redhat.com [10.10.117.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 742D865F5E;
        Wed, 30 Sep 2020 16:12:21 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Eric Paris <eparis@redhat.com>
Subject: [PATCH 0/3] fanotify: Allow user space to pass back additional   audit info
Date:   Wed, 30 Sep 2020 12:12:19 -0400
Message-ID: <2042449.irdbgypaU6@x2>
Organization: Red Hat
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

This patch defines 2 bit maps within the response variable returned from
user space on a permission event. The first field is 3 bits for the 
context type. The context type will describe what the meaning is of the
second bit field. The audit system will separate the pieces and log them
individually.

The audit function was updated to log the additional information in the
AUDIT_FANOTIFY record. The following is an example of the new record
format:

type=FANOTIFY msg=audit(1600385147.372:590): resp=2 ctx_type=1 fan_ctx=17


Steve Grubb (3):
  fanotify: Ensure consistent variable type for response
  fanotify: define bit map fields to hold response decision context
  fanotify: Allow audit to use the full permission event response

 fs/notify/fanotify/fanotify.c      |  5 ++---
 fs/notify/fanotify/fanotify.h      |  2 +-
 fs/notify/fanotify/fanotify_user.c | 11 +++--------
 include/linux/fanotify.h           |  5 +++++
 include/uapi/linux/fanotify.h      | 31 ++++++++++++++++++++++++++++++
 kernel/auditsc.c                   |  7 +++++--
 6 files changed, 47 insertions(+), 14 deletions(-)

-- 
2.26.2




