Return-Path: <linux-fsdevel+bounces-31084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F6E991B15
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 00:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F8B28227D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 22:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CA1165EFA;
	Sat,  5 Oct 2024 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cUI6HwJf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF5A31
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728165668; cv=none; b=d0uQIRt/TwUe/KezGxyUdsD6P7RQsQcoBXxhccPVmyExYjDj+hEb5gJYSmh7gaEoKQvjGicanWq4HkzKIT9NlGXfgT5m+KAWNXiBjuyUqLYHOMqsUmYMr9VLo9yfVzMkCZqw8CTJudaqBXHzOKnrd0zAqJkyTR8TE7haoM6I/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728165668; c=relaxed/simple;
	bh=gIEJ1Sr7A9b6Xt0sje5MWMBhYCLYjo+mI1qGPLLP+IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyhmZb2CkLKXnoRXXJ3SP4CZ9S1iy73FEu0KAR07FfaIGYSjceZOKNidzjr572rPZeDvmoze3wQpckK0lrlFq8OYCYrDQuqFdkUWy5KSpTA29HfxxvxuZevDUq86AU4Up9FQXlqXL6g59PP5Rqk4tm+qiQObr9NIybY2wreLBeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cUI6HwJf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lfg0olrfhJB19CHvBB5YIlB7oygp6mE8o2+X3BZPnI8=; b=cUI6HwJfL3gVq4vQGMX6cJ7Oh2
	uQTSnbEQFYGp1txmXSqMzAy/KOtCbOqGDwwh/1pMY1OW0resKHQ4GD35ge8yN+lLzwirGo/3AuTqL
	ysyoPVU9DAPCgUMHXsuyC9uo8nHGlCzaoTVgtHoWDujmuN37wksH0iXZDK3pyrvlgnUYzmW8R3lSB
	b3MywiL8LBn269uvw/JyO8Ed96hEU6Py7ewmOCRFmXGxdvMUdBACF+14HYbB4BaaU1QspkemFqT1U
	Dh+pNcGR0sQXSG5D2z/RpL1iOgeLRq/n7tiZt0wM1eJqb3TjPAun0UuRdQd5HWHE9RBz/z4n4L3Id
	N0ZjKbUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxCpg-00000001Asw-0UrG;
	Sat, 05 Oct 2024 22:01:00 +0000
Date: Sat, 5 Oct 2024 23:01:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH RFC 0/4] fs: port files to rcuref_long_t
Message-ID: <20241005220100.GA4017910@ZenIV>
References: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
 <CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Oct 05, 2024 at 02:42:25PM -0700, Linus Torvalds wrote:

> Also, honestly, the only reason the file counting is using a "long" is
> because the code does *NOT* do overflow checking. But once you start
> looking at the sign and do conditional increments, you can actually
> just make the whole refcount be a "int" instead, and make "struct
> file" potentially smaller.

I wouldn't bet on that.  You *can* get over 2G references on 64bit box
with arseloads of memory, and we have no way to make fget() et.al.
fail when refcount gets that high - no valid error to return and
a serious DoS potential if we start doing that.

Overflow on leaks is one thing, a huge pile of real references is a
different story, and yes, we can get that.  And boxen with 1Tb RAM
are not as exotic these days as they used to be...

