Return-Path: <linux-fsdevel+bounces-63156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1638BBAFE1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 11:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18743B3EB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 09:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6502DA755;
	Wed,  1 Oct 2025 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHVKkJSA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD84E278150
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311428; cv=none; b=TtwYkgw91lQ5IYUH/9+uqZga4Ou9e4s1hOxyA5UJ7TNJCFZ+cOBmZjGtxVhX1LNJKJSKU3zOdtBsfOt0MfFCzJ/omW/J1Voo4e8IFuJE2kd8s8X52RkOIw7rKuXyyE1a22Ztl8BtXnpkRZY16Cp1o/WypRXoxnKbzQyGLvITgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311428; c=relaxed/simple;
	bh=smJzPZ2H+puqNQpL9LTWdRgBhAS8OfsmNfjleezYjpM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=rvP421GJkJMk6p1aGLux7hjlIgdcxVTLlEvb69TmWyiOrg3/Eca5QslLyTHhsWHguKsxDyMQK+wUyvS3frMRNRfqAth7B74UrStcGMWUVX+vkmyWu5YilEEeKLBUvfB9zFrguzwAsU+BeB3AGMwpwXDU9zdZOn1aBJTRB+9yeKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHVKkJSA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759311424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00w3hkHfsTAxYQCvIOKAjdtuK2kAChIoMSa2X5uPZB0=;
	b=KHVKkJSAH402JlKqHxOEcTUp9tJWlqpWsH3T8GJ3DwcZ75nuFSPptYWBJ8h9YuOeXi7UuG
	B26olVMznKHO+75vGEmOtouoq5egPzp9oOaScOLzpgmu09I2QmwB8mcaNtODcAIZTRo5XF
	c6qRTsy9UHTn0aK8CJbSO79i3gnjEWU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-ngBKf_HyMku4dc3tcFSEpA-1; Wed,
 01 Oct 2025 05:37:01 -0400
X-MC-Unique: ngBKf_HyMku4dc3tcFSEpA-1
X-Mimecast-MFC-AGG-ID: ngBKf_HyMku4dc3tcFSEpA_1759311419
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0BBC1800451;
	Wed,  1 Oct 2025 09:36:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 003CB30002C5;
	Wed,  1 Oct 2025 09:36:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20251001083931.44528-1-bhanuseshukumar@gmail.com>
References: <20251001083931.44528-1-bhanuseshukumar@gmail.com>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: dhowells@redhat.com, Kent Overstreet <kent.overstreet@linux.dev>,
    Jonathan Corbet <corbet@lwn.net>, Carlos Maiolino <cem@kernel.org>,
    Paulo Alcantara <pc@manguebit.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
    linux-bcachefs@vger.kernel.org, linux-doc@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel-mentees@lists.linuxfoundation.org,
    skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Subject: Re: [PATCH] fs: doc: Fix typos
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2077277.1759311412.1@warthog.procyon.org.uk>
Date: Wed, 01 Oct 2025 10:36:52 +0100
Message-ID: <2077278.1759311412@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com> wrote:

> Fix typos in doc comments
> 
> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>

Reviewed-by: David Howells <dhowells@redhat.com>


