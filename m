Return-Path: <linux-fsdevel+bounces-12032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A435185A7AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 16:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B331F232E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA943D0CB;
	Mon, 19 Feb 2024 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIoKsImN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBF838FA5
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357345; cv=none; b=sDI2qzN4UUMT2JHw8YrgXkFFDVbfowYdINuQLqV5fRSYEroXBZUR6b09sy2haV5zEkq/O4DPwlUr37wnowB/+qxKtCrthr9VZQSIAUwR73lfZlM764o9MQNc13n70JQ81hIhDbtLeuux1KH0NpspzP4X+lEtSHulcYlwEVgtXTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357345; c=relaxed/simple;
	bh=NIFtUpFLsHivFguvB+ZvyrkpY/INW7ZD0v9T38aeM/k=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=eaUTithyTUF7buAK1XGg0S82molqOsCAV6ba+OdG2oqruiOmD5mQBHI0NWEcRgirfA+dW8z2JcVJ1RmK4eLGyLrsfK2Iu/C1ZEpjNI9GZbMbiGSxhvKwDNfq1z7rlp9Rfl+YN8AfVfIr0qRqoSp6YT6RLK/QkwB2juEBR4YTqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XIoKsImN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708357342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYi7OFizi+TSpI37jerYjh3Z/519CTMS/OFVVmKV/5k=;
	b=XIoKsImNl0ivHO2QqzOU47EpjEG9iYWW4qbVLpxrulGrTfXn+bwAfAzxGUQT2kkqDXZmyX
	QByF9NUlK+HCFGQbflqN0xgxoLKrM7dz7sjqDFQ0v9b8rQ6pPWg77TXYR4EAUokoKaLlTj
	yCk5lGJZYqPm0mKML4tryWro+V3LVOs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-78AazjT2NnWPZegN_d8_QQ-1; Mon, 19 Feb 2024 10:42:17 -0500
X-MC-Unique: 78AazjT2NnWPZegN_d8_QQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C10E85A588;
	Mon, 19 Feb 2024 15:42:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A3E7D1C060B3;
	Mon, 19 Feb 2024 15:42:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <187136.1708356611@warthog.procyon.org.uk>
References: <187136.1708356611@warthog.procyon.org.uk> <CAH2r5mu0Dw7jVHFaz4cYCNjWj9RFa76pRTyQOEenDACHDgNfyg@mail.gmail.com> <20240205225726.3104808-1-dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/12] netfs, cifs: Delegate high-level I/O to netfslib
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <187506.1708357334.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Feb 2024 15:42:14 +0000
Message-ID: <187507.1708357334@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

David Howells <dhowells@redhat.com> wrote:

> I don't suppose you can tell me what line smb2_readv_callback+0x50f/0x5b=
0 is?

It's almost certainly the iov_iter_revert() here:

	switch (mid->mid_state) {
	case MID_RESPONSE_RECEIVED:
		credits.value =3D le16_to_cpu(shdr->CreditRequest);
		credits.instance =3D server->reconnect_instance;
		/* result already set, check signature */
		if (server->sign && !mid->decrypted) {
			int rc;

			iov_iter_revert(&rqst.rq_iter, rdata->got_bytes);
			iov_iter_truncate(&rqst.rq_iter, rdata->got_bytes);

The reason that the:

	[  228.573737] kernel BUG at lib/iov_iter.c:582!

happens is that we're trying to wind the iterator back before its start po=
int.

Now, the iterator is reinitialised at the beginning of the function:

	if (rdata->got_bytes) {
		rqst.rq_iter	  =3D rdata->subreq.io_iter;
		rqst.rq_iter_size =3D iov_iter_count(&rdata->subreq.io_iter);
	}

so the reversion is probably unnecessary.

Note that this can only happen if we're using signed messages:

		if (server->sign && !mid->decrypted) {

as we wind back the iterator so that we can use it to feed the buffer to t=
he
hashing algorithm.

David


