Return-Path: <linux-fsdevel+bounces-53988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE16AF9BA7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 22:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37561CA72AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 20:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E72234973;
	Fri,  4 Jul 2025 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RPolmwef"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DC1228CB8
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751660622; cv=none; b=iz7iRKTcJUwtlhaNk91IzyuGD4SPySLyr0/605j0FlGqdZHjkTEkBzkW5N8EQezry5ApSmGaio/uC2+zWuHOItfWcAzDBOHVq6xZSzqzsp5P6vY1nO47VEvll99x8LK0DJ1cT0/XkoWUxYu0Npl//hDmGmyLgGG4zzIgNR6vgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751660622; c=relaxed/simple;
	bh=IAKLlQDkFZaUgfS/Y15p4+tfcq8R40iwSQGaVof4VnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeI6uKF2Zyr0Ch06YCoT41gODkV1iSBUpbdMpUrBxzepay1exDoyCE1NkJjt4frMzPGda5NwZm1digBHIBIFWXJrVCLjGsl/kquzJc4sKpAlhlulC3NwR3lYcyhSi0lzdzJmS0hL6Fknn8Tka4/VI3VNTCRze32B6ZwTd+yOsME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RPolmwef; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Tw6LOfTwR/DCVN99hNYiU0VWbg0/xaEKJfGILbLa8wo=; b=RPolmwef24SVPfZxESluwh2tp8
	HYiDzWxNffPGIfTAHUSrXQctHeYoe23twFnn9lMdZK21KTMNIPqf63NwvMBRgBXCtk26rNUIRiQRf
	j/dlwtCXaVsV2ZFvdF5Fss8VBPkupzUv3blCcn0ztdFmhqqbcqWeWs3WLehh2QxVMU4k5LH883LMb
	u6IepORG/UuK0jq8dzwX5kb/Da2eXzYdDdK2jcnChDuLKsYkHfQ2GkPhOPNlBY4iCB5GZ2+vdocpA
	emNPych0EGnfDFNn9QvTwQTxpQDtrT7qKYgN3oow6uwwSas9PdXZNsrmH9RNA0S8aAKrSvbKa3I/p
	5wsNmrhg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXmwb-0000000EqNr-1mDz;
	Fri, 04 Jul 2025 20:23:37 +0000
Date: Fri, 4 Jul 2025 21:23:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] MNT_WRITE_HOLD mess
Message-ID: <20250704202337.GT1880847@ZenIV>
References: <20250704194414.GR1880847@ZenIV>
 <CAHk-=wgurLEukSdbUPk28rW=hsVGMxE4zDOCZ3xxY3ee3oGyoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgurLEukSdbUPk28rW=hsVGMxE4zDOCZ3xxY3ee3oGyoQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jul 04, 2025 at 12:57:39PM -0700, Linus Torvalds wrote:

> Ugh. I don't hate the concept, but if we do this, I think it needs to
> be better abstracted out.
> 
> And you may be right that things like list_for_each_entry() won't
> care, but I would not be surprised there is list debugging code that
> could care deeply. Or if anybody uses things like "list_is_first()",
> it will work 99+_% of the time, but then break horribly if the low bit
> of the prev pointer is set.
> 
> So we obviously use the low bits of pointers in many other situations,
> but I do think that it needs to have some kind of clear abstraction
> and type safety to make sure that people don't use the "normal" list
> handling helpers silently by mistake when they won't actually work.

Point, but in this case I'd be tempted to turn the damn thing into
pointer + unsigned long right in the struct mount, and deal with it
explicitly.  And put a big note on it, along the lines of "we might want
to abstract that someday".

Backporting would be easier that way, if nothing else...

