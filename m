Return-Path: <linux-fsdevel+bounces-24013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3F8937932
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 16:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12571F2313C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A703DB660;
	Fri, 19 Jul 2024 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="JZZnt0Tb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565498C06
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399425; cv=none; b=ARQWGs82kb20Qyh47906zE4rInJfmLAjzS7qjbgSTsdND3jlkt7cDTnX1ZXKdfYcHDKf8p8MmoYctDiA9tpU5t7nYxpmikFG2NaSPoD6c9jyT1jEKh25qD666ep+sDKU6HZXBVp9JKuu/ZBpqgIcIElJGvLBDpizA90WafuyeCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399425; c=relaxed/simple;
	bh=EV8YF/xZeTMqPh4i7Ghl7fvFLDOerg3p+GeutAZ97hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pz4WFT//Qpf+Hwgvh4clGz8cmaEKZtdMjwyBrHH/aG4lI/B3fjFD+rNzg1S93tpG8MyLvU7auC1m/nXg3TZPZDFy3OEa8AmxM2M5Vrym274BoBQkgZZBVaIdfcUlYZjmsHDSy1R9gpMj8A3kqppwlx5JGJAMwx8St8+c7nQRFy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=JZZnt0Tb; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-17.bstnma.fios.verizon.net [173.48.115.17])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46JEU1dj024673
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 10:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1721399403; bh=Wb+H9ac9NfOTm/D/TkgZKLQniLuU6Iek81X6nbJI7o8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=JZZnt0TbI8sGXvbmWAVm+ekAM73TouWTuItn7jrR/LWHb+UedBHC32A5XupjKVm13
	 ogIm9Xnc9bA2i0SneLpHYr6BQrXH62O2s/8JKMV9/DUy1iTWyx67iHPoBxL2snBy/g
	 FNfaSisLwRXGDHGhNyA/wIn+zPwHdweZeHExqWqNUsH9b1cNvD4Tq2mN8OoXJxJroA
	 kTyMv7L7is8GDKWQB+u9AbtAxdRIF0zDcnl/Xg3bo6kjtrQbQIpY/+kmNOcIOCM4x7
	 g5Urp2AZLYKOWwetaORsAgY771tViuD662DeocfmZEUaDHf96KA9lozDaU0BHV9Xvf
	 +33U4OQng/jNw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 2A1E715C029B; Fri, 19 Jul 2024 10:30:01 -0400 (EDT)
Date: Fri, 19 Jul 2024 10:30:01 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>, linux-bcachefs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.11
Message-ID: <20240719143001.GA2333818@mit.edu>
References: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
 <CAHk-=wigjHuE2OPyuT6GK66BcQSAukSp0sm8vYvVJeB7+V+ecQ@mail.gmail.com>
 <5ypgzehnp2b3z2e5qfu2ezdtyk4dc4gnlvme54hm77aypl3flj@xlpjs7dbmkwu>
 <CAHk-=wgzMxdCRi9Fqhq2Si+HzyKgWEvMupq=Q-QRQ1xgD_7n=Q@mail.gmail.com>
 <4l32ehljkxjavy3d2lwegx3adec25apko3v355tnlnxhrs43r4@efhplbikcoqs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4l32ehljkxjavy3d2lwegx3adec25apko3v355tnlnxhrs43r4@efhplbikcoqs>

On Thu, Jul 18, 2024 at 06:24:08PM -0400, Kent Overstreet wrote:
> 
> I've gotten essentially zero in the way of test feedback from
> for-next (except from Stephen Rothwell directly, the odd build
> warning or merge issue, but 0day mostly catches the build stuff
> before it hits next).

I am currently running regular testing on the new linux-next's fs-next
branch.  Things which are still blocking me from announcing it are:

*) Negotiating with Konstantin about the new lists.linux.dev mailing
   list.

*) A few minor bug fixes / robustification improves in the
   "gce-xfstests watch" --- for example, right now if git fetch fails
   due to load throttling / anti-DOS protections on git.kernel.org
   trip the git watcher dies.  Obviously, I need to teach it to do
   exponential backoff retries, because I'm not going to leave my
   kernel.org credentials on a VM running in the cloud to bypass the
   kernel.org DOS protections.  :-)

As far as bcachefs is concerned, my xfstests-bld infrastructure isn't
set up to build rust userspace, and Debian has a very ancient bcachefs
packages --- the latest version in Debian stable and unstable dates
from November 2022.  So I haven't enabled bcachefs support in
gce-xfstests and kvm-xfstests yet.  Patches gratefully accepted.  :-)

In any case, I'm hoping to have some publically accessible regular
test results of fs-next.  I've just been crazy busy lately....

	     	 				   - Ted
						   

