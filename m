Return-Path: <linux-fsdevel+bounces-78803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACpqAtkdomlMzgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:42:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 983621BEC3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4E843061C7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 22:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A3A3D902B;
	Fri, 27 Feb 2026 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwXzja3n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFEB2DA749
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232150; cv=none; b=sRn23eXZkHmNqBFBoBI0lrHT9W9vpESq43Nuj00TN6wdsYjvx2X9U2ZlvRTv/IMrtYASaocyHav/Yt/WlEU/1AhOGxHAy7AVxuF/lxIMjF9OntxNwYaWpvMWtNKUKgXnAWQYV+2gy6lgfnFEGTT/za0Qziq3xc5/mX4APx9mCAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232150; c=relaxed/simple;
	bh=bvvF1sfeO0OrUxbSoQYtyRk/sV5o+XzBFzSbTrzIk60=;
	h=Subject:To:Cc:In-Reply-To:References:From:MIME-Version:
	 Content-Type:Date:Message-ID; b=SU12wu4xL+NJR013B3uhJT2kdInxtTic0aWirMnyWi5gmzk6PeRIkKVDw66pAmlMjn58N8vwMHfFCh/Y9RKbLJ5BtigleV5NEigX6rQTXUjQgVApISNE6h9UB3iunwvTtYRY1FNobOq3yqdJjN5wrrd8QUEkiNzv/YwlYRaWvn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwXzja3n; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-827307b12dfso1440678b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 14:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772232149; x=1772836949; darn=vger.kernel.org;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=FpqIYj+15/j3QcGVpMOftzJrXM1/vX1ZNGSvGc9WPwE=;
        b=CwXzja3nBit6X/d7DXnykXWM2y022p96XAWuEBzhN49WZgYKKuOW4TW8gUfpGcJAru
         8EXi6aKT5aq1q979QNmVmXTMdhWfZhyIdyK2iXa8O8EcxZO3bZiwH3WYDT/2PFwDaMe7
         qkZ/5T+GLF8UOtQQDE0+6DgoXt98SPmRrGm1vkqsCMbpe/lHWkHDCFgrNElSPWgWkkl3
         UjlrMhY1FhlQtii1D16fA6jh9tpxL9JjVC+NcB0if9I/QSAu3W7lfd+DLAUKVOn4FRB6
         pU9xX+xAUW6x5gVxMGQUurLYwXDb0hEfB45/ddjWCWXm567bgxA54LxENFyuTI4j6Ss/
         EQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772232149; x=1772836949;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpqIYj+15/j3QcGVpMOftzJrXM1/vX1ZNGSvGc9WPwE=;
        b=VhlwjK1hSXV7qHcbFlj7fFhM0g7k7pUHN1gAC3htCD0dajcIYow+0U5z07XgG4wJit
         qe9vCzt4KoWPPgYKaUoaQ/43db0CqQXHlPId/9LbxEuDQqzXtiiWVT6KIER74lARje9r
         614d1uhyRkEf0qWhOIR0ViTefLz9ghBjG9ivYivXJtx7A8vYQxOh0Bw3Zz/FzNmQh/mp
         0wuqklURvUwubp6FIq/R29Gan6ZAUy36OOW+6OCskj5mHkSkTBieH3MIsm9gBnV4iXFy
         90zqPt9Mk5cTTsNIxSWLQt9kyt90IMq8HmgI6lONSIrGRFmgyBTb+ycPxYyNwHFXXByo
         kNQg==
X-Gm-Message-State: AOJu0YxL88e8Jr0UZk96uT043Yv/Zevlw+UqA682Dc4moIDRaAafi5ZB
	yQbdcYgrxLVBffLhCsu1QdtbzrDHqQvCFGPVxpkM4//XpzW8RTdMVNW0
X-Gm-Gg: ATEYQzzWiGasjrfO3b3ZxB+vj5AHRPSqTCNIQOC5ql+mXJOYDfbvW8uVxNJfJmnttUl
	icSTH/Cpl0hXpzUK0VJTB+wT1LjK9DHzOwDmgJLEdKs1V5urAT/RFe9NG/tk+XC8/EdizG8PS9n
	MriZmEt9zzBquLBArEYz4Ce+yFYkcLHSqcnsefSpDugmuiH2ACrM7pUFFeFvpyycnuY7McEHBk/
	a6OKSu/04C8Cx+j6wN8NHNuH/DpdrmpSXYnTV48Vs/3C1A1mhMrTP4OqPcgHes2vOS4n4YkcdE0
	aO/wNepWNrzrKtA5wPvDawDgu/H2997gYVLvI0MBICiPQ5lCdA1KhXXJJzuAYvWd6MEE08OhDsL
	IRoi/l+kWb/wiJFZ2QQJV81Q2GjdO7UJ1jbBN7wBvSJgL6BxmyFtS5ilEHEGFtQdczxN5R3CXIs
	zY0VOwG+Tp3v8g+Z3mcw6JBKYGCUoHbjeSz0N/w7ZZeejrnbTTeIfhCyzX6KN2QB92
X-Received: by 2002:a05:6a00:cc4:b0:827:2dff:7116 with SMTP id d2e1a72fcca58-8274dafe30cmr3470836b3a.13.1772232148712;
        Fri, 27 Feb 2026 14:42:28 -0800 (PST)
Received: from jromail.nowhere (h219-110-241-048.catv02.itscom.jp. [219.110.241.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a05cbe6sm6229386b3a.59.2026.02.27.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:42:28 -0800 (PST)
Received: from jro by jrotkm2 id 1vw6Qf-0003VW-29 ;
	Sat, 28 Feb 2026 07:35:25 +0900
Subject: Re: v7.0-rc1, name_to_handle_at(..., AT_EMPTY_PATH)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
In-Reply-To: <20260227184804.GC3836593@ZenIV>
References: <14544.1772189098@jrotkm2> <20260227152211.GB3836593@ZenIV> <26309.1772206864@jrotkm2> <20260227184804.GC3836593@ZenIV>
From: hooanon05g@gmail.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13484.1772231725.1@jrotkm2>
Date: Sat, 28 Feb 2026 07:35:25 +0900
Message-ID: <13485.1772231725@jrotkm2>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78803-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 983621BEC3C
X-Rspamd-Action: no action

Al Viro:
> The last point where LOOKUP_EMPTY (or AT_EMPTY_PATH) matters is (and had
> always been) getname_flags(); pathname resolution proper doesn't care.

Filesystems recieved LOOKUP_EMPTY before v7.0-rc1 and could use it to
detect a case like this.

	fd = open("fileA");
	unlink("fileA");
	name_to_handle_at(fd, "", fh, &mnt_id, AT_EMPTY_PATH);

The flag was used to support
- unlinked but still alive inode
- without its name
and d_revalidate() should handle it still valid.

Yes, the filesystem is out-of-tree.
Now I understand that LOOKUP_EMPTY is not passed to filesystem
intentionally.


Thank you
J. R. Okajima

