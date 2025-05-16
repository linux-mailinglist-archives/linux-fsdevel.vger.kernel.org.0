Return-Path: <linux-fsdevel+bounces-49253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 977F0AB9C65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 14:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6248918980F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AFD241693;
	Fri, 16 May 2025 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICZmrBrS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB95024166A;
	Fri, 16 May 2025 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399280; cv=none; b=huU1xsyXAW2423pYSSFtMRcwkhWMtazHFQHPs7ffgv7wrLJ3YCAjJ2dPtHrdWjO/HFmTzds0eF3XBvejJ+xBppsqmDZTxIMaSdc9WXeiKrgYCosys3QEplHvSObQRUBrU4B6l6aokWXI1+AS7tDGGchjxF/SmYPtDRYWpAycSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399280; c=relaxed/simple;
	bh=W1LnMroB/BfHUS1m8h58WOZrv8gmAr5UnqYWSeJMj6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+rCuCRFajJSiD1Uly/JB2fiu1P7Jf6gUVKHUdEU04w+oNZMaAoZsk5hvY0W55/6edkNiDPY472gP4vketvARuDiPaSN6mldfOCMkjcTFPRsxAfpHiaxr+s9kd8lKOaLQHvuOz9qiR3xZzFZEtrZCMIF3hp6reWrze2K4Mw2ab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICZmrBrS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fca2805ca4so3155502a12.1;
        Fri, 16 May 2025 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747399277; x=1748004077; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V7NUGr2BVJhHBDoLt3wMB0yrF5gFmUvtd5fZ0Ivln8c=;
        b=ICZmrBrSM2+Pcv0UpAMoqhkNoPfFB+gmgPYLyfZILjomorLFwTMWF8vMw6D47G7asa
         4f00zE4Fgmi0nYBuPB1VbPO/jG5tPZSYGExjwbUt2i1v6WCHQtTKJlEP9ibINMRBnQ6P
         ASsEa4rV0E41RSlMg4ahxlTiOqZHdkBrrjB/5/SKavR0qbIjOcJAQnj3DKVKC8cpTshh
         9rFrbNBJ2rVLSy3wI2zrVd2CJcNStVAjwmqJePCsGcYRAO/j8nRglfjWh4hQlH+lFEBr
         MWkvuJO70I1+A0uAPgQqFaR8gw/MIOW5VB8fbJjxjadKrcZUhBddDRip2nSpavIqCoBd
         YXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747399277; x=1748004077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7NUGr2BVJhHBDoLt3wMB0yrF5gFmUvtd5fZ0Ivln8c=;
        b=JYElymuOLypnSUT89ovGEitBonfSEaecHgbB1nAihx+ofO3QdmaBV9SEtPEwgjT1Gq
         Vws0qSeww7mWy6Vl6xhxb4GBDOLiHPhCmCd3FhpUu+2FcYEvNTmqkqRJ1eVIQ+GcLNHd
         s+4PoAIlCrVJou3L2jHEssIwI0boNrvuvdHrFHs36MqXVfJIMt7pIoGBIR/dMa/I4AY8
         V5LGIMLPBeRLwkCuBRsVMI3ZNLQ4ZhqVLoiyTM5cmfAw3YvpzuA+8eHvlotrm5TacnO+
         KEW2AIkg+iHq1ff5sEnUBruQ6Kc9D1GYcnxV9n6fewG4Mc/XERVr3659H//k15bf2x8E
         LOVg==
X-Forwarded-Encrypted: i=1; AJvYcCUxIvYQP39qTRinnVL3E+ghvyG+o7B0tz/73JR37Nl/TgeIVoJex6vWJ7evcIOeNhxsgIoGNdODzUs=@vger.kernel.org, AJvYcCWNeGfwIlstEawuG8TyPASwys5jy/6OC3knvnMFerf5krsdSte1bfVZcTiet0H0gIG+GSOxiLfrs5af@vger.kernel.org, AJvYcCXyc3mKA0ivqH927ylBAnI5EP3bw3hT4adOxZcyOmU5seFMvh+pwhrC7Z95P8QbyChqPV+E6wxJRdiTSN32Wg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5pzi8l4m1T+p4C+R7w8qZ5lSmD6/Zwb0Qn/ywJDGTSfCID8C
	1x+Wi2x2rHddADUhcngEMWRCw2eJ+1yCO1flBqVQX26ovsgCb+vKy7kj
X-Gm-Gg: ASbGnctk/8J19ayFmbskhwcQVIJE4810syPMF0t1kxfNejvikTg6mxrGHbii0DO1PzF
	AfHgICopcgf+4bAoJX3FDTaIjoDfjGxZVxw6Ci+KHuPAg4Sd133AR+594dVaIKH30Fjy8gPKy9W
	tztF7aaqRFPRBcxQa0tUivF9R2jH68MCge3ZuKsVz9aFDdL5/L7KHVlT2SHQ3oG38y6Q1OO0OAE
	C7By20qEK3sbjy1RUFW34TZ8A7BCVrwVrv/YfGYcRja+y5MgRfRJ/fM5RxrQmG51j4jEOVIN0Bi
	AgSm+8CCCzQFT79QFLXbEl5JXH74mOZYzP2Qi2c2OH91ia/S0l+cejeE7pAKdTYE
X-Google-Smtp-Source: AGHT+IFTPI2eQkud84FVoFUn8Zc73GAgtlNkErrz3SQM/mI7Y/+0S4tj4ZpolxGMcygIO0zxmFl+6w==
X-Received: by 2002:a17:906:3491:b0:ad5:40ab:ad38 with SMTP id a640c23a62f3a-ad540abc1d8mr94982366b.51.1747399276851;
        Fri, 16 May 2025 05:41:16 -0700 (PDT)
Received: from f (cst-prg-82-53.cust.vodafone.cz. [46.135.82.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d437585sm152105866b.115.2025.05.16.05.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 05:41:15 -0700 (PDT)
Date: Fri, 16 May 2025 14:41:09 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Alejandro Colomar <alx@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: close(2) with EINTR has been changed by POSIX.1-2024
Message-ID: <x5mnkxiljojscijzkerut3zmijzxsxeqsjhdozqlxv25lglxsh@zxam27ia6gtw>
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

I wonder what are they thinking there.

Any program which even bothers to check for EINTR assumes the fd is
already closed, so one has to assume augmenting behavior to support this
would result in fd leaks.

But that crappery aside, I do wonder if a close() variant which can fail
and leaves the fd intact would be warranted.

For example one of the error modes is ENOSPC (or at least the manpage
claims as much). As is the error is not actionable as the fd is gone.
If instead a magic flag was passed down to indicate what to do (e.g.,
leave the fd in place), the program could try to do some recovery (for
examples unlinking temp files it knows it stores there).

Similar deal with EINTR, albeit this error for close() would preferably get
eradicated instead.

Just some meh rambling.

