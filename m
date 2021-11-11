Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8E944DC22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 20:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhKKT03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 14:26:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60096 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhKKT02 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 14:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636658618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YIM//77eVq+WiOzKYxB2jBwFGnXPPcmuq+7JMettZwQ=;
        b=EG82jAyqWN0LS6sBGuc2mToWvgmRhGm3dCfJodkk/AFP27NHjdQnLNUmAarKqniqQOHxjN
        UdJwtq/tWWChlRhQ9EKAZCZQODLr+W0HyHv1Dp/DGOfr95TaXqJoUuC+E+JfATGld/S8rk
        pXzEL2Ds034VJ52Dof+LM2JxWF/VhZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-5ZGfFq2KPbKHgHgJQsIkOQ-1; Thu, 11 Nov 2021 14:23:35 -0500
X-MC-Unique: 5ZGfFq2KPbKHgHgJQsIkOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A67F81C863;
        Thu, 11 Nov 2021 19:23:34 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9058679582;
        Thu, 11 Nov 2021 19:22:44 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v1] proc/vmcore: don't fake reading zeroes on surprise vmcore_cb unregistration
Date:   Thu, 11 Nov 2021 20:22:43 +0100
Message-Id: <20211111192243.22002-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In commit cc5f2704c934 ("proc/vmcore: convert oldmem_pfn_is_ram callback
to more generic vmcore callbacks"), we added detection of surprise
vmcore_cb unregistration after the vmcore was already opened. Once
detected, we warn the user and simulate reading zeroes from that point on
when accessing the vmcore.

The basic reason was that unexpected unregistration, for example, by
manually unbinding a driver from a device after opening the
vmcore, is not supported and could result in reading oldmem the
vmcore_cb would have actually prohibited while registered. However,
something like that can similarly be trigger by a user that's really
looking for trouble simply by unbinding the relevant driver before opening
the vmcore -- or by disallowing loading the driver in the first place.
So it's actually of limited help.

Currently, unregistration can only be triggered via virtio-mem when
manually unbinding the driver from the device inside the VM; there is no
way to trigger it from the hypervisor, as hypervisors don't allow for
unplugging virtio-mem devices -- ripping out system RAM from a VM without
coordination with the guest is usually not a good idea.

The important part is that unbinding the driver and unregistering the
vmcore_cb while concurrently reading the vmcore won't crash the system,
and that is handled by the rwsem.

To make the mechanism more future proof, let's remove the "read zero"
part, but leave the warning in place. For example, we could have a future
driver (like virtio-balloon) that will contact the hypervisor to figure out
if we already populated a page for a given PFN. Hotunplugging such a device
and consequently unregistering the vmcore_cb could be triggered from the
hypervisor without harming the system even while kdump is running. In that
case, we don't want to silently end up with a vmcore that contains wrong
data, because the user inside the VM might be unaware of the hypervisor
action and might easily miss the warning in the log.

Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 30a3b66f475a..948691cf4a1a 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -65,8 +65,6 @@ static size_t vmcoredd_orig_sz;
 static DECLARE_RWSEM(vmcore_cb_rwsem);
 /* List of registered vmcore callbacks. */
 static LIST_HEAD(vmcore_cb_list);
-/* Whether we had a surprise unregistration of a callback. */
-static bool vmcore_cb_unstable;
 /* Whether the vmcore has been opened once. */
 static bool vmcore_opened;
 
@@ -94,10 +92,8 @@ void unregister_vmcore_cb(struct vmcore_cb *cb)
 	 * very unusual (e.g., forced driver removal), but we cannot stop
 	 * unregistering.
 	 */
-	if (vmcore_opened) {
+	if (vmcore_opened)
 		pr_warn_once("Unexpected vmcore callback unregistration\n");
-		vmcore_cb_unstable = true;
-	}
 	up_write(&vmcore_cb_rwsem);
 }
 EXPORT_SYMBOL_GPL(unregister_vmcore_cb);
@@ -108,8 +104,6 @@ static bool pfn_is_ram(unsigned long pfn)
 	bool ret = true;
 
 	lockdep_assert_held_read(&vmcore_cb_rwsem);
-	if (unlikely(vmcore_cb_unstable))
-		return false;
 
 	list_for_each_entry(cb, &vmcore_cb_list, next) {
 		if (unlikely(!cb->pfn_is_ram))
@@ -577,7 +571,7 @@ static int vmcore_remap_oldmem_pfn(struct vm_area_struct *vma,
 	 * looping over all pages without a reason.
 	 */
 	down_read(&vmcore_cb_rwsem);
-	if (!list_empty(&vmcore_cb_list) || vmcore_cb_unstable)
+	if (!list_empty(&vmcore_cb_list))
 		ret = remap_oldmem_pfn_checked(vma, from, pfn, size, prot);
 	else
 		ret = remap_oldmem_pfn_range(vma, from, pfn, size, prot);

base-commit: debe436e77c72fcee804fb867f275e6d31aa999c
-- 
2.31.1

