Return-Path: <linux-fsdevel+bounces-43885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 421B7A5EEBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 10:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1A119C09A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 09:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09151263C8A;
	Thu, 13 Mar 2025 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gteJGi8w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C951FBCA3
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856462; cv=none; b=pevSZhJK5BO25r/nb2E3bd8FoYiBDj4J/qZOIWvDeV5s6H9sP/dBbNs02xjrWldpvoTmC49uP5b6q15gctFEx45r2LgcSYWQgO13bMa2jn1ldkv96uc3u3AConHKRV5eHxxjX6E2bYCK8MYHTj9AMdqwZ/c5WZ2NloBzYJjd8hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856462; c=relaxed/simple;
	bh=2NVIlOXjOqN6H2t3XTMFYhxsI9xrRSifYJsUYEBiDaM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=c7x/eOaaJH9UqOuRFEqfYaV0pu7fgERNUDKFPahxBm8VsIKlEMgEpdrry8jF9R43RhwFSUbR0nKDV7yqVuOWgNBSvqbXvYq9ZL0fqxFKiFl2R6og2DpBMjTXSJPSsfdnWswiaFZQ1NDX2PCYL54GEfk1kB8sH9QsCwX7rrWjeU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gteJGi8w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741856459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HWX+NY4k6HSsnkBzV4RnRPKYxMVxCP2ZIMbCALpTIGg=;
	b=gteJGi8wkysSgTvSO34JGSr0wWP7Uz/dRMLkIk3a2nGL1GvOvU5qWFhKHmSx7Q0pOngSoe
	UL4He+63hefDaYQkVnJlG350JmSs5GLIkgiT7V3jVlQ7uENgVHsEkI4DRxBGWqsLvlnQ60
	j78+Sh6CK+zKuV6GkSEqvAxpw7eOhXI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-_jZveJSVOR-CqeIuwQAaWQ-1; Thu,
 13 Mar 2025 05:00:55 -0400
X-MC-Unique: _jZveJSVOR-CqeIuwQAaWQ-1
X-Mimecast-MFC-AGG-ID: _jZveJSVOR-CqeIuwQAaWQ_1741856454
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D3DE1800258;
	Thu, 13 Mar 2025 09:00:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C02981828A99;
	Thu, 13 Mar 2025 09:00:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <458de992be8760c387f7a4e55a1e42a021090a02.camel@ibm.com>
References: <458de992be8760c387f7a4e55a1e42a021090a02.camel@ibm.com> <1243044.1741776431@warthog.procyon.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, "slava@dubeyko.com" <slava@dubeyko.com>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    Alex Markuze <amarkuze@redhat.com>, Xiubo Li <xiubli@redhat.com>,
    "brauner@kernel.org" <brauner@kernel.org>,
    "idryomov@gmail.com" <idryomov@gmail.com>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ceph: Fix incorrect flush end position calculation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1330414.1741856450.1@warthog.procyon.org.uk>
Date: Thu, 13 Mar 2025 09:00:50 +0000
Message-ID: <1330415.1741856450@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Shall I ask Christian to stick this in the vfs tree?  Or did you want to take
it through the ceph tree?

David


