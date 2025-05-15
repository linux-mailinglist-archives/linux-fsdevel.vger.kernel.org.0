Return-Path: <linux-fsdevel+bounces-49188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF902AB90F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 22:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4A11B6345F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 20:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F5829B76C;
	Thu, 15 May 2025 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8zerxL+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE8255E44
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342382; cv=none; b=E7aRbrnianYAz8GRaA2RboOdcwvxL4LKZjIzSszIYyXnU7bMlVE6ycpLRoN/0MFZsQjsXW/Ts8s/G0Uc8h3SwH5rxB9d85LBEAtcvgyQqNfgBM9YJpt9MY7MupuMYkWm5dqcObXtVwQ1hfU/iW16oOnz5wsJJckF2wpdLfg/29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342382; c=relaxed/simple;
	bh=czi5+u2kEjArBpOgbOhFbSFaZ/a1SpCa/lwq2gvfT8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIuq9w6DTypLixASGpGWcGCnKepnP5Rhe7YU2glXM33SgzywArU+mifWeKax/5o/Pw6k+/gz7PUPnc0RoEoss58D4KgRUaeluqLu1Q7zDWb3lamB7xuJ1/Jt9MMi6XD8O1wZzUpxQ3rc0QFRwmyIUnWCHaKvLmasIOs8sUDQE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8zerxL+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso1416a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747342379; x=1747947179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czi5+u2kEjArBpOgbOhFbSFaZ/a1SpCa/lwq2gvfT8c=;
        b=e8zerxL+wnR+j4tazWO2tN19dxkVVHq0ygT4AY4rUUiU7kSO3wLtgzkg3q3cmv2YTa
         vZfFierl81popnMsW80aNLb7U2Afe2GxeX7M+fSQdXk47M0NSRNru8MuznHwxifNxZQX
         0XEbNYFlWryCsSd+Lv6PC8V6RmJnt51yU35olEby9SMXawcuutLVxdSL3DAC9Dert6/2
         uiXZ83Ifso2wolN93HuEMnIOSzfr9Trv+66flzNib18fyYn8POs6Ffv+67f3wprwvxMs
         gvOSiIQyNZ2li7jqt/fH8nG+n+gmupBubWTyGD6m+IcHWxvk2pnspjdvNQ2eu3Btf4qA
         U4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342379; x=1747947179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czi5+u2kEjArBpOgbOhFbSFaZ/a1SpCa/lwq2gvfT8c=;
        b=wlXXTh8jkH2yK8Qgyz99hY8jPFYaesEY/OSfHddMGaIsqDOnzKg0EYU9eo4vikynAN
         W6niFTr0Ta0ezZ4bjjUMnZWM1TnBGum6rnaf8xkoOs9uiy18cG42vQJWZ/lmuGwpKp/y
         EE9ellurU0bYkkdXrRmK9HU+f6qHa6HzSSHmlNGsU9uIT236IcqhY0o2/ZHp+ly9eJKY
         KE9ewObYNLcLJkcMfCmUUt6XbmQUEo6vnwHcCM6/XydHLcbv9v3qVqEDTzBCqOL7lKT1
         Illhls0okMpK95ctOAiMsY/4jfr/9yLUpcdDt7X+kkmO+hYGMAwRNQuPn3h9aFC0wDdw
         6umQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+y4jq3HYE+GqlGFoF1HEMa7D1XRsiCTgeND4Jfpm62azzWliaGen2tzfEqJxza0PC8Qrpq7uQDwqpQdr9@vger.kernel.org
X-Gm-Message-State: AOJu0YxLaFm2DMlR1wmcHrsBh+9uR2Rallr/xXvXPejRSgVG0J7eF/ss
	Uq2k2uh0qiS9vlAFZEXnQ6jiLPOc0bwZSt79hrxhrohcoU6RY+JIwS+2ZCA6nVlqanz3yo0chuX
	8RNQ5UUT261Wp+gszAhSy2ARL4hvXb5DR7goRsHes
X-Gm-Gg: ASbGncs+6PDO1H7GAJJOf6df3OI8jCDG3HvemsfgcTNZY6dXHkpUWAepCZkSuvwVIQs
	z5YJ1IiRpjQnz55A9S9EwAPgctt6HAAnNPKgcN5HqhkvNISkd82xvON9JhXiIXV7nSPIPo0YZhF
	vb4UXYkmf95lWr4wF/RDW4Mt7gCBa8zbzz3Q6Fu5DdoHXEzrrbc7zPOyt3sF3+
X-Google-Smtp-Source: AGHT+IF2M8wfat+ypXS8t4pkU9r+Ie60fdxet+x1ExwrsKQgeSVE6SwmGNdqBwNHbwOcKqnaWIIoX1c/2Jgm5HmN7XI=
X-Received: by 2002:a05:6402:22b0:b0:5ff:f051:60f0 with SMTP id
 4fb4d7f45d1cf-5fff0516857mr119534a12.3.1747342378383; Thu, 15 May 2025
 13:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-4-0a1329496c31@kernel.org> <20250515170057.50816-1-kuniyu@amazon.com>
In-Reply-To: <20250515170057.50816-1-kuniyu@amazon.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:52:22 +0200
X-Gm-Features: AX0GCFukZXeV2YnpYpWYUXI1kiBBOFCdeQQogQc1TbzHuyl2utiuGujZlMvm38g
Message-ID: <CAG48ez3fC902JU244d=0zzr39f+iXxQH0GZgJp0rs8pbu8ka4w@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] coredump: add coredump socket
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: brauner@kernel.org, alexander@mihalicyn.com, bluca@debian.org, 
	daan.j.demeyer@gmail.com, daniel@iogearbox.net, davem@davemloft.net, 
	david@readahead.eu, edumazet@google.com, horms@kernel.org, jack@suse.cz, 
	kuba@kernel.org, lennart@poettering.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	me@yhndnzj.com, netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com, 
	viro@zeniv.linux.org.uk, zbyszek@in.waw.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 7:01=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
> nit: please keep these in the reverse xmas tree order.
> https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ord=
ering-reverse-xmas-tree-rcs

Isn't that rule specific to things that go through the net tree?

