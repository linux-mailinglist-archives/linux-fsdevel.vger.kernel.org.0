Return-Path: <linux-fsdevel+bounces-4061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930CF7FBFF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45EE1C20E5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22044645C;
	Tue, 28 Nov 2023 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAJxPhNq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBC110DF
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 09:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701191047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5xJUMRtpP0PPy0iDA3FSq+XNxMW0H+Y5iZLNztTj2pA=;
	b=VAJxPhNqJ3sgxueuiGvTUpZfhLuxQRv/FPmlTOo+0m968pGhtkRUFA2gw1iW3n3O4rc/Fw
	EcBlZhZCiqGbnEi1uNC+/WrITtTFx8LX0qZc7nTt1INhJ75IJThLlIN3NDFNHSZGaQOD1O
	eEcEmZfwv/FZz/qIK0ohwSY9Ag/wWEA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-Vroa0AwkOkCAwOb2IbE7AQ-1; Tue, 28 Nov 2023 12:03:54 -0500
X-MC-Unique: Vroa0AwkOkCAwOb2IbE7AQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5483F916D62;
	Tue, 28 Nov 2023 17:00:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.14])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0F1D11C060AE;
	Tue, 28 Nov 2023 17:00:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 28 Nov 2023 17:59:49 +0100 (CET)
Date: Tue, 28 Nov 2023 17:59:45 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <20231128165945.GD22743@redhat.com>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <20231128-arsch-halbieren-b2a95645de53@brauner>
 <20231128135258.GB22743@redhat.com>
 <20231128-elastisch-freuden-f9de91041218@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128-elastisch-freuden-f9de91041218@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 11/28, Christian Brauner wrote:
>
> Yeah, I had played with that as well. Only reason I didn't do it was to
> avoid a PF_* flag. If that's preferable it might be worth to just add
> PF_TASK_WORK and decouple this from PF_KTHREAD.

OK, I won't insist.

But,

> +       /*
> +        * By default only non-kernel threads can use task work. Kernel
> +        * threads that manage task work explicitly can add that flag in
> +        * their kthread callback.
> +        */
> +       if (!args->kthread)
> +               p->flags |= PF_TASK_WORK;

The comment and the name of the new flag look a bit misleading to me...

kthreads can use task_work's. You can create a kthread which does
task_work_run() from time to time and use task_work_add() on it,
nothing wrong with that.

Probably nobody does this right now (I didn't try to check), but please
note irq_thread()->task_work_add(on_exit_work).

Oleg.


