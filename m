Return-Path: <linux-fsdevel+bounces-53719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9783AF6234
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863B61C47543
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F8D2D9EF4;
	Wed,  2 Jul 2025 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="iE/jubqi";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="fjDuO26c";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="SW26/YE6";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="b/DrPuw6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9402BE651;
	Wed,  2 Jul 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482788; cv=none; b=qnyJnC3GPFCI3fZ3zPYwhRzGLBMaygt7hEvx3T9ab3hMhash+Ag67/9EFXh1X8JY6E9nK/2cEJTpnITGKU1Fr/ft98Tb/wQ29LLbypj5s8fJSno2Fgg67YwQMfUwU62K5sJyP7Onf8dbf3liRIWYGfE9s9SVN8Rg2pS0nkxSvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482788; c=relaxed/simple;
	bh=QHrXzmhcjq+tf7zFyEmmqMNmhAWNPWCstCoYDwuWjt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXQ4nqDK014vOIaA4u9ai0rhoHw+XAyK2Onk1DeVzYujocoU9fwB3OJglVPHJt+nptawRwpWIYSKLr+gmn+LR+EF7nmLFgOx4gxBzqJrfgGvzNa6sGKG4qNC9qSgnR4xQYm1wbeDWi0f9JGhY8X4diIbOOrw/vWJLYx0KP6ow28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=iE/jubqi; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=fjDuO26c; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=SW26/YE6; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=b/DrPuw6; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:41c4:f6bf:9765:d776])
	by mail.tnxip.de (Postfix) with ESMTPS id D18DD1F508;
	Wed,  2 Jul 2025 20:49:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1751482193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QHrXzmhcjq+tf7zFyEmmqMNmhAWNPWCstCoYDwuWjt4=;
	b=iE/jubqic12yzgfhguECgeXwFLfaUdG2lbDggyuFT+JWIUHNFDBlFSVu/9MgMtlVdOLcoz
	H/coId7izuylyqJ+hqijSp5ID+bPXU+7vwcurTVEsOiqTbiC501yu7CMJBKfpVXLBuYPh7
	HxHpmOpr1Z7xUOBZ4aP78nMgzHHHhOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1751482193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QHrXzmhcjq+tf7zFyEmmqMNmhAWNPWCstCoYDwuWjt4=;
	b=fjDuO26crbRSF0bVmRO+lJSefRPFWJRBYPGhr+dDlMSMAnchwjBB8rNZPjfMX733mGTh60
	+bY5NGp4tGSfhZCw==
Received: from [IPV6:2a04:4540:8c04:1600:d42:34ad:c501:6cc5] (unknown [IPv6:2a04:4540:8c04:1600:d42:34ad:c501:6cc5])
	by gw.tnxip.de (Postfix) with ESMTPSA id 8478B3800000000017FE8;
	Wed, 02 Jul 2025 20:49:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1751482193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QHrXzmhcjq+tf7zFyEmmqMNmhAWNPWCstCoYDwuWjt4=;
	b=SW26/YE6Nkw2wtr2YrG7+Q3tv/OJT1Wg1NHQYybgyPXTvQr/+iTwJCJm5/QjI+LD25TJn2
	kTk6d88O3HIkpMXnUUP1+f1PiPQ2Q/Btf8PaghEhxVeKpevNAirIpx4huYwgtaH9V4NK2F
	l9xwKzgQPaHi7ZjV8QZ9TUtDr6ZnErA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1751482193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QHrXzmhcjq+tf7zFyEmmqMNmhAWNPWCstCoYDwuWjt4=;
	b=b/DrPuw6PzjFdtZoIVuocUtrnF94Giab5lQ0S7r/Lr8J1GpMMxzkHVXIR/QdR13+r5EcWi
	fDXrA+72zNNjplDw==
Message-ID: <a448243d-8ef8-48d8-afbc-2c45068c882c@tnxip.de>
Date: Wed, 2 Jul 2025 20:49:32 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc4
To: Kent Overstreet <kent.overstreet@linux.dev>,
 "Carl E. Thompson" <cet@carlthompson.net>
Cc: John Stoffel <john@stoffel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
 <CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
 <xl2fyyjk4kjcszcgypirhoyflxojzeyxkzoevvxsmo26mklq7i@jw2ou76lh2py>
 <26723.62463.967566.748222@quad.stoffel.home>
 <gq2c4qlivewr2j5tp6cubfouvr42jww4ilhx3l55cxmbeotejk@emoy2z2ztmi2>
 <751434463.112.1751478094192@mail.carlthompson.net>
 <fomli5univuatcdc7syty56wffm4uvslocxkufks27otyix7fl@6c5i7w7g64qo>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <fomli5univuatcdc7syty56wffm4uvslocxkufks27otyix7fl@6c5i7w7g64qo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02.07.25 19:53, Kent Overstreet wrote:
> On Wed, Jul 02, 2025 at 10:41:34AM -0700, Carl E. Thompson wrote:
>> Kent, at this point in bcachefs' development you want complete control
>> over your development processes and timetable that you simply can't
>> get in the mainline kernel. It's in your own best interest for you to
>> develop out-of-tree for now.
> Carl, all I'm doing is stating up front what it's going to take to get
> this done right.
>
> I'm not particularly pushing one way or the other for bcachefs to stay
> in; there are pros and cons either way. It'll be disruptive for it to be
> out, but if the alternative is disrupting process too much and driving
> Linus and I completely completely nuts, that's ok.
>
> Everyone please be patient. This is a 10+ year process, no one thing is
> make or break.
>
So as a user usually hanging out on IRC and running Kent's trees:

I think most of those people actually testing bcachefs are either
running bcachefs-master, -rc or some outdated distro kernel. From my
perspective I'd think it would be good enough to push for-upstream
during the merge window and then only provide further patches if there
where regressions or some really bad bug appears that actually eats data
(like the one that bit me). If it's "just" stability fixes, well, if
people running a distro kernel hit those bugs they'll need to build a
-rc kernel anyways to get fixes, those could just build bcachefs-master.
When running Linus' tree I am aware and accept that I am not running the
absolutely latest code.

I've had some pretty bad experience with amdgpu requiring out of tree
patches to get my system running free of glitches, which took months to
get into upstream. It's annoying, but I accept that.

I'd rather have a slightly outdated bcachefs in kernel than not at all.
It is good to have a distro kernel I can fall back to if I mess up my
own kernel building ;)


my 0.02€

/Malte


