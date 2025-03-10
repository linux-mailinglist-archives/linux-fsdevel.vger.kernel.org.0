Return-Path: <linux-fsdevel+bounces-43592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A94A5924A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 12:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE52916B861
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 11:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7909B227581;
	Mon, 10 Mar 2025 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmYZzL94"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F69F1B4138
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604999; cv=none; b=fIqZRcq7fNYJ9OaokNy62AEn1B6LYP8XqKYpJrFGWLaQLLPRg7roObO7U1gCc68stIaKVF7IIBFBKjA8i5ZtVqsJt2rfx4KkVEx4bBw6cvCFKEFFcdeIyGnjIrhgP5WwcO4msIowTttPo9UqKTRcjydeTUyRzdTbO9GsQoN0pdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604999; c=relaxed/simple;
	bh=QhZuDoyXPwU0zWzvdHsudE00w2M1x8BCuEsReSrGY+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2LX02jpQ68H3Ma9FSLS8l6FWbj5EadSwvZU6dLPu6g4WN5Vj1VWevAdYwS1DMRQD1LKuWAZ4Ctjn5f28YNfgLAowGQEX3PeaRigpRHKzA+RtMmDyLC7R3ccQJhwiUhCtDW+5WmTUZHwdNKkgxjfo2LIChPJCdH2Zt+E8O3NCgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmYZzL94; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741604997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYm99ae64FxzvhRAPoRmkCAFFzyYHIuA7FzWt/K271Y=;
	b=dmYZzL94qXbvV9aC9YbaLOJf9Zfrfo82ejDQzHCnvBZ7CwVH1KKUGZGiq3c1I3CskYA4xt
	AkuDmJTWhV9RyQuJ1zsuRk2Z+FowRh0mKmseQyCMvHV4cuApf6s/wwIQ6qu//XdmYW2KEn
	sUiIieSPQhFwaJcUT6VoU6j7IQnoecU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-Xn0HdWn6P62amKN5gjJGeQ-1; Mon,
 10 Mar 2025 07:09:52 -0400
X-MC-Unique: Xn0HdWn6P62amKN5gjJGeQ-1
X-Mimecast-MFC-AGG-ID: Xn0HdWn6P62amKN5gjJGeQ_1741604990
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F50518004A9;
	Mon, 10 Mar 2025 11:09:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.34])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B0F6B19560AB;
	Mon, 10 Mar 2025 11:09:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Mar 2025 12:09:19 +0100 (CET)
Date: Mon, 10 Mar 2025 12:09:15 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250310110914.GA26382@redhat.com>
References: <20250304050644.2983-1-hdanton@sina.com>
 <20250304102934.2999-1-hdanton@sina.com>
 <20250304233501.3019-1-hdanton@sina.com>
 <20250305045617.3038-1-hdanton@sina.com>
 <20250305224648.3058-1-hdanton@sina.com>
 <20250307060827.3083-1-hdanton@sina.com>
 <20250307104654.3100-1-hdanton@sina.com>
 <20250307112920.GB5963@redhat.com>
 <20250307235645.3117-1-hdanton@sina.com>
 <20250310104910.3232-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310104910.3232-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 03/10, Hillf Danton wrote:
>
> On Sun, 9 Mar 2025 18:02:55 +0100 Oleg Nesterov
> >
> > So (again, in this particular case) we could apply the patch below
> > on top of Linus's tree.
> >
> > So, with or without these changes, the writer should be woken up at
> > step-03 in your scenario.
> >
> Fine, before checking my scenario once more, feel free to pinpoint the
> line number where writer is woken up, with the change below applied.

    381          if (wake_writer)
==> 382                  wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
    383          if (wake_next_reader)
    384                  wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
    385          kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
    386          if (ret > 0)
    387                  file_accessed(filp);
    388          return ret;

line 382, no?

Oleg.


