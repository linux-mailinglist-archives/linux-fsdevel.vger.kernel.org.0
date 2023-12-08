Return-Path: <linux-fsdevel+bounces-5324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E1E80A589
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 15:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CA3281B4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CA31DFF7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAjJ2Zut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AE5171F
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 05:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702041367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gb0GPMiMlGSDj0aJqLOnlqDRREqBTKMhjqExl2I2m1g=;
	b=EAjJ2ZuttHegI3BzKraGZ/YBBkBhjk8bOfJ9dGXuCEIENAQI2+Wfb1k4tYhcWL2psScUeU
	XEfolaQVYL1OFHVD06dukUJ0NLKtEBCvTM/jkclPV0EvhtmcUYfcc2ogNI6i8DhWhv8X6E
	Y2e3sksqMKJI05G1u06k477pvylNTX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-S3kEsJVQOfybehL8PHBI1g-1; Fri, 08 Dec 2023 08:16:02 -0500
X-MC-Unique: S3kEsJVQOfybehL8PHBI1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7577830F20;
	Fri,  8 Dec 2023 13:16:01 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.131])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D4953C2E;
	Fri,  8 Dec 2023 13:15:59 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,  Tycho Andersen
 <tycho@tycho.pizza>,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  Jan Kara <jack@suse.cz>,
  linux-fsdevel@vger.kernel.org,  Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
References: <20231130163946.277502-1-tycho@tycho.pizza>
	<874jh3t7e9.fsf@oldenburg.str.redhat.com>
	<ZWjaSAhG9KI2i9NK@tycho.pizza>
	<a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com>
	<87ttp3rprd.fsf@oldenburg.str.redhat.com>
	<20231207-entdecken-selektiert-d5ce6dca6a80@brauner>
Date: Fri, 08 Dec 2023 14:15:58 +0100
In-Reply-To: <20231207-entdecken-selektiert-d5ce6dca6a80@brauner> (Christian
	Brauner's message of "Thu, 7 Dec 2023 23:58:53 +0100")
Message-ID: <87wmtog7ht.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

* Christian Brauner:

> File descriptors are reachable for all processes/threads that share a
> file descriptor table. Changing that means breaking core userspace
> assumptions about how file descriptors work. That's not going to happen
> as far as I'm concerned.

It already has happened, though?  Threads are free to call
unshare(CLONE_FILES).  I'm sure that we have applications out there that
expect this to work.  At this point, the question is about whether we
want to acknowledge this possibility at the libc level or not.

Thanks,
Florian


