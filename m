Return-Path: <linux-fsdevel+bounces-70473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F95EC9C736
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 18:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04AB3A92D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A272D0C61;
	Tue,  2 Dec 2025 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKcBS+nU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4805F2C21E7
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697519; cv=none; b=UrcyGwun9yCUYuIZyO4u/qB0D/Lf5bhT2rA4wwouH1d3DibRMiJzBETKh8jZXw7pJKB7YEZOedeRLljeFvc4idvghGs0Z4vg0pkwy6pc8QsCO/lNS3ukUe04l5mnsMcmUXKfZ5n4KyslcSRC9+Bgh6iFN5e6Mu2i4LHu7tGWKM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697519; c=relaxed/simple;
	bh=tamybLxNrophK48+LjH+nI7WJXO09o5rS7gtzjOP3xc=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=YBweOTdUepVc2fMkJFLGrmNwXHXTtlk1GZmjnDkz8Xne/2TpiLlCBHQU0PP0wQ79a8j96uC5IOecQiY4QHqlAn8g+P3dFAXJRf+ffsa/rShU8rFJiZIKjn3EjgfOUmEjAQqUEm8b3VmBuHcMycBXCBQ4BllW9WaOIkdWbtpN4ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QKcBS+nU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764697517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sO3YMt7bwHXHXoImGSFPk/MGZ4Jh8BA+UgosjHsNIMw=;
	b=QKcBS+nUZ3pdpR6CbZyztYk3NYDNUMWBmlal0W1KXoUzJlHS38S5mPehB1l2YR//lP5NpT
	5VgSD7Fq/gLKL8EveHANEzjA1QfNIWOXlV23guQMqQ64ixo7WIyD1+DF0IiyFbYhwMR8M5
	0n7+h/PWF4wbulg0laMqbEKLQ0HCZl4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-ww52pWIROKa1BUU12KTOWQ-1; Tue,
 02 Dec 2025 12:45:12 -0500
X-MC-Unique: ww52pWIROKa1BUU12KTOWQ-1
X-Mimecast-MFC-AGG-ID: ww52pWIROKa1BUU12KTOWQ_1764697510
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D0671801303;
	Tue,  2 Dec 2025 17:45:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0CCF30001A4;
	Tue,  2 Dec 2025 17:45:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix handling of a beyond-EOF DIO/unbuffered read over SMB1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1597478.1764697506.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Dec 2025 17:45:06 +0000
Message-ID: <1597479.1764697506@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

    =

If a DIO read or an unbuffered read request extends beyond the EOF, the
server will return a short read and a status code indicating that EOF was
hit, which gets translated to -ENODATA.  Note that the client does not cap
the request at i_size, but asks for the amount requested in case there's a
race on the server with a third party.

Now, on the client side, the request will get split into multiple
subrequests if rsize is smaller than the full request size.  A subrequest
that starts before or at the EOF and returns short data up to the EOF will
be correctly handled, with the NETFS_SREQ_HIT_EOF flag being set,
indicating to netfslib that we can't read more.

If a subrequest, however, starts after the EOF and not at it, HIT_EOF will
not be flagged, its error will be set to -ENODATA and it will be abandoned=
.
This will cause the request as a whole to fail with -ENODATA.

Fix this by setting NETFS_SREQ_HIT_EOF on any subrequest that lies beyond
the EOF marker.

This can be reproduced by mounting with "cache=3Dnone,sign,vers=3D1.0" and
doing a read of a file that's significantly bigger than the size of the
file (e.g. attempting to read 64KiB from a 16KiB file).

Fixes: a68c74865f51 ("cifs: Fix SMB1 readv/writev callback in the same way=
 as SMB2/3")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifssmb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 645831708e1b..1871d2c1a8e0 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1395,7 +1395,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	} else {
 		size_t trans =3D rdata->subreq.transferred + rdata->got_bytes;
 		if (trans < rdata->subreq.len &&
-		    rdata->subreq.start + trans =3D=3D ictx->remote_i_size) {
+		    rdata->subreq.start + trans >=3D ictx->remote_i_size) {
 			rdata->result =3D 0;
 			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 		} else if (rdata->got_bytes > 0) {


