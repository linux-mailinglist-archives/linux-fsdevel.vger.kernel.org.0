Return-Path: <linux-fsdevel+bounces-39921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4F8A19CC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 03:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9F03A18CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8771D555;
	Thu, 23 Jan 2025 02:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kMqTJPoL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07AF179A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737597811; cv=none; b=gi0yiQ1c0Pls4BW82mr9wBBuPM6WcoEVAYQdFUZTccFm7TCaDAieE9PQ9FGHrNwT/d7ZfQ3IJaEB/9AESNnmAT2MuW9iMpk+o+l+E3IQUkDfE1brBTZzth7UPXrw6kx8X/ZSTtyboRE6tBC9/dYkkPVoa9HyJmXcivnbnMMtibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737597811; c=relaxed/simple;
	bh=pqDRvPlCgekn1c0gl2IhzUd/RfVkvDlSUYefN2+8J5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G76MCpKY+ssUfj8IuoxOUSQLeP3H1Xo3StkBOPtiAH36RuSJHTLNMIWSjAcHqr6vQ5cULH73Dv0CQIn1M5m8csVneRKWG5Wvtw1OmVEr88BfAus+iSGE2sZjw+RTB3iAtTGHL7AYX/KEv3W1DyKLjZrDPWGKkJ3f9wwCFCZS9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kMqTJPoL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xeuOGTTCk94nh0DDn+PLjjEVD7sQAmtDNqBtCELN6DY=; b=kMqTJPoLWNRM+hNgyMgfSN35xa
	5NtdWgwhZJJzIO5NcuXFwh64xEaLCy9w1pADUpOU+r5+K/gcD+8iha+cbW/wr9ZJdUb/0QNYqsdpl
	jYoaZEp+PCVaGWFydULPwuxCVtea0U9oFOf/7i89ub1SD8EfM20Y64ooh+75RrIV1pE7TgDGg/lWu
	1dy9O9E3IcVk602sSGD1hdWbA5dLRq4ZQU6Z+1kJKhrvxtSuFpNsxu/b/m1aIVF/PRe/9wMHI+Yt7
	jt8F+47CY75qXcwIL7IXIjEHoCyf8cY0h/fD4wDUXoVUaUsW72lg1HCxVfQeBsEQVQb46ipkNsieU
	g3e7ZpQA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tamZ5-00000008FvL-44Lf;
	Thu, 23 Jan 2025 02:03:28 +0000
Date: Thu, 23 Jan 2025 02:03:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] EOPENSTALE handling in path_openat()
Message-ID: <20250123020327.GB1977892@ZenIV>
References: <20250119053956.GX1977892@ZenIV>
 <CAJfpegtxKLYe_-mkv31Ww_PD984YZyPsDuwS=46gbmEKq4-5yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtxKLYe_-mkv31Ww_PD984YZyPsDuwS=46gbmEKq4-5yg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 21, 2025 at 01:07:38PM +0100, Miklos Szeredi wrote:
> On Sun, 19 Jan 2025 at 06:40, Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > Miklos, could you recall what was the original intent of that?
> > Do we want to keep that logics there, or should it just turn into
> > "map -ENOPENSTALE to -ESTALE??
> 
> I think the intent was to prevent a full LOOKUP_REVAL if this happened
> on the first try in do_filp_open().  I still think that makes sense,
> but needs a comment since it's not obvious.

For that to have happened we need the following sequence:
	* we started in RCU mode
	* we'd run into something that needs fallback to non-RCU (e.g.
open() callback itself)
	* we had successfully switched to non-lazy mode - grabbed
references, etc.
	* we got to call of open() callback and that returned us -EOPENSTALE.

What's the point of re-walking the same trajectory in dcache again
and why would it yield something different this time around?

IDGI.  We *can't* get to open callback without having already dealt
with leaving RCU mode - any chance of having walked into the wrong
place due to lack of locking has already been excluded when we'd
successfully left RCU mode; otherwise we would've gotten to that
check with error already equal to -ECHILD.

What sequence of events do you have in mind?

