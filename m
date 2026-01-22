Return-Path: <linux-fsdevel+bounces-74944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMOjBwlscWnsGwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:15:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B97A35FDD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B817368B48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817272367D1;
	Thu, 22 Jan 2026 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dU/GXHID"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9266E222575
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040891; cv=pass; b=mfDMH3mMqmKdfE+0B5V9whB3ByZjJLi6j+TJR56rbVTY2HU5rNROGe2WX5Z//8J2QmQuLpMRiEpsY8cIzHl/Li0tFABisSXxc3eMPA8oiOt7IdkZmQVXFJyRjiVztVSTRtdKbHWQSXFDlZiq8WMi6JoqHq21oadkhAGM7UnAcnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040891; c=relaxed/simple;
	bh=A5RWos469E7OdpHxOy7QWO7HMl+c1GqjTI4t+/0t7I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlCKKjG5KkYdDYnEQsenlniFB1zP16zO0zxC8aNlw9Rlzs4aeQG58euy1zYXkqWCjdsfJ9GJ5Fup1IFsi3Cxd7N2ZMPXwHhHt8mffYi8j0dry6z9iZW8lusg7AH2fgyDvqfx757Iw6aJDlF0YyxIRslzC9+WReuc/RFFTddJ/7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dU/GXHID; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c868b197eso351213a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 16:14:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769040889; cv=none;
        d=google.com; s=arc-20240605;
        b=KBI8PXz/snuFuzsq7UcrD3xDxkJ+C+aMIwW5pMtEYI2Cl+UcafOfKMq3szEoC6o55/
         UN8JiyIZXuwFlgsvr9J9cBopXdY91D+gVcEugofy8fE3LW0lC/51T7i2b/EWrHN0acgf
         +bqMdsrpao0GxWL733VJE+3zGFzkcDXgZtTFoeI8ivh45EW4ZQoPnbPsUC1sSrO3qY+M
         zUbihunNNKTp53KiTGHRU35eGLK4lQvlF6H1yAhzv4L3XAMxsRMLYBN1Cjj+72Rh6crv
         FTpKW63+VPkvmt9VqaQpxH4lKTGu6Oz22VtL0aMsDQphz14BMJwq5hD20T3SFkpBYvUs
         fRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zXPAFU5JIVtw63vlsc/Q6CXxBcUl3qbYAmmc88ADSD0=;
        fh=k1o7fuSpKGt1PXDP4zYFTB399VVVstYl5/g9Bch8BNY=;
        b=UL2B2+uMLYlUKwviFtsH87hmxED9YnjbnX2sxlHQAfRDkbRCeSAPfo3a408UW6mI7A
         uYD85C3twoZWrDsGT53Jssv34+nL4Ch2UC2o+RTWjBCQHcTFvANcIxHSGGR20vHwhBoU
         1tcaH1uInX5KqtMdo7WGrInG9jeFiagXSUjkthfYsfXgIpfQEUgHoPf5/zv491w+XaAR
         X4ywtmXS/7mVJ4MwX/p2bAfvIFf72JJHWjU8SdJrll9Lcr3EmpNAGGF4nBbLulUK99vr
         ydtWHmTRfRGU8oVt8XG/cm2exsptJId23xPdahmY7iKQU1R1EBERN8KbT89DYpfIzWfz
         WFZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769040889; x=1769645689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXPAFU5JIVtw63vlsc/Q6CXxBcUl3qbYAmmc88ADSD0=;
        b=dU/GXHIDEkNX12ZR4K9e0Su2HMD5q4K/1lbCMpzqcqWeYBBxT140w87zXDVx8oP1x8
         qZtqu81XZDb5HvBT+gChEsFOKdsAthJY1/aZkCO23VSX/wI3jCTkPgEdgWYFrSMwZ30Z
         Mu89dNh3Kr8X4v8gaHpNvQwU1bhu4+gS4DQpaJrre26gUSmxWc2rbWubDb04poJV+wro
         2rAgKytmH8rk/k4PxVrB/rZ2miT1Abc4jAiJVToiVx+iuCqadr4KFry2B5L7jEvn1HHp
         2FmqeHkTqVgxmMw/SnEB28gg0I4Cqbh5cMCG9hDLdBCmblR34DTCsikwNqdDpPva9QUb
         1QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040889; x=1769645689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXPAFU5JIVtw63vlsc/Q6CXxBcUl3qbYAmmc88ADSD0=;
        b=JhHWR+ooQeEUbTORRCUTr0ZpQofJQMHmOlXtNmpF7V52R9DVEgOrYr6ORlxSK6Jwf7
         dOu/iNW2tfwgPEnVGEm8vgtbPTAp17VJNF+4C4rAvIK5cTsNlBq8MNG6Tv+9Ry0bvzWM
         l79g4jqsqXa3U5SsNRwnfImPQLjPshn32iNmJz5xKwWSN0XZw9Dr+vfsgJBsUyFAIx8x
         BAcZJRd1w3QARfDlWWY2/4BkDjMJOSmxuG70RBGaOmZnuVmAyk3q9gSw5JSX7KJHe9zX
         uLFlM8yAhJHJRKht4D1FhBNRj5YiqBNJ04xBwNefImrVLnpDikb7hYY+vY0ZdPVKjuQ2
         S/Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWZmJ2WuZR16KezEK0QCfIzdW4IzSzc6T5NAxeCYHIIBtGSDaBb65CN6zKUcVK7PrkeUPdC3LA98Xp3Tx3j@vger.kernel.org
