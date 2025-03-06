Return-Path: <linux-fsdevel+bounces-43328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F7BA5465D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 10:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B5317277D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A0A20969B;
	Thu,  6 Mar 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjhE+cQf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6C1917D0
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253468; cv=none; b=kkR1BCMricsS3Rr5hniWtHC5B6LFu88rrGxsc8tVQO8zdan3tn1+jFi/CKFJhoOy8u8/vPLngRaETZ0vMXtKLfrG/bVyChGGCDiXgyFyEp5h4rkJVE9TQSGJXUB1+GCWpBNFpGIJrbMaD8l55dDxofBFl9wbUVoSQDHu6FOwnB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253468; c=relaxed/simple;
	bh=7AWyzaoRNX7pBPmkkgAhqvWqkw5zPYUp7ZguMwwhrpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKKNnzJ34mbYKKX4VJlyruZF9HI5d2gDtN0/ywUDly3Hk4EK4S4FIZYZH+F974Yoi5cPZDFZ2hLCKO7JMr6xovgbe+L0Mq+w+P4utQK+XSMcUMjQlQjjemdvSjkyG1J6cEqNAn/yNUcNFcBEgOesJxkEIEWauLycCi6WH3AB9qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VjhE+cQf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741253465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1b3+ZzLyvyNemOvRu/XqHRTaVSt8GcD6sOCsL+LMgwo=;
	b=VjhE+cQfm2nKTYege1s76lfXbnSJPbpc/fnZjCdx6NkUKz+XGzSmFkGn8LgNsmNaiD4/Oe
	KbpsSY3w/LmP06KbbXnmSb/uRCwTuRni0m1VVxEOF/Wmx4Gc63BrN4n+KPj/01Etz98R26
	iqGp7MziZ4/8k8Gxaj0jyXqwIoqJBSE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36--3E89iakONiQoo4YS72d3g-1; Thu,
 06 Mar 2025 04:30:58 -0500
X-MC-Unique: -3E89iakONiQoo4YS72d3g-1
X-Mimecast-MFC-AGG-ID: -3E89iakONiQoo4YS72d3g_1741253456
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D5B3180025A;
	Thu,  6 Mar 2025 09:30:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.240])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8AF9518009BC;
	Thu,  6 Mar 2025 09:30:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  6 Mar 2025 10:30:25 +0100 (CET)
Date: Thu, 6 Mar 2025 10:30:21 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250306093021.GA19868@redhat.com>
References: <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
 <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
 <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com>
 <20250304050644.2983-1-hdanton@sina.com>
 <20250304102934.2999-1-hdanton@sina.com>
 <20250304233501.3019-1-hdanton@sina.com>
 <20250305045617.3038-1-hdanton@sina.com>
 <20250305224648.3058-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305224648.3058-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/06, Hillf Danton wrote:
>
> On Wed, 5 Mar 2025 12:44:34 +0100 Oleg Nesterov <oleg@redhat.com>
> > On 03/05, Hillf Danton wrote:
> > > See the loop in  ___wait_event(),
> > >
> > > 	for (;;) {
> > > 		prepare_to_wait_event();
> > >
> > > 		// flip
> > > 		if (condition)
> > > 			break;
> > >
> > > 		schedule();
> > > 	}
> > >
> > > After wakeup, waiter will sleep again if condition flips false on the waker
> > > side before waiter checks condition, even if condition is atomic, no?
> >
> > Yes, but in this case pipe_full() == true is correct, this writer can
> > safely sleep.
> >
> No, because no reader is woken up before sleep to make pipe not full.

Why the reader should be woken before this writer sleeps? Why the reader
should be woken at all in this case (when pipe is full again) ?

We certainly can't understand each other.

Could your picture the exact scenario/sequence which can hang?

Oleg.


