Return-Path: <linux-fsdevel+bounces-27160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2DD95F13C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E6D1F22EBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED561714C1;
	Mon, 26 Aug 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ug025Rhr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EE616F84A
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674959; cv=none; b=s2pj4hG9iieNPlwaFONZN+GLVrfYGZHwS9aCPvqi7KIHksbfmwPR/URxlwYpVDh+PwNuBxdAn67w8O6jN7cxqH8D53XN/yj6e1nu8fMhIqDlcJN/eVcl1qrUxGWshSTwcC4rSuwh8Gut3FrGL0kZcYdo0SIyZJW+76Q0cDccFs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674959; c=relaxed/simple;
	bh=m5wtQla5FgoWz7ZxfK1ger/KDhcx7TO+oRRgN1ZhGeg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P+g7QBQcDIzyseXtft7zoDjNlwcMCrmciBx8cEdX+nvfKpd9aXv0mKRngawSmb1Fl9yhE7jdJUlutOUso9R0WU006q1HmiDawL8G2YQGCaJlztoyXoflIntFAGeupIvxhEwYs9i9QHilQiyaL5gWwJEyKiBW87+3y0Wvhy7bHL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ug025Rhr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724674957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=LUXUZJ2+JyyNU9O9Z+6HVFbmCd3VdbShk2keZH+bP6s=;
	b=Ug025RhrWIktmHQ7p6GQNu/L8h1N0TealCvIgzdgNgAp0gpIsLVGky2dVYJJwuWZAnO1Hz
	LGh4MjSWST8hQPzvJVHwH10smKVk3hmYQlmc++hCPYx5fq/12zLlneLKbIGOjJ1iHU3SDJ
	iiLHdxaOTbQv+IEO6qojJqUMHzamwV4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-VOLqy6ElM16LcHu0OpnxYA-1; Mon,
 26 Aug 2024 08:22:30 -0400
X-MC-Unique: VOLqy6ElM16LcHu0OpnxYA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67C431954B0E;
	Mon, 26 Aug 2024 12:22:29 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.8])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84BC319560A3;
	Mon, 26 Aug 2024 12:22:27 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Recommended version handshake for FUSE clients
Date: Mon, 26 Aug 2024 14:22:24 +0200
Message-ID: <87seurv5hb.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

I cannot use libfuse, so I'm writing my own mini-wrapper directly on top
of the kernel interface.  For the major version handshake, I understand
that I need to reply with version 7 if a later major version is
required.  But what to do about the minor version?

Should I use the minimum version that is expected to work (because there
have not been any struct layout changes since)?  I think this could end
up problematic if some struct sizes have grown between the known-good
minimum version and the <linux/fuse.h> version, something that a future
<linux/fuse.h> version might bring.

Or should I just send back FUSE_KERNEL_MINOR_VERSION from the system
version of <linux/fuse.h>?  I think this assumes that merely increasing
the minor version does not result in behavioral changes (such as
additonal FUSE events being generated that the current code knows
nothing about).

The code only has to run on the system that it was compiled on and
possibly newer kernels.  Going back to older kernels is not needed.  But
I also expect people using a wide range of kernel header versions to
compile this code.

Or perhaps I should bundle some older version of <linux/fuse.h> with my
sources?

Thanks,
Florian


