Return-Path: <linux-fsdevel+bounces-40256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 772D2A2146F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 23:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8607C7A33DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 22:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E037C1DF74F;
	Tue, 28 Jan 2025 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CsRKayCo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78FB194A6B
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 22:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738103664; cv=none; b=oQ0pTVhtxhoeUSWwxOvl6MASziuqSHhmyVDncM+VD6yK/wkFGqaWq33/1qCZyIFwgYU9wKeKdv96dGYj/knI5x7JakWDaLx7jvYvvAt/3tsfQoCny80s4BkKxK5etLzZbxu7WKLuE1IegBLicgdSgbYC86WxRyF6N7ebVO/BDfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738103664; c=relaxed/simple;
	bh=+y2ia/Wz3C+6c3SALHoNsKrjDCbNVh6oWLrp4hVM4hk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=QMBXmhVMTI0lSTfMyq7eZCrQqetGd2I/W+b6BSNVFAjCT7p94RlolwFes51h7ONABZwSY8a4hqZNRhfJmP6Ae+Sv9PhSMlNEx/1yTAIMadbJ9q/SaOhY+Em9rKu79YCBT1/hxh7KYIp44h19Br6LQTCSSXgmypWzN9alQLCmjxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CsRKayCo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738103662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+y2ia/Wz3C+6c3SALHoNsKrjDCbNVh6oWLrp4hVM4hk=;
	b=CsRKayCo0qNwr/mhtQTatlHUhhSaTsAtxE9qEFpUYoJ+GMpqchPXDWW3i3tvzNz8EVFmr5
	FxGJ/61AlpKFnYRwFHTTgpHbPjfqgKvgdiwpJPdzOANJAcOuDV6HMC7Ro5InfY5RLFSvS+
	0tzILLKzzT+Q0IXPQd65XN2WZ9gXQSc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-lFyIuru7M8KEQyl-ZRdRyA-1; Tue,
 28 Jan 2025 17:34:18 -0500
X-MC-Unique: lFyIuru7M8KEQyl-ZRdRyA-1
X-Mimecast-MFC-AGG-ID: lFyIuru7M8KEQyl-ZRdRyA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34A2A195608A;
	Tue, 28 Jan 2025 22:34:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.56])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6FB6519560A3;
	Tue, 28 Jan 2025 22:34:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <d81a04646f76e0b65cd1e075ab3d410c4b9c3876.camel@ibm.com>
References: <d81a04646f76e0b65cd1e075ab3d410c4b9c3876.camel@ibm.com> <3469649.1738083455@warthog.procyon.org.uk> <3406497.1738080815@warthog.procyon.org.uk> <c79589542404f2b73bcdbdc03d65aed0df17d799.camel@ibm.com> <20250117035044.23309-1-slava@dubeyko.com> <988267.1737365634@warthog.procyon.org.uk> <CAO8a2SgkzNQN_S=nKO5QXLG=yQ=x-AaKpFvDoCKz3B_jwBuALQ@mail.gmail.com> <3532744.1738094469@warthog.procyon.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, "idryomov@gmail.com" <idryomov@gmail.com>,
    Alex Markuze <amarkuze@redhat.com>,
    "slava@dubeyko.com" <slava@dubeyko.com>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] ceph: Fix kernel crash in generic/397 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3541165.1738103654.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jan 2025 22:34:14 +0000
Message-ID: <3541166.1738103654@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> And even after solving these two issues, I can see dirty memory pages af=
ter
> unmount finish. Something wrong yet in ceph_writepages_start() logic. So=
, I am
> trying to figure out what I am missing here yet.

Do you want me to push a branch with my tracepoints that I'm using somewhe=
re
that you can grab it?

David


