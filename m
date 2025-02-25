Return-Path: <linux-fsdevel+bounces-42610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0069A44F99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 23:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0643617ADDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 22:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD56A212B0D;
	Tue, 25 Feb 2025 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HKHrvHIP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904CA198A32
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521675; cv=none; b=HNtt5h0t9FFOnn3hrNtenHUm1xR4qLYxhPB3B8V7JP8ItEKcnDFW1qKNmiI4PmE5YOM8Q4GY5AT1sOIGKJ+jKEUIyyHfcjjlsBcxMQSxK7CbQrIyYSqF/4GQOaigRJz2hlvHjAj5dp5WUv7iZlbO8RMjApH0KYv2DVR4P3NP5qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521675; c=relaxed/simple;
	bh=MDGLRB1elogkq5ZS7O3/EtHbyE61wRXahwAtSkqJ0aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QswyQZPaTvb7QX6HH3IshlrjTBsM54qlXhKf/L9ljLVVkNKtIjwglyKEMKWNFmGfKtV2UDcdPqTgRIeHH3+cPE4ApuO0hqdJq3vgQiI/uwvY+8BKCIzOH/7sTLoP2tCl37bvRAu8qFkaC6TRGqkNUEZDaQQKBc0Ee7g8WR3WsyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HKHrvHIP; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fcf0617523so24611557b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 14:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740521672; x=1741126472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDGLRB1elogkq5ZS7O3/EtHbyE61wRXahwAtSkqJ0aw=;
        b=HKHrvHIPGOs1LAPhaKGNVYAN4p1hSmui5H2x05WfT8rpf/+sxE5cNaJe4j4UPShABd
         QdglBIJRHJlmFTsh0oXtBBF8oK31iko2mj5XAMfkURIXlnHuNViYHY6r4rtcvAFOoCtI
         iKp00SFOYRRF4IrIH5cz9W1tHw+QlEtTRXMqgiMh24y1D7JKw+EngatYg/Lh+9uAIW+r
         B1jSUsbiiMY20xcsisZek9Fjju86noKydwlAvseGVqLwOeC4Pci7nwp+jLZt0Uf28mO8
         we5gSJFCqE0NJTVwC1+55Q/k4JgavG3yBljPZJ2worsbEqjsdGQPxVIwT4TwA5Y2IM+5
         ukpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740521672; x=1741126472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDGLRB1elogkq5ZS7O3/EtHbyE61wRXahwAtSkqJ0aw=;
        b=pEAfcjXg/uhldG22Kzw9PfrO5exgx0sF/BSnlD6Bzrby1hhXJ+C9MsIv1250lnG3vH
         gNAne2d3gy8on3GmQPmRmSLxp7dZXyW+/9FwfjW0nm9/g/KDa6clWUZb8I9r7eAeLgTc
         T3WUQoqlaxLMTBs4pupqClQaSidmXhgFJC2wx+Bpgn1NY29b3HoYTS4JuOXO9OwTgA+D
         O0hCoKBNuRQyOfO+SG6zYl1WI24BcOOOMikohVyYWWYn4v/uJFjRZfZlpqhIkenjpgOc
         YeeAOHSuufSuOBuw1aUzS1ugbHF6Qj/ai3wwAOrWmoPaIHsURwPU29KNfeJy4/WONQtI
         MLkw==
X-Forwarded-Encrypted: i=1; AJvYcCUspeKpOhFg1u9PpP8nElZ8eWsX0VvNWZRSVy1OwSuu7qJNPGI4GhyepfcnKRfhyw0JCZPJ8yWdD7Yut/KF@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHWiZSBAdI6anevI5s5bTrESPXzdxEMVE+jDH1A0Cxjf7bN0I
	C0CetEus4CLfcPGIPgW9GIAk5hrcd2mjh3EqAooW86x6iSVayUI0S+x6XxGYD5bzMNN1jfS3R5b
	me13XfpDDX/+XchsH6rjUOUCwDALDx/bxl3M8
X-Gm-Gg: ASbGncsryAqXyn43aXBYnE0o9dU3HhAzZ0huytfhM/w4/JEoBR9z5XgFFoR9cC77y1g
	xLtnOiVYzTdx2I9erfBPH0GnF/jgy+MuQj9KoxKdz+uNQdIpPY9om5mOGMIwA3XlxL28cFLOKET
	YFROVqolo=
X-Google-Smtp-Source: AGHT+IEq+q/3SNBzxXflir8s+6QdmuMLr7mPJKzm7/BUu7IXjxCgJ1uEovP+G+hSJ9QqgINvHv7u8FQo9Dm4e0gAv10=
X-Received: by 2002:a05:690c:312:b0:6fb:9fb2:5840 with SMTP id
 00721157ae682-6fd10ad8d15mr47580827b3.28.1740521672571; Tue, 25 Feb 2025
 14:14:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhxQfFfrpmRS6tOv5ANVug6d8dGx6Hsc7MYYe63sUOpcg@mail.gmail.com>
 <20250225192644.1410948-1-paullawrence@google.com>
In-Reply-To: <20250225192644.1410948-1-paullawrence@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 25 Feb 2025 17:14:18 -0500
X-Gm-Features: AQ5f1JqI7MeM_scLLuLOFY1u27DXLEkWvnLakhLURvGM4cGQ0eQrhjUWTYnMN4E
Message-ID: <CAHC9VhSu-034tguAKj+rptYB0w8D9mtgmjbDgLwVc-bJQcSrBg@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To: amir73il@gmail.com
Cc: corbet@lwn.net, dvander@google.com, ebiederm@xmission.com, 
	john.stultz@linaro.org, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	luca.boccassi@microsoft.com, miklos@szeredi.hu, paulmoore@microsoft.com, 
	rdunlap@infradead.org, salyzyn@android.com, sds@tycho.nsa.gov, 
	selinux@vger.kernel.org, vgoyal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 2:26=E2=80=AFPM Paul Lawrence <paullawrence@google.=
com> wrote:
> Would a patch to set credentials during remount be
> of interest?

Amir mentioned (in a html email so I'm not sure it will go through the
lists, I haven't seen it yet) that Christian recently proposed an
override_creds option using the new mount API, does anyone have a lore
link they could share?

--=20
paul-moore.com

