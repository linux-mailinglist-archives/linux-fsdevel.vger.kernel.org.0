Return-Path: <linux-fsdevel+bounces-17320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0988AB67B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 23:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C061F21BE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 21:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D78113CF83;
	Fri, 19 Apr 2024 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="itVp2F74"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0F612DD97;
	Fri, 19 Apr 2024 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562371; cv=none; b=B1IAbTiQvjxtXjKcZqXhKJaXFa4uUvAOeGQjOTNXvhBDHqAbYX39Mokr91Th+dp488O3InC6g9ejMr1WhuX8onElNb8FSe5pf6kZZ+JrQHBri/y82k2an8Q3h6BZlRDX1lkbvfkweZsq3FsKxUbVJIYJdl9WctGDFvEQ+uPeVYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562371; c=relaxed/simple;
	bh=B2iZnJTC4U4cJAnQgyN7BqEuOSFQX6ioLbcIUsDWQ2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LK1cRnpdWoko1wQXhkuPA8GnXKk+QDk9q2gl/8JE/8tJF+nQ1p0AtJ/ZTb3HkbsNxAwJbtJ3BnE+/s4EmUOx5lV338G2/qxV1EEW7F347ovgkO7DYcYJuac6NWc5qiW3volo/En+LqjucSuI7jlUiZC3Zg2dPDoICpeRL45nY7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=itVp2F74; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=BSbfcQ7mq/v3QwnrqUlPv0jIW1VWZRhaDa+hlEmn1xA=; b=itVp2F74WuIvR2DEge0CZPHYjJ
	e7rw8X2SioMwT2jsL0nciCUwrmGrq/4G/alY0u+k34cNqlsEKRpCuFoIr9owJGypggKiecCetAi2O
	dI1C4SyAQzzfKfB7W8WQ/CQopIALH+mz1jscTSt+iv1nTIscnGhZJJszVrHSiteykrnulu4dN0Y95
	Y49qyBhuhT+ojpaCUsf+vTCjA+fgrdmS8Cvs+I/O3d03nLeUMuIJD41CXBCkXzNWyGSWC7X9qDIDO
	Z2C8yxjfbLHVmRJzxyOraaBuylRqFCjOi3i+Q8hDLGnszBPkvRrTTZ9Uos0OQjugRTDQGqbREw/RB
	WJWMiFBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rxvqa-00GgxV-1E;
	Fri, 19 Apr 2024 21:32:40 +0000
Date: Fri, 19 Apr 2024 22:32:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: David Laight <David.Laight@aculab.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] seq_file: Optimize seq_puts()
Message-ID: <20240419213240.GE2118490@ZenIV>
References: <5c4f7ad7b88f5026940efa9c8be36a58755ec1b3.1704374916.git.christophe.jaillet@wanadoo.fr>
 <4b1a4cc5-e057-4944-be69-d25f28645256@wanadoo.fr>
 <20240415210035.GW2118490@ZenIV>
 <ba306b2a1b5743bab79b3ebb04ece4df@AcuMS.aculab.com>
 <5e5cde3e-f3ad-4a9b-bc02-1c473affdcb1@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e5cde3e-f3ad-4a9b-bc02-1c473affdcb1@wanadoo.fr>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 19, 2024 at 10:38:15PM +0200, Christophe JAILLET wrote:
> Le 16/04/2024 à 22:56, David Laight a écrit :
> > From: Al Viro
> > > Sent: 15 April 2024 22:01
> > ...
> > > No need to make it a macro, actually.  And I would suggest going
> > > a bit further:
> > > 
> > > static inline void seq_puts(struct seq_file *m, const char *s)
> > 
> > That probably needs to be 'always_inline'.
> > 
> > > {
> > > 	if (!__builtin_constant_p(*s))
> > > 		__seq_puts(m, s);
> > > 	else if (s[0] && !s[1])
> > > 		seq_putc(m, s[0]);
> > > 	else
> > > 		seq_write(m, s, __builtin_strlen(s));
> > > }
> > 
> > You missed seq_puts(m, "");
> > 
> > I did wonder about checking sizeof(s) <= 2 in the #define version.
> 
> git grep seq_puts.*\"[^\\].\" | wc -l
> 77
> 
> What would you do in this case?
> 2 seq_putc() in order to save a memcpy(..., 2), that's it?

Not a damn thing - just have it call seq_write().  Note that
	if (s[0] && !s[1])
which triggers only on single-character strings.

