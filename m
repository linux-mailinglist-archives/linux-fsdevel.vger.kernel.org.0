Return-Path: <linux-fsdevel+bounces-69714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 169C6C825D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 20:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F04F64E246C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 19:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C7E32D448;
	Mon, 24 Nov 2025 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+91f7aD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870F298CC4
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764014208; cv=none; b=hNgSHqVn6DkJukGOGfpObWEWbtclBPhQNMtsvsslspo5LDUdEouvbopfV0ep3qlXLEEtUaR1Zv1xFQbnpzpNP+evpdAWpqHz0Afs0yLQw526zLPRK+VGBl69zL6ZeZ8oGN9MbP22Nz2ACa5TDnDoj58Bd/qtriTV6MKlPiDsYD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764014208; c=relaxed/simple;
	bh=mOFz3pDbIikoGojeagVAUflzKKEym12vWvlNpcvFY40=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=VMbyu4yMzGyU75qMZDLnFU/tqGHdofhI2cKpwjoPpl1UuMA9iYEWWIohbBHCDWBFDaU6asmhi/7Rst6YABlUYd3KkvlqZe5hGH6RUO1jPP1/nSkvamALMlU9e81Ve8vxxGSUeAj7vkl+EjBRYUwEhnZYOsqilRtfJ/Px0z0RSfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+91f7aD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764014205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JWTHDWixO/WvuzV14DS/uqZIEULkQGQzdbnhW5iVDYU=;
	b=U+91f7aDCivPBHKhUx1uNZcjkbDURWAHpZxE2CUyozXXyb1Iym/PYDq2XlYIgik8UlwKWI
	KOvvfaXsY13Tog2GuZM5ZlRRkY4A8p9V5YPQhL11wj3zk5Nrzm1lUdzo6ljKYow68lma6V
	j94uLKCxv7YK+bg1LGjd20mH8CvzxKM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-cVU6EIuhOZymMOv5hBRUZw-1; Mon,
 24 Nov 2025 14:56:39 -0500
X-MC-Unique: cVU6EIuhOZymMOv5hBRUZw-1
X-Mimecast-MFC-AGG-ID: cVU6EIuhOZymMOv5hBRUZw_1764014198
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90DFA1954B0D;
	Mon, 24 Nov 2025 19:56:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 47227180047F;
	Mon, 24 Nov 2025 19:56:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <fe428483-6564-4f18-bd1a-cc1150941da5@talpey.com>
References: <fe428483-6564-4f18-bd1a-cc1150941da5@talpey.com> <20251124124251.3565566-1-dhowells@redhat.com> <20251124124251.3565566-6-dhowells@redhat.com>
To: Tom Talpey <tom@talpey.com>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.org>,
    Shyam Prasad N <sprasad@microsoft.com>,
    Stefan Metzmacher <metze@samba.org>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/11] cifs: Remove the RFC1002 header from smb_hdr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3649835.1764014194.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Nov 2025 19:56:34 +0000
Message-ID: <3649836.1764014194@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Tom Talpey <tom@talpey.com> wrote:

> On 11/24/2025 7:42 AM, David Howells wrote:
> > Remove the RFC1002 header from struct smb_hdr as used for SMB-1.0.  Th=
is
> > simplifies the SMB-1.0 code by simplifying a lot of places that have t=
o add
> > or subtract 4 to work around the fact that the RFC1002 header isn't re=
ally
> > part of the message and the base for various offsets within the messag=
e is
> > from the base of the smb_hdr, not the RFC1002 header.
> =

> This is truly great, RFC1002 is a framing layer and separating it from
> the upper SMB code is long overdue.
> =

> But... isn't this applicable to SMB2/3? The commit log implies it's SMB1
> only (nit there's no such thing as "SMB-1.0"), which is weird given the
> commit applies to many smb2<foo> files.

SMB2/3 doesn't have the RFC1002 headers included in struct smb2_hdr,
presumably because of the compound chaining, so nothing needed doing in th=
at
respect.  This harmonises SMB1 with SMB2/3.

> And, are similar changes envisioned in the ksmbd code?

None required AFAIK as that doesn't support SMB1?

David


