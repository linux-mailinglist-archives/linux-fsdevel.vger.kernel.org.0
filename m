Return-Path: <linux-fsdevel+bounces-30119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAE99865F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 19:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190F41C24AD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 17:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D8083CDA;
	Wed, 25 Sep 2024 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HcUCbq5a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A89753376
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286683; cv=none; b=VhcZHTWoz/CGZh7tmUwZe0RjjcoeWpsdfDYX5QS6gRvYOfG00LZP1aIuIowr7kIJ8H9vMaoCAoAitFASzDMDeOcXRIc2OtHabSU6ie42PlnVX5KxA88rc9dxD/VPSMSkDUo1H/IwZcrZYSZOeyT7+0pGXcug40SCbWtgxKn3gQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286683; c=relaxed/simple;
	bh=IeN+Rb/JcCtYTVqKMKOgmerz/Yx5J+48slMxMSFibaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5jnHW1wjMqiSN9+MaPfMX3rjhXZkuXbjwt+pGTHccgRDBM0EHZn6xm5JsBOehEjfIFoFUG2kj339kiBHHYn0L7uYVhCfQmLQnzfBGrySbBu8P+BxocZwWjtxAU7Xc3hPDnKdawhyfUA312oKuZvrtkZkFOFJvd/g5vy8Dj8BPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HcUCbq5a; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=udJNJ8G0CcrtL0v9M1Xkwn0kb+I2cPSgqSEpGi2qYfE=; b=HcUCbq5aAYaVyTm6XDriKlv/iu
	MgEP9i8Z1WMxAqaeQceoeVG7MxT/Hrssyizx+um3j4Um2sze67k75YSoVAwnuKXnG2avzF3tLQTMI
	6Lk4rTPbXuCIDnn+n3YRbsoBQEEoGj/zn1WDiDGuuutU5DnO2S1aP58s4uHbNWvQNF3fifE+bvFPi
	MevJ80VkJn8cvvQbBW2uwFDOe3OSsBDJKK9tW+/IQIldq33CoOPylyxKWNdUlhPJWIc8As6sjZ8bP
	1N6ixAR6efIYGu4uS8kGXym6+P+JbxK2yILATfqYmgzebG0qpoShbCaKg7ta7Y4v4rlbYHj3OIkrY
	+/FXHSiw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1stWAY-0000000FU3Y-4791;
	Wed, 25 Sep 2024 17:51:19 +0000
Date: Wed, 25 Sep 2024 18:51:18 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: reveliofuzzing <reveliofuzzing@gmail.com>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Report "WARNING in putname"
Message-ID: <20240925175118.GJ3550746@ZenIV>
References: <CA+-ZZ_gDJ02P46ee08sFcFGUWCyS37nbybcRALnBkGhSPkB-fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-ZZ_gDJ02P46ee08sFcFGUWCyS37nbybcRALnBkGhSPkB-fQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 25, 2024 at 11:50:17AM -0400, reveliofuzzing wrote:
> Hello,
> 
> We found the following error when fuzzing^1 the Linux kernel 6.10 and
> we are able
> to reproduce it.

Must be nice, seeing that the rest of us are only given something
that needs syzbot (presumably with your modifications) to translate
into usable C.

[snip "dangling struct filename on return from mkdir()"]

> - reproducer
> syz_genetlink_get_family_id$mptcp(0x0, 0xffffffffffffffff)
> syz_open_dev$usbmon(&(0x7f00000004c0), 0x0, 0x0)
> setxattr$trusted_overlay_opaque(0x0, 0x0, 0x0, 0x0, 0x0)
> socket$nl_generic(0x10, 0x3, 0x10)
> openat$null(0xffffffffffffff9c, &(0x7f0000001180), 0x0, 0x0)
> r0 = openat$urandom(0xffffffffffffff9c, &(0x7f0000000040), 0x0, 0x0)
> read(r0, &(0x7f0000000000), 0x2000)
> shutdown(0xffffffffffffffff, 0x0)
> r1 = syz_open_dev$sg(&(0x7f0000000040), 0x0, 0x0)

Seeing that nothing in that, as far as I can parse the damn language,
should go anywhere near mkdir(), I suspect that you are seeing
a memory corruption from something that reproducer is actually
doing.  And IIRC there had been a bunch of reports from you lately,
all with similar reproducers and with rather varied symptoms, which
makes memory corruptor triggering crap in whatever code that might
step on the buggered data structures afterwards.

Hard to tell anything beyond that without something one could
actually run...

