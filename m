Return-Path: <linux-fsdevel+bounces-30497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3139998BCDD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 14:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6317E1C2352C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 12:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325E81C331E;
	Tue,  1 Oct 2024 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKqIfl9C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C2C1A0733
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787260; cv=none; b=teJDHczLf7xEUdaY+HB9WbW3zcfzNTrLxGy1HMEdbgh55/nCaSppgGTtTaVqy/3yBxA8V8lQbdwU1ayF0P33iw63AIeZ5nBU8IeLKySSmJlj2tkz6T/mMkWUBfBp/a9M+Ob6JbOwRuiM+Bp8h2njDWL7c3A5+X7Afw9AMhiwOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787260; c=relaxed/simple;
	bh=SlgkcT3VIvsR9xt5rJ/ZZZ2NrD2d4Bg54ZZmbv8EgXY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Ba1ahWQZfQIr0CD65IGEhHRksEDmbMZme+XVm0H5+/pvslaPSKUzdnRMXhu+SNkePS5L7jVc/7piDs3w5EiLaBZFBEqCZYCWokesludwmZ9FWdHeZ7aQTtY4Yp3QNmV9YEmBXcT5M9JTotJTNaWji6wHG6rNyHtcsjCWAacApfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKqIfl9C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727787258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlgkcT3VIvsR9xt5rJ/ZZZ2NrD2d4Bg54ZZmbv8EgXY=;
	b=GKqIfl9CZYH9TsgK5e/YfkmEUjQ7PrzmKweMnVPjSF9HfGZISQcm6rm3kNKcSUjBpEqmtY
	tsCp7WshtE4/TnkYtnI59l/9W5/N54MZ/aFWx2+Sv2fNf8lVtuBS+DEdpolbXjbGOZfRcM
	RtZUP16dQkFFtCK1T+ZiBtxPancIkR0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-52vA4fYgNJig4i_2LyBlIQ-1; Tue,
 01 Oct 2024 08:54:15 -0400
X-MC-Unique: 52vA4fYgNJig4i_2LyBlIQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E563A19626FC;
	Tue,  1 Oct 2024 12:54:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 01371195605A;
	Tue,  1 Oct 2024 12:54:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZvuXWC2bYpvQsWgS@gmail.com>
References: <ZvuXWC2bYpvQsWgS@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Chang Yu <marcus.yu.56@gmail.com>,
    jlayton@kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    skhan@linuxfoundation.org
Subject: Re: [PATCH v2] netfs: Fix a KMSAN uninit-value error in netfs_clear_buffer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3115999.1727787250.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Oct 2024 13:54:10 +0100
Message-ID: <3116000.1727787250@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Chang Yu <marcus.yu.56@gmail.com> wrote:

> Use folioq_count instead of folioq_nr_slots to fix a KMSAN uninit-value
> error in netfs_clear_buffer
> =

> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> Reported-by: syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D921873345a95f4dae7e9
> Fixes: cd0277ed0c18 ("netfs: Use new folio_queue data type and iterator =
instead of xarray iter")

Acked-by: David Howells <dhowells@redhat.com>

Christian: Can you pick this up?


