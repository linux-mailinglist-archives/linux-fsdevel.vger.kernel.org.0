Return-Path: <linux-fsdevel+bounces-38272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673E29FE7AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 16:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA9D3A21AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 15:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DB91AAA1B;
	Mon, 30 Dec 2024 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tn6xHVZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A57382
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735573161; cv=none; b=TN33Vy3IMUrwhzXSXghppYtrnPz7WrA0BXa7xOUCjVFFspBpiXnqY7kJsip/TnCTZGT1hI02hMjjMX1zPkvo51OxHKuj6b7WlSB+Z5rGHyK0L9Xl5Ac38NO6xzRsvvcbXhavaIPK1fSNCz3Cb4zgDefNWaUlQUbo5gN7PB5ygLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735573161; c=relaxed/simple;
	bh=xtzQsm5tN7664xUi7vS936W9m94cACHyKMh4y6o22YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvEYapc2M4qVXsKVqNDU5SLApLwrHQnFxr5fybC0I8Lctj/8RJJ0nMqkjlCMq7gYviWgTMCbSNyzMxKexKdaFNHiEgZGsrw5jwSLbSLvaVQIiRFm6P4DI9yIgmVl7XI/tsWmk76uIrSOwTad0Ca4sVUgnRXlGMTDjWVaQT3zWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tn6xHVZC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735573159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xtzQsm5tN7664xUi7vS936W9m94cACHyKMh4y6o22YQ=;
	b=Tn6xHVZCh/xAO4UUKX5CjP09T1zyWrx3XAbFa73A2CbfDhXbc5qII13Fvy9BlIaIV9BBMB
	E3+YTFnwJPWt4P9NKOad/rjOBRgoSUVD1mAPh8k4dISnqzI/YE45s4UxtQ2x6/uQc+pewH
	SyvbdUSo5TcK2pO0jWPxnLYxDs/joQ0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-tN6UxOOrNZKZhrd4iX3SfA-1; Mon,
 30 Dec 2024 10:39:15 -0500
X-MC-Unique: tN6UxOOrNZKZhrd4iX3SfA-1
X-Mimecast-MFC-AGG-ID: tN6UxOOrNZKZhrd4iX3SfA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E65E919560A7;
	Mon, 30 Dec 2024 15:39:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.54])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 49B261956086;
	Mon, 30 Dec 2024 15:39:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 30 Dec 2024 16:38:49 +0100 (CET)
Date: Mon, 30 Dec 2024 16:38:45 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	WangYuli <wangyuli@uniontech.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <20241230153844.GA15134@redhat.com>
References: <20241226201158.GB11118@redhat.com>
 <1df49d97-df0e-4471-9e40-a850b758d981@colorfullife.com>
 <20241228143248.GB5302@redhat.com>
 <20241228152229.GC5302@redhat.com>
 <addb53ac-2f46-45db-83ce-c6b28e40d831@colorfullife.com>
 <20241229115741.GB27491@redhat.com>
 <ee120531-5857-4bfc-908c-8a6f1f3e7385@colorfullife.com>
 <20241229130543.GC27491@redhat.com>
 <20241229131338.GD27491@redhat.com>
 <a71a7cad-c007-45be-9fd1-22642b835edd@colorfullife.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71a7cad-c007-45be-9fd1-22642b835edd@colorfullife.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Manfred,

On 12/29, Manfred Spraul wrote:
>
> Hi Oleg,
>
> On 12/29/24 2:13 PM, Oleg Nesterov wrote:
> >Sorry for the noise...
> >
> >and currently this is fine.

Heh, please see below.

> But if we want to add the wq_has_sleeper()
> >checks into fs/pipe.c then pipe_poll() needs smp_mb() after it calls
> >poll_wait().
> >
> >Agreed?
>
> Yes, agreed.
>
> Just the comment in pipe_poll() was a bit tricky for me.

Well yes, but... It turns out I didn't grep enough.

See fs/splice.c and wakeup_pipe_readers/writers (which should use
wq_has_sleeper() for grep sake). And I don't understand why do these helpers
use key == NULL...

So it seems that pipe_poll() already needs smp_mb() to fix the current code,
at least in theory. I'll recheck and send the patch(es).

Oleg.


