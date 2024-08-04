Return-Path: <linux-fsdevel+bounces-24953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5457B947046
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 20:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2BE1C20B51
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 18:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575D8139D13;
	Sun,  4 Aug 2024 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzmCLi2O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042AEAD59
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2024 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722797635; cv=none; b=LXsHEZfSmhXEKH7WJ3ijA4QK8NnkIOehWsJ5eIfrmF4cWLWTxH3VlQlyvAH9zjEr4n4TtUFYWVW+cpr2t43yZt/KMYm9ZJuMoCLfhwPIz22m9vVjJ+pe9/8cfYdUccLNo7K+tjUCRWVA/celUIUPm6QXO6/maNjsaR8jW84puGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722797635; c=relaxed/simple;
	bh=GC05VjOW+Ud/zQn9u1M9aJNEJiu5D1z6sqv5c4//nyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7+sBvd3MiRAttSD4Bgw3aq6UqEwMUA0cUzlICvnPUJ25qJ0r3fJYLbjfomHNjGNPhuXlghsaWWMXx4o8rwSmh6CKFREHw9CtlTEFXRSqdBb0J1vJnACLmsGUoPOLHIVBJuhhgSs24qkPkNAHgMi3Kv8/bHs25IgmjD0hOmqDqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzmCLi2O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722797633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GC05VjOW+Ud/zQn9u1M9aJNEJiu5D1z6sqv5c4//nyo=;
	b=hzmCLi2OvIFAh8obQpkBI6g6az7ZHvehnVgu6YpHgVq5ZAPAxTUO2ptE1t04UlQAgqT51I
	75cTvukBaLAjlV/lG9kYCHU5CpAJyTdCJkYaEC1lZHG/d6UwHFgm98qBz1RVrFtQOCCu7c
	kXFty8jXIOxtG9G2H4jAMyGkuqqpvVE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-HL_wgFG1NxaTife3_w51DA-1; Sun,
 04 Aug 2024 14:53:47 -0400
X-MC-Unique: HL_wgFG1NxaTife3_w51DA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3F3A19560AB;
	Sun,  4 Aug 2024 18:53:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.47])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id ED55E1955F40;
	Sun,  4 Aug 2024 18:53:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  4 Aug 2024 20:53:43 +0200 (CEST)
Date: Sun, 4 Aug 2024 20:53:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Brian Mak <makb@juniper.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] piped/ptraced coredump (was: Dump smaller VMAs first
 in ELF cores)
Message-ID: <20240804185338.GB27866@redhat.com>
References: <C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net>
 <20240804152327.GA27866@redhat.com>
 <CAHk-=whg0d5rxiEcPFApm+4FC2xq12sjynDkGHyTFNLr=tPmiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whg0d5rxiEcPFApm+4FC2xq12sjynDkGHyTFNLr=tPmiw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

OK, I won't insist, just a couple of notes.

On 08/04, Linus Torvalds wrote:
>
> On Sun, 4 Aug 2024 at 08:23, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > What do you think?
>
> Eww. I really don't like giving the dumper ptrace rights.

Why?

Apart from SIGKILL, the dumper already has the full control.

And note that the dumper can already use ptrace. It can do, say,
ptrace(PTRACE_SEIZE, PTRACE_O_TRACEEXIT), close stdin, and wait
for PTRACE_EVENT_EXIT.

IIRC some people already do this, %T just makes the usage of ptrace
more convenient/powerful in this case.

> So I prefer the original patch because it's also small, but it's
> conceptually much smaller.

Ah, sorry. I didn't mean that %T makes the Brian's patch unnecessary,
I just wanted to discuss this feature "on a related note".

Oleg.


