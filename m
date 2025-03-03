Return-Path: <linux-fsdevel+bounces-43004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB682A4CCBF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 21:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738B63AD401
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 20:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2F6235C1D;
	Mon,  3 Mar 2025 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLndGvg0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B01EDA3E
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033702; cv=none; b=a7G+YIm7oJKYCwlHe+ZTaid4ssTi+DgEs6BpCm24KR6pv5Fk4/ifhdxj2Q8L+vGemUAoqyJ9Xyw6TFE9vvKZ8reP5l2sPR7P6d7EnGHt1jc3T9ga4zNB3iGSzqMJJurq2hpTjPcV5HtfsyUC2WuwL4VDb3ZdwqL9q9uRB1uuvRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033702; c=relaxed/simple;
	bh=3iAmAP1+Co3YdANb3loBtNpe8XoxQdbND6uSpjvFA1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NM2ze/HfXGOgM0mA0PqoBD6GXWqilOuHbNeVFQilgip9D55Za39HOc+N6j/DtEjP5zO18KiuLJaRMWYxvKJC7RViXMCZ2rypilsR+pI4w3wdH4c87gXid4tLPCbMKot3VxBExkKgRR6Ro27+c3BIXRCwyBNVRrag+MovwLd+KS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLndGvg0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741033699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnnESx01LRBIfqKJRPPRwpcG2n3krda1DS4FSCNKp90=;
	b=CLndGvg0gCltHIK0huuz6IWCW3U1Pxgu7IM/9CQH0onn3KV6/uq1oS9U/cKk90hn3+7nU+
	U5CdwBNwWDimw+puZ2XX3AqkK9XLtj83GrOCs5JA9RCuDp+zDWeXlEpG1mhDHX/XNQAnUY
	4kdARHlH065GDLGC3hKfOuNK3pATNd8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-REhW-CMjOQaOo7peCJJPNA-1; Mon,
 03 Mar 2025 15:28:14 -0500
X-MC-Unique: REhW-CMjOQaOo7peCJJPNA-1
X-Mimecast-MFC-AGG-ID: REhW-CMjOQaOo7peCJJPNA_1741033693
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6778D180087B;
	Mon,  3 Mar 2025 20:28:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9E16F3000197;
	Mon,  3 Mar 2025 20:28:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  3 Mar 2025 21:27:41 +0100 (CET)
Date: Mon, 3 Mar 2025 21:27:36 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250303202735.GD9870@redhat.com>
References: <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com>
 <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
 <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com>
 <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 03/03, Linus Torvalds wrote:
>
> There's currently a fair number of open-coded assignments:
>
>     git grep -E 'pipe->((tail)|(head)).*=' fs/
>
> and some of those are under specific locking rules together with other
> updates (ie the watch-queue 'note_loss' thing.

Stupid question... but do we really need to change the code which update
tail/head if we pack them into a single word?

I mean,

	-	unsigned int head;
	-	unsigned int tail;
	+	union {
	+		struct {
	+			u16 head, tail;
	+		}
	+
	+		__u32   head_tail;
	+	}

Now pipe_writebale() can read do READ_ONCE(pipe->head_tail) "atomically"
without preemption and this is all we need, no?

Yes, pipe_writable() should take endianess into account, but this is
simple...

Oleg


