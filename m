Return-Path: <linux-fsdevel+bounces-16099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD9D8982D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 10:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A50CB21E4E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C039679E1;
	Thu,  4 Apr 2024 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="hqQ2aPWv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE2A5DF23;
	Thu,  4 Apr 2024 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217972; cv=none; b=NVZiHqZwMLYdTpCaGU7mLtlCpjsWF5A1JKR2ereZWZ/uzZAV7Mr2m9dL5WQ0T7wiCFOyDT4TtfrHnQfCGar+sfvgaR93m5NICgysZyw+AjlRlgHqddKFr0OD6Xq+vt0U7ulvfxfjtQpz9KIv9+3ZPt7fYl/FLc4q7AwtNhZl0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217972; c=relaxed/simple;
	bh=V0ZzmEqQsQKwVDJeWcxb9WLsHGI8+KEPzrwafFQMJh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJnOlpuTaR5pvnPm1/BfyOvqtpPH6/6qsL7COtOPs4ar3gBoqcIRVrzOdBTQtjNWlJONzyHuLOYlzWsqb8IJJqc6TxFEmbzOF7rvvU0ofcBjsDBwsJfJ2uDO1LWq1UubTBt/fD0g8npbhkwgHqiUBZKmUaG8XDEevuxQkPA/MfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=hqQ2aPWv; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=lvik5pSFcG40Al9cRmT31wTUpqQ/o8j4XMGvq8bSXT8=;
	t=1712217970; x=1712649970; b=hqQ2aPWvnKygWOpZ1E0z6luWkVMjsv4VUpwDBN7by4nk3Kt
	6Jt+WsL0G/SO1DLRyku2oDKJiQfZiHP/sjQXh3tfRXejhkMUbDIhBpYmkkccVnuWhwp8angs9Ghbs
	ggPZugdCaepIWPSJU52J98a1ZBjXODsTnB0qcVVCQbrFw7kLuD+fPzqkx+8lbE9dyNGLI9zZcb4HP
	aygOiTWV/VgGFCgSh4Jb+I0+10biI0PDdC1Q4JVBCPx144mGi2mA0RP8Lv77podZF4UJ2rEmOQafQ
	/OqFsgYx0Zr9XRTQI+hCV/FRa2U8MZWGjOQzUHnMVG+EdE10wTmAcOqah8qix3WQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rsI6m-0003jS-Ir; Thu, 04 Apr 2024 10:06:04 +0200
Message-ID: <a417b52b-d1c0-4b7d-9d8f-f1b2cd5145f6@leemhuis.info>
Date: Thu, 4 Apr 2024 10:06:03 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ntfs3: remove warning
To: Christian Brauner <brauner@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Anton Altaparmakov <anton@tuxera.com>, Namjae Jeon <linkinjeon@kernel.org>,
 ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, regressions@lists.linux.dev
References: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
 <20240325-faucht-kiesel-82c6c35504b3@brauner>
 <ZgFN8LMYPZzp6vLy@hovoldconsulting.com>
 <20240325-shrimps-ballverlust-dc44fa157138@brauner>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240325-shrimps-ballverlust-dc44fa157138@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712217970;d526d445;
X-HE-SMSGID: 1rsI6m-0003jS-Ir

On 25.03.24 13:05, Christian Brauner wrote:
> On Mon, Mar 25, 2024 at 11:12:00AM +0100, Johan Hovold wrote:
>> On Mon, Mar 25, 2024 at 09:34:38AM +0100, Christian Brauner wrote:
>>> This causes visible changes for users that rely on ntfs3 to serve as an
>>> alternative for the legacy ntfs driver. Print statements such as this
>>> should probably be made conditional on a debug config option or similar.
>>>
>>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>>> Cc: Johan Hovold <johan@kernel.org>
>>> Link: https://lore.kernel.org/r/Zf2zPf5TO5oYt3I3@hovoldconsulting.com
>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>
>> Tested-by: Johan Hovold <johan+linaro@kernel.org>
>>
>> I also see a
>>
>> 	ntfs3: Max link count 4000
>>
>> message on mount which wasn't there with NTFS legacy. Is that benign
>> and should be suppressed too perhaps?
> 
> We need a reply from the ntfs3 maintainers here.

Those are known for taken their time to respond -- like we see here, as
nothing happened for 10 days now. Which makes we wonder: should we at
least bring the first patch from this series onto the track towards
mainline?

FWIW, quick side note: just noticed there was another report about the
"Correct links count -> 1." messages:
https://lore.kernel.org/all/6215a88a-7d78-4abb-911f-8a3e7033da3e@gmx.com/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot duplicate:
https://lore.kernel.org/all/6215a88a-7d78-4abb-911f-8a3e7033da3e@gmx.com/
#regzbot poke

