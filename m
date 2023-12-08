Return-Path: <linux-fsdevel+bounces-5327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7055A80A58F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 15:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13781C20BF2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 14:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B371DFF9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dG4OpHOB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4638910D8
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 05:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702043894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVS2GiFnVhk8BbnE3962ZAIxlqpLh4SepAXQYdXCDKE=;
	b=dG4OpHOBuk6qgAvuqfUjmD+xSeVlehIVxVJ+Be7uTSNpoRiXWJ8PdcBRDKytKXLi4/kHLw
	nrWJsmknx+FVyeyBlWSAYIr3o2FRXk8Qe8UwxUi7b+61GmBrpaJ5MfzGd8MfZ0SPFXvP29
	VlN+uQ+ZYilvXRkAMDCsTdrl2suojRk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-whDzf_fgMXWWbeog9d0oZg-1; Fri, 08 Dec 2023 08:58:08 -0500
X-MC-Unique: whDzf_fgMXWWbeog9d0oZg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 906F3101A551;
	Fri,  8 Dec 2023 13:58:07 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.131])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EF4B40C6EB9;
	Fri,  8 Dec 2023 13:58:05 +0000 (UTC)
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
	<87wmtog7ht.fsf@oldenburg.str.redhat.com>
	<20231208-hitzig-charmant-6bbdc427bf7e@brauner>
Date: Fri, 08 Dec 2023 14:58:03 +0100
In-Reply-To: <20231208-hitzig-charmant-6bbdc427bf7e@brauner> (Christian
	Brauner's message of "Fri, 8 Dec 2023 14:48:30 +0100")
Message-ID: <87cyvgg5jo.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

* Christian Brauner:

> On Fri, Dec 08, 2023 at 02:15:58PM +0100, Florian Weimer wrote:
>> * Christian Brauner:
>> 
>> > File descriptors are reachable for all processes/threads that share a
>> > file descriptor table. Changing that means breaking core userspace
>> > assumptions about how file descriptors work. That's not going to happen
>> > as far as I'm concerned.
>> 
>> It already has happened, though?  Threads are free to call
>> unshare(CLONE_FILES).  I'm sure that we have applications out there that
>
> If you unshare a file descriptor table it will affect all file
> descriptors of a given task. We don't allow hiding individual or ranges
> of file descriptors from close/dup. That's akin to a partially shared
> file descriptor table which is conceptually probably doable but just
> plain weird and nasty to get right imho.
>
> This really is either LSM territory to block such operations or use
> stuff like io_uring gives you.

Sorry, I misunderstood.  I'm imagining for something that doesn't share
partial tables and relies on explicit action to make available a
descriptor from a separate different table in another table, based on
some unique identifier (that is a bit more random than a file
descriptor).  So a bit similar to the the existing systemd service, but
not targeted at service restarts.

Thanks,
Florian


