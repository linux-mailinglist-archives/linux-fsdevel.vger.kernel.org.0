Return-Path: <linux-fsdevel+bounces-44372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F47A67F82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 23:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0747C3B8F4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 22:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372861FCCF2;
	Tue, 18 Mar 2025 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUpSE0xO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163B72063FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336035; cv=none; b=nLRfc5gPNmKObusAW5U9lbndukQqsivkqWMyqIpGuwNVf1BUl18RNx8E5da+UDGGjBETUHISdhTfOzNM/vyD/BZ/K/QFur4GrWBecsz78Bg8hdEjxxQHblAIS6D4ka3W18MxCS1RwPyn9bN4woTYIJjTuLUtuiY3V0Rui7+4r7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336035; c=relaxed/simple;
	bh=+GT7xTCoAxdd7TaqB8aFZCSz0X4+G43xmplubN02gas=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=HX+JpRlPMbcZ6LFItDiy28nFotjIJ1Dhp1MwnBjD5axihstCzghYFVRMwmMkaQhXovB3bFNP4zzHvha7FBntJmlSiyODsKIYvEPHWEKGSY3bIck8iwnpe+Lq3NNJmIal9qC/sQIeL3qykEshQ3WnJKLqa/qLQeskK2VSvniMP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUpSE0xO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742336033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+GFAiir4R3bujMXcWPgCyvMMm2RkMwRgEUEGWcFBco=;
	b=SUpSE0xOoZGtnva6GnxzqxutRHraXzOR+V7VLWtJ1KyIKxcrDXvQjSacQISlU/vIVh7pav
	qENycNFFtM9ka9/cQaIGY6Syyw1b1qKziByk1tE7VDHF7S/VBzwJx+96aaAF9uHeU7Og3u
	mmW1Ac2K8dnwOQgjSAjjxdkGXhVi0Ro=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-2O6T27d7McenMk_496jj5A-1; Tue,
 18 Mar 2025 18:13:49 -0400
X-MC-Unique: 2O6T27d7McenMk_496jj5A-1
X-Mimecast-MFC-AGG-ID: 2O6T27d7McenMk_496jj5A_1742336028
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6847E18004A9;
	Tue, 18 Mar 2025 22:13:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13E7719560AD;
	Tue, 18 Mar 2025 22:13:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <639bd030acc938dc3ef1d11fe630c03e3effd24d.camel@ibm.com>
References: <639bd030acc938dc3ef1d11fe630c03e3effd24d.camel@ibm.com> <20250313233341.1675324-1-dhowells@redhat.com> <20250313233341.1675324-14-dhowells@redhat.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    "slava@dubeyko.com" <slava@dubeyko.com>,
    "dongsheng.yang@easystack.cn" <dongsheng.yang@easystack.cn>,
    Xiubo Li <xiubli@redhat.com>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
    "jlayton@kernel.org" <jlayton@kernel.org>,
    "idryomov@gmail.com" <idryomov@gmail.com>,
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC PATCH 13/35] rbd: Switch from using bvec_iter to iov_iter
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2680457.1742336023.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Mar 2025 22:13:43 +0000
Message-ID: <2680458.1742336023@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> > +	list_for_each_entry(ex, object_extents, oe_item) {
> > +		if (ex->oe_objno =3D=3D objno &&
> =

> OK. I see the point that objno should be the same.
> =

> > +		    ex->oe_off <=3D objoff &&
> =

> But why ex->oe_off could be lesser than objoff? The objoff could be not =
exactly
> the same?
> =

> > +		    ex->oe_off + ex->oe_len >=3D objoff + xlen) /* paranoia */
> =

> Do we really need in this comment? :)
> =

> I am still guessing why ex->oe_off + ex->oe_len could be bigger than obj=
off +
> xlen. Is it possible that object size or offset could be bigger?

Look further on in the patch.  The code is preexisting, just moved a bit.

My guess is that we're looking at data from the server so it *has* to be
sanity chacked before we can trust it.

David


