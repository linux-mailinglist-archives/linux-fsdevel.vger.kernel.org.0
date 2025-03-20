Return-Path: <linux-fsdevel+bounces-44601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53648A6A969
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9821895958
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A871E835D;
	Thu, 20 Mar 2025 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSaRsfEY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EB11E570D
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482799; cv=none; b=Xl7xm/MVQNPQhwj/tumJzqGqbLRJFa6/1ohPRIV6sJqBZZNw54aDs9I8/salV0hd5Eq8pgN+kHqNs6CaatrvjgguckC/MrPaYgzjV+FnnB4LRql5FRZFbsFIoYQ9kdchjAYeH1esDIg9aNyzuZoP10K/rQk+712RaEWgtDhgZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482799; c=relaxed/simple;
	bh=2rOGlMmtdQ4Ksoad5RSTtLyZgwyZ5X/mRZl26DRqT94=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=mZNCiM0QOWBLzO+BDHICw+/GtiOVpeFj201zqS9h5UZdSgag6t8cYhybuxZC9rTGNpmyykI0DhiBg6muCxk5Q6OuF+SEoVJpdd0RG5wfKP9xDIcz9K3cd0vvW8FfaX/vza79304dBoB7eImKKJMJXAIo4oGYMpZEvNafRa3/O0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SSaRsfEY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742482796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRe2APlP+3rualAe+YEcPMiZ23dWUMdOZf0dy04wvzQ=;
	b=SSaRsfEYJU3zDtGeOrOS9g1OTB/h6qAjLjgtNXyEvI4qmFexW7hP39MoNTKYz+amGnsH41
	CSLqJhEvuqXMhZPSaVHyO2pWvKFcOV2jee7sO+WjfO33swT/OjkWr7LVEndD+ON0yy+k6n
	TSEgoT8hwn2l0jDo3IcPWsvlMXJxjWw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-XPbzXm-7PjWIQos2Ykpyrw-1; Thu,
 20 Mar 2025 10:59:52 -0400
X-MC-Unique: XPbzXm-7PjWIQos2Ykpyrw-1
X-Mimecast-MFC-AGG-ID: XPbzXm-7PjWIQos2Ykpyrw_1742482791
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F635196D2E0;
	Thu, 20 Mar 2025 14:59:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 163253001D16;
	Thu, 20 Mar 2025 14:59:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <749dc130afd32accfd156b06f297585a56af47f3.camel@ibm.com>
References: <749dc130afd32accfd156b06f297585a56af47f3.camel@ibm.com> <20250313233341.1675324-1-dhowells@redhat.com> <20250313233341.1675324-24-dhowells@redhat.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
    Ilya Dryomov <idryomov@gmail.com>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    "slava@dubeyko.com" <slava@dubeyko.com>,
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
    "jlayton@kernel.org" <jlayton@kernel.org>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    "dongsheng.yang@easystack.cn" <dongsheng.yang@easystack.cn>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Why use plain numbers and totals rather than predef'd constants for RPC sizes?
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3172945.1742482785.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Mar 2025 14:59:45 +0000
Message-ID: <3172946.1742482785@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> > -	dbuf =3D ceph_databuf_reply_alloc(1, 8 + sizeof(struct ceph_timespec=
), GFP_NOIO);
> > -	if (!dbuf)
> > +	request =3D ceph_databuf_reply_alloc(1, 8 + sizeof(struct ceph_times=
pec), GFP_NOIO);
> =

> Ditto. Why do we have 8 + sizeof(struct ceph_timespec) here?

Because that's the size of the composite protocol element.

As to why it's using a total of plain integers and sizeofs rather than
constant macros, Ilya is the person to ask according to git blame;-).

I would probably prefer sizeof(__le64) here over 8, but I didn't want to
change it too far from the existing code.

If you want macro constants for these sorts of things, someone else who kn=
ows
the protocol better needs to do that.  You could probably write something =
to
generate them (akin to rpcgen).

David


