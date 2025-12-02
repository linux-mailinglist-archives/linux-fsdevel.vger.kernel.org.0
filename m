Return-Path: <linux-fsdevel+bounces-70437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFE0C9A668
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 08:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C9A3A5C55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 07:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AE22FF176;
	Tue,  2 Dec 2025 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8jrErAc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3550B220F2A
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764659740; cv=none; b=hIGRC7bxU6PwGf0yWLkf63mwe1cjlhqFBvNEN/PDk35MQ6kL017MPjfIYINayOVTvX763ebkZKsKtfXcmXbZPufxCpqdC/eY92t0l7Oe/0EDxNJVtiASyFqRzLPftuP8L+FBiY8EKHqdr6Ecqud4dTf+MwTZqPTeyS16pE+CpUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764659740; c=relaxed/simple;
	bh=pHumqMXjkE+Vj64y57/9pD4S38sJnHL2whNM0VtC9sU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=UUXwo4bTgBF70GjquFDGPMD51H73pDdF/YfcxKiagbKmrOLKVu4ypYzuXk/eKjPgSFcgZh/y7HLeu9wF9PpLQvaoEyDdByfFXyU6xGaVPZAQoCg2vG2ZL55aAhuV+vYFbUjaNMz0QaiO0xp6qBTK6aDNa8+qS96BssXknQBhRfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8jrErAc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764659738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8CWvvfM17/Cvz924l3G7RhGFfI+KD2myRsJZPyFxwIc=;
	b=N8jrErAcCLKnMqN5hrGSpjx0IYPc38jLxQ4UeqYrRJCUTEsVXUUw/EpF/8wCVk+kK4bJsX
	Pd+4UgKDVs5fgYRiCgHoZREV46XRi8C5QRO//+9jayNo4NksNni8Fq2rl6jFmJfwwMiBAg
	rCBvnaQbJQPUTwo/UjCf0lRQXFrUfa0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-pxQjchumNKCbcJFjvx5VmA-1; Tue,
 02 Dec 2025 02:15:34 -0500
X-MC-Unique: pxQjchumNKCbcJFjvx5VmA-1
X-Mimecast-MFC-AGG-ID: pxQjchumNKCbcJFjvx5VmA_1764659733
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9A35195608E;
	Tue,  2 Dec 2025 07:15:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D318180047F;
	Tue,  2 Dec 2025 07:15:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5mspiEXcA2pxTfQrWrpZDLEW5YjFJCn0An4OcpEtkJ+B2A@mail.gmail.com>
References: <CAH2r5mspiEXcA2pxTfQrWrpZDLEW5YjFJCn0An4OcpEtkJ+B2A@mail.gmail.com> <20251201225732.1520128-1-dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.org>,
    Shyam Prasad N <sprasad@microsoft.com>,
    Stefan Metzmacher <metze@samba.org>, Tom Talpey <tom@talpey.com>,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] cifs: Miscellaneous prep patches for rewrite of I/O layer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1530644.1764659728.1@warthog.procyon.org.uk>
Date: Tue, 02 Dec 2025 07:15:28 +0000
Message-ID: <1530645.1764659728@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Steve French <smfrench@gmail.com> wrote:

> The first seven (of the nine you sent recently) applied ok to
> ksmbd-for-next and I can do some testing on them, as we await more
> review and testing of the patches but patch 8 caused a few checkpatch
> warnings (and patch 9 depends on it).  Do you want to clean it up?
>
> 
> ./scripts/checkpatch.pl 9/0008-cifs-Add-a-tracepoint-to-log-EIO-errors.patch
> ERROR: trailing whitespace
> #440: FILE: fs/smb/client/cifssmb.c:1379:
> +^Idefault: $

I can clean this one up.

> ERROR: Macros with complex values should be enclosed in parentheses
> #2069: FILE: fs/smb/client/trace.h:23:
> +#define smb_eio_traces \
> + EM(smb_eio_trace_compress_copy, "compress_copy") \
> + EM(smb_eio_trace_copychunk_inv_rsp, "copychunk_inv_rsp") \
> ...

In this case, checkpatch is wrong.  This cannot be enclosed in parentheses as
it will then fail to compile as this is used to generate an enum.  If you
compare it to other trace headers (including your own trace.h, you'll see this
sort of construct in a number of places).

David


