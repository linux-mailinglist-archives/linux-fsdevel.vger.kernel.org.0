Return-Path: <linux-fsdevel+bounces-41315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77ACA2DEAF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 16:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C023A5423
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ACC1DF255;
	Sun,  9 Feb 2025 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efn0Mg/N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD0CF9FE
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739113680; cv=none; b=qiWYclqpszc5WyLDgKiCPMOq8e4re3L+A5H9VH5WuL/NOxUn2l4kP4JpVb2zV1yZQj2/G0gLIU1So1tujEGcOBdxbh7juKrtnlPDq+XCuxaWSW6HX9VcfytcgHaRQDd6hRO6MkU39LQBwnzaWZDjxilrIcWAkyjfSMtIrjGaxoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739113680; c=relaxed/simple;
	bh=4+A2O/9pfbjnctGO0vqQmij1ozXNtS0Yul/pRjJ5ePY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SExgEEjrDOPhvsxfhZVu9Z6pryYX80P8DujPrDmXaBlKErX/qRAybaLyba1iwRvqeOmkujdxeDgbRs4F1xS138pEbD2vzsAqN3c4FSBHITDovP8rVSUEyqDtbYrVhGXQl5XVn6/YuqGZlkPu9We7D41veadA8XRcEcFkx/TcQgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efn0Mg/N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739113677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=O0Ffvi4Q6+3S9mSE/lomeVWJWI1rx10DSFD64nNJGkc=;
	b=efn0Mg/Nj8MJ+IhgpAcrtf/imN5lYcK+Owyky24sPQ4F/EfcrnVVQbyk88uCQ/JLd/mGw0
	hVhuxZKlbMHbMOWc0YdC5Ou2wvuF4XKMiv6D8SZXQRM80wektNwowKl4SCE7rTozxWpL6T
	+HLUVxSN1yW3Wc3i8T6j5Ryh3c6QfXY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627--jdJel4_Nry6XSU9oliY5w-1; Sun,
 09 Feb 2025 10:07:53 -0500
X-MC-Unique: -jdJel4_Nry6XSU9oliY5w-1
X-Mimecast-MFC-AGG-ID: -jdJel4_Nry6XSU9oliY5w
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B98101955DDD;
	Sun,  9 Feb 2025 15:07:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8FC0E180035E;
	Sun,  9 Feb 2025 15:07:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  9 Feb 2025 16:07:24 +0100 (CET)
Date: Sun, 9 Feb 2025 16:07:18 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Oliver Sang <oliver.sang@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] pipe: change pipe_write() to never add a zero-sized
 buffer
Message-ID: <20250209150718.GA17013@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Please review.

pipe_write() can insert the empty buffer and this looks very confusing
to me. Because it looks obviously unnecessary and complicates the code.

In fact this logic doesn't even look strictly correct. For example,
eat_empty_buffer() simply updates pipe->tail but (unlike pipe_read) it
doesn't wake the writers.

But is pipe_write() is the only possible source of buf->len == 0 ?
I am not 100% sure, fs/splice.c is very nontrivial, but it seems that
this code at least tries to not add a zero-sized buf into pipe->bufs.

Oleg.
---

 fs/pipe.c                 | 47 ++++++++++-------------------------------------
 fs/splice.c               | 14 ++++++--------
 include/linux/pipe_fs_i.h |  6 ++++++
 3 files changed, 22 insertions(+), 45 deletions(-)


