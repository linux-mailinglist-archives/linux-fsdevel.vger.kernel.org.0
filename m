Return-Path: <linux-fsdevel+bounces-52932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4ADAE8901
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5201B4A3606
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25051DF980;
	Wed, 25 Jun 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gw8ktGzT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640A1D5CE0
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867225; cv=none; b=iKLrhGkk568HLSklOnZfudRFsu64G3MTDUncgmS+Z4tCWYCpBTPtNQ0JrcaJzm7FGWnSUhN5sGayOFAnAL9brnHm/B3jsM3Nn6NITXBW3X97SpBQ09YaqSoHMl7OO4S01f5RwAR/yyZLY5TRKX6Glycv0GKLHDcKEmeTfoqASt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867225; c=relaxed/simple;
	bh=gmxAdGYH01kQqDUySciDEd2T1xICD8j3PusfHCEXsTE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=EgBhQQbkc2n+XXW/pI9CDc5INxI4QjMzzK0kzQCYTBXf3BdmGqHHOcaJC6cgymLF6LYKH0hIe5r8yI0MfSPfSzp30h9Mo6LKBxFayCcU2Z3Gd9H/3oS11Ecy3ecuOGUiD/3yidYl3qPI5m8GpgboRvkN1ka/b+gVgsXmwTBmdow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gw8ktGzT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750867222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0NvJR22D1lGBwJC9xwFeqS10DKhxpDNcNeEIOF/0eE=;
	b=Gw8ktGzTu8GZd6tiniykxsJZ7fsqgO/aNLB2JbQ9/SMhlhPscwmkCsfjNPu6bLSDf8cl5V
	nCC7BR25dDVPTkRMzpm1QeSFMgHNy7h6p6XE8q8oZlIXfUBgR6SVTH/wbSjt8JdXpIpHSd
	TmQ2hUHMyDO2C+by/zF6BHQUhVVu+Tk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-AcHNvVIfOy2R2XPuDzd6pQ-1; Wed,
 25 Jun 2025 12:00:17 -0400
X-MC-Unique: AcHNvVIfOy2R2XPuDzd6pQ-1
X-Mimecast-MFC-AGG-ID: AcHNvVIfOy2R2XPuDzd6pQ_1750867215
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77C6E19560BA;
	Wed, 25 Jun 2025 16:00:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B80FA19560A3;
	Wed, 25 Jun 2025 16:00:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <15a2d9f7-0945-4bb9-9879-e2a615b8f208@samba.org>
References: <15a2d9f7-0945-4bb9-9879-e2a615b8f208@samba.org> <1107690.1750683895@warthog.procyon.org.uk> <f448a729-ca2e-40a8-be67-3334f47a3916@samba.org>
To: Stefan Metzmacher <metze@samba.org>
Cc: dhowells@redhat.com,
    "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
    netfs@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
    Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH] cifs: Collapse smbd_recv_*() into smbd_recv() and just use copy_to_iter()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1401345.1750867212.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Jun 2025 17:00:12 +0100
Message-ID: <1401346.1750867212@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Stefan Metzmacher <metze@samba.org> wrote:

> Please keep the rfc1002_len variable as it's used in the log_read messag=
e
> below and it should by host byteorder.

So this change on top of the patch I posted?

@@ -1838,11 +1838,11 @@ int smbd_recv(struct smbd_connection *info, struct=
 msghdr *msg)
                         * transport layer is added
                         */
                        if (response->first_segment && size =3D=3D 4) {
-                               unsigned int len =3D
+                               unsigned int rfc1002_len =3D
                                        data_length + remaining_data_lengt=
h;
-                               __be32 rfc1002_len =3D cpu_to_be32(len);
-                               if (copy_to_iter(&rfc1002_len, sizeof(rfc1=
002_len),
-                                                &msg->msg_iter) !=3D size=
of(rfc1002_len))
+                               __be32 rfc1002_hdr =3D cpu_to_be32(rfc1002=
_len);
+                               if (copy_to_iter(&rfc1002_hdr, sizeof(rfc1=
002_hdr),
+                                                &msg->msg_iter) !=3D size=
of(rfc1002_hdr))
                                        return -EFAULT;
                                data_read =3D 4;
                                response->first_segment =3D false;

Btw, I'm changing the patch subject and description to:

    cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code
    =

    When performing a file read from RDMA, smbd_recv() prints an "Invalid =
msg
    type 4" error and fails the I/O.  This is due to the switch-statement =
there
    not handling the ITER_FOLIOQ handed down from netfslib.
    =

    Fix this by collapsing smbd_recv_buf() and smbd_recv_page() into
    smbd_recv() and just using copy_to_iter() instead of memcpy().  This
    future-proofs the function too, in case more ITER_* types are added.
    =

    Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
    Reported-by: Stefan Metzmacher <metze@samba.org>
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Steve French <stfrench@microsoft.com>
    cc: Tom Talpey <tom@talpey.com>
    cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
    cc: Matthew Wilcox <willy@infradead.org>
    cc: linux-cifs@vger.kernel.org
    cc: netfs@lists.linux.dev
    cc: linux-fsdevel@vger.kernel.org

David


