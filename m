Return-Path: <linux-fsdevel+bounces-8368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F40835756
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 20:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61471C20C9B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 19:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADE8383A2;
	Sun, 21 Jan 2024 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pb7k3Ur8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01863838B
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705865272; cv=none; b=mj2jBf18iJLjuqtsTsdN5Yr7FNseUnYbUQ3PX8j6qgeu22WpQaxY4NgEXfZMVaBqIk6QX3ZYzGljJGBaynE2SRFefWZaPIihA0Q7KlL1/mrRhfrtVwkIZsc5r/dKDMn4VAGnPwSuGgGGvNoaGmSiPqx38eLHerckavxJ0lrMcGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705865272; c=relaxed/simple;
	bh=2FpoKLKzqH8UC9hSwhA9E7HCkyq8gOsBF8dHu25KccI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCJkKcmTmUK4/PDGRZgBfR5KCg/vd74aGsiZaVgTInWywSk11lfoDDDNPM6uKccGo0RzJjAFdmSjf387NoRTMs/nRS42ufpIBZcRxJXdh12J7maqHKSau80h5d7Y5w3HX6zvZ1aoFVFGW7FK4AH3z8lbLZSqCuu8hzX27aqnkPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Pb7k3Ur8; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so3118294a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 11:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705865269; x=1706470069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ilsHoBAFLGrxDRmI028SujMWUyj+V2X5SyCrYhyT90=;
        b=Pb7k3Ur8ELXjk8kws/DCquJ0aRwO1f6XiTIz2OawJIrZSJKZ8QJUztXvAfbIVjJ2lq
         d5UAcRcg4PH9UA9zBADHkHbrMhmFv+ciSigR8Yjri7idzif7p0GC++6AbvVWnJKoJZqP
         zgFSJapFb8dYx71PTI53DVJO3kkMUL+l6ax+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705865269; x=1706470069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ilsHoBAFLGrxDRmI028SujMWUyj+V2X5SyCrYhyT90=;
        b=uMsE0t056I7cldt3GkghfSUUcYWlkugIg+6yFtnwyPltCjkii7Yoh/enRdOW+fivX2
         1m20rt/OmS6QW07cx5rr7GdktMT19rr0bl5xtu6aYBV26EzhSr7PWLjhlXsN9UdpPN0J
         Ow4BxtE+416C+Fw6VfJF6F0bQjSov0tRH615W1n26QTDX71bC5FkS/SMLH6sEZIAPVEY
         Ou5/7xKoXzb8oXQbATDJIvtN6zKLAPW2biUnUgxanTxVa46YO5hEYRaU0QbYbbzBIB7B
         FzvF5PaH73Cb+ku/Rf2Uo8jCgJaiufF1BC8jJrnmuqxG595Umy+9imAAxSLdxPwurxqA
         +JKQ==
X-Gm-Message-State: AOJu0Yx0D38KywhRQ2Ro70UDDiic/N2xRBQDsMT8jlFHtixqfXjfKCj4
	m/u9xwlaT9gTaX014VGeGdgVekHLJj627LAFLBhaMDvVPa67sVvlrW5315ZACnH4SCNMIEBt49B
	ewWYUUQ==
X-Google-Smtp-Source: AGHT+IExHu/QGw6337B/6gfDiYO+tDBjqxChxQ18wBKmOVUb/w7QDQD1SS0FShUIAJ3wYvFeam9Lug==
X-Received: by 2002:a17:906:f597:b0:a29:3a5b:6fdd with SMTP id cm23-20020a170906f59700b00a293a5b6fddmr1295712ejd.192.1705865268761;
        Sun, 21 Jan 2024 11:27:48 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id cu12-20020a170906ba8c00b00a2f181266f6sm4482771ejd.148.2024.01.21.11.27.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 11:27:47 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a86795a3bso1625772a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 11:27:47 -0800 (PST)
X-Received: by 2002:a05:6402:26d3:b0:55c:29c1:4186 with SMTP id
 x19-20020a05640226d300b0055c29c14186mr493069edd.26.1705865267510; Sun, 21 Jan
 2024 11:27:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119050000.3362312-1-andrii@kernel.org>
In-Reply-To: <20240119050000.3362312-1-andrii@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jan 2024 11:27:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg3BUNT1nmisracRWni9LzRYxeanj8sePCjya0HTEnCCQ@mail.gmail.com>
Message-ID: <CAHk-=wg3BUNT1nmisracRWni9LzRYxeanj8sePCjya0HTEnCCQ@mail.gmail.com>
Subject: Re: [GIT PULL] BPF token for v6.8
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jan 2024 at 21:00, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> This time I'm sending them as a dedicated PR. Please let me know if you are OK
> pull them directly now, or whether I should target it for the next merge
> window. If the latter is decided, would it be OK to land these patches into
> bpf-next tree and then include them in a usual bpf-next PR batch?

So I was keeping this pending while I dealt with all the other pulls
(and dealt with the weather-related fallout here too, of course).

I've now looked through this again, and I'm ok with it, but notice
that it has been rebased in the last couple of days, which doesn't
make me all that happy doing a last-minute pull in this merge window.

End result: I think this might as well go through the bpf-next tree
and come next merge window through the usual channels.

I think Christian's concerns were sorted out too, but in case I'm
mistaken, just holler.

                  Linus

