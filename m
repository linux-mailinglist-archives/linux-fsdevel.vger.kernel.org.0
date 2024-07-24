Return-Path: <linux-fsdevel+bounces-24190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E7C93AF59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 11:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F407B1C2108C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 09:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991AC15350B;
	Wed, 24 Jul 2024 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nd9F37qu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8A4152160
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814553; cv=none; b=Mazxo97cpQSEPhpugOyS3hUbn3lyIlTNvmykBMEHLSl4JK7/9OzDrY2SrOoGNp3+Tyuf4lScxyAo1NO+bVtOweaUM51fH0lr5lzBRRr3y5102K0XDZuZz5YzZvxus/m+iyY5Wc7H6aa/bqxOVRbqdSPMnw/w48ohD9u7b7XR1BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814553; c=relaxed/simple;
	bh=On3pfYPoO7z0t+5h4T28x9zYP+tznnS6VJGlMP61PsU=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=ahBkBoOSgGNlMygxpkoHh8hK9JIlC++PLlw0qUwXj7J6uizABCWLGRmHc2DzMbp7lKy2vyn6tPfYKBjVQVaexUezQGDt/jQWr1+BCyYr6gMVR4CnFlSVIRjd+qX7EhJNWAQLyu9h+owfcxu6/y5mZKAtvefJpcbYsLDaY6PiRZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nd9F37qu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721814550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=On3pfYPoO7z0t+5h4T28x9zYP+tznnS6VJGlMP61PsU=;
	b=Nd9F37qunhEIs7T/eq0EjgeyIMT5MDTQauTH3r7zISUcAjq/xBC4ZS3KnG7x2bjKdOMS0m
	58Lrf2Q76HsJayXUFkW0IgG66BXS/Loy4FDYur41/RWY1MVSW2wJJ5E9Oz3GVG9dFueAQc
	IGzyG/ZOB1AmjVO8gtqkifUWqZrmWfo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-aiHBK3TROMqWK67A11NOKQ-1; Wed,
 24 Jul 2024 05:43:07 -0400
X-MC-Unique: aiHBK3TROMqWK67A11NOKQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E84B01955D57;
	Wed, 24 Jul 2024 09:43:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBDCF1955D42;
	Wed, 24 Jul 2024 09:42:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2299428.1721813616@warthog.procyon.org.uk>
References: <2299428.1721813616@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Gao Xiang <xiang@kernel.org>, netfs@lists.linux.dev,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: Fix non-taking of sb_writers around set/removexattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2300460.1721814176.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jul 2024 10:42:56 +0100
Message-ID: <2300461.1721814176@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesy=
stem")


