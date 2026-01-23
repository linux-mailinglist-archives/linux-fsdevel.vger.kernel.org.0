Return-Path: <linux-fsdevel+bounces-75198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM3XNHTfcmntqwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 03:39:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F036FBB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 03:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60A4A301627A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 02:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C886835D5F8;
	Fri, 23 Jan 2026 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I8v2Zedg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAA1362131
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135970; cv=pass; b=t5r3YNRtTJigPYX4iy1cb3n1KhSWFXJ0iWarjcqFpaecKqh58RrFregyHtqDWE9Q7arPseOi7PjiS9VkUjrsbq8Fr77kC8CYLM9hZoha5a5qJA+FFy1Fnr5kSJSXbYysuEMCUehUfTHKImufV1HyFLyRaNTwQHcqRVI2a0onfiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135970; c=relaxed/simple;
	bh=P3EptHWa4KTu9luDIRb1mjNwdTplheDIhc6soBo/bkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSZSBLe3bts3XpN4eMUc637CEcGs+RPv8uJhufK6ABJdyPAEBXLMMEnKSMno9qC9zGIXh3IuY5dis1XPrN3VRsAXSPzTx2ZrRZz2JB8EyjOV1lErlh65Vp9O6K4L9YKw033GGXmRL0QnjhsZolfkjTxNfD+lFXgNjiww4orDBYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I8v2Zedg; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c1d98ba11so1637869a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 18:39:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769135959; cv=none;
        d=google.com; s=arc-20240605;
        b=J1a6Rqbmsfau6Hyn64ATun/C5aVmPY2CBX9zqeWrBypaQL5XyOvlrG0OTxq3sJYMSC
         RyeLj95RF4u0Rx+/PxLCHE0E/xVhRHMwdHTeT8TB1cbkU1Xxs9ZTpeYPXWom7M5siwLG
         QH9yZqZxohYS7aoeUv2cwGIrHTFJzi5sbmq8W4pCQlcCPfHPfKor/ahvyvnvUO2pgXE9
         xmGS0uHCRyxbHbcDjSqPndSeOc9HIEUCnLlcWFUBuUSmvTPxNE2MZ5bxG7M1nW25+Vuf
         CBD/i+eJaH3kjodeE+TKqr1TmYpHtpAXJoWE1MUAl5sfYYklMG0CymUC8yZ1maGlJwF8
         tT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P3EptHWa4KTu9luDIRb1mjNwdTplheDIhc6soBo/bkE=;
        fh=l9atYDgRjK3DRkkiSp5tfXGj8f2XM+RZkFCcPpGG+hw=;
        b=AGO4XmnwUsdNB5QlgUhV4StZ9bGTUvqSh+ea54zooaxS3Eb2KEEVc8wveShJdMJK+b
         yDOtBDFEzy79Q0M9L0f6hqJch7J0aBWBjLSMIlCdENxGxJGxqkr+HMovJhH+R/EGsQwz
         /OyZSLwVBaJsaNd+Rgt5bxny/f5Z4MGG/rsYFzfcYHKEgHlh9LY5Q7wBm9rMqHNCH60a
         cx9WWSMEAqVcT7DQQ3Hp+swP6XK8S4bpX4xFlIiOYqscqU42qtLL+nQacYHZqAhG3wpp
         KNUchEc7tDEQSJT/pkOpK4j8QzdnEtCJaqB5HvlmZURWOBKf3WCCt0nMioqHLXfUqOvp
         Vb6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769135959; x=1769740759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3EptHWa4KTu9luDIRb1mjNwdTplheDIhc6soBo/bkE=;
        b=I8v2Zedgw4jpN7rWa/wxZ5lSKgncvp/c2tGHB5oayIw2Jir2n6HijDzUeaZatg3dry
         74zKOxDEger65D9PfEvo8WVzvHS5qITyxcYM7zbifKxEBqKKIsHwN/FH0FhGeMtSxqT+
         EYCtaX+bNCDzml4wckFzmtu+WvhF008yFXP4skx5IgI11JrulmYqTeCT61CRq/QBOt1Z
         KbgWeogB4Uy2Z/rOSq2ugxRqxtgB4LRumVtQfZjWJTwGRiGgwLKWK4ybhx+vNOvzu7bO
         +xKGZnzOCRKt7Oq3GFIC0u81b2ooU9JwBZc86cxmJNNX0910naWlT7xsUHWha8yzEKt3
         HQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769135959; x=1769740759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P3EptHWa4KTu9luDIRb1mjNwdTplheDIhc6soBo/bkE=;
        b=qNn14pZivNTi0h86OlCNntYeamWsPWyxzIsFmLY3D6kIfuHsn5Oa3e2mMdrlZmS68E
         7lGUQBmQgXDpK99l6cIqlnBF3jcO0pDGfCSFNPpjEE6OWoMjYzDSCgjncEjKYSkqeBzV
         xisnYvPV1zKE8TYz5PR9pV9my9mg8yblvFNDkG6J3ORBtW+QToZIPkhSSGqaNFTVTSHJ
         udN8QVLBtC1gI4dcU2Q9K/OZdOvWYUyTBKiY23QvJh0+M6Wh2X6sDDJVSJflO1fY5jdi
         ydFt5UYjETCZIKGrzAd0oU62L52fKAOmC1BIQJ7x/7C3aPLiTbvcby47l5FDQwwDKAuZ
         84Fg==
