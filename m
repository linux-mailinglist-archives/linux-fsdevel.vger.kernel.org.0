Return-Path: <linux-fsdevel+bounces-39689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A7CA16F79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDC93A2779
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D881E9B0C;
	Mon, 20 Jan 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMHlZven"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D682E1E32DB
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387836; cv=none; b=k8YsnNnOF+6y38zCGWbIghA23bmlqiN/WghkLm5d7aXCjRvxYVdVQhxWjGahU0DMPvxrR3TUTbwkhHxBOLg+k5jBemXuWM1ZeYLuVEN5jiZknKfey6fSpGSB8VI+QOIPGpKU5dQWGN0yLKhmCeBQWI3XanJid0rpQUPD8oQQVv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387836; c=relaxed/simple;
	bh=7GSgh24e7Lrx6jF7Y+WvZ/VFxDmY/RDDmKTerlQyylE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=D6JWtO07d2TwX7G/fuKHimItK/Jzh1ZPoeXRCjCnHUYMHtgHN/ao4iBQubR3h9SnNtWvOB0CN5qfgM5zks7lYemD4QJn7haHc3+V7O5XVojlixhTWVJVjiAmHoBqpBxMp5Jzf+PmVT3orZjww6MVN99+XygnscHpSaRdW84pRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMHlZven; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737387833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7GSgh24e7Lrx6jF7Y+WvZ/VFxDmY/RDDmKTerlQyylE=;
	b=DMHlZvenOE1CQkLYPeMT+L/0r9fi55Y/EZ9Up+FKa4/csmhTkaR/EnizdZ9ZYdGHdus8wc
	7sxr2akPcDySSbpni3oKKeikcIuGo4CTcukDRsrI+2DACIlCKJpfw0btofKgsKBTTDtRcB
	ifvR92kDv8oN1/lJPcMv9g7v/Rp7tbc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-vONu1RTdPVW21o9O61ZlCg-1; Mon,
 20 Jan 2025 10:43:50 -0500
X-MC-Unique: vONu1RTdPVW21o9O61ZlCg-1
X-Mimecast-MFC-AGG-ID: vONu1RTdPVW21o9O61ZlCg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DE5C1955BD9;
	Mon, 20 Jan 2025 15:43:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C30AC3003FD2;
	Mon, 20 Jan 2025 15:43:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1201003.1737382806@warthog.procyon.org.uk>
References: <1201003.1737382806@warthog.procyon.org.uk> <1113699.1737376348@warthog.procyon.org.uk>
To: Eric Biggers <ebiggers@google.com>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    fstests@vger.kernel.org, ceph-devel@vger.kernel.org,
    linux-fsdevel@vger.kernel.org
Subject: Re: Error in generic/397 test script?
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1207324.1737387826.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jan 2025 15:43:46 +0000
Message-ID: <1207325.1737387826@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

David Howells <dhowells@redhat.com> wrote:

> However, in this case (in which I'm running these against ceph), I don't=
 think
> that the find should return nothing, so it's not a bug in the test scrip=
t per
> se.

Turned out that I hadn't enabled XTS and so the tests for xts(aes) failed =
and
produced no files.

David


