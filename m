Return-Path: <linux-fsdevel+bounces-13220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFE686D621
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 22:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA8A1F2642A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 21:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5376D534;
	Thu, 29 Feb 2024 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDJMAJmX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F5616FF5C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241921; cv=none; b=F+rGtfvt3ELEBWMZNIRc9eqzfo6BLyKSnivSg3R8L7tfI6XS+hXgS494IVTgAXAPrK470hsHXoYV24awh4Ejh7HPXIXz+OnzgVeOe2fdP3PJAkbTCWPKbOSSzXb3VPzK4gmFRQR8XcthBxAYrK85CPsUUIjq5IHVpWu07Z1XS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241921; c=relaxed/simple;
	bh=SFyQlewP4ftbmGqknuUYzFkLWVMDFsCIdPs9JN7A2rk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hQ18eTleAyBnUDqHWEX1airgk8B4mAePHA1KG0x6irJRPFS2ezmEcTqd7euS8Os3W/F6Savf21e0yhtL2IO5TPUhv8ZJ9/pKviS1eEVslCy/7MjSXC4Ws5Kp/SB1I3+rtRApkZxjfNMPz+6644VrXwAkUVSJrVVYsP9oRBDrDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDJMAJmX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709241918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=c900KPGjnu3D/iFJTCJ5ahUYDipicYnnjvzpvJk+zps=;
	b=UDJMAJmX5gSG3A403vv+BuQNpyYzJHL2BlqJ/JZyEEqOjT9+Obe6+bIw+b+9VInQqC8fs7
	v4we5V/onFRb7oQwit2Bbn6b7Awip5+vfYdLLCjF1+co8U+qTVMYMyKMXVjn5GOTJg9x4a
	qoMpw0i7wZn2RnWO3xvbTSvfXdm1ZtU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-EBDQQc53M-m_oYY3F6H75w-1; Thu, 29 Feb 2024 16:25:13 -0500
X-MC-Unique: EBDQQc53M-m_oYY3F6H75w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D64E881C81;
	Thu, 29 Feb 2024 21:25:13 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A2F1A112132A;
	Thu, 29 Feb 2024 21:25:12 +0000 (UTC)
Date: Thu, 29 Feb 2024 22:25:10 +0100
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.40-rc2
Message-ID: <20240229212510.ltajnsygpmxclz7i@ws.net.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3


The util-linux release v2.40-rc2 is available at
                                                      
  http://www.kernel.org/pub/linux/utils/util-linux/v2.40/
                                                      
Feedback and bug reports, as always, are welcomed.    
                                                      
  Karel       

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


