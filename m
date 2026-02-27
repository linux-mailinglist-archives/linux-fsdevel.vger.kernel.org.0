Return-Path: <linux-fsdevel+bounces-78741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECbrBh69oWmswAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:49:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8643A1BA456
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 965B03121640
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B443D43DA32;
	Fri, 27 Feb 2026 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz+Cv1Rb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510912877C3
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206868; cv=none; b=GEwaMRDtUReUwDo0tujOqcY2gxv9v7D87iSS069HA4Qkn+yzgvL0a3fHPHSoruuYvG5K6XHKcdtNPAasOzth1vWOueLBdF/05VqRQT+D5UJ6KfwNBUl1q/vPIqeO8mLkMT3wbCu5IcuzwCGvuCOsIKZyz03kbNI4yxvsyQWWYfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206868; c=relaxed/simple;
	bh=nX/jHH44bl+AlT2PlBDE3dEu5Z+loqlx8IDa3H7UJKU=;
	h=Subject:To:Cc:In-Reply-To:References:From:MIME-Version:
	 Content-Type:Date:Message-ID; b=sgO9zh2PxriNub5XtVjQvOQJM4O6iS0gxPcDs7//l/hHHBbBRQlV1i67N/MlsHuVIUtSQSK8KgMHzI4Z0L/nSlhVvbLXRTRWH7sX0hRWxlsh79KLMlmXeheT5jxzCq8hTv2XxfojukDOZDijEqBjIJ48LI1C3uNMRkWRaCikiAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wz+Cv1Rb; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82748095892so835090b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 07:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772206866; x=1772811666; darn=vger.kernel.org;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=s2jOgbxrjWDyh4FLNcSqpUzf8JY36cLv1UD8DXTlkg4=;
        b=Wz+Cv1Rboj5WOeNbtKw4xp8fsEuPM6Qq4Ia/XbJOd3Evd6DVjMGJFhWj6s60tDaAmj
         8ua3L8qhpoD7GbzD6a4NKTlXgmU+QlBWjHKycSFpKxOol1lBVbcfhkaDMcUn6RFlzfSB
         W4Jbx3t3XWFYkX0pv8bj0MjfSbgzhWCILiU3oHnrRUF7wqDYYEpvuSHhlh6BIN+OXeGV
         8hBz9u6Lwz4ApG5fwU3D7HtMLcTwuTomkmw+3R0zneqBIPMkMmnSfIMcdZm1swlxyt4x
         4HLsLRPb3RowZ+D0oIIjxThRfeynwmA39ZdkefECPV0xZg5RchY04VLqzYXzDZxM+Tni
         dq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772206866; x=1772811666;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2jOgbxrjWDyh4FLNcSqpUzf8JY36cLv1UD8DXTlkg4=;
        b=UmFTc1xn39LeJj5GwVEus3zhH0yppR7IjMsqOzSd9gaXchxqXqXIAYrmB7MJt59Ye3
         cGic4OQddox19YW47PQpGTo6slQDm958n1AYLRSR9wOHj1bp5ERuPUM/qpaLp4msFNiT
         RR1lD4yEVSG7pfyxdkjwa3Z2yNUR+5ETmH/dohYl7LPfr9eMzPvq95YxPmfHdehTw9nR
         3mf7Tojjybfh1OHUzO26yFC7YYfZam2etjiI/iiIhunYmSzXJoKkIUcaY4qOfSeTtwG5
         UHyzH8YmMuGQKBwhyULWWtmEg4H4NKyIxvlzhnVZKJFBLRMaRmm4QQ0ZDbvJhpQncIEU
         0+iQ==
X-Gm-Message-State: AOJu0YwUlryh5V0A8GCY0/2pMAvznD8W7dlYxVtezi7Hwslpxw/MdrRU
	F9uRXcPWOdY/HskipUM0uACGafacrMZaDWwLDflVQMZikHPxSCCWerpEJSSGRA==
X-Gm-Gg: ATEYQzwHlWzEqmDlykhHo+cj+uFMIaD9ZMbNqeNPPTvCcmn8JVNXWFTHeafITIWezBU
	HN0YFWHVAzO4HE0hT0U+u8/UgiYtEYdD1B/+1p5wn9MMk/tqMZWHdGuArIXCM8YqHj35/NSKMJg
	DNRnG7A3a72bd8u4CDTr070dzt0Im2hhO6s9AJD2gdIz5uIDMq48afCFC6FF20yf99NWWAZNb41
	cj3JVP5f8wq22iVf55rQt6ZC+fOTrwhHy2YUONQImqO7JFtZZiRySRsen1Dp8M/823Ddf+nkHM3
	8E3aeUlOhVdl6ZyQ4DPqGWakSjs/0/36lOz+H7wdo9ZYPsZtoyiJJT0AJ4uwtWqg4IST572uxeU
	revtJUHdhv65PmCrqPHi8+pMsABs7m4lOuOykwJviTlRI5j9P8mfuC8m0XFHRC8FpqNXHj3hZ+R
	+eByqqONs2klv5FOVM6Qxp9v5VC/hTSyoDWmg4UDaclVzWHVZUKp/oVqDaQL5cA3BC
X-Received: by 2002:a05:6a00:e0a:b0:823:652:d2a8 with SMTP id d2e1a72fcca58-8274d921f6bmr3271249b3a.5.1772206866201;
        Fri, 27 Feb 2026 07:41:06 -0800 (PST)
Received: from jromail.nowhere (h219-110-241-048.catv02.itscom.jp. [219.110.241.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8bcd3sm7327529b3a.20.2026.02.27.07.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:41:05 -0800 (PST)
Received: from jro by jrotkm2 id 1vvzxg-0006qM-1j ;
	Sat, 28 Feb 2026 00:41:04 +0900
Subject: Re: v7.0-rc1, name_to_handle_at(..., AT_EMPTY_PATH)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
In-Reply-To: <20260227152211.GB3836593@ZenIV>
References: <14544.1772189098@jrotkm2> <20260227152211.GB3836593@ZenIV>
From: hooanon05g@gmail.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26308.1772206864.1@jrotkm2>
Date: Sat, 28 Feb 2026 00:41:04 +0900
Message-ID: <26309.1772206864@jrotkm2>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78741-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hooanon05g@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8643A1BA456
X-Rspamd-Action: no action

Al Viro:
> This
> struct filename *getname_uflags(const char __user *filename, int uflags)
> {
>         int flags = (uflags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
>
> 	return getname_flags(filename, flags);
> }
> is where AT_EMPTY_PATH is handled; could you check the arguuments it's getting
> in your reproducer and argument passed to getname_flags()?

getname_flags() is not a problem.
For me, the problem looks that LOOKUP_EMPTY is NOT passed to
path_lookupat().


J. R. Okajima

