Return-Path: <linux-fsdevel+bounces-77178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIEvOzqLj2nURQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 21:36:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A18313977D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 21:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAF9A3010B62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 20:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC22275AF0;
	Fri, 13 Feb 2026 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DxMJqL7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C621A3160
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 20:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771014968; cv=none; b=qjMlsVL5twilsEQ+tlK5F+SeYgsOFt/TvGnzrpS0j4WdsHfbRsXdfRqOzqS7RFUstYPU+8JjTn7Sd1tz4N5CR09JqD8Lo9KiMEJ7NmRwQIml+50tjDTlg6T1guWm1+A8MYTkemdSsdQ8CxJMQPJ3uW5iHZhpIFQ0XFbcSpV7PPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771014968; c=relaxed/simple;
	bh=AKb026XjL6fD4D/JKcwKPy7Fx7+waIesVBqhJT8bxd0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E86Z2qnNxKDdiLvv3ZGk2o0Ye5/tj/G6xHGKRMpfatQjb/MuIrzhKBoMK+3fQGs2mlteb3/QAWu/NooiXvznmQJYJehXAy0qc56YzMfsm6x+bu6sHdD5WN6vaUe0rU0ylFALgSQ3QAYUu3mAnFYkCvkDDK7UssEf0JE0Z+8EtPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=DxMJqL7I; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2607:fb90:3709:ce04:bf4c:86df:148a:f3f5] ([IPv6:2607:fb90:3709:ce04:bf4c:86df:148a:f3f5])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61DKZhVI959920
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 13 Feb 2026 12:35:47 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61DKZhVI959920
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771014949;
	bh=C1aXGLi1vyf0hLGjNBKsOALCyfSI0qR3BVc7+cDQmpE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=DxMJqL7INTZbvFZ+NPm2LF7yWA2ujFilJD8goh0O6ywevNUNj79aIMwdNF4CNfqtp
	 tNVjU/OQ2GEpJ12BzXQD4xCUGtTcnKG+v1NGHnHOWf09toRuwBhh9j/fWoHGNy6jHI
	 0M4cTLjrGZB+67+u6Z6w9xl8bIVahwGAfh2B1uVLsP5JPzz94vj1R8LFjCb+ygPmKx
	 ox6/N6egKbw6lRFy68dQwofC6kFMIg/FrNCpdZkOINOLwZLU5W5HXtzOY87WsxK+Z9
	 DPgc+LIgkPW44Lh1uLqV39PWRTrFbFxWNhv8fOk0cPcJkxQTkdmKyNUgwK9HsCYv/s
	 sXj/cyezfU3iQ==
Message-ID: <302fd715-bc6e-4d57-a8f3-b24a4eb54f1d@zytor.com>
Date: Fri, 13 Feb 2026 12:35:43 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] pivot_root(2) races
From: "H. Peter Anvin" <hpa@zytor.com>
To: Askar Safin <safinaskar@gmail.com>
Cc: christian@brauner.io, cyphar@cyphar.com, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, werner@almesberger.net
References: <1FC2FB1F-BDA5-472D-A7DB-D146F6F75B16@zytor.com>
 <20260213174721.132662-1-safinaskar@gmail.com>
 <1caf6a70-e49b-42c7-81d0-bd0d6f5027bf@zytor.com>
Content-Language: en-US, sv-SE
In-Reply-To: <1caf6a70-e49b-42c7-81d0-bd0d6f5027bf@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77178-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[zytor.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zytor.com:mid,zytor.com:dkim,zytor.com:email]
X-Rspamd-Queue-Id: 9A18313977D
X-Rspamd-Action: no action

On 2026-02-13 12:27, H. Peter Anvin wrote:
> On 2026-02-13 09:47, Askar Safin wrote:
>> "H. Peter Anvin" <hpa@zytor.com>:
>>> It would be interesting to see how much would break if pivot_root() was restricted (with kernel threads parked in nullfs safely out of the way.)
>>
>> As well as I understand, kernel threads need to follow real root directory,
>> because they sometimes load firmware from /lib/firmware and call
>> user mode helpers, such as modprobe.
>>
> 
> If they are parked in nullfs, which is always overmounted by the global root,
> that should Just Work[TM]. Path resolution based on that directory should
> follow the mount point unless I am mistaken (which is possible, the Linux vfs
> has changed a lot since the last time I did a deep dive.)
> 

If that doesn't work, then it can be dealt with by resolving the pathname in
the namespace of the init process *at the time it needs to resolve the path*,
as opposed to having to cache a pointer to the root.

The init process is inherently special anyway, and it isn't like the
additional overhead will be significant for these kinds of heavyweight events.

	-hpa


