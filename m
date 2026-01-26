Return-Path: <linux-fsdevel+bounces-75444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBwNO50rd2nacwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 09:53:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7C285A66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 09:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 472E2302769C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 08:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8FD3019D8;
	Mon, 26 Jan 2026 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXqOc4+Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085A725FA05
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769417530; cv=none; b=d1/eWk85Q2u0hC4o7LkDxgpM7iCLPkt9Cw6zsrOiWXOuh345uYahzVeBjviXibPiNWiIfxOtTRH8VYWUUKJCPk9R8k0bA5+CS9o0y3LyQyuRofvny2mDuF0dff1PvJLNpj0J8Fswl/zbygW1hRMP/+VQtJhBHZ3q+ViRlQU2LMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769417530; c=relaxed/simple;
	bh=VuF13fDDkjsDdQB0FK1glz3rdsLnhvFj2Qao2aEyreo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lR4akf42HNJZgRT/G7gFpmUqIj/5nq8M5KsHFBvQZxrbyAaaZnP2/g61twX2LYN1K3sDgdI/sqDZ4CH9FwrE7/FRhhJX0qyfhTmjwN6Typ6lgAuIfH2KxqB+w11BeewC8RF70nV/RyZ77WfGXjF4rFHPnEz5gNQ4Vc1MPsnSzeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXqOc4+Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769417528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YzWG8mhXvLiSMnrLWOTgHghebUSlEnmkpDMK2MCkjTI=;
	b=TXqOc4+Q/o5I9FshDL4tTiQHBRipTIyxOYTsTnO+EoP4vJsh42OBmcQWS7H7yqxJdbxCub
	92z8ZIM7kQzH5DhmkNTlmZMh1KZGvfWjP9di2W7yj09vVNohY82qaVOSwvJBn69SJVqjbX
	+a+0/5jH6ez9S25GN5/HVOncA2Xxb7I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-7XI-tJViPxmtoAD9SgSCrw-1; Mon,
 26 Jan 2026 03:52:04 -0500
X-MC-Unique: 7XI-tJViPxmtoAD9SgSCrw-1
X-Mimecast-MFC-AGG-ID: 7XI-tJViPxmtoAD9SgSCrw_1769417523
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 143001944A84;
	Mon, 26 Jan 2026 08:52:02 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.225.129])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 431D519560B4;
	Mon, 26 Jan 2026 08:51:57 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: "Zack Weinberg" <zack@owlfolio.org>
Cc: "The 8472" <kernel@infinite-source.de>,  "Rich Felker"
 <dalias@libc.org>,  "Alejandro Colomar" <alx@kernel.org>,  "Vincent
 Lefevre" <vincent@vinc17.net>,  "Jan Kara" <jack@suse.cz>,  "Alexander
 Viro" <viro@zeniv.linux.org.uk>,  "Christian Brauner"
 <brauner@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-api@vger.kernel.org,  "GNU libc development"
 <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
In-Reply-To: <de07d292-99d8-44e8-b7d6-c491ac5fe5be@app.fastmail.com> (Zack
	Weinberg's message of "Sun, 25 Jan 2026 10:37:01 -0500")
References: <20250517133251.GY1509@brightrain.aerifal.cx>
	<5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
	<8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
	<20250524022416.GB6263@brightrain.aerifal.cx>
	<1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
	<20260120174659.GE6263@brightrain.aerifal.cx>
	<aW_jz7nucPBjhu0C@devuan> <aW_olRn5s1lbbjdH@devuan>
	<1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
	<0f60995f-370f-4c2d-aaa6-731716657f9d@infinite-source.de>
	<20260124213934.GI6263@brightrain.aerifal.cx>
	<7654b75b-6697-4aad-93fc-29fa9b734bdb@infinite-source.de>
	<de07d292-99d8-44e8-b7d6-c491ac5fe5be@app.fastmail.com>
Date: Mon, 26 Jan 2026 09:51:55 +0100
Message-ID: <lhu8qdkpxhw.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fweimer@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-75444-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Queue-Id: 5E7C285A66
X-Rspamd-Action: no action

* Zack Weinberg:

> In particular, I really hope delayed errors *aren=E2=80=99t* ever reported
> when you close a file descriptor that *isn=E2=80=99t* the last reference
> to its open file description, because the thread-safe way to close
> stdout without losing write errors[2] depends on that not happening.

> [2] https://stackoverflow.com/a/50865617 (third code block)

Are you sure about that?  It means that errors are never reported if a
shell script redirects standard output over multiple commands.

Thanks,
Florian


