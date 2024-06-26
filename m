Return-Path: <linux-fsdevel+bounces-22478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD419179CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 09:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA8AB25428
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 07:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D874915A856;
	Wed, 26 Jun 2024 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwPrOqOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B441FBB
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387283; cv=none; b=Sm8lUY1MxAy8c3zyqBuXvR4mGPzSDTG74YSvcuJQ/wZBWcxyVO1RruK7rjEDjYJ6o+ze9q3Jszp0zNJNwdIBH0NjbsksOIp+B2VnjHGpUTrO68W7H2bA28iXCaVVgH75Ezf4lpV+GO6Gmz2laIVbzoldXEusjZEWn2U27NdwSGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387283; c=relaxed/simple;
	bh=JgZDBdj+o/ZDAy2JVfuXqEjXW/4Q2SRFvq5rO17/3f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PR5O5qbYvAuxx/N1ZABKg0eFvcIF43S3fGbsPTRits8IhLOC+jnOlTo9Ub3hxZTBev+2KiOK8PpwBfCt2c57fRLLJAaSi2vvnQbG3bnkNfHp/AGBXPDnX5e5rpI+qfTTJY9tNS1mtgsUW3QCkhQypB6+r38Ljx2QaKCcLVeNkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwPrOqOP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719387279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3e/czXazg6gizGLwwefFskTMgg7cE9SghgtEWNFfp5U=;
	b=TwPrOqOP2GMQ1IHfodZ6i5EEL8qXEkvk7JH0qny2yyEDG9Nll9b5Oa8urrscBmonraskCr
	SMD9EsLgeRYal1CWCQzauQ73B3leNkyI6nDAO6SiwXHqG+wra6WChcpo9eTm/IhUjFiqgy
	fJ5pxhB5xdEmmfCOX6iHMxjEP/jnAjQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-QrZHjufuNl6_ZJo4pRC-7Q-1; Wed,
 26 Jun 2024 03:34:36 -0400
X-MC-Unique: QrZHjufuNl6_ZJo4pRC-7Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60BFB1956095;
	Wed, 26 Jun 2024 07:34:34 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.185])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2ADDF3000221;
	Wed, 26 Jun 2024 07:34:31 +0000 (UTC)
Date: Wed, 26 Jun 2024 09:34:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4] Add the ability to query mount options in statmount
Message-ID: <7242gzbanc3v25sfkqeb2fbc3w56knnlinaanuladq5hzx5ett@jvthmwe4rvu3>
References: <cover.1719257716.git.josef@toxicpanda.com>
 <20240625-tragbar-sitzgelegenheit-48f310320058@brauner>
 <20240625130008.GA2945924@perftesting>
 <CAJfpeguAarrLmXq+54Tj3Bf3+5uhq4kXOfVytEAOmh8RpUDE6w@mail.gmail.com>
 <20240625-beackern-bahnstation-290299dade30@brauner>
 <5j2codcdntgdt4wpvzgbadg4r5obckor37kk4sglora2qv5kwu@wsezhlieuduj>
 <20240625141756.GA2946846@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625141756.GA2946846@perftesting>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jun 25, 2024 at 10:17:56AM GMT, Josef Bacik wrote:
> On Tue, Jun 25, 2024 at 03:52:03PM +0200, Karel Zak wrote:
> > On Tue, Jun 25, 2024 at 03:35:17PM GMT, Christian Brauner wrote:
> > > On Tue, Jun 25, 2024 at 03:04:40PM GMT, Miklos Szeredi wrote:
> > > > On Tue, 25 Jun 2024 at 15:00, Josef Bacik <josef@toxicpanda.com> wrote:
> > > > 
> > > > > We could go this way I suppose, but again this is a lot of work, and honestly I
> > > > > just want to log mount options into some database so I can go looking for people
> > > > > doing weird shit on my giant fleet of machines/containers.  Would the iter thing
> > > > > make the overlayfs thing better?  Yeah for sure.  Do we care?  I don't think so,
> > > > > we just want all the options, and we can all strsep/strtok with a comma.
> > > > 
> > > > I think we can live with the monolithic option block.  However I'd
> > > > prefer the separator to be a null character, thus the options could be
> > > > sent unescaped.  That way the iterator will be a lot simpler to
> > > > implement.
> > > 
> > > For libmount it means writing a new parser and Karel prefers the ","
> > > format so I would like to keep the current format.
> >  
> > Sorry for the misunderstanding. I had a chat with Christian about it
> > when I was out of my office (and phone chats are not ideal for this).
> > 
> > I thought Miklos had suggested using a space (" ") as the separator, but
> > after reading the entire email thread, I now understand that Miklos'
> > suggestion is to use \0 (zero) as the options separator.
> > 
> > I have no issue with using \0, as it will make things much simpler.
> 
> What I mean was "we can all strsep/strtok with a comma" I meant was in
> userspace.  statmount() gives you the giant block, it's up to user space to
> parse it.
> 
> I can change the kernel to do this for you, and then add a mnt_opts_len field so
> you know how big of a block you get.
> 
> But that means getting the buffer, and going back through it and replacing every
> ',' with a '\0', because I'm sure as hell not going and changing all of our
> ->show_options() callbacks to not put in a ','.
> 
> Is this the direction we want to go?  Thanks,

Honestly, I don't have a strong opinion on this. Both the ','
and \0 options work for me, and the userspace is already set up for
','. 

Using \0 is a possibility for creating an ideal kernel interface as it
doesn't require escaping, but it may require significant changes to the
kernel with minimal advantage for userspace. 

By the way, starmount() is so flexible that adding support for other
formats can be done anytime later with some new STATMOUNT_* mask.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


