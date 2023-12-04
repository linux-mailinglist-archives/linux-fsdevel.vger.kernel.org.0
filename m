Return-Path: <linux-fsdevel+bounces-4785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1CC803A80
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 17:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA601C20A63
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1A02E635
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOnVWrYR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1381B0
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 08:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701706442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+iDr/P+1Bne1w6lrvRu/pfnDeZlU730URyMsIIhmOk=;
	b=SOnVWrYR90gEy9Vxir/0ydlZ2IGWz6vJFXhsnevGjBv5z48tWJMCzAUNbq1L76yXe4STXo
	VLGsFdg47rbHJQldFhLHYaODMHtA6Z62KJii9i8YsJamxlCVHct0inJwXqMdejZe5mzCop
	kZcoZduCOu6h2SDuyxtnLicQiUuC7DM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-fxN3OT9QPt-YonZ6_cEPwg-1; Mon, 04 Dec 2023 11:13:57 -0500
X-MC-Unique: fxN3OT9QPt-YonZ6_cEPwg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B23EE8007B3;
	Mon,  4 Dec 2023 16:13:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.82])
	by smtp.corp.redhat.com (Postfix) with SMTP id CE6D22166B26;
	Mon,  4 Dec 2023 16:13:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  4 Dec 2023 17:12:49 +0100 (CET)
Date: Mon, 4 Dec 2023 17:12:45 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neilb@suse.de>, Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Message-ID: <20231204161245.GA31326@redhat.com>
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
 <20231204024031.GV38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204024031.GV38156@ZenIV>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

I am sick and can't read emails, just one note

On 12/04, Al Viro wrote:
>
> Just have the kernel threads born with ->task_works set to &work_exited

Then irq_thread()->task_work_add() will silently fail,

> and provide a primitive that would flip it from that to NULL.

OK, so this change should update irq_thread(). But what else can fail?

And what if another kthread uses task_work_add(current) to add the
desctructor and does fput() without task_work_run() ?

Oleg.


