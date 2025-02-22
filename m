Return-Path: <linux-fsdevel+bounces-42340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9024BA40A17
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 17:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F221A3BBA6E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 16:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4210202C48;
	Sat, 22 Feb 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YacEjXNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EFA13C81B;
	Sat, 22 Feb 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740242187; cv=none; b=k7Q4VxOQ3lB92TAItnQe+YgJZ9OKGzixpI7QuQO+PaMFjkPAzYomckFqIYwZXnzGuuMQF7xofMVgNsWmNZCvbT/p+gi2Ddj9dvAobLohiVLbW6Lsa3q9QYNOc+yj3WyfCDgYrH7vsm5jeycIgA9UK/GE9yeN78adcypGA3m+wWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740242187; c=relaxed/simple;
	bh=rtocORGzCiCgEQdJ5J8bKjDbeb2QhBgSx+UwY48U/hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g676ojQ3sIDyruU8QosowznIi5libSbtFOBAEnZS5AaXGAY2kfkSVjza8FLq3ZqmBMRZncxgn7dEaHRA6ioGQA4R3hGcNPVarIgmJ1KqBr7PnFNpoXP2v1c0g2QS+yuyIqKRD8ErhyGyV0oh1Rnm9hCqdxuzFvMfRYFqIuDumcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YacEjXNT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dedd4782c6so5852344a12.3;
        Sat, 22 Feb 2025 08:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740242184; x=1740846984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtocORGzCiCgEQdJ5J8bKjDbeb2QhBgSx+UwY48U/hE=;
        b=YacEjXNTT+t9oJyXD/ZCmJ+MAcy2oaluZBojcQzBvlZgYrox6ZLOM8aSTyXbfjcbQH
         kps0nhZwlBH82cQicZuUl5VypKIechg6XwbW/vZjS6jE76z/vSVOnKGtjTtZWBlQB9+H
         H0QovYw9ql2j3H6NnT4tJ+Eq4iCx33wWBwPfS3mkbQugwDu9gO17suCk0qLg57Sf5YPv
         zljryDadNpScPM/A9TtRBrPaUmsXZE+hc2rcNTakrtX6TwSP5teP0EL98yzWM1LnmjKb
         HyVNN3gZyna372HJt3a9tuplKhxyx9Bsehs7KFNSIkc8UfbgPWFf11nuAPVB32iZyiDR
         w1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740242184; x=1740846984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtocORGzCiCgEQdJ5J8bKjDbeb2QhBgSx+UwY48U/hE=;
        b=YnAzuFgQ7+bqbXI1VVTIwOD2tAutP3K4amVIECuv/Pr7tYNbRtcHf0T6pFgAcXamQA
         aSWW8uOfVFirs5ndWpdaQ0RS21M3BmL3AT6FvFbV+2gz4Do2gB5YzMMUlqB2nClFYmIA
         W09PUMZ0JoqyXi8gvrb2Htf8I4o/i0I3lBDzv0qoKSUZ7BKfNX2q4LAzOcChBwsQ6i/n
         GlBiGazJjl3n9yJrIYN0MFD2VkvhKNehjnUZk3ZynYp28utcF6V3iSHthZMPh8lPZRwK
         H6n112xAD1hCSmTrvWRNyZXQXaL6X9zPe3sctvLljHLCnHME1Pt8r554U9C6InNCheTF
         kpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFKMyKnhYgDAz+bb+uXLkrjPFuq0Q2NEPNh4z0/qeOzu50o8CmFmL/bH8OU4NaG6fc0b/zcVvu+bmVI9Hs@vger.kernel.org, AJvYcCUR/hFEegsfQNH0kdIMS2p6pX9lMjcAPJgrGXsMmszG75gizwcSjZHm+IjqIyidGI8e607WJP/1tYAeVdGZ@vger.kernel.org, AJvYcCUeG7IQP1Uds7mIp91yJuhKdInCEPhiegfQXNkiR7jZL7uOy6vpkIUvv42hYg2NtO/jS+uo6/lvNIM3Kxy3kD9o@vger.kernel.org
X-Gm-Message-State: AOJu0Ywak1IveBzm/uapjTM7q8yPty56hH5MI41JVdWQEmwxaab6rO3W
	2xgajm7+mgYF9CO27QB5NSUV0fsWxXWxwJzK8u0T+5jBoY+hARg3PYVJ5eL6oyEod+X1e9ZeRrz
	dQ92FJS4MrRuE/ZlMXQSiqhJn64s=
X-Gm-Gg: ASbGncu8n8h5Mrjd2hneS+JH4UL/PAFXmT8ceGevP9BlqFOWlmiM3FEEBw2FU8rQpfL
	w/IiAAb8Vhfra6ntyHUs7SXGYckxK5WaLDfG1MwnOEOw+zwigzEjp/OwX60W/zF+/CXZBDbZPi4
	awhmlleg==
X-Google-Smtp-Source: AGHT+IFoTbdYhtMQGikIy6G8PoWJvpf+gybBSbSK/2WABhKajv8WRol8YlxcddMnnL2dDGgT019UyARxlKZVnElem8U=
X-Received: by 2002:a05:6402:3509:b0:5e0:4276:c39e with SMTP id
 4fb4d7f45d1cf-5e0b724439amr7711854a12.30.1740242183583; Sat, 22 Feb 2025
 08:36:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112095353.579855-1-debug.penguin32@gmail.com>
 <gfnn2owle4abn3bhhrmesubed5asqxdicuzypfrcvchz7wbwyv@bdyn7bkpwwut>
 <202502210936.8A4F1AB@keescook> <CAGudoHHB6CsVntmBTgXd_nP727eGg6xr_cPe2=p6FyAN=rTvzw@mail.gmail.com>
 <202502220717.3F49F76D3@keescook>
In-Reply-To: <202502220717.3F49F76D3@keescook>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 22 Feb 2025 17:36:11 +0100
X-Gm-Features: AWEUYZmKQosZykKblnkg3KxtVoch81HrzwmyrB7GiwZeJcOjQPtX6hxk5lhJCdI
Message-ID: <CAGudoHGtRdu-s=RKDbQtcOxNx8NBaCvJFmq7u+kUbVymLTZj1g@mail.gmail.com>
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
To: Kees Cook <kees@kernel.org>
Cc: Ronald Monthero <debug.penguin32@gmail.com>, al@alarsen.net, gustavoars@kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 4:17=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Sat, Feb 22, 2025 at 01:12:47PM +0100, Mateusz Guzik wrote:
> > If it was not for the aforementioned bugfix, I would be sending a
> > removal instead.
>
> Less code is fewer bugs. I'm for it. :)
>

Removed code is debugged code.

--=20
Mateusz Guzik <mjguzik gmail.com>

