Return-Path: <linux-fsdevel+bounces-38596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B92EA048AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 18:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042D2165526
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 17:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ED1199236;
	Tue,  7 Jan 2025 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDIbbyxX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B618628F
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736272622; cv=none; b=DdiXsI5jprP85E/MdSYyHyuxJ+rXwft/V1a/xcFqSppuEvDhos8J5SHF+fGGYJZXsxA3mGbXkeABUB68CpThmlwSIPMWFoRo3eA6E5wVe/Ji7XeI8jG0NtNpJbihv4orhC1i2a53/0yyEHNaDaERif7KSJR8KROILh7LLo+W7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736272622; c=relaxed/simple;
	bh=xtGznjkFjU2j2JyizdGOjY46uQbVdSii9CAm4CED3g0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=o/5k6XBsVnfu7f/I6FRe9lHY0cTagSO4SPFzzsDHHFKKv+x5ZxdbxrlNQkJBBNQRgtt930+IbPeIzhy5mkyId9+M7OWP7MB2PyqBySLl2bxC/KoS/8AXSGKuT83rVRbbU2rEjnCWHsRwh6OV9ubybAaLrEO9ie0uuRITzIKxBCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDIbbyxX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736272616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTq33EoWpM3rfkjorX4/dJHRzV36Z30CG6gKd1GBlzs=;
	b=SDIbbyxXo48vE/HwBdn6LLymqiYQyVxxOQKa/bisEoIcoec7s4CMGlgTfuECYmZW4LsQU3
	ieA1IlXQ3IU1i8JFnIvavwCgMzucAHDRslL7ftA4/rmvv0div8UQAVq2D54wXorM0coq/c
	eS4O0hdylNAVDYjOKhkQ48Wz8zV2EBU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-ZHy_XoJHObOpybr4ExFAfQ-1; Tue,
 07 Jan 2025 12:56:54 -0500
X-MC-Unique: ZHy_XoJHObOpybr4ExFAfQ-1
X-Mimecast-MFC-AGG-ID: ZHy_XoJHObOpybr4ExFAfQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0102C1955F41;
	Tue,  7 Jan 2025 17:56:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87F3A1955F43;
	Tue,  7 Jan 2025 17:56:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250107152050.GP1977892@ZenIV>
References: <20250107152050.GP1977892@ZenIV> <20250107142513.527300-1-dhowells@redhat.com> <20250107142513.527300-3-dhowells@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Christian Brauner <christian@brauner.io>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] afs: Make /afs/@cell and /afs/.@cell symlinks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <599880.1736272608.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jan 2025 17:56:48 +0000
Message-ID: <599881.1736272608@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Al Viro <viro@zeniv.linux.org.uk> wrote:

> Just allocate those child dentries and call your afs_lookup_atcell() for=
 them.
> No need to keep that mess in ->lookup() - you are keeping those suckers =
cached
> now, so...

Actually, I wonder if creating the inodes and dentries for cells and the @=
cell
symlinks at mount of the dynamic root or when the cells are created is
actually the best way.

It might be better to list all the cells and symlinks in readdir and only
create them on demand in ->lookup().  The cells are kept in their own list=
 on
the network namespace anyway, even if the dynamic root isn't mounted.

David


