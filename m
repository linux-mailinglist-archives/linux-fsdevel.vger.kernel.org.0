Return-Path: <linux-fsdevel+bounces-24955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DED94705F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 22:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684821C2080D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 20:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54073130A54;
	Sun,  4 Aug 2024 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrbLq3Px"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7ABFC0E
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2024 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722801728; cv=none; b=Ip83eZiJtn5CrkKH8CBkS5pyMaJXiq2tKwEn+Kcl+3dpM/iJhr6NH10rblCPJKP9cvVsBsFMSUQPmBGNhLAf+AbK+O0Q0A0yuJlp+GjzI6Vvur2cWCqZxxc7kFBWcDsUMqDhLkg6Ca8AzzOKx8pF2kQwKqKKMQoaB7AURsCIoqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722801728; c=relaxed/simple;
	bh=H+rtlATAt9OolKawgkfo2ZCZccJCrnu6Q2G3/BugDm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8HRPJ//SdMJWXdwDGwckqWqvU/F4EA4ZHqR1xnQ04JGBU+t/bhn/gKlLU6Onoy1p4WFKku7WfRq5zvHgfG6o6kAqB8qKEixn50pFLhbZNaU8zheNYuh2iK8xoBOF7rvjdTYJzH0EIuk0gRydRb4e+dYgmnoPnv9ixI21Z9Hflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LrbLq3Px; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722801726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+rtlATAt9OolKawgkfo2ZCZccJCrnu6Q2G3/BugDm8=;
	b=LrbLq3PxhxS61FAh/VWX0MErMy8X0x14ZFQp11Q7Bd4FUTAEcBalim8G78RbP8torjQNlg
	al/jC8U8qNmS25WnFNGu6CRlpEc6Sm0lMKIA78QkXZ4bPT4UpgNS8+udsfxsNxPe2cGDuN
	iXJiHKVWYrjeCPiyEin+zMgxBZkAXZk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-GSJVXezxNgeCIAJSp2csjg-1; Sun,
 04 Aug 2024 16:02:02 -0400
X-MC-Unique: GSJVXezxNgeCIAJSp2csjg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DC6B1955D45;
	Sun,  4 Aug 2024 20:02:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.47])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2E7E21955F40;
	Sun,  4 Aug 2024 20:01:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  4 Aug 2024 22:01:58 +0200 (CEST)
Date: Sun, 4 Aug 2024 22:01:53 +0200
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
Message-ID: <20240804200153.GC27866@redhat.com>
References: <C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net>
 <20240804152327.GA27866@redhat.com>
 <CAHk-=whg0d5rxiEcPFApm+4FC2xq12sjynDkGHyTFNLr=tPmiw@mail.gmail.com>
 <20240804185338.GB27866@redhat.com>
 <CAHk-=wjr0p5CxbC-iGEznupau936D24iotTZi7eFXqgKX-otbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjr0p5CxbC-iGEznupau936D24iotTZi7eFXqgKX-otbg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/04, Linus Torvalds wrote:
>
> On Sun, 4 Aug 2024 at 11:53, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Apart from SIGKILL, the dumper already has the full control.
>
> What do you mean? It's a regular usermodehelper. It gets the dump data
> as input. That's all the control it has.

I meant, the dumping thread can't exit until the dumper reads the data
from stdin or closes the pipe. Until then the damper can read /proc/pid/mem
and do other things.

> > And note that the dumper can already use ptrace.
>
> .. with the normal ptrace() rules, yes.
>
> You realize that some setups literally disable ptrace() system calls,
> right? Which your patch now effectively sidesteps.

Well. If, say, selinux disables ptrace, then ptrace_attach() in this
patch should also fail.

But if some setups disable sys_ptrace() as a system call... then yes,
I didn't know that.

> THAT is why I don't like it. ptrace() is *dangerous*.

And horrible ;)

> Just adding some implicit tracing willy-nilly needs to be something
> people really worry about.

Ok, as I said I won't insist.

Oleg.


