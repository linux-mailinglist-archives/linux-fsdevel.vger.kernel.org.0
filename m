Return-Path: <linux-fsdevel+bounces-4029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FCF7FBC1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 15:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD4D1F20FD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 14:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4DF59B7E;
	Tue, 28 Nov 2023 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBti74QD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B29BB5
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 06:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701180199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6b4zlJ+NQVyh7nGzEMDX1ZgHvtc06NNFgRYvyVDhSc=;
	b=GBti74QDCFvTfxyj7iVf/cnH84n2MjbDN5/Fyb9VwojuaLCgoRMjS4FiV8vUwtaRWUmCA4
	atiW9fQ4YOb1QK705YYILnJVeByMsYoiUee/oTdl2mcvV0ZiP1CFEvyCCw8zZj+y4qNCbw
	J2JYL9mZMpZn+gixBTqY1/kmsQL3jIg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-xxJ-ZggePqKq7XGAgfcdJA-1; Tue, 28 Nov 2023 09:03:16 -0500
X-MC-Unique: xxJ-ZggePqKq7XGAgfcdJA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01D35101A529;
	Tue, 28 Nov 2023 14:03:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.14])
	by smtp.corp.redhat.com (Postfix) with SMTP id E0CEB492BE7;
	Tue, 28 Nov 2023 14:03:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 28 Nov 2023 15:02:01 +0100 (CET)
Date: Tue, 28 Nov 2023 15:01:57 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <20231128140156.GC22743@redhat.com>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 11/28, NeilBrown wrote:
>
> I have evidence from a customer site of 256 nfsd threads adding files to
> delayed_fput_lists nearly twice as fast they are retired by a single
> work-queue thread running delayed_fput().  As you might imagine this
> does not end well (20 million files in the queue at the time a snapshot
> was taken for analysis).

On a related note... Neil, Al, et al, can you look at

	[PATCH 1/3] fput: don't abuse task_work_add() when possible
	https://lore.kernel.org/all/20150908171446.GA14589@redhat.com/

(please ignore 3/3).

Oleg.


