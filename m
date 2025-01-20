Return-Path: <linux-fsdevel+bounces-39707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABDAA171AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF73188AAB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033F01EE7C6;
	Mon, 20 Jan 2025 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRB2xSyy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6451EE7AA
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393998; cv=none; b=K0gKJKF21aqG9F7lUFoKLZwh1YwpDpuOMh6hZA3+WZv6eGHlrlDJDlu3dd4CSbvL6B09D+A9IO0Jr9uf3bxHtMRu/hzPgnxf87Zf35y220SoLeeErt8U30BhZEHcdk3/t+dw85ObbqZvUlgD3Jh2Btc1XLPjsOZ+gDSFrQNvh3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393998; c=relaxed/simple;
	bh=aWzc5C6UWD++0R5GZgNegpCkD6RqUqzWCdfAg13It4c=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Mn4OLCoOCE0AyUWVhY6iwZUagV5cgizLkMaH4Vemsp4YJ3u0SqrttbxPCLLM693HAuLrVcrKW7qX+uYSdtTBd5Qw4KZU8hnDlKVSl/vlBmW+NOX3LiwJISWq60ewEDmm1DSbc9aVk7CUz4w/7H0TW+gyIjPT8k1lox21o7+GkaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRB2xSyy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737393995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsXLiXsiXHpVVZSNjKfKmeF5iaS+nQUdM7F3d7+t0Hc=;
	b=HRB2xSyyaZcrSIQbGfTM8ioVGTAdKKZaOL4iHJx7L33QVw9pK+BJ8bZecVPB7MACruRIWy
	suRbrDTcwfDIOxHRaioUApMoqio68JtgPUTrGvwCkLRaB0IoIhvEcCtcpFKX4V1BzlA/Lv
	FqjIYDmKbK1hcuOdIDshEFIRxxPM2iQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-hbTccmFSO96aPW4smJW3bA-1; Mon,
 20 Jan 2025 12:26:32 -0500
X-MC-Unique: hbTccmFSO96aPW4smJW3bA-1
X-Mimecast-MFC-AGG-ID: hbTccmFSO96aPW4smJW3bA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42D691955F43;
	Mon, 20 Jan 2025 17:26:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D5E333003E7F;
	Mon, 20 Jan 2025 17:26:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250120171705.GA1159@sol.localdomain>
References: <20250120171705.GA1159@sol.localdomain> <1113699.1737376348@warthog.procyon.org.uk>
To: Eric Biggers <ebiggers@kernel.org>
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
Content-ID: <1210839.1737393988.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jan 2025 17:26:28 +0000
Message-ID: <1210840.1737393988@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Eric Biggers <ebiggers@kernel.org> wrote:

> First, I'm guessing the context here is that you're testing some (not ye=
t
> upstream) kernel patches that introduce a bug where creating these files=
 does
> not in fact fail?  That bug will need to be fixed before your patches ar=
e
> merged, of course.

Nope.  I'm using v6.13 as-is with ceph.

David


