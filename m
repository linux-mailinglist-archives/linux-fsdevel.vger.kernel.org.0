Return-Path: <linux-fsdevel+bounces-24612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8399941456
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 16:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B0E1F23116
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 14:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768CA1A2553;
	Tue, 30 Jul 2024 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWsZBtUO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B981A2554
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349619; cv=none; b=e3OdKp/+5EAK2DBr6CnIfxsd9dcmuobVXLkEHt5g42RPbGWf/kQQ7DfWiyIkfWnwJX8oAqN3w/1YDfY3YxoyoKmabTWNBkK4T67dZWG+FPRhReA5kD71qIzYWLAOPfoSvch08X1pSQti+oNEBi6iHDXR9HiO+ncxvI9jRTzPwlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349619; c=relaxed/simple;
	bh=QwOqJyMeabVVRXz2SZZrMQsxGHIjnHfDQSOp9Mld0Ok=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=YLrPBGomTUuNhiMqjSlJqdJVTfETeCDFWb8MMi8ufhQ15ZmvMiBzK3Ud3K/USyzyPpX2tTgl/uudlSzX/N+VHOhhQ4GQMcehh7Mvtn2bDEOdF/+wm01PRpn03PurqBzef1PlX3I1/ch37GXkDYdH8szCrXZk4FnPb0sS52XH918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWsZBtUO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722349617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HN99UYk8Kh6g/3OE9am3X/kGbGNdhXjLG7Bh6vntP4U=;
	b=iWsZBtUO2xswIavOjbTp2MHpW3OsRcLUdM99q2/wITJxAQL6k8V7UkZQimPPfH07yTII4h
	3s2FfMKw6sJ07HLisqB+rkEHb//IqrOwQ4dyypXXUlcrZEHsQU2CxJdLIMNBAaxOzIwPIi
	UEAcCDgtQQKQOh4BVJlPVQa1A2nppvg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-inhxdHUVP768Hgmk5_Y2BQ-1; Tue,
 30 Jul 2024 10:26:55 -0400
X-MC-Unique: inhxdHUVP768Hgmk5_Y2BQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 957731956080;
	Tue, 30 Jul 2024 14:26:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E4ECC1955D42;
	Tue, 30 Jul 2024 14:26:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240729090639.852732-1-max.kellermann@ionos.com>
References: <20240729090639.852732-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, willy@infradead.org,
    linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
    ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH] fs/ceph/addr: pass using_pgpriv2=false to fscache_write_to_cache()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3516607.1722349609.1@warthog.procyon.org.uk>
Date: Tue, 30 Jul 2024 15:26:49 +0100
Message-ID: <3516608.1722349609@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

For the moment, ceph has to continue using PG_private_2.  It doesn't use
netfs_writepages().  I have mostly complete patches to fix that, but they got
popped onto the back burner for a bit.

I've finally managed to get cephfs set up and can now reproduce the hang
you're seeing.

David


