Return-Path: <linux-fsdevel+bounces-41337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CD6A2E02D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 20:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F4031164D17
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 19:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34781E1A3F;
	Sun,  9 Feb 2025 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCd0iP3b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C3370807
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739128555; cv=none; b=bxKq5wtWBTKz/efdH7dWP3mt+AeKoGJ8zwtDJSkGvsH0y3gJeopuCc5zxfFcJrVCwF1LuSH+xYsacOB3bZNXt97JHRLZgFHUfdSvBU/XLQBTca3CC3ZNLCejvZNZUrB88POjEQHVQ2ivMeVZ7s7ABnsk+IeZJB2b+U/E2fPa74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739128555; c=relaxed/simple;
	bh=sNIqBwASHZS6f8Tct2wIuBKd1+bQdUMIFK+Uqg8rsxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPZISElkuYJITV19hyvhk5yMaGtWL43iu/KxXMqdCNf+CfopyHsMbYce8BjMk4wRZbLv313bhOUadN1cI7iWrRYzJth2gyKVvh3x2jXnM5fK/RUeFadpeIjz1i6I77q5PKJ+Sb0v4cyXH1fO+M9TKYuUOnnYXExExO2K12hXBjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCd0iP3b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739128552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bzx0E/Qg3IYe3K4apwPHQsXCz/GYdO9gQu3c3MuxtD0=;
	b=GCd0iP3buWBxwHyyFyk1B0B2wxODuWxjv/TCKGgpXU+6KTMQ225VtBffG5t/LgP7J0lGde
	RK8Gn58CAh4FduQ87YeWyT4G/cVJNprbJF5v2PDosJaRB2O73FxHkQTSWTaVHHqczo45Ub
	awOr9ff0lXuUdZuL1Ym4XX+OHGKBG1o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-VDxynddGMVecglnoLUczKQ-1; Sun,
 09 Feb 2025 14:15:49 -0500
X-MC-Unique: VDxynddGMVecglnoLUczKQ-1
X-Mimecast-MFC-AGG-ID: VDxynddGMVecglnoLUczKQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A79261800872;
	Sun,  9 Feb 2025 19:15:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.8])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8D17A19560A3;
	Sun,  9 Feb 2025 19:15:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  9 Feb 2025 20:15:17 +0100 (CET)
Date: Sun, 9 Feb 2025 20:15:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	David Howells <dhowells@redhat.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Oliver Sang <oliver.sang@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pipe: change pipe_write() to never add a zero-sized
 buffer
Message-ID: <20250209191510.GB27435@redhat.com>
References: <20250209150718.GA17013@redhat.com>
 <20250209150749.GA16999@redhat.com>
 <CAHk-=wgYC-iAp4dw_wN3DBWUB=NzkjT42Dpr46efpKBuF4Nxkg@mail.gmail.com>
 <20250209180214.GA23386@redhat.com>
 <CAHk-=whirZek1fZQ_gYGHZU71+UKDMa_MYWB5RzhP_owcjAopw@mail.gmail.com>
 <20250209184427.GA27435@redhat.com>
 <CAHk-=wihBAcJLiC9dxj1M8AKHpdvrRneNk3=s-Rt-Hv5ikqo4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wihBAcJLiC9dxj1M8AKHpdvrRneNk3=s-Rt-Hv5ikqo4g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 02/09, Linus Torvalds wrote:
>
> On Sun, 9 Feb 2025 at 10:45, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Again, lets look eat_empty_buffer().
> >
> > The comment says "maybe it's empty" but how/why can this happen ?
>
> WHY DO YOU CARE?

Because it looks unclear/confusing, and I think it can confuse other
readers of this code. Especially after 1/2.

> So here's the deal: either you
...
>  (b) you DON'T convince yourself that that is true, and you leave
> eat_empty_buffer() alone.

Yes, I failed to convince myself that fs/splice.c can never add an
empty bufer. Although it seems to me it should not.

> In contrast, the "eat_empty_buffer()" case just saying "if it's an
> empty buffer, it doesn't satisfy my needs, so I'll just release the
> empty buffer and go on".

... without wakeup_pipe_writers().

OK, nevermind, I see your point even if I do not 100% agree.

I'll send v2 without WARN_ON() and without 2/2.

Oleg.


