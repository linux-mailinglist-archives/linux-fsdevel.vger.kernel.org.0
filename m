Return-Path: <linux-fsdevel+bounces-49386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AF3ABBA42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B745178EA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6817935957;
	Mon, 19 May 2025 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+6JXLC5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D935961;
	Mon, 19 May 2025 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648123; cv=none; b=SQeiryU1zcTaT6XcPn299ojbDd7DOoIO1N6VYag8ej92IbRn9xiZJ9zt/W4p+AXKi1dVgnX6sd4623jQv5Hsw1Kzvmxq//ra6OMp4TOZjDyzw0S8ujmRnBRPv2FDLhRR7Y0Zz5iJeWm2ZYhz0TtySGZq2vg0rElLglg+tZ0R39k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648123; c=relaxed/simple;
	bh=/3ArMFUDk3CDwgactLjkgY3d4YWTpgV4Iv5e1mlvnqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIpUKpuxHVJvYK6obVrxGUZm5bs009MXfPfhDyCZ0uQ/85Kx2DmvpHj/pF2CJqVsHv63wSVrBe7kYViGtFx2m6WO+ZM6OkM9yTgtQ9eShZWtzfI6eicxNVJD5qzfw7LJilBZkhn3LzjQz79hRE4jg+m+uWxMBEP0dJ5cm4kzWm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+6JXLC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7092C4CEE4;
	Mon, 19 May 2025 09:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747648122;
	bh=/3ArMFUDk3CDwgactLjkgY3d4YWTpgV4Iv5e1mlvnqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+6JXLC5HqzTBiOMIv745yuYXbYZGa64HF/xeCqN3wBh6DaPwA7cKVVF4ShdSo2uV
	 DNoYctb4jvMcVLUUi2TU8noClNDWsWSBBIEHnNc1AhRmXXBdphesLft36Cgn3TETtU
	 AQglqUarQLEbV0Mt66nJo2a6luXaowgByI+e8E67/y5fY0wWZDqDRuRQmzOdz3ARAT
	 bTBSHhw+EcehJy/sDf2Be2FSTZLNiSXN/7ygHvsT/Q5NQjWcDmFVMIx9r0mE1ksHKg
	 MTneG20OEh26zWdWGUwpzSP4VYsGX/r7m96w2qtG3st7DjS+RRSgz57Q415eL9eRfY
	 yYvpSBDwsSkvg==
Date: Mon, 19 May 2025 11:48:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alejandro Colomar <alx@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org
Subject: Re: close(2) with EINTR has been changed by POSIX.1-2024
Message-ID: <20250519-rauben-geldentwertung-3f18b3c8876c@brauner>
References: <fskxqmcszalz6dmoak6de4c7bxt4juvc5zrpboae4dqw4y6aih@lskezjrbnsws>
 <ddqmhjc2rpzk2jjvunbt3l3eukcn4xzkocqzdg3j4msihdhzko@fizekvxndg2d>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddqmhjc2rpzk2jjvunbt3l3eukcn4xzkocqzdg3j4msihdhzko@fizekvxndg2d>

On Fri, May 16, 2025 at 12:48:56PM +0200, Jan Kara wrote:
> Hi!
> 
> On Thu 15-05-25 23:33:22, Alejandro Colomar wrote:
> > I'm updating the manual pages for POSIX.1-2024, and have some doubts
> > about close(2).  The manual page for close(2) says (conforming to
> > POSIX.1-2008):
> > 
> >        The EINTR error is a somewhat special case.  Regarding the EINTR
> >        error, POSIX.1‐2008 says:
> > 
> >               If close() is interrupted by  a  signal  that  is  to  be
> >               caught,  it  shall  return -1 with errno set to EINTR and
> >               the state of fildes is unspecified.
> > 
> >        This permits the behavior that occurs on Linux  and  many  other
> >        implementations,  where,  as  with  other errors that may be re‐
> >        ported by close(), the  file  descriptor  is  guaranteed  to  be
> >        closed.   However, it also permits another possibility: that the
> >        implementation returns an EINTR error and  keeps  the  file  de‐
> >        scriptor open.  (According to its documentation, HP‐UX’s close()
> >        does this.)  The caller must then once more use close() to close
> >        the  file  descriptor, to avoid file descriptor leaks.  This di‐
> >        vergence in implementation behaviors provides a difficult hurdle
> >        for  portable  applications,  since  on  many   implementations,
> >        close() must not be called again after an EINTR error, and on at
> >        least one, close() must be called again.  There are plans to ad‐
> >        dress  this  conundrum for the next major release of the POSIX.1
> >        standard.
> > 
> > TL;DR: close(2) with EINTR is allowed to either leave the fd open or
> > closed, and Linux leaves it closed, while others (HP-UX only?) leaves it
> > open.
> > 
> > Now, POSIX.1-2024 says:
> > 
> > 	If close() is interrupted by a signal that is to be caught, then
> > 	it is unspecified whether it returns -1 with errno set to
> > 	[EINTR] and fildes remaining open, or returns -1 with errno set
> > 	to [EINPROGRESS] and fildes being closed, or returns 0 to
> > 	indicate successful completion; [...]
> > 
> > <https://pubs.opengroup.org/onlinepubs/9799919799/functions/close.html>
> > 
> > Which seems to bless HP-UX and screw all the others, requiring them to
> > report EINPROGRESS.
> > 
> > Was there any discussion about what to do in the Linux kernel?
> 
> I'm not aware of any discussions but indeed we are returning EINTR while
> closing the fd. Frankly, changing the error code we return in that case is
> really asking for userspace regressions so I'm of the opinion we just
> ignore the standard as in my opinion it goes against a long established
> reality.

Ignore. We've long since stopped designing apis with input from that
standard in mind. And I think that was a very wise decision.

