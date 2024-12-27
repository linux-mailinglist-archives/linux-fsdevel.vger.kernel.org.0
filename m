Return-Path: <linux-fsdevel+bounces-38164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 922AE9FD5BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 16:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322E51651C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28801F7094;
	Fri, 27 Dec 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6+Hjgig"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A14412FB1B
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735314904; cv=none; b=XrWIfKaB8kSIoSYhpw90QTe1uLN/6GVvmZpFXVn5WJSnqICCAqKED64BoFmv9u9WuUZScR03khIzZ1eH/POeVbLUUQeoO/6RVVRul+4jFGAcTX1VoZ8X+t3kuGJjtpK13Etgz5v0u559Y7UMu1qrwU9U6poGJmSf79mcLw66SZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735314904; c=relaxed/simple;
	bh=HnKiEwm2THC3dybJ3DMwhpRF0xhDOToiw8YqPmch4jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y35MIQy62D/DheAqKpRcX3IhDWKwB+xQ6RO0MRDAJkYTQCIPfSF8PNtzE0fTRxgK3N5v2NjacEW3KkmJGN5mW+GbUzbdcuvuBJwc8vR1a7HovaxwrwQR+QA3LkGs8hnMWVeQBpruqXX9n2ZoraGXCG2BWv5WtaHvC9IXzLiCqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6+Hjgig; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735314901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XtsRlXvexnQ2mwHiMNXBb80D5vWX4b75zLU2RpTUBs0=;
	b=V6+HjgigHe1p2zmr/nHd49zBluJ34N853Q57JanfPPxPLAiLbi8jG/fvAucds/JhMymYPY
	cJun8/rwO4na0VQSY9tlezOC/YZrS7JVtsSxXaC03Ki0SrMwCFVY/oJ7YHk6qGx1XUO1gH
	DefkjyCToUgcA2jeRn7xLk3JENS8V58=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-njBQ0bz5MXmvwv_Cy1ykVg-1; Fri,
 27 Dec 2024 10:54:58 -0500
X-MC-Unique: njBQ0bz5MXmvwv_Cy1ykVg-1
X-Mimecast-MFC-AGG-ID: njBQ0bz5MXmvwv_Cy1ykVg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E3AB195608E;
	Fri, 27 Dec 2024 15:54:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3064A1956053;
	Fri, 27 Dec 2024 15:54:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 27 Dec 2024 16:54:31 +0100 (CET)
Date: Fri, 27 Dec 2024 16:54:28 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: WangYuli <wangyuli@uniontech.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <20241227155428.GA15300@redhat.com>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
 <20241226201158.GB11118@redhat.com>
 <CAHk-=whRnW3e3g5PkEtH6geVVYZO2MPUH4ZV5a=khePC9evY4g@mail.gmail.com>
 <20241226205746.GC11118@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226205746.GC11118@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 12/26, Oleg Nesterov wrote:
>
> On 12/26, Linus Torvalds wrote:
> >
> > So the optimization may be valid
>
> I don't think so, see my initial reply.
>
> unlike wait_event(), __pollwait() + the head/tail checks in pipe_poll()
> doesn't have the necessary barriers (at least in theory) afaics. Between
> add_wait_queue()->list_add() and LOAD(head/tail).

Hmm...

Even if we add the wq_has_sleeper() check, the "wake up" logic would
be still suboptimal. Lets forget this patch for the moment.

Consider

	int main(void)
	{
		int fd[2], cnt;
		char c;

		pipe(fd);

		if (!fork()) {
			// wait until the parent blocks in pipe_write() ->
			// wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
			sleep(1);

			for (cnt = 0; cnt < 4096; ++cnt)
				read(fd[0], &c, 1);
			return 0;
		}

		// parent
		for (;;)
			write(fd[1], &c, 1);
	}

In this case the child will wakeup the parent 4095 times for no reason,
pipe_writable() == !pipe_pull() will still be true until the last
read(fd[0], &c, 1) does

	if (!buf->len)
		tail = pipe_update_tail(pipe, buf, tail);

and after that the parent can write the next char.

Or did I completely misread this code??

Oleg.


