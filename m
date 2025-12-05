Return-Path: <linux-fsdevel+bounces-70814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B231CA7860
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 13:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FB0230299DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 12:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5DB32E6BF;
	Fri,  5 Dec 2025 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="XL72UuDv";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="DGPX8Nhp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42A313E05
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764936552; cv=none; b=M/G0pBMKjI2U6TmLJEHC7hjhZiJPqfhjKqyOmgkg6Im6QgvH9ZaKuP+aDjQDHZkBImhoFkqVlFSAikx0Cw07OQEOLuF1RB7WFwDzZM8QAQozIzxT82MOj3BIFfasb1tCHi2VGvoo/u6vw3VZmWvp9Y4L3jAIAMuHkUbwJY4GHX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764936552; c=relaxed/simple;
	bh=LaOiU5bWnuebDcDGPmZl4kS1pqOs9u+qoKUghe2ucy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fy/OdbiPhOLzqPrRrRc43HwPY8/iUwrTLuDDGFsjigahSUGTXXmboMoLLI3BRfD/YK6yyyTXU4JqnrUblDItqg6Ar1kHkHK2xK9HO0BJsG1hdTq0KThsKiE83eh0tKP20yfpFLMVXU/dnce1iS1DPW4go8o3RYzlbUcYWDpKa+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=XL72UuDv reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=DGPX8Nhp; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1764937449; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=nDQbuCR0xlv5qS7HgYyT3GoyUmABzZVoQRnEZkWUh3E=; b=XL72UuDvrjc4+s3dnPfFDnhos/
	xfeMHNB9EM4SUMg7AJ09Z1iilfFFrktcdNBwbQ1p79E+TH9V7XklFW4/cVtCEekdRNVMmJnwe+Nu3
	Vw6/4jODAqlRJkDjogbYxJmX+q/I+50v5U+hQ2ecufJNfFIAumZEq6up8wGZERerOlzTZepZ+fgre
	e6Eal6YbPXmNn2MP/N4c2TIJKjCWaZtWglvpL6FrtmAxKoae7n9F1JbsoSL4xH1zl3GEQ/5DSUDKS
	l/QCrv2+IzeIt+cQ8WmggGSI4IJTOL9cXf5pDR/gzJr6BmxC5pmRA2WmAiWpf2RkHJboCCWvGAya3
	mmE1sbrQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1764936549; h=from : subject
 : to : message-id : date;
 bh=nDQbuCR0xlv5qS7HgYyT3GoyUmABzZVoQRnEZkWUh3E=;
 b=DGPX8Nhp+hjyaROAcTAle079W7supvqWuk1SL0tEkjubOVP5531R/cJUJL0E7nStyx2aD
 91djG45BOesqYIOrmDV2Bwi2feXhLyz5+Xt68H2mmwZBi/FK7EU2gLugJ91cAgQZChXoHcQ
 lcVx1nk5rBx8AHsagtUr8AvJ1FOr0srQIjw+AGb1maMFBpJ+q7LqzLGN/kkQMfzenLRJ8hK
 BP+g2mgFJ5yP/yVmnivcGyQaqQRXmI9msA0DgjtVOQGB3v/CWbi3kUbNaR045fUBPCKSgxs
 QXixudrVVZQOx/sUsLmFO+yRPv0YamxUL+dbwpjaJf7G1b5pV307pTs+uSOw==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vRUcA-TRk4wX-Kz; Fri, 05 Dec 2025 12:08:46 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vRUcA-4o5NDgrjBW5-lSAe; Fri, 05 Dec 2025 12:08:46 +0000
Date: Fri, 5 Dec 2025 12:53:04 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Sandeen <sandeen@redhat.com>, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
 eadavis@qq.com
Subject: Re: [PATCH V3 4/4] 9p: convert to the new mount API
Message-ID: <aTLHoPiC93HTc-VM@pilgrim>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <aOzT2-e8_p92WfP-@codewreck.org> <aSdgDkbVe5xAT291@pilgrim>
 <aSeCdir21ZkvXJxr@codewreck.org>
 <b7b203c4-6e4b-4eeb-a23e-e6314342f288@redhat.com>
 <aS47OBYiF1PBeVSv@codewreck.org>
 <13d4a021-908e-4dff-874d-d4cbdcdd71d4@redhat.com>
 <aTBTndsQaLAv0sHP@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTBTndsQaLAv0sHP@codewreck.org>
X-Smtpcorp-Track: 5rxZ8ULxq7tK.k3wksMRbOUlC.McHEmwzT3Wk
Feedback-ID: 510616m:510616apGKSTK:510616sykM-zowXn
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Thu, Dec 04, 2025 at 12:13:33AM +0900, Dominique Martinet wrote:
> Eric Sandeen wrote on Tue, Dec 02, 2025 at 04:12:36PM -0600:
> > Working on this, but something that confuses me about the current
> > (not for-next) code:
> > 
> > If I mount with "cache=loose" I see this in /proc/mounts:
> > 
> > 127.0.0.1 /mnt 9p rw,relatime,uname=fsgqa,aname=/tmp/9,cache=f,access=user,trans=tcp 0 0
> > 
> > note the "cache=f" thanks to show_options printing "cache=%x"
> > 
> > "mount -o cache=f" is rejected, though, because "f" is not a parseable
> > number.
> > 
> > Shouldn't it be printing "cache=0xf" instead of "cache=f?"
> 
> Definitely should be!
> 
> > (for some reason, though, in my test "remount -o,ro" does still work even with
> > "cache=f" in /proc/mounts but that seems to be a side effect of mount.9p trying
> > to use the new mount API when it shouldn't, or ...???)
> 
> ... and Remi explicitly had cache=loose in his command line, so I'm also
> surprised it worked...
> 
> > I'll send my fix-up patch with a (maybe?) extra bugfix of printing
> > "cache=0x%x" in show_options, and you can see what you think... it could
> > be moved into a pure bugfix patch first if you agree.
> 
> Thank you! I would have been happy to see both together but it does make
> more sense separately, I've just tested and pushed both your patches to
> -next
> 
> 
> I also agree the other show_options look safe enough as they either
> print a string or int. . . .
> Ah, actually I spotted another one:
>         if (v9ses->debug)
>                 seq_printf(m, ",debug=%x", v9ses->debug);
> This needs to be prefixed by 0x as well -- Eric, do you mind if I amend
> your patch 5 with that as well?
> 
> 
> Remi - I did check rootfstype=9p as well and all seems fine but I'd
> appreciate if you could test as well

I just tried your 9p-next branch and the issue is gone for rootfstype=9p
using cache=loose (I've also made sure that I reproduce the issue without
the last two commits of your branch).

So yes for me that fixes it, thanks for the patches.

-- 
Remi

