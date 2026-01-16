Return-Path: <linux-fsdevel+bounces-74074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99504D2EB3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7B4930ECA65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280CB34E743;
	Fri, 16 Jan 2026 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSg6xRnW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401BF1B4156
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555305; cv=none; b=mH4Hhk6LlXzNtDO/j01QM3MLBgheka3B62rcn65nm0AWhsu18i3OS4X6jFLuTBERiAdfZWSFK6vt+QI3tFsGWQ/57X6RfGLEgkHplvLWuDgVtuhhWteCquROv+yQl3BO0J85+9ZHcUSLYPaGIlORvs/cETsgy9i4Nzfx9OxCtsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555305; c=relaxed/simple;
	bh=5cr8bJh3nZ+2uZ+AsWQpetOvAIGygSdWsyMX5tWBN4M=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=SgxUAJqDw4BAwXwFHW9E5jQtnsKdeoQceOV0e6GXlMK2qtf5e0uSQ3ShAsGXG3PiZJ0Kal1u5ZC06QA8nBkqHVS9e9hddaAwxVOuLZrgnm0XljtvNRuyoDHLIKqOC3/fyrysJgze/+L6b2RlZ/F4shP4Wfm+84+SCb7M+3dhtMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CSg6xRnW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768555303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cr8bJh3nZ+2uZ+AsWQpetOvAIGygSdWsyMX5tWBN4M=;
	b=CSg6xRnWhtRSKgo9fQqrJhmQBO+dhza0stKdpR8jeqvuu2vCVnePT5fa+yy/EVgf/zlWrh
	+iJxAnjGozbugtXg5WV30uyn7vXxtTH1SDhwCsxYl+5BgprqPlke0U6+JLA1U1Tq1Lb47P
	DXkRDZ+PboLqTm9/ZLlsqKtOFPmQqwM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-Pb7NKcFsO6KAfXS0xgqx1w-1; Fri,
 16 Jan 2026 04:21:40 -0500
X-MC-Unique: Pb7NKcFsO6KAfXS0xgqx1w-1
X-Mimecast-MFC-AGG-ID: Pb7NKcFsO6KAfXS0xgqx1w_1768555299
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90B1A18005AE;
	Fri, 16 Jan 2026 09:21:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10CFF30002D6;
	Fri, 16 Jan 2026 09:21:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <d3e04144-0a92-4074-80db-64b6d4d77e85@linux.dev>
References: <d3e04144-0a92-4074-80db-64b6d4d77e85@linux.dev> <CAH2r5mtgC_s2J9g0smr5NDxSp1TO7d+dtZ7=afnuw9hMxQ4TYQ@mail.gmail.com> <20251222223006.1075635-1-dhowells@redhat.com> <sijmvmcozfmtp3rkamjbgr6xk7ola2wlxc2wvs4t4lcanjsaza@w4bcxcxkmyfc> <320463.1768546738@warthog.procyon.org.uk>
To: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>,
    Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, Enzo Matsumiya <ematsumiya@suse.de>,
    Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    henrique.carvalho@suse.com, ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: Re: [PATCH 00/37] cifs: Scripted header file cleanup and SMB1 split
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <653806.1768555294.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Jan 2026 09:21:34 +0000
Message-ID: <653807.1768555294@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Okay, I've rebased my patchset on -rc5, fixed up the bits that changed and
stacked Chen's patches on top:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/=
?h=3Dcifs-cleanup

Note that Chen's SMB2 error-map patches don't actually intersect with my S=
MB1
extraction patches.

David


