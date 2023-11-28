Return-Path: <linux-fsdevel+bounces-4038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F647FBCA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 15:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2387C1C20E34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 14:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBA85ABB3;
	Tue, 28 Nov 2023 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9AKXn6o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C848D72
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 06:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701181290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6PBOG7uTuPrKERcez1Y3MMxHTda3oU4ZYJf1T2X8ASo=;
	b=M9AKXn6oN9G6Shwvb5XjvMb7Op/AXru5KurKTbGXILdIgCDTltuha/7WdLLuUZfMPMgPhW
	j5PMYywUtSuZqHSdhNiRk+5xhPyR3rH9HXdjxgLKaZzLunViWRvhNN1E5wXs+FrxWspkYp
	y7qNeKBYVaPWDBAewMmeDzWC5DjxSMo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-u32DRhyoNDeiqwLc2n0fEg-1; Tue,
 28 Nov 2023 09:21:27 -0500
X-MC-Unique: u32DRhyoNDeiqwLc2n0fEg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C48511C060D1;
	Tue, 28 Nov 2023 14:21:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.14])
	by smtp.corp.redhat.com (Postfix) with SMTP id E36FD5028;
	Tue, 28 Nov 2023 14:21:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 28 Nov 2023 15:20:21 +0100 (CET)
Date: Tue, 28 Nov 2023 15:20:18 +0100
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
Message-ID: <20231128142018.GA24108@redhat.com>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <20231128140156.GC22743@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128140156.GC22743@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 11/28, Oleg Nesterov wrote:
>
> On a related note... Neil, Al, et al, can you look at
>
> 	[PATCH 1/3] fput: don't abuse task_work_add() when possible
> 	https://lore.kernel.org/all/20150908171446.GA14589@redhat.com/

Cough... Now that I look at this 8 years old patch again I think
it is wrong, fput() can race with task_work_cancel() so it is not
safe to dereference the first pending work in theory :/

Oleg.


