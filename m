Return-Path: <linux-fsdevel+bounces-19196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E770B8C11FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9DC1C20E39
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E862D16F26D;
	Thu,  9 May 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/T4oVm6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E253214A612
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715268629; cv=none; b=hcjABJdxwpC0RZTMMMisn5+oaoKODBIPffwT/CgYEGKoBwzg1DOL7IXvuXshayrzRnqXqc0+wvHNfUNFAo0l02j7Btjfr0SvTq3S7/CEQPNVkzbSBlnJ7LDiWExkIKGeQ3v4OqphUQW+QJttH330P+P/JlIPpl+AMz/dZcmOJ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715268629; c=relaxed/simple;
	bh=UTqGM0dWpCz6nS63Q6iMVN9wJSByAgwNJAKBTDBd2bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afZBa9/RSBiqUfCcKo1vhyhdX5NTofowHWR7yY6kOMbdjfRGMvFruk71FAvXaiy5He82PwmUi7MXvAdfFBkd9yZ2gVkvCnvM44IM2B5JGKYh3C6M14UvbZ+sdVCKem+RL5XqmROKzLiHE8ctTMjr7qAKKb08I24gMQShuEV5F+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/T4oVm6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715268626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hy/b3d3gFNZGN9o/TMf1nXsT/S7nrlG2+f6fAjptoCk=;
	b=C/T4oVm6gew2PPhag8b7eOEWmIyu69ghV59F1Po5xlginR9fU+Sa9MhHE0oaDguU3JvvlK
	NpGK5LWUWLGruCKg3boOKf2VGK1kRc2HzkkhaqUe0BGTT5gekD14zjw13VJS8ZKP3Rz0W0
	BA8k5Xy67KDzLutQtOt1d/VWmwoKMh8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-lBH72HkKPEu-T6_GN-WWuA-1; Thu, 09 May 2024 11:30:24 -0400
X-MC-Unique: lBH72HkKPEu-T6_GN-WWuA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 562671816ED2;
	Thu,  9 May 2024 15:30:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 48D5220C5662;
	Thu,  9 May 2024 15:30:21 +0000 (UTC)
Date: Thu, 9 May 2024 23:30:19 +0800
From: Baoquan He <bhe@redhat.com>
To: Rik van Riel <riel@surriel.com>
Cc: akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] fs/proc: fix softlockup in __read_vmcore
Message-ID: <ZjzsC8KwEoDzAZBt@fedora>
References: <20240507091858.36ff767f@imladris.surriel.com>
 <ZjxImBiQ+niK1PEw@MiWiFi-R3L-srv>
 <cfa4ec0f8f26ffceb6adcea96a182736519886ef.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfa4ec0f8f26ffceb6adcea96a182736519886ef.camel@surriel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 05/09/24 at 09:41am, Rik van Riel wrote:
> On Thu, 2024-05-09 at 11:52 +0800, Baoquan He wrote:
> > Hi,
> > 
> > On 05/07/24 at 09:18am, Rik van Riel wrote:
> > > While taking a kernel core dump with makedumpfile on a larger
> > > system,
> > > softlockup messages often appear.
> > > 
> > > While softlockup warnings can be harmless, they can also interfere
> > > with things like RCU freeing memory, which can be problematic when
> > > the kdump kexec image is configured with as little memory as
> > > possible.
> > > 
> > > Avoid the softlockup, and give things like work items and RCU a
> > > chance to do their thing during __read_vmcore by adding a
> > > cond_resched.
> > 
> > Thanks for fixing this.
> > 
> > By the way, is it easy to reproduce? And should we add some trace of
> > the
> > softlockup into log so that people can search for it and confirm when
> > encountering it?
> 
> It is pretty easy to reproduce, but it does not happen all the time.
> With millions of systems, even rare errors are common :)
> 
> However, we have been running with this fix for long enough (we
> deployed it in order to test it) that I don't think we have the 
> warning stored any more. Those logs were rotated out long ago.

OK, thanks for the explanation.

Acked-by: Baoquan He <bhe@redhat.com>