X-Gm-Message-State: AOJu0YzzrrDMfugfJLo9R31f9QmjTXd5CQiQ0OhgVFL2uza/CPcHXLXY
	w0WtgnExtzMCi9yMz9AwMprC0QxqTZd/Hk2onbGfj1gKivzMn4so0MFZdIHseE5RFdPju2VpY4V
	SR3hDuq30OCwHlnWASWeneq22PWiGasJIC94527SM
X-Gm-Gg: AZuq6aIyXo+Zw5SMWuL0jXbCkEwWyjpS7mW1i2L+Bg9z+5bWC1FWcJxCkTwbRDmAmSA
	fIF64kNWMkrM+DPFb+z77wDhWgWGKdM9ucZsVT1py0AnxicXUQnjMugyrnpJ04zvF1LlPdh6KAE
	54XKbiDn1RQMlf/+7dU1lmZkHz40h+a4+5o/vhAeYujJp9EH8qea7rahniOMTLeqn2pU2NbUHuh
	HgbNUEdwWeBBUrO/2K8ogtEg4pd8EkHD13L3/zeDs80djG8sGkWH2h6Idx7bvu5JV4LWRw=
X-Received: by 2002:a17:90a:d00d:b0:33e:2d0f:479b with SMTP id
 98e67ed59e1d1-35272edb23bmr15763365a91.6.1769040888822; Wed, 21 Jan 2026
 16:14:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
In-Reply-To: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Jan 2026 19:14:35 -0500
X-Gm-Features: AZwV_Qi4Pxfxx-5TehqNnHnBk2vVum5Naq85Aa55fS3OaaOQkTNm5PTJBxmaI_4
Message-ID: <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc@lists.linux-foundation.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[paul-moore.com,none];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-74944-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[paul-moore.com:+]
X-Rspamd-Queue-Id: B97A35FDD7
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 4:18=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Current LSM hooks do not have good coverage for VFS mount operations.
> Specifically, there are the following issues (and maybe more..):

I don't recall LSM folks normally being invited to LSFMMBPF so it
seems like this would be a poor forum to discuss LSM hooks.

> PS: I am not sure whether other folks are already working on it. I will p=
repare
> some RFC patches before the conference if I don't see other proposals.

FWIW, I'm not aware of anyone currently working on revising the mount
hooks, but it's possible.  Posting a patchset, even an early RFC
draft, is always a good way to find out who might be working in the
same space :)

Posting to the mailing list also has the advantage of reaching
everyone who might be interested, whereas discussing this at a
conference, especially one that is invite-only, is limiting.

--=20
paul-moore.com

