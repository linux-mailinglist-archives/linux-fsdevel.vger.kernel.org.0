Return-Path: <linux-fsdevel+bounces-42084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FC2A3C4F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE7E3ADC64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 16:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435E21FECB8;
	Wed, 19 Feb 2025 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu7KHE+3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6DC1FECA3
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982370; cv=none; b=Yn1zFmgzyf3DSNM9uDhpcmGczv1qC1W5/U26Xp6FDlWDJbI3fSw0cB6QQagjyIr4kEvmNGNjIyjaGUOkEQRMXNmP50tK+xquAS5+ISv4VepYEnHzYsMnmvCiBs1R3s3Byw/2fIZsnuRDUjj8JEPsChFDmG9s2yvttVNMHoLJY+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982370; c=relaxed/simple;
	bh=4bAM7j6fwjdmH+PmBRf3we/MlLMXPn1NZ5kN0kz3Jnk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=kH/AFlq30BuHvV2e1mT5XkC4GxiKBIkadFTTHR9qlTTEsGO47zCoB1daccABl/eGhsmwC1vqotpgEbhCKKDIWkhGIdvKzWKlbBl/B6Q5F9PblwKFBjGAk936hWTpSiGuSZMhD0HqzAMim7LZ+22MjCWq/jEBgGWn4969aq+yMLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pu7KHE+3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739982368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4bAM7j6fwjdmH+PmBRf3we/MlLMXPn1NZ5kN0kz3Jnk=;
	b=Pu7KHE+3fbj+e07cylorbRSLNu9SnJtKc2O4WyJsa6Le3B96hdH/7s/OmQrKaqS4GkJV0z
	w/h0r/ChWoMTg1qr7zSc7w5m244Pkw/BYUCEbCj7JPtXKL2jxP+fs2t+I2AMT2RmGviI/U
	lEcMpxrIWln0vJkjsyRKlm4Wq0WHpOM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-Y9KoTljjMA6BCgbogSmUWA-1; Wed,
 19 Feb 2025 11:26:06 -0500
X-MC-Unique: Y9KoTljjMA6BCgbogSmUWA-1
X-Mimecast-MFC-AGG-ID: Y9KoTljjMA6BCgbogSmUWA_1739982365
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD66A19039C6;
	Wed, 19 Feb 2025 16:26:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 972801800D9E;
	Wed, 19 Feb 2025 16:26:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5mvgkPdLQ_oz_faa=4CVCaHNDcNVZfqBbdKTENrW5COSTA@mail.gmail.com>
References: <CAH2r5mvgkPdLQ_oz_faa=4CVCaHNDcNVZfqBbdKTENrW5COSTA@mail.gmail.com>
To: Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
    linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: netfs read failures with current mainline
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <526481.1739982363.1@warthog.procyon.org.uk>
Date: Wed, 19 Feb 2025 16:26:03 +0000
Message-ID: <526482.1739982363@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Steve French <smfrench@gmail.com> wrote:

> cifs/102

What's cifs/102?

David


