Return-Path: <linux-fsdevel+bounces-62726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D635B9F573
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 14:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04EA17587F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 12:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E591EBA1E;
	Thu, 25 Sep 2025 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFR8Rycd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAD21DF75D
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804498; cv=none; b=Vm6ebZXlf6kyHGmWjgPAR4QDI+s2znBDHtMsvUacVXbFMmcGSbOUp8wYFUcz3qQMZpZlvZ7wg8NxeFwddo0FPBcOmWzZjcUm6bsRyIPQZAsoStw7J+WmfTHHElCjSRz+6hrdttn7ZnwrLtMa+v3S7s25kotKAEGDA5bUxlim0CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804498; c=relaxed/simple;
	bh=1p0/K1FNQh7/1IKJ74SFyThJwjp913FFaM8bYFIezGo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=gt+Bhj8fP1OSUspKLpaME3x48Il//lao2By/297gNtXE9W/ZX6DIlZBMxmBXKQ2AUSUBMpAhngC4WdRcIQVuRugXxZiNfMmiwPWm4HoxmhyY2OR24+qpZZBYmKKVj2LJAWB7wG3v9W865h6DG6O74l1V4VcqvW5eUrUl4fGmj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFR8Rycd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758804495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1p0/K1FNQh7/1IKJ74SFyThJwjp913FFaM8bYFIezGo=;
	b=SFR8RycdCfoZTAe+FFPQpetDFCWvGvXfcqJ3OWJYn8lhJw+4zlINRF9fDYX6erMrhAzq3E
	WOnCKsHcdBqiEI8eTgYMpxY7aMg4t9+6LzeyvW+j5tKvEKChZIBlDfKprWndVaLh6w7Vy3
	xzr331keIoCuAML8Hf6SDqQADRLXBx0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-ugnWQ7hkPyyC0_FT4WuaPg-1; Thu,
 25 Sep 2025 08:48:12 -0400
X-MC-Unique: ugnWQ7hkPyyC0_FT4WuaPg-1
X-Mimecast-MFC-AGG-ID: ugnWQ7hkPyyC0_FT4WuaPg_1758804489
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98B0C180034D;
	Thu, 25 Sep 2025 12:48:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.155])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0CC9119560AB;
	Thu, 25 Sep 2025 12:47:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <68d2fc06.a70a0220.4f78.000d.GAE@google.com>
References: <68d2fc06.a70a0220.4f78.000d.GAE@google.com>
To: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, asmadeus@codewreck.org, brauner@kernel.org,
    danielyangkang@gmail.com, eadavis@qq.com, ericvh@kernel.org,
    jack@suse.cz, jlayton@kernel.org, linux-afs@lists.infradead.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux_oss@crudebyte.com, lizhi.xu@windriver.com, lucho@ionkov.net,
    marc.dionne@auristor.com, netfs@lists.linux.dev, pc@manguebit.org,
    syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
    viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <935793.1758804475.1@warthog.procyon.org.uk>
Date: Thu, 25 Sep 2025 13:47:55 +0100
Message-ID: <935794.1758804475@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

#syz fix: netfs: Fix unbuffered write error handling


