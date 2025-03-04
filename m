Return-Path: <linux-fsdevel+bounces-43193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD45AA4F1CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 00:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82FA87A3340
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 23:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE36327C14C;
	Tue,  4 Mar 2025 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RouAyXT2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BFE1EBA1C
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132193; cv=none; b=lPOJ1miB22Veo/DIstfBK69yCarKeUiv29F9sFTlVEtl4NqKPFZvzr2/5KUO98OtDyhZgiwRxZSsi/z0IGtu2iL7AfGsej79ZHpJQto+WFDneF2+uvwHovEb8LwdozVvif2Zcebmn7kVYdac5vpoiSPyd/vjdJ1hoRhbXvh4IZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132193; c=relaxed/simple;
	bh=iEtB+gCyt8I6YiLzpl4Y3N3BrPvrl3nxkNTaQR2VtHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTK/VomhB91QkWLvygzmzg8xJNDZEM8rj/x1xdcWMrDXmbeSg5ct+taVScnDMgW4ozAZJq2DJv+ajcDHO5FU4IdVSD9I415Ah4i0FIjBzShlRFJfmDLCaZQKaFfXnTF9xNSsJ6z6gbVuOx2/o/hbO+MHsg1wQyYghErq16GHg1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RouAyXT2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741132190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zsLjsgiwz48CWElDV+44qdETBMYv+pYUPW3rLAb2CoA=;
	b=RouAyXT2h/oZq52eIPQGFNReaVTg338reQenbj/2eHfTuet3ggtYFu4NR4qtciFIU36Nom
	fY62J8H/kznv5svWAleQdVjDpPYMjOwqtJ4Zw2Kv2M+NxzshmwMw0AuXyOcVC3BDu9eW0+
	uqSwRfhFSLh1WVelonZbJR5KQvNVwgY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-85hpojrxOUGcCCaFuSHlqQ-1; Tue,
 04 Mar 2025 18:49:45 -0500
X-MC-Unique: 85hpojrxOUGcCCaFuSHlqQ-1
X-Mimecast-MFC-AGG-ID: 85hpojrxOUGcCCaFuSHlqQ_1741132184
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A4071800872;
	Tue,  4 Mar 2025 23:49:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.41])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 35DDE180035F;
	Tue,  4 Mar 2025 23:49:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Mar 2025 00:49:13 +0100 (CET)
Date: Wed, 5 Mar 2025 00:49:09 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250304234908.GH5756@redhat.com>
References: <20250224142329.GA19016@redhat.com>
 <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
 <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
 <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com>
 <20250304050644.2983-1-hdanton@sina.com>
 <20250304102934.2999-1-hdanton@sina.com>
 <20250304233501.3019-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304233501.3019-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/05, Hillf Danton wrote:
>
> On Tue, 4 Mar 2025 13:34:57 +0100 Oleg Nesterov <oleg@redhat.com>
> > > >
> > > Note wakeup can occur even if pipe is full,
> >
> > Perhaps I misunderstood you, but I don't think pipe_read() can ever do
> > wake_up(pipe->wr_wait) if pipe is full...
> >
> > > 		 * So we still need to wake up any pending writers in the
> > > 		 * _very_ unlikely case that the pipe was full, but we got
> > > 		 * no data.
> > > 		 */
> >
> > Only if wake_writer is true,
> >
> > 		if (unlikely(wake_writer))
> > 			wake_up_interruptible_sync_poll(...);
> >
> > and in this case the pipe is no longer full. A zero-sized buffer was
> > removed.
> >
> > Of course this pipe can be full again when the woken writer checks the
> > condition, but this is another story. And in this case, with your
> > proposed change, the woken writer will take pipe->mutex for no reason.
> >
> See the following sequence,
>
> 	1) waker makes full false
> 	2) waker makes full true
> 	3) waiter checks full
> 	4) waker makes full false

I don't really understand this sequence, but

> waiter has no real idea of full without lock held, perhaps regardless
> the code cut below.

Of course! Again, whatever the woken writer checks in pipe_writable()
lockless, another writer can make pipe_full() true again.

But why do we care? Why do you think that the change you propose makes
more sense than the fix from Prateek or the (already merged) Linus's fix?

Oleg.


