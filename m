Return-Path: <linux-fsdevel+bounces-49198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A539AB9171
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 23:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AE71702DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 21:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27B02550A6;
	Thu, 15 May 2025 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="CvUvtBX4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0238DD8;
	Thu, 15 May 2025 21:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343756; cv=none; b=subtDdO0zItkPjSzjIwHcYZfag2xdGW+GBToRVMPOxRGCx9ABIE7D0+t87/ZC5ubLvMGNRpOi3My//srtNgqM+zMBjC0+JY3aaz7HKyyojcYjF7lRECnRiOGAJnbsW9N7Zi4h6dS2isccfvxQqesXmhWOJYOtw2/+ZeidN37cNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343756; c=relaxed/simple;
	bh=0xMKbu9JvEzTLH/t7pzwV8X6AAq3s2TjmRoUG/aZy/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDD+hXBvJLKHsGmHBromhxqkPeWERlg7NTt3oyNNVcMNrrhlc4nO+dikQiNF8oGCHwMaBjG2u006a/dO2NjDMkRcWtRXoufTFassRT4pd/h4s+oEyyw57AmDDEX0eNGZoXlMC3eHBtQqRGjCgQrvCECy05vLlgaAKnbk2Fk3fN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=CvUvtBX4; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747343754; x=1778879754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=INKi4gWzLSgpI54JdZ2cf2sadUWhpO0o8pnubcsQ0Qo=;
  b=CvUvtBX4vfcg6Us+iwdSXuXsCOVZrIxXqu9vNrsRVv6233rLy1hRutoM
   7e3fa//BNShnQPZv0RAB6TjqYixeYHxj/I5gGzlWOjpUxPcW01e5sRLjk
   fwyGKfsr0sDS7rgSCi3rOWyxhxYAZx6ZvBNM7W6iP4cVZ0WVbcLJhMYif
   S3nq+/2OAwPwwxFt8yLD7vnm9kJ6YSqqhKH0oVMZff3mfwcOZsdc92HHi
   55nJp31JHUAeHj2tzBzXtk5hwjfazHxtEt9HYc8Qbmn5NDMVDbGsX3ohS
   Dk3rdIW7GuOuJQfqJGQViEoMr+TvOGK/LeFz2h7E8V6uuL5RK6YuNDNji
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="197320532"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 21:15:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:46432]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.141:2525] with esmtp (Farcaster)
 id 79f35f10-c27e-46a5-9970-bd7c79ee1730; Thu, 15 May 2025 21:15:51 +0000 (UTC)
X-Farcaster-Flow-ID: 79f35f10-c27e-46a5-9970-bd7c79ee1730
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 21:15:51 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 21:15:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jannh@google.com>
CC: <alexander@mihalicyn.com>, <bluca@debian.org>, <brauner@kernel.org>,
	<daan.j.demeyer@gmail.com>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<david@readahead.eu>, <edumazet@google.com>, <horms@kernel.org>,
	<jack@suse.cz>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<me@yhndnzj.com>, <netdev@vger.kernel.org>, <oleg@redhat.com>,
	<pabeni@redhat.com>, <viro@zeniv.linux.org.uk>, <zbyszek@in.waw.pl>
Subject: Re: [PATCH v7 4/9] coredump: add coredump socket
Date: Thu, 15 May 2025 14:15:26 -0700
Message-ID: <20250515211539.93223-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAG48ez2iXeu7d8eu7L694n54qNi=_-frmBst36iuUTpq9GCFvg@mail.gmail.com>
References: <CAG48ez2iXeu7d8eu7L694n54qNi=_-frmBst36iuUTpq9GCFvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:54:14 +0200
> > +               /*
> > +                * It is possible that the userspace process which is
> > +                * supposed to handle the coredump and is listening on
> > +                * the AF_UNIX socket coredumps. Userspace should just
> > +                * mark itself non dumpable.
> > +                */
> > +
> > +               retval = sock_create_kern(&init_net, AF_UNIX, SOCK_STREAM, 0, &socket);
> > +               if (retval < 0)
> > +                       goto close_fail;
> > +
> > +               file = sock_alloc_file(socket, 0, NULL);
> > +               if (IS_ERR(file)) {
> > +                       sock_release(socket);
> 
> I think you missed an API gotcha here. See the sock_alloc_file() documentation:
> 
>  * On failure @sock is released, and an ERR pointer is returned.
> 
> So I think basically sock_alloc_file() always consumes the socket
> reference provided by the caller, and the sock_release() in this
> branch is a double-free?

Good catch, yes, sock_release() is not needed here.


> 
> > +                       goto close_fail;
> > +               }
> [...]
> > diff --git a/include/linux/net.h b/include/linux/net.h
> > index 0ff950eecc6b..139c85d0f2ea 100644
> > --- a/include/linux/net.h
> > +++ b/include/linux/net.h
> > @@ -81,6 +81,7 @@ enum sock_type {
> >  #ifndef SOCK_NONBLOCK
> >  #define SOCK_NONBLOCK  O_NONBLOCK
> >  #endif
> > +#define SOCK_COREDUMP  O_NOCTTY
> 
> Hrrrm. I looked through all the paths from which the ->connect() call
> can come, and I think this is currently safe; but I wonder if it would
> make sense to either give this highly privileged bit a separate value
> that can never come from userspace, or explicitly strip it away in
> __sys_connect_file() just to be safe.

I had the same thought, but I think it's fine to leave the code as
is for now.  We can revisit it later once someone reports a strange
regression, which will be most unlikely.

