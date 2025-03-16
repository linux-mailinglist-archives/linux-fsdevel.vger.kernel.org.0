Return-Path: <linux-fsdevel+bounces-44148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718E0A63653
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 16:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B875116B590
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 15:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BA91C861B;
	Sun, 16 Mar 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="0YOk6I6d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9481AC891;
	Sun, 16 Mar 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742140133; cv=none; b=Mb+MDv5nLxMAWcwdw/nOwP0dWNJi8yU1nvFslXhvn5EbxxjlzeLoPoVF82RrTC12XFeSD1ePVG7bp6DyfAGx3fyEgQ9lJbTCEYiN5MmoN6GUtn71zaVvYUPgEhLhQmepAmAiPHBY3IjzTfEFSCaEXQgqisuEbPjjiJYVfLWeGvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742140133; c=relaxed/simple;
	bh=nVwvsxhqemfhzZHbyu4iQC8Ag3suhWEKRvZ3GIQtyko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkP9GW4XvFeoH28vyQA1k8tRIMOq/CoOHK5k+oRoyNKghlaahuEaFdij+CPEeZz9xJp+4X1Cmg4xz2ImW/0r1qfhGSvnELe8kZV2BkyrBPq2kivY3YnWBJHkRDNhLmv8mbZoYGTLQbx/vQ3MPRPIX5wicgVEHpPzD78iwLYvsaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=0YOk6I6d; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZG2Zd2n8Bz9sDg;
	Sun, 16 Mar 2025 16:48:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742140121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzQ7h6Xch89+C3wonmv8OV6q+gZlnJyorvZRHbRI6uE=;
	b=0YOk6I6d6bLuJMQgfGkRqV7DBSP8uOeBYnNyI1cftjFkfnOA8tjMkTU02GBzW52GubZoN0
	mNi2b3ovxdQVsG6RwJyGfj8NeT1k7HR1HRHfvWIGi8N6Df21a1SK/atmr8dTI/ZmLh8P97
	huSN9+MrnUIeENoc92xzN2X1JDzJghWvgqvcslzscOOOa9VnYmKVG2y4thfnrrbNHLyRSo
	6t+NWYr8fCRKDL/5QVTa37QKkMu8mAkDtSj8pERcxsyOznSLHnGAAwMcmox/MMljCNfF1d
	oK1tBinoZRc5lvL7+64BHWzXbcz38sZrVfd6f45Yy26g+Q8Mt9SFmXoNF+gJJQ==
Date: Sun, 16 Mar 2025 11:48:36 -0400
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "tytso@mit.edu" <tytso@mit.edu>, 
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>, "sven@svenpeter.dev" <sven@svenpeter.dev>, 
	"ernesto@corellium.com" <ernesto@corellium.com>, "willy@infradead.org" <willy@infradead.org>, 
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>
Subject: Re: [RFC PATCH 0/8] staging: apfs: init APFS module
Message-ID: <tj47jlgexcqk3uri2l5crvvz6ujr3yfoqaphnrhabkzmzisp4a@upd76hg7dgco>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
 <20250316033133.GA4963@eaf>
 <5EFFE468-D901-4E24-8C17-370DD232C019@live.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5EFFE468-D901-4E24-8C17-370DD232C019@live.com>
X-Rspamd-Queue-Id: 4ZG2Zd2n8Bz9sDg

On 25/03/16 06:31AM, Aditya Garg wrote:
> 
> 
> > On 16 Mar 2025, at 9:01 AM, Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com> wrote:
> > 
> > Hi Ethan,
> > 
> > I'm happy to see your enthusiasm for my driver but, if you want to help, I
> > think you should simply send the changes you have in mind to the out-of-tree
> > repo. That way you'll start learning the codebase while I can review your
> > work and run xfstests for you. Filesystems are very dangerous things; I've
> > probably done a lot of damage myself back in the day trying to help out with
> > the hfs drivers.
> > 
> > As for upstreaming, the driver still has a few rough edges, but I don't
> > think that's the real reason I never tried to submit. I'm just no longer
> > confident that filesystem compatibility is a reasonable goal, and I don't
> > expect much interest from reviewers. There are too many risks, and too many
> > hardware restrictions these days; regular users have much easier (even if
> > slower) ways to move their files around. Other uses exist of course (like
> > Aditya can explain), but they are a bit esoteric. Of course if upstream
> > people disagree, and they do want the apfs support, I will be glad to
> > prepare a patch series.
> 
> As far as I can tell, in case of upstreaming, making the FS readonly is worth it.

Definitely. I agree. From my understanding, and Ernesto, correct me if I
am wrong, but write is not explicity enabled unless mounted as so, unless
the module is compiled with CONFIG_APFS_RW_ALWAYS. I enabled this by
default in the previous patch set, but we could definitely add a Kconfig
/Kbuild option for it.

> 
> Writes, I won’t comment. Maybe add option to force them, just like it is rn, old just remove
> the whole code. The second option IMO would require quite a lot of work from your side.
> 


