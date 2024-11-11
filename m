Return-Path: <linux-fsdevel+bounces-34266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A23F9C42D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 17:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E0F2815CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837941A070E;
	Mon, 11 Nov 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8h5Je2m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A93189BBF
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343383; cv=none; b=fZiF9570Hc6eIG+xrfpnGUs6K/fTUJJJ+bs+J93IwtlCP6EnyzHtUr1T8DA3n0cygJZ5w4v0+xB4BEkHpEBlkjxw7vHCxrmcZoEVcrnbznEkOuPvd43aTsziNfQAf/fLDnY4lrhVG48B0LWj1lq1yeQ+Z66kR47KgqtWhdl7BuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343383; c=relaxed/simple;
	bh=F9psZ+V9YWhCHcqilkljM+dULNGGix+NUkI+YbY3QdQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=WYhcD6WTvjLXjLXRtr6GenBpbqMC/RGJkB2WZ6Gf9qd7QxrudTozafJgVIUdqqxIL+KFTLDJWo5Zv3oxLSGpjQoW1Lk4vY8tpXbjkveUIvOL8EnqiE+78yreKUy3gFoFtSWWIZtAn7QxAuxTuoI0i/LxnbA/QetXmTj0WvOPOTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8h5Je2m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731343380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOlFnv4MGaRQ26f5MutyiWNgN0xOvPFay9zoQV8RqbE=;
	b=c8h5Je2mqfxTsr7sb7ILkNIZWh3dgvejQaTEmpQesshxHrGnPjCrIQt4UVBWtlBKdhAZXN
	irozmwstaczKx1FkEB2gnnTAL01KG2FeZ9MsTAmOQl58ifGJqpTOMrrLnPiUhhHvEWI2wc
	sx3TdCMU9wU0bswe+UQj32Rei25QDcY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-sQCJ7bNCP52rdYrP406xKg-1; Mon,
 11 Nov 2024 11:42:58 -0500
X-MC-Unique: sQCJ7bNCP52rdYrP406xKg-1
X-Mimecast-MFC-AGG-ID: sQCJ7bNCP52rdYrP406xKg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 084C1197731B;
	Mon, 11 Nov 2024 16:42:56 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.81.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58C611956054;
	Mon, 11 Nov 2024 16:42:52 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: bcrl@kvack.org,  brauner@kernel.org,  jack@suse.cz,
  linux-aio@kvack.org,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  viro@zeniv.linux.org.uk,
  willy@infradead.org
Subject: Re: [PATCH] fs: aio: Transition from Linked List to Hash Table for
 Active Request Management in AIO
References: <x491pzwtogw.fsf@segfault.usersys.redhat.com>
	<20241106110120.11093-1-pvmohammedanees2003@gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Mon, 11 Nov 2024 11:42:50 -0500
In-Reply-To: <20241106110120.11093-1-pvmohammedanees2003@gmail.com> (Mohammed
	Anees's message of "Wed, 6 Nov 2024 16:31:20 +0530")
Message-ID: <x49ed3hrab9.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Mohammed Anees <pvmohammedanees2003@gmail.com> writes:

>> ... and cancelation is only supported by usb gadgetfs.  I'd say submit a
>> patch that gets rid of that todo so nobody else wastes time on it.
>
> Absolutely I'll do just that, do you want me to make it a V2
> or shall send it as a new patch.

A new patch would make more sense.

Thanks!
Jeff


