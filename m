Return-Path: <linux-fsdevel+bounces-44839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E9DA6D0E2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 20:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C16316DA9A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 19:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8847F19C569;
	Sun, 23 Mar 2025 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KA7UFNDy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A54BF507
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Mar 2025 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742759269; cv=none; b=oqhAUkmo31xv7/UCTj3cpKtKmk1aK8KHLq6jZCl76X1v6ui+5T2rMWCHfQlBjgaH+D0WpZVIwXQ/06x9kxi4JNVvssT+TfoKL8/UC5Foics1/z8PSuDjH8SMVeD/zylyUIIYFKFAbns1YrM8iQBGmp0ItsokQL/DgM0RPVO4QHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742759269; c=relaxed/simple;
	bh=iUR3681lmcQ8e6lNQBa94X6U9ui9TWzgm3USzDftaHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8HGsJAIwP4PzQVaQyg+T+BRpUtzKALE086hPaCofAjkFMIJdybfxyvmBKKpvJCFDg/5XPyCoMp/dkEaZq3m8dB6l7M9EIO5MPlsKFS18zt8FIp9x4/diHFm20flEx8pquuJ9uGgHM3eRMAuU5gNWbAj3qZoHIF91OO40n4LO0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KA7UFNDy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742759266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iUR3681lmcQ8e6lNQBa94X6U9ui9TWzgm3USzDftaHU=;
	b=KA7UFNDylyslgnq0aEs3TTCnJJSrXY72AkV+plL/VHdMux8MlL9UkIq23AGBFOgUTQg1+k
	GZQSQwAg6ewC/GSneZfinziX/E7k/nEt0s/V43TojzDyIv5fC89SfEuO4wyJ9ryETY4hVL
	360+2WmSaap4HQ/RWRf/B9nirVwND6g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-MbqQq6QfOPCwiRx3qmyF7g-1; Sun,
 23 Mar 2025 15:47:43 -0400
X-MC-Unique: MbqQq6QfOPCwiRx3qmyF7g-1
X-Mimecast-MFC-AGG-ID: MbqQq6QfOPCwiRx3qmyF7g_1742759261
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EB56196D2CC;
	Sun, 23 Mar 2025 19:47:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2FC6F30001A1;
	Sun, 23 Mar 2025 19:47:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 23 Mar 2025 20:47:08 +0100 (CET)
Date: Sun, 23 Mar 2025 20:47:02 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, dhowells@redhat.com, jack@suse.cz,
	jlayton@kernel.org, kprateek.nayak@amd.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	mjguzik@gmail.com, netfs@lists.linux.dev, swapnil.sapkal@amd.com,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250323194701.GC14883@redhat.com>
References: <20250323184848.GB14883@redhat.com>
 <67e05e30.050a0220.21942d.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e05e30.050a0220.21942d.0003.GAE@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 03/23, syzbot wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> INFO: task hung in netfs_unbuffered_write_iter

OK, as expected.

Dear syzbot, thank you.

So far I think this is another problem revealed by aaec5a95d59615523db03dd5
("pipe_read: don't wake up the writer if the pipe is still full").

I am going to forget about this report for now and return to it later, when
all the pending pipe-related changes in vfs.git are merged.

Oleg.


