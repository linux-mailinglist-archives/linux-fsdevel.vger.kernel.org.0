Return-Path: <linux-fsdevel+bounces-41328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A90FA2DFFF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 19:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C1E188438F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 18:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563891D934D;
	Sun,  9 Feb 2025 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixYxxfb9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA381E25F1
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739126709; cv=none; b=jUD1Hxztw3O6q5Yk7d4BMQiq27r7eM/UfsUBPlyGaTX1nh7W3cRG5n5wzpJCKol9UTYhMVuTbZidjwXxa3pUmL1bFPO5neFshpOEGHbiVKVNNJTk2uT1sblcXIMLacrAqJu0SEjUIeNLfwq/4HZX2I5mgU17xNi3aYx/gyvBuPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739126709; c=relaxed/simple;
	bh=stoG6L6OWR+FoYTdXqa5HvVCl2kNIYa3Y5+3ZZ90kFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yt23FV8XSghWEVkDETwO6VXN0I/ELOZ60UcbijHS7EDL8ZaVRc9NREhcwRAEvPwAC8tlir/XUF1b8ce04ZIsbEOkUxvH2KyqkW8bC9F23mQw144/tWJ3uyPtk6iZFyHCdEJem+HzVViCqOhhko94yWOdgy2Ohn5ETi7bT5L2LLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ixYxxfb9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739126707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=stoG6L6OWR+FoYTdXqa5HvVCl2kNIYa3Y5+3ZZ90kFI=;
	b=ixYxxfb91zW1cuvQDDsDCMYX0riTp148WqW80b1H9o1m6BaUkJwAZh+aZpSEmYZgGt1uQC
	yYESwnswWX1BqYLXfAA3x6/VdcTwzl2SESCk91X4BjHiuaSCL6ltvw7DUN5qIlVEKrGy+z
	J5QnEPd66oimsCSFgYdHZEV7q7JDX+M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-sohR_Hi6OHSGBTotKcXZmA-1; Sun,
 09 Feb 2025 13:45:03 -0500
X-MC-Unique: sohR_Hi6OHSGBTotKcXZmA-1
X-Mimecast-MFC-AGG-ID: sohR_Hi6OHSGBTotKcXZmA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B89618004A7;
	Sun,  9 Feb 2025 18:45:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.8])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 25F761956094;
	Sun,  9 Feb 2025 18:44:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  9 Feb 2025 19:44:34 +0100 (CET)
Date: Sun, 9 Feb 2025 19:44:28 +0100
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
Message-ID: <20250209184427.GA27435@redhat.com>
References: <20250209150718.GA17013@redhat.com>
 <20250209150749.GA16999@redhat.com>
 <CAHk-=wgYC-iAp4dw_wN3DBWUB=NzkjT42Dpr46efpKBuF4Nxkg@mail.gmail.com>
 <20250209180214.GA23386@redhat.com>
 <CAHk-=whirZek1fZQ_gYGHZU71+UKDMa_MYWB5RzhP_owcjAopw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whirZek1fZQ_gYGHZU71+UKDMa_MYWB5RzhP_owcjAopw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 02/09, Linus Torvalds wrote:
>
> On Sun, 9 Feb 2025 at 10:02, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Could you explain what do you think should I do if I keep this check?
> > make pipe_buf_assert_len() return void? or just replace it with
> > WARN_ON_ONCE(!buf->len) in its callers?
>
> Just replace it with WARN_ON_ONCE() in any place where you really
> think it's needed.

OK, will do.

> IOW, why warn for a case that isn't a problem, and you're only making
> it a problem by thinking it is?

Again, lets look eat_empty_buffer().

The comment says "maybe it's empty" but how/why can this happen ?

The changelog for d1a819a2ec2d3 ("splice: teach splice pipe reading
about empty pipe buffers") says "you can trigger it by doing a write
to a pipe that fails" but if someone looks at anon_pipe_write() after
1/2 this case is not possible.

And if eat_empty_buffer() flushes the buffer and updates pipe->tail,
why doesn't it wake the writers?

WARN_ON_ONCE() makes it clear that we do not expect !buf->len == 0,
and the kernel will complain if it does happen.

So unless you have a strong opinion, I'd prefer to keep it for now.

Oleg.


