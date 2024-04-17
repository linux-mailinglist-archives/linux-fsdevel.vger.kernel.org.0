Return-Path: <linux-fsdevel+bounces-17090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C0E8A7A02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 03:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 070BAB22C48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 01:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1DC1877;
	Wed, 17 Apr 2024 01:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DKEUcC1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E13463B8;
	Wed, 17 Apr 2024 01:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713315880; cv=none; b=rUnp2FRkTwPPnU9ojCF39ilQlhMzdnhwMFeCfv60n41fpVt0evC0Bbm2mZ94ZFH9FiK9MYOtu/ZwhWp8KITI5o6t5p76m8NmdEoykE1wLpKv45JCfjKZJQ2CWuRo4V5hwcrDuKtMJtmCrLYp7cYaVXZHuaSSiQ5/nBtBTe89OuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713315880; c=relaxed/simple;
	bh=hQttcr/K+L2TZzpAmTtlhuqzh30BQG44N5VEGmk/0w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiHuWf/XMD4kR73iI+sJzl2/OmbvmxSpyhe8QVn9ItNFxuB2sSqYCgJ35w6IBFNUelftsMpgaEK0GJAUTXeDfOhDI4ycFHcZ1gMJFbufVlskFdnI9oT/hvuYj5TK4Jgk/REXjOerzMUZc65CQZxLuoWpe/35FXE31oRHb4QIi2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DKEUcC1e; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4utM/Sl9d7qVlWh5DitFl//HRd0EeK+V3m+eOFZIrrg=; b=DKEUcC1el2eewz7Hw202gFRAEF
	puke5nCdVc89xvbsGo8hLzAssnxfBiTnjbSosHTkdroVYv4zjRgJd19bQKKX2Tc6CLy3Ezfi9J1K8
	/zrv4vSJJaDQow/L271Uft6UMm3a8ueBdi1F9pyvEgzB6ciyExb1K6Cqoeaiwtm/MKQo1pgAso8Xf
	q6gDDgXyZ6jf/7uRadvYgutjdZvB+KgtGyl+zjTcUi2cd15XeePPbz/l3+mfW+oRT8DTxoHSAUHBb
	e72BrrFw/CUOw8D2M1rcuk78y4g5c8ZiFNtyX7RmHDOKlUbZyigoQflFjOa03Ea2kf3+c8apvIs4e
	NhTMBmqw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rwtiw-00DuLU-1h;
	Wed, 17 Apr 2024 01:04:30 +0000
Date: Wed, 17 Apr 2024 02:04:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Laight <David.Laight@aculab.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] seq_file: Optimize seq_puts()
Message-ID: <20240417010430.GB2118490@ZenIV>
References: <5c4f7ad7b88f5026940efa9c8be36a58755ec1b3.1704374916.git.christophe.jaillet@wanadoo.fr>
 <4b1a4cc5-e057-4944-be69-d25f28645256@wanadoo.fr>
 <20240415210035.GW2118490@ZenIV>
 <ba306b2a1b5743bab79b3ebb04ece4df@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba306b2a1b5743bab79b3ebb04ece4df@AcuMS.aculab.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 16, 2024 at 08:56:51PM +0000, David Laight wrote:

> > static inline void seq_puts(struct seq_file *m, const char *s)
> 
> That probably needs to be 'always_inline'.

What for?  If compiler fails to inline it (and I'd be very surprised
if that happened - if s is not a constant string, we get a straight call
of __seq_puts() and for constant strings it boils down to call of
seq_putc(m, constant) or seq_write(m, s, constant)), nothing bad
would happen; we'd still get correct behaviour.

> > {
> >	if (!__builtin_constant_p(*s))
> > 		__seq_puts(m, s);
> > 	else if (s[0] && !s[1])
> > 		seq_putc(m, s[0]);
> > 	else
> > 		seq_write(m, s, __builtin_strlen(s));
> > }
> 
> You missed seq_puts(m, "");

Where have you seen one?  And if it gets less than optimal, who cares?

> Could you do:
> 	size_t len = __builtin_strlen(s);
> 	if (!__builtin_constant_p(len))
> 		__seq_puts(m, s);
> 	else switch (len){
> 	case 0: break;
> 	case 1: seq_putc(m, s[0]);
> 	default: seq_write(m, s, len);
> 	}

Umm...  That's probably OK, but I wonder how useful would that
be...

