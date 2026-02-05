Return-Path: <linux-fsdevel+bounces-76458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JCqDfrGhGk45QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 17:36:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83633F54CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 17:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA6A83098A05
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 16:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF65743900D;
	Thu,  5 Feb 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Z3uG1hcR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222013D3488;
	Thu,  5 Feb 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309057; cv=none; b=PYDc8QMw1uqBggvK1FqKh4ywJU2l0/ygPmEwcdWaEa7VVWuELQaEB/2ll0J90RuyWmKd1DFSEIWFIhpi69sUFkhWjDzA4F1A2ve98eeYtIbT97SNiuOsEnBrX1eAj9jPEL/6LjzyEZnBBHuMZhBooRLis0/7JExRXUwKwscSp5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309057; c=relaxed/simple;
	bh=8TG+lTgRzgGsPO2DgnP1ru1aDD9gu26O85oU6t1o9Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CCQHepIYvb4qtvxxh/GekZifF2f1ADVmeyYx/SvS4QZ2DhNGqmQ+CW5Ovkast6ERcjw+akGLN7GJ4Bw2SJ+P/4XNLEFbl3o9FLruGX/AdnFL5RQmu3/SxRgTVXEvw5xieI0yprkxHJgbeW5tJpP5oURXs22k5ViK11zVOaGOsH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Z3uG1hcR; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4f6N4w55RnzlgyFx;
	Thu,  5 Feb 2026 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770309055; x=1772901056; bh=fbcV4cnmo4NZOCdTRC3DqWxy
	r72GNnL+1HdHZL0/F2Y=; b=Z3uG1hcRVJVWZ2y1wmKM1OgwF1mKBki8FPc6Wfne
	uGhRueKRBsNN7WrEIOfYFPkfFdWxj7qPpxSHGDIRR0jhQ4/WXwR1fWw7zsZ1Gymk
	BqHBVbCQK//w8lsDw2spuOSo4u6VfK6ArBNtLU6hP+L2O5fBA/o6gJ/vu5MKHQJS
	qeYB/NwoaesOchSN69g/SSdGllzWXm62GaNRLAzbTWkLRj3gCUamQ/Z8lOX7R9m9
	DDn3XLVItWSwtcXe+q2aFluebm135rZfml3xLe2d2J55irxv2NX7YKWgPPsZTRMg
	qjjLN6Au/YAQMOeVDkxjgmJcWZOItEuKbpCCudbuauqQtA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id lDPSgkPPM4F5; Thu,  5 Feb 2026 16:30:55 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4f6N4t3n1tzlgwMq;
	Thu,  5 Feb 2026 16:30:54 +0000 (UTC)
Message-ID: <8075dab2-49db-408e-bff6-5de6b0b372cd@acm.org>
Date: Thu, 5 Feb 2026 08:30:53 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Documenting the correct pushback on AI
 inspired (and other) fixes in older drivers
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org
References: <32e620691c0ecf76f469a21bffaba396f207ccb9.camel@HansenPartnership.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <32e620691c0ecf76f469a21bffaba396f207ccb9.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76458-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83633F54CF
X-Rspamd-Action: no action

On 2/5/26 1:51 AM, James Bottomley wrote:
> I'm not even sure they're all AI found [...]

Some people use the checkpatch output or scripts from
scripts/coccinelle/ to create patches (I don't do this).

> I'd like to see us formulate a document we can put into the kernel and
> point to when they come along. Probably formulated along the lines of
> "first do no harm" and pointing out that every "fix" carries risk and
> we have to set that risk against what we actually get in terms of
> benefits. So require the submitter to specify:
>=20
>   * What are the user visible effects (memory leak =3D none), transient
>     bad stats data, or actual data corruption or kernel crash (latter
>     being most serious)
>   * how likely (or often) will this be seen?  If about once a kernel bo=
ot(
>     or less), at this point if you have anything less than corruption o=
r
>     a crash, don't bother fixing it because the effect is too minor
>   * For bad stats data, is there an existing tool that uses the data, i=
f
>     not don't bother and even if so show it leads to issues
>   * How was the fix tested (to reduce risk) i.e. do you have the
>     hardware or an acceptable emulation? =C2=A0If not, report the issue=
, but
>     don't bother sending the fix.
>=20
> I think this is just a starting point, and, obviously, it's a bit
> driver centric, but we can probably add generalizations for filesystems
> (and even mm and bpf).

We don't want to forbid tree-wide API changes, isn't it? See also
Documentation/process/stable-api-nonsense.rst.

Sometimes I post patches myself that only have been compile-tested.=20
These patches could help with deciding where to draw the line. A few
examples:
* [PATCH] scsi: mpt3sas: Simplify the workqueue allocation code,
   January 2026
 =20
(https://lore.kernel.org/linux-scsi/20260106185655.2526800-1-bvanassche@a=
cm.org/).
* [PATCH 0/2] Fix locking bugs in error paths, February 2025
(https://lore.kernel.org/linux-scsi/20250210203936.2946494-1-bvanassche@a=
cm.org/)

Thanks,

Bart.

