Return-Path: <linux-fsdevel+bounces-15301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D58488BEF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 11:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE38301A2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6ED6CDB6;
	Tue, 26 Mar 2024 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="scgFueta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB76E616
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447815; cv=none; b=ZYJgVCHjofipXDdz4S3w67vV34xvyuKfsIgTk3KkFsxZF2nLRe+7C1CGntgRaLyRdK+js+uuANt3AJEQhYDpyBUAEO/lGygIOYz6Shns3fPCj0kgX4jtLfA14cBBeJcF6sgH+VKHqbmLKCyGWJHCrvrSGlemA7sJenZNIbWB79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447815; c=relaxed/simple;
	bh=fTGzewKK6NNxAEDkXrp9efAnHeqrie/o7hrsmeeKsqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pzp89ZVFDBVOL1rx0RkLmpZ6GgGlQxfVLlE5snEaY1bftHgAJxWnh/Wh1P69h1ol2+5A6PUCuEr9HHp43LMdHFZRTBs3FQwtl5l9G76Ney2YX62/M1IZeXmDL5MOfPWO9dfK6DEmKYcJdEMKZXRGfy3zgoW7raytUnXfaWyYJ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=scgFueta; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V3lst40vqz3ym;
	Tue, 26 Mar 2024 11:10:10 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4V3lss3Z0CzMppHg;
	Tue, 26 Mar 2024 11:10:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711447810;
	bh=fTGzewKK6NNxAEDkXrp9efAnHeqrie/o7hrsmeeKsqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=scgFuetaKopx7yXZ8ckjYGk5v82vMMMv0wfnwqTBC1/J2yuLvzcfRDRy6pWsLk6UF
	 d6CjHexRSYb+gdsjexbDrOPZYnUr2kVq0BHBe8VvDowZsoY2cgipboVYrp+PIWUIEV
	 g4mzlJUNYgE13NHSuv8BQciPPppBL5iLuR0bsmSs=
Date: Tue, 26 Mar 2024 11:10:08 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v12 1/9] security: Introduce ENOFILEOPS return value for
 IOCTL hooks
Message-ID: <20240326.ahyaaPa0ohs6@digikod.net>
References: <20240325134004.4074874-1-gnoack@google.com>
 <20240325134004.4074874-2-gnoack@google.com>
 <80221152-70dd-4749-8231-9bf334ea7160@app.fastmail.com>
 <20240326.pie9eiF2Weis@digikod.net>
 <83b0f28a-92a5-401a-a7f0-d0b0539fc1e5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83b0f28a-92a5-401a-a7f0-d0b0539fc1e5@app.fastmail.com>
X-Infomaniak-Routing: alpha

On Tue, Mar 26, 2024 at 10:33:23AM +0100, Arnd Bergmann wrote:
> On Tue, Mar 26, 2024, at 09:32, Mickaël Salaün wrote:
> > On Mon, Mar 25, 2024 at 04:19:25PM +0100, Arnd Bergmann wrote:
> >> On Mon, Mar 25, 2024, at 14:39, Günther Noack wrote:
> >> > If security_file_ioctl or security_file_ioctl_compat return
> >> > ENOFILEOPS, the IOCTL logic in fs/ioctl.c will permit the given IOCTL
> >> > command, but only as long as the IOCTL command is implemented directly
> >> > in fs/ioctl.c and does not use the f_ops->unhandled_ioctl or
> >> > f_ops->compat_ioctl operations, which are defined by the given file.
> >> >
> >> > The possible return values for security_file_ioctl and
> >> > security_file_ioctl_compat are now:
> >> >
> >> >  * 0 - to permit the IOCTL
> >> >  * ENOFILEOPS - to permit the IOCTL, but forbid it if it needs to fall
> >> >    back to the file implementation.
> >> >  * any other error - to forbid the IOCTL and return that error
> >> >
> >> > This is an alternative to the previously discussed approaches [1] and [2],
> >> > and implements the proposal from [3].
> >> 
> >> Thanks for trying it out, I think this is a good solution
> >> and I like how the code turned out.
> >
> > This is indeed a simpler solution but unfortunately this doesn't fit
> > well with the requirements for an access control, especially when we
> > need to log denied accesses.  Indeed, with this approach, the LSM (or
> > any other security mechanism) that returns ENOFILEOPS cannot know for
> > sure if the related request will allowed or not, and then it cannot
> > create reliable logs (unlike with EACCES or EPERM).
> 
> Where does the requirement come from specifically, i.e.
> who is the consumer of that log?

The audit framework may be used by LSMs to log denials.

> 
> Even if the log doesn't tell you directly whether the ioctl
> was ultimately denied, I would think logging the ENOFILEOPS
> along with the command number is enough to reconstruct what
> actually happened from reading the log later.

We could indeed log ENOFILEOPS but that could include a lot of allowed
requests and we usually only want unlegitimate access requests to be
logged.  Recording all ENOFILEOPS would mean 1/ that logs would be
flooded by legitimate requests and 2/ that user space log parsers would
need to deduce if a request was allowed or not, which require to know
the list of IOCTL commands implemented by fs/ioctl.c, which would defeat
the goal of this specific patch.

