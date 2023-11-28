Return-Path: <linux-fsdevel+bounces-4069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 695A77FC377
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 19:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB341C20A91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E7D3D0AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCvqoP7Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89207F5
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 09:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701192671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qoYg4QwqiFnQKk6Phfk0sCXSGpCCrhqviVxw7/WZ9YY=;
	b=UCvqoP7Zx1Z+11Pnr906m+JqLdXhX7tt6bVYegooXVQ7bxEbxaSFgmJFu213RJAq+6EP+U
	zAH6JtNw0e8bTTkc5bu6b7hAwy89qeAufkQXIuWatvCZEz6ZhMGuv0zywwaUvi4gkDZReM
	N+hpXJp7fr/4pi7Gh0tLwqjVBW9gTRc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-E6YPM5haNiKDMVq8xEcWFw-1; Tue, 28 Nov 2023 12:31:08 -0500
X-MC-Unique: E6YPM5haNiKDMVq8xEcWFw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F3EE101A550;
	Tue, 28 Nov 2023 17:31:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.14])
	by smtp.corp.redhat.com (Postfix) with SMTP id 97F7EC15984;
	Tue, 28 Nov 2023 17:31:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 28 Nov 2023 18:30:02 +0100 (CET)
Date: Tue, 28 Nov 2023 18:29:59 +0100
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
Message-ID: <20231128172959.GA27265@redhat.com>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <20231128-arsch-halbieren-b2a95645de53@brauner>
 <20231128135258.GB22743@redhat.com>
 <20231128-elastisch-freuden-f9de91041218@brauner>
 <20231128165945.GD22743@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128165945.GD22743@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Forgot to menstion,

On 11/28, Oleg Nesterov wrote:
>
> but please
> note irq_thread()->task_work_add(on_exit_work).

and this means that Neil's and your more patch were wrong ;)

Oleg.


