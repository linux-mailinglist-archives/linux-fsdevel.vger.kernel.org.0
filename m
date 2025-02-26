Return-Path: <linux-fsdevel+bounces-42713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A467DA467C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 18:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100B33AE1EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6892253EC;
	Wed, 26 Feb 2025 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0prwXY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF59821CC79
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590250; cv=none; b=YczPKy8X3DCP5ftFAEC8BY8hkx/4qLn/DSxGGxQInGXicLVCdMuQiJJ2cVOJ1TMw7aOdnncV4kP/IloorPTt3O/Pivi6KBvRUCL0e09xZLh4YrMaPz8qqW4gq/p/xLr5U2knWszF+nEbH6U4FhIff+e4oU2KXd7hgA/rk/sW5Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590250; c=relaxed/simple;
	bh=4IWTO+yFXZQLpfb06fmYIIE+muqxQRpsizmPObyVJUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5LU4X+DH3fFzb3c7n5Ka7bCBTKFsuiOze+tHcGZy1h8ektFwXpBwq6qeZmTIp01a/aJ9Jqm0x8uPJR0Gmx9BDvFqpkFKaUMkSaMuUFY4spg1lgTQWTf/z3km2Jnwsmmlj1cJwkwZYDdI1Vw6+KBqGzvt0E0veGuuPM38hebCWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T0prwXY7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740590247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSXYs0Ypm9+hDMpFhNpxbn65/XRpk3PYQsylAaaaDb0=;
	b=T0prwXY72RjcUXTM4raZ47+Ir524PwiTpYEv0YnkzdwjG6v+OX304hKQW9wXXKSgyy9bha
	FJqiaxWAG2sT1EjkMs/pmPxmFRrFIGMbdGZVfg+a7I4ibflTSib/hUm8B5l6BH6MrJiSLR
	aw/SUBKHFYct+S4P/jzy+2g9aOwW5/M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-PbARJ24iO0udAZCO0VAnUw-1; Wed,
 26 Feb 2025 12:17:24 -0500
X-MC-Unique: PbARJ24iO0udAZCO0VAnUw-1
X-Mimecast-MFC-AGG-ID: PbARJ24iO0udAZCO0VAnUw_1740590242
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 415711955F28;
	Wed, 26 Feb 2025 17:17:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E6600180035E;
	Wed, 26 Feb 2025 17:17:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Feb 2025 18:16:52 +0100 (CET)
Date: Wed, 26 Feb 2025 18:16:46 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250226171645.GH8995@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
 <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <CAGudoHGaJyipGfvsXVKrVaMBNk8d35o66VUoQ3W-NDa1=+HPOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGaJyipGfvsXVKrVaMBNk8d35o66VUoQ3W-NDa1=+HPOA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/26, Mateusz Guzik wrote:
>
> On Wed, Feb 26, 2025 at 2:19 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> Now that I sent the e-mail, I realized the page would have unread data
> after some offset, so there is no room to *append* to it, unless one
> wants to memmove everythiing back.

Yes, but... even "memmove everything back" won't help if
pipe->ring_size > 1 (PIPE_DEF_BUFFERS == 16 by default).

> However, the suggestion below stands:

Agreed, any additional info can help.

Oleg.

> > As for the bug, I don't see anything obvious myself.
> >
> > However, I think there are 2 avenues which warrant checking.
> >
> > Sapkal, if you have time, can you please boot up the kernel which is
> > more likely to run into the problem and then run hackbench as follows:
> >
> > 1. with 1 fd instead of 20:
> >
> > /usr/bin/hackbench -g 16 -f 1 --threads --pipe -l 100000 -s 100
> >
> > 2. with a size which divides 4096 evenly (e.g., 128):
> >
> > /usr/bin/hackbench -g 1 -f 20 --threads --pipe -l 100000 -s 128
> 
> 
> 
> -- 
> Mateusz Guzik <mjguzik gmail.com>
> 


