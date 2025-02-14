Return-Path: <linux-fsdevel+bounces-41755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 679B3A3671B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 21:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D445171B2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 20:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4380B1C8619;
	Fri, 14 Feb 2025 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYUZWOXq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0046718EFD4
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739566346; cv=none; b=bl+onXI+GdkH13hiZ45haz7pwLe2ScrUtDZT2jcsrzd6dbc9i3VEiWPVN+aLrhRmqAxDM4AbEpKzGd3Jsh7Qb08mcw/N9Eg42wqgbRRMy+tQdeBq1mV2V1jZFdGIw4tWid81vEMAO07COP9XZQDDTeoeYuaPtTeo8ez1/NrHYCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739566346; c=relaxed/simple;
	bh=X3cB6ZCneqpRx9v6lRtOLwO+zGoe4uspxkptHXtgQjg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Ec17e4dHmbPH5bTlAF9DoilvWSl4danaP79I1PTU4+/qUHU01iXZVXJDeoQqUiKvlGMpFT/vIJmNxAr7msgctmkyo3SqYL/p68qeTwGqjXU5n5Gq5YDkOo+h/kdJC3ubNFog6TO3OnsTaHoQ6HlGmP4aX58mk2eYiWqXchcUMDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYUZWOXq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739566343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8ogKAwfoFxL/HoewL0fsTN6KG0OtYNxHopbhCpQT4A=;
	b=aYUZWOXqeGh8phTQW62m6rN4A3mab8qHI59Uj4s9u/IcM56BfSuUtB99I/TK5URfxNxd33
	X6/FpPFOM9Em6XnkVMiPuhLcL0palsS4frFDPDlQYqMC+O6tMnYQje7UAZESDadgq3Za8L
	GgopmXxG7Dhz/97rdNUIjTU6eArW4FE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-9WgvDOQwNpWYxo8NqMX2mg-1; Fri,
 14 Feb 2025 15:52:20 -0500
X-MC-Unique: 9WgvDOQwNpWYxo8NqMX2mg-1
X-Mimecast-MFC-AGG-ID: 9WgvDOQwNpWYxo8NqMX2mg_1739566339
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 642321800879;
	Fri, 14 Feb 2025 20:52:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7725419373D9;
	Fri, 14 Feb 2025 20:52:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <7596dd297239c4226a0ff6005bbb368733d38b4a.camel@ibm.com>
References: <7596dd297239c4226a0ff6005bbb368733d38b4a.camel@ibm.com> <4e993d6ebadba1ed04261fd5590d439f382ca226.camel@ibm.com> <20250205000249.123054-1-slava@dubeyko.com> <4153980.1739553567@warthog.procyon.org.uk> <18284.1739565336@warthog.procyon.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, "idryomov@gmail.com" <idryomov@gmail.com>,
    Alex Markuze <amarkuze@redhat.com>,
    "slava@dubeyko.com" <slava@dubeyko.com>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [RFC PATCH 0/4] ceph: fix generic/421 test failure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36585.1739566336.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Feb 2025 20:52:16 +0000
Message-ID: <36588.1739566336@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> Do you mean that you applied this modification?

See:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dnetfs-fixes

for I have applied.

David


