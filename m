Return-Path: <linux-fsdevel+bounces-4027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E78407FBBF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 14:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A986E282ED4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 13:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B374E58AD6;
	Tue, 28 Nov 2023 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWXu+afn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C41B5
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 05:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701179651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ww4tb37z+QtlEnTPZlBwHCJJj+TrIqx4ZMKlc8ERHeA=;
	b=TWXu+afnO1uXU3HKvtpXoG43aVwrQL1XqwIm/c85bgehxYrbxwgAVmCK54USC+MHZTWMHE
	Iyx8xNMt4fA0o2XGEvq24XbFvEnRBa9RsEKiiXS/f8MAHuG0hzaWYUeVhCSUm2mEPz9Ygx
	1OOojqtgREid9+lsZUbRDtWHVQ/kJ0I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-lwrmL7D6NWaWrcZVqNIhYw-1; Tue, 28 Nov 2023 08:54:08 -0500
X-MC-Unique: lwrmL7D6NWaWrcZVqNIhYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD511811E8F;
	Tue, 28 Nov 2023 13:54:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.14])
	by smtp.corp.redhat.com (Postfix) with SMTP id A0B4E1C060AE;
	Tue, 28 Nov 2023 13:54:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 28 Nov 2023 14:53:02 +0100 (CET)
Date: Tue, 28 Nov 2023 14:52:59 +0100
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
Message-ID: <20231128135258.GB22743@redhat.com>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <20231128-arsch-halbieren-b2a95645de53@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128-arsch-halbieren-b2a95645de53@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 11/28, Christian Brauner wrote:
>
> Should be simpler if you invert the logic?
>
> COMPLETELY UNTESTED

Agreed, this looks much better to me. But perhaps we can just add the new
PF_KTHREAD_XXX flag and change fput


	--- a/fs/file_table.c
	+++ b/fs/file_table.c
	@@ -445,7 +445,8 @@ void fput(struct file *file)
		if (atomic_long_dec_and_test(&file->f_count)) {
			struct task_struct *task = current;
	 
	-		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
	+		if (likely(!in_interrupt() &&
	+		    task->flags & (PF_KTHREAD|PF_KTHREAD_XXX) != PF_KTHREAD) {
				init_task_work(&file->f_rcuhead, ____fput);
				if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))
					return;

?

Then nfsd() can simply set PF_KTHREAD_XXX. This looks even simpler to me.

Oleg.


