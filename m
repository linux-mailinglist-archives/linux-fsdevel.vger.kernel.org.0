Return-Path: <linux-fsdevel+bounces-75703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIcIKqfNeWnEzgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 09:49:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 266D89E66B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 09:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D632300EFA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113183382D2;
	Wed, 28 Jan 2026 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikN+zYJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1130C337BBC
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590138; cv=none; b=PPsU5nkyf8ZfQt/gyXlb+7DttVAFrlDGAWwykeuNLXKACMFb68s3YQkOx24NzTKpFRj0WifMDBwmC/jRd4ETzGTDyNYpH/Z3oNoSksWEN5LzE34kLFWem5515fJM5c9G9Ph2R5YVTfhOXZoRlhUWlJfN/ciA/c/iJe9HJyZtDRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590138; c=relaxed/simple;
	bh=Z7MlY2axWxq8E3SWbd6gQj/fN3uQVFDxTaFddi0rkVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tR8uuTuzok6NtNAmYq0lRJXpg3aehXrqLy3Sp78TrQaKLFTM3GK0HtmM/54xkL47MbpZtjgYbtMBO+RDth6VlEy0glnjk/29WC3e0FAr3mJljia5jqfndQiMUccPmyR8RqURrUR00DFYnwv8347CFyKNAeEuH5Q+bhjIbLD/sBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikN+zYJO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769590136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgruSQvmurWSg0KfNFN9sWLaWLbPbPhYkfx2vIhIsKo=;
	b=ikN+zYJOO6TJJVIz9wqszEHZ/2GSRFP9H59GM0UlQGp0swd6QwJxaRgG/uh3ikPu4tnRLF
	Lw/sXRlLrG4Vu30cySyyTRFtyZLGKAypkDHLSEKeW1fGEPjEqvb/xv43cLCZCiNCQ2T5Yk
	PtV9CQnh2xEe7WS0b9iClBdySecnvvc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-nlh7bbIQMm6zovQzEo7xLw-1; Wed,
 28 Jan 2026 03:48:51 -0500
X-MC-Unique: nlh7bbIQMm6zovQzEo7xLw-1
X-Mimecast-MFC-AGG-ID: nlh7bbIQMm6zovQzEo7xLw_1769590130
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D96218002C7;
	Wed, 28 Jan 2026 08:48:49 +0000 (UTC)
Received: from fedora (unknown [10.45.224.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 78EB130001A2;
	Wed, 28 Jan 2026 08:48:45 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 28 Jan 2026 09:48:49 +0100 (CET)
Date: Wed, 28 Jan 2026 09:48:43 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: alexjlzheng@gmail.com
Cc: usamaarif642@gmail.com, david@kernel.org, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, mingo@kernel.org,
	alexjlzheng@tencent.com, ruippan@tencent.com, mjguzik@gmail.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] procfs: fix missing RCU protection when reading
 real_parent in do_task_stat()
Message-ID: <aXnNa2jymiJYjzij@redhat.com>
References: <20260128083007.3173016-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128083007.3173016-1-alexjlzheng@tencent.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux-foundation.org,oracle.com,tencent.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-75703-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 266D89E66B
X-Rspamd-Action: no action

On 01/28, alexjlzheng@gmail.com wrote:
>
> From: Jinliang Zheng <alexjlzheng@tencent.com>
>
> When reading /proc/[pid]/stat, do_task_stat() accesses task->real_parent
> without proper RCU protection, which leads:
>
>   cpu 0                               cpu 1
>   -----                               -----
>   do_task_stat
>     var = task->real_parent
>                                       release_task
>                                         call_rcu(delayed_put_task_struct)
>     task_tgid_nr_ns(var)
>       rcu_read_lock   <--- Too late to protect task->real_parent!
>       task_pid_ptr    <--- UAF!
>       rcu_read_unlock
>
> This patch use task_ppid_nr_ns() instead of task_tgid_nr_ns() to adds
> proper RCU protection for accessing task->real_parent.
>
> Fixes: 06fffb1267c9 ("do_task_stat: don't take rcu_read_lock()")
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>

Acked-by: Oleg Nesterov <oleg@redhat.com>


