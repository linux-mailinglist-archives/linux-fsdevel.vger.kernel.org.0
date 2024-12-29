Return-Path: <linux-fsdevel+bounces-38238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31FC9FDECE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 12:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6713D16149A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA0C152532;
	Sun, 29 Dec 2024 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/Mc7hCG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937EE259497
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735473496; cv=none; b=Wb6y0RhVkXbtGlKC1iiTHmu3Nie9dOw3/s3eOg72I7MxQJgNOnmlfIp4bslq3zhlDB+SxxjAQ69hAUu4WZWs159Nb0tVIUAF5P5Bv8OFoZqOhcbVB5hkkSsluPRznbxf34mYNH6kSFxDpFdXBG9p62a/alQS4nQkT6TuiDHzaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735473496; c=relaxed/simple;
	bh=YOOZBImuAlrs49ji96Afg/uN+awxtIndLAu3nGRtosU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7UQvNEt/dXfUeBHQ73QbnoRC5gSH1Kzx30I2pGeO2uWyMviae1oV+/e44WihnYwYwIvVRCR368nP52yHYD/1znmO8VpOOfQymezx4S7R9hZRGzUyD8b90DKasYtRLVGza3luj3cPOx7qqFCzE75HrbVN9yPp1T90dmjQZqIj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/Mc7hCG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735473493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YOOZBImuAlrs49ji96Afg/uN+awxtIndLAu3nGRtosU=;
	b=S/Mc7hCG+ruq+aWEufjnQTCHT+6JJ8hRcrG5vBOpWVCJVkZh8ROR3U9It7g4ao02f1+F4K
	nKebpES2qEmErdY+IMaprpHbQLP64EBefnlK/KhOz6kotkMk/pa1V3C5m5+tPu12WcVJU5
	0GNxmkk92Ee2RGUrNpb3vCax7bClrNg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-W293Sh7YNzCJ6sN4uJOA9w-1; Sun,
 29 Dec 2024 06:58:11 -0500
X-MC-Unique: W293Sh7YNzCJ6sN4uJOA9w-1
X-Mimecast-MFC-AGG-ID: W293Sh7YNzCJ6sN4uJOA9w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D0E419560AA;
	Sun, 29 Dec 2024 11:58:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.22])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7F69A19560AA;
	Sun, 29 Dec 2024 11:58:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Dec 2024 12:57:45 +0100 (CET)
Date: Sun, 29 Dec 2024 12:57:41 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	WangYuli <wangyuli@uniontech.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <20241229115741.GB27491@redhat.com>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
 <20241226201158.GB11118@redhat.com>
 <1df49d97-df0e-4471-9e40-a850b758d981@colorfullife.com>
 <20241228143248.GB5302@redhat.com>
 <20241228152229.GC5302@redhat.com>
 <addb53ac-2f46-45db-83ce-c6b28e40d831@colorfullife.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <addb53ac-2f46-45db-83ce-c6b28e40d831@colorfullife.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 12/28, Manfred Spraul wrote:
>
> On 12/28/24 4:22 PM, Oleg Nesterov wrote:
> >
> >Now suppose that another CPU executes wake() between LOAD(CONDITION)
> >and list_add(entry, head). With your patch wait() will miss the event.
> >The same for __pollwait(), I think...

...

> It could still work for prepare_to_wait and thus fs/pipe, since then the
> smb_mb() in set_current_state prevents earlier execution.

Not sure, please see the note about __pollwait() above.

I think that your patch (and the original patch from WangYuli) has the same
proble with pipe_poll()->poll_wait()->__pollwait().

Oleg.


