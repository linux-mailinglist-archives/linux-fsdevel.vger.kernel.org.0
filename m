Return-Path: <linux-fsdevel+bounces-44835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B302A6D060
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 18:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D65188A035
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 17:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BA5157465;
	Sun, 23 Mar 2025 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMtc2JCF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6255D847C
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Mar 2025 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742751969; cv=none; b=pU7ibWua/vblR+mOsVsq13bbax2wm8EoDSQxhEEf+jOa2YdcuFradK+zDgwTWpv2PEiGJXmt0CZKmvzL5FVvjyfa6WAajGE1EEEF1EWpU3fD7C/KxD7PlYtkp6MI+2+3BZtjULjFf6s4xxoiXQEGpiGolPNwGEC0FQXMI0VLLmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742751969; c=relaxed/simple;
	bh=N/VPBA27MvYnb/iL12DWHexKUQPeJckm1VqJ8DaMklY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyCqafaE5P1xxWgMXQtAT+iCmQclYqi7JyFArFMwnEhV80l2+K3VfignUAALs38ZmE2GEIu0NCxQLSonzUQKaMLQtrRyosHHUqS3O5sxuc6MO2M9t8FzVlQL7KKbiVURFwfY60kMLzRStYwUwpv19sQUXy1KPGoEII78xJicDQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMtc2JCF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742751964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q4DTaAqr3eY2ndpD7LT4GPYapZMK4/PNCxQI/f57kE8=;
	b=JMtc2JCFs3KORaELOKylAYe37l2hPqPqgmEDcCoQCeesTMbOUU9x+QQhAp9VA0+XRg1xG7
	UX0fxY6OiI+hV4nU2VZgfOKtHri2mt85R253aIDDmNLrGOm+ed2dXskUAkMGwn4L6grgHr
	vUKC+/7DZI3c25P2uM2mG4NDs8/AmlA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-HYuqlN3rNwewwt-vgqSwcQ-1; Sun,
 23 Mar 2025 13:45:56 -0400
X-MC-Unique: HYuqlN3rNwewwt-vgqSwcQ-1
X-Mimecast-MFC-AGG-ID: HYuqlN3rNwewwt-vgqSwcQ_1742751955
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 309B41801A1A;
	Sun, 23 Mar 2025 17:45:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7E1D830001A1;
	Sun, 23 Mar 2025 17:45:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 23 Mar 2025 18:45:22 +0100 (CET)
Date: Sun, 23 Mar 2025 18:45:18 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: selftests/pidfd: (Was: [PATCH] pidfs: cleanup the usage of
 do_notify_pidfd())
Message-ID: <20250323174518.GB834@redhat.com>
References: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
 <20250323171955.GA834@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323171955.GA834@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Christian,

I had to spend some (a lot;) time to understand why pidfd_info_test
(and more) fails with my patch under qemu on my machine ;) Until I
applied the patch below.

I think it is a bad idea to do the things like

	#ifndef __NR_clone3
	#define __NR_clone3 -1
	#endif

because this can hide a problem. My working laptop runs Fedora-23 which
doesn't have __NR_clone3/etc in /usr/include/. So "make" happily succeeds,
but everything fails and it is not clear why.

Oleg.
---

diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index 3d2663fe50ba..eeca8005723f 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -16,7 +16,7 @@
 #define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
 
 #ifndef __NR_clone3
-#define __NR_clone3 -1
+#define __NR_clone3 435
 #endif
 
 struct __clone_args {
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index cec22aa11cdf..55bcf81a2b9a 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -32,19 +32,19 @@
 #endif
 
 #ifndef __NR_pidfd_open
-#define __NR_pidfd_open -1
+#define __NR_pidfd_open 434
 #endif
 
 #ifndef __NR_pidfd_send_signal
-#define __NR_pidfd_send_signal -1
+#define __NR_pidfd_send_signal 424
 #endif
 
 #ifndef __NR_clone3
-#define __NR_clone3 -1
+#define __NR_clone3 435
 #endif
 
 #ifndef __NR_pidfd_getfd
-#define __NR_pidfd_getfd -1
+#define __NR_pidfd_getfd 438
 #endif
 
 #ifndef PIDFD_NONBLOCK