X-Forwarded-Encrypted: i=1; AJvYcCW5P3zU+cmXRlU3uLC1WfCmbLLM1mQh/wm4TdPUhL4xBaXzyw30pZfb/MXWTwkAgloGMMPTrfKYZ9sg2ydX@vger.kernel.org
X-Gm-Message-State: AOJu0YwZPG9XMNZql+gtK/S8kHGrE11tojViuZ1g3br7EYyDTv0/C3Wp
	Mvd2eJYz9qIBgRgzeYJAMkQZ+tB6paHydhSeX2dsK8qPPhaegKrSXsvK2npPgg8O2AasbgXUjss
	hpNALQ4L0WJBAJQ9Hboy6jV2Ac984R+aw24+lQnw1
X-Gm-Gg: AZuq6aKgm3wWVltQbmq4MP12/mZsHDJn33PPhGTBK3ZkVgL3dNWihHJnPKdRh+i6Zus
	vWZGGp1wUt2RVDTnmSDrRZdR8Mp2xW6GdBFDTlAW6YNg6yfeFmTSgDHYwEY/Gn8UIvFv/Esk0qX
	AMGRlHhIV+qyGoroAB3t6CQYXK0OJHpzlLkZNLTPqc+ShBRefHM2BLk3BrRB8t+YT3xSRafMwQZ
	y4lE8qViUAab5MNj1Jsf5tcdbQfzB/w1bPYjljrqSl7QUFKQdo3zh6Af/Sp6O+zSdyd6+E=
X-Received: by 2002:a17:90a:d403:b0:343:a631:28b1 with SMTP id
 98e67ed59e1d1-35367024a1bmr1261929a91.16.1769135959102; Thu, 22 Jan 2026
 18:39:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
 <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
 <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
 <CAHC9VhSSmoUKPRZKr8vbaK1222ZAWQo51G5e3h65g135Q3p8jw@mail.gmail.com> <CAPhsuW6TMNTGs9miKmQ_YFdm-NnCfLViCjQjMkWUYnuj9bB-qA@mail.gmail.com>
In-Reply-To: <CAPhsuW6TMNTGs9miKmQ_YFdm-NnCfLViCjQjMkWUYnuj9bB-qA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 Jan 2026 21:39:07 -0500
X-Gm-Features: AZwV_Qiuw-WOvpplG3_3YRv6P3Gqf8NRc7bLKC5WTsb9MkYny2ZAcVsltSt3mLs
Message-ID: <CAHC9VhR0F7rp=ne3BWPtuu_KjUao03iYoHuNsQdYgWygg0DBkg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc@lists.linux-foundation.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75198-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 74F036FBB7
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 6:15=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Thu, Jan 22, 2026 at 9:27=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:

...

> This issue has been bothering us for quite some time. Therefore, I
> don't mind spending more than necessary effort to get it fixed
> sooner.

Help on identifying and correcting any deficiencies in the LSM mount
hooks is definitely welcome.

--=20
paul-moore.com

