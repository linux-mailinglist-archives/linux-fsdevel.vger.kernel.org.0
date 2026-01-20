Return-Path: <linux-fsdevel+bounces-74647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHOTGmlHcWn2fgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:38:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3F05E256
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C8229209D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 13:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF51843CEDE;
	Tue, 20 Jan 2026 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="HTe8UjMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A249543634B;
	Tue, 20 Jan 2026 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916907; cv=none; b=EAhEvJaVCXDqrhSgu2h32lBKtSiLKjGFIyGwPbDaaywYvFIvM9aTSw6jggvO+xN216JLUOYB7XIN/xY2M3K1uUqxdy7ProNy+vHp/wEpeWFk3goRyavSTPCijUrxJ1dvmD87SOgjNK6PEtFkUBe1HdkoxbyN/5BVbzPCEpWfukk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916907; c=relaxed/simple;
	bh=DdCeDquolF/w7F6B01lbUF/rIeGCTbJAYlhr8LWHkJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNI2YjCQxUYqED0XJSTECT7G4YqRxOszl2iv+IdTAnr86H7tGGK1M+v/mbsh9Yqo1yTW03Efr4h1Jycz4WxKK4oQn1VT719u5NGwJDUPTOopUm8gcsqEiyFWIwg8kiNEnIpNMVykMFCwbAxzT7IOEkDMh3q4wgXWU/7uTGw4WJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=HTe8UjMP; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dwTDn1j0Jzlfl8N;
	Tue, 20 Jan 2026 13:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1768916902; x=1771508903; bh=SOAdpbDm0eHpipCEaZSPiJYY
	fuJseVJynyq5vsxpEV0=; b=HTe8UjMPTjFI9fuDL/EbKshTsyDMz8UC31uq9k1O
	Cfy33tTlYI5lLEnOH0qyyH1qVdEMv+/PgjXJ8bQKvhgP9DNWjIhegnWrnqd6He9q
	lGjsPcxa63+y29eQGndXn5GOzJ1Fav8lDjmnjcxuSo/j0FlHmMojrSR1Pn0z4WUx
	OFvKWP7SRWTB4vZ/j2dsu/aujjuu8Mv4+wtauAAGawlQvAmKtOrrGFfqqltPyxSF
	yzPSkobUXBU0Jrz5rNnsCRI51UVfEXB116vMtHoaqYO2R2g1YzqveQbNHCX1bBd/
	e7q5iMjhhmSSpyGE9opMZ/+oJhBRldiPMP+4q64iaxhGQg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TM8u1GgFmxyU; Tue, 20 Jan 2026 13:48:22 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dwTDf2ftVzlfpMC;
	Tue, 20 Jan 2026 13:48:18 +0000 (UTC)
Message-ID: <ac604919-1620-4fea-9401-869fd15f3533@acm.org>
Date: Tue, 20 Jan 2026 05:48:16 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: target: Fix recursive locking in
 __configfs_open_file()
To: Prithvi <activprithvi@gmail.com>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
 jlbec@evilplan.org, linux-fsdevel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260108191523.303114-1-activprithvi@gmail.com>
 <2f88aa9b-b1c2-4b02-81e8-1c43b982db1b@acm.org>
 <20260119185049.mvcjjntdkmtdk4je@inspiron>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260119185049.mvcjjntdkmtdk4je@inspiron>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[31];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[acm.org,reject];
	TAGGED_FROM(0.00)[bounces-74647-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lst.de,evilplan.org,lists.linux.dev,linuxfoundation.org,gmail.com,kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel,f6e8174215573a84b797];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,acm.org:mid,acm.org:dkim]
X-Rspamd-Queue-Id: CC3F05E256
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/19/26 10:50 AM, Prithvi wrote:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&p->frag_sem);
>    lock(&p->frag_sem);
The least intrusive way to suppress this type of lockdep complaints is
by using lockdep_register_key() and lockdep_unregister_key().

Thanks,

Bart.

