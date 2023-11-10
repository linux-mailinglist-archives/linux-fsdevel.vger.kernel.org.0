Return-Path: <linux-fsdevel+bounces-2732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F13407E7E02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 18:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97FEC1F20D48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 17:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7968208B0;
	Fri, 10 Nov 2023 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEAzRzqG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D430C1DDFA
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 17:06:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325D127B2D
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 09:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699635993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NIZFwo+4TtJxX+MehT6Ekh0B/R7ATGmbr24QUTPhoNE=;
	b=GEAzRzqGxDeaZF5piqU2tVTlITd9YVt8UKESzD9WI9GYByZg4LLCUFbR4oCWSE3eq2Npge
	ivRPWtmNOeGE0i77U/NaSkZecOXTZfQOsxyBqCGyP6hdDC2UbBSOjVMybRgswIStc8frkQ
	y/JDgFKFzUelKjRy73I83xxI49ckadM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696--b21MyKUN3a1cwZoFSNvbQ-1; Fri, 10 Nov 2023 12:06:28 -0500
X-MC-Unique: -b21MyKUN3a1cwZoFSNvbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8751C85A59D;
	Fri, 10 Nov 2023 17:06:28 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.16.238])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3B44D502C;
	Fri, 10 Nov 2023 17:06:28 +0000 (UTC)
From: Charles Mirabile <cmirabil@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Charles Mirabile <cmirabil@redhat.com>
Subject: [PATCH v1 0/1] fs: Consider capabilities relative to namespace for linkat permission check
Date: Fri, 10 Nov 2023 12:06:14 -0500
Message-Id: <20231110170615.2168372-1-cmirabil@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

This is a one line change that makes `linkat` aware of namespaces when
checking for capabilities.

As far as I can tell, the call to `capable` in this code dates back to
before the `ns_capable` function existed, so I don't think the author
specifically intended to prefer regular `capable` over `ns_capable`,
and no one has noticed or cared to change it yet... until now!

It is already hard enough to use `linkat` to link temporarily files
into the filesystem without the `/proc` workaround, and when moving
a program that was working fine on bare metal into a container,
I got hung up on this additional snag due to the lack of namespace
awareness in `linkat`.

Charles Mirabile (1):
  fs: Consider capabilities relative to namespace for linkat permission
    check

 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 89cdf9d556016a54ff6ddd62324aa5ec790c05cc
-- 
2.38.1


