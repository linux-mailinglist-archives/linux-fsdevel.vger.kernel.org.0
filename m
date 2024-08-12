Return-Path: <linux-fsdevel+bounces-25624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D33494E50C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 04:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBA628099B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 02:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C57713049E;
	Mon, 12 Aug 2024 02:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJTThQyM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC1EAF9
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723430024; cv=none; b=EBweZQnKYiCQSrNs/gB7s6Mu3ZcSkuS2u+9vG6xU6GbDh/vypyl9wn34oj0OQlzH9qog3tk5pyBr0wdzt4ejP534WtAzyJixQTNDzqHAkt6cs4YLjvEhyZxhdmufjTHHYJjx7BVAcV5wEn0RBKW2NP3q1SP+z7usM0fflHBwoBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723430024; c=relaxed/simple;
	bh=AGSqEzujcT4rhms5DQXOtKvLjWEYm/benqGijoNojHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5UjIS+yOJBq1aeGl7saRuNis69OBWmhqpD25hqK0vRyOZGYIPwM81OnoEKdvglyox1UnwAYoZ3a7infPvthBKXUDorAvzABIA9i/b9SPh55BXTua8RM69R1mN3tQFm1q2tlu3S0brgLbfqvVpxn4akDVcq+/Yo0U4iGLUL9AfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJTThQyM; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-825eaedff30so736937241.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Aug 2024 19:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723430021; x=1724034821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1le6XpHEPwKYcJAYoAolP384jq2LdapH+EnbsvFQA4=;
        b=MJTThQyMd3fT+aBZ1rxerJGflsZ8SHjPiiDWgcSA88Epdz4eUEBPfuOjvOSlohGctE
         p15Eh5U/bS2Xu7Wv273bFxIEH2UBI1aqo4ni99LuaBaygBYJsknzbqgOSkCk97z2yY10
         pFi8cUgLx9yjeOWfEo5kjZZg8sHJUwX3cHXTpAdlfjiK61+fw6iCn1odXbF5WI+JbM6y
         aO9DqzR76agwMpgcvHmcL+vRaLX3GZP8ynlUi1Z5f4c305V2Qc80tkbdPxwpJY2w5evo
         uuskud8sBQKkBXE7crZdZjSdoCpEoZuqKrzlBGf6deqA0uTAqqqGJjjf0f7J/7jbfZoz
         Ja9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723430021; x=1724034821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1le6XpHEPwKYcJAYoAolP384jq2LdapH+EnbsvFQA4=;
        b=rX+M3or2RNbNs//Sl683tb33JdNRvsvCAtAMcdRUhNzmwuBNYO7kAJkxS9zLDtC+9r
         N2mbNzZ3ubUYeyzGogBVfN9sTljGS+I1JAFTLpMBSwxHt17IkP0cFU4jZJLGlpPH3eTW
         OZKTtp6vaFTgi8dPplGKwsJPQ9QKQ2seW4ZnW9aa57s/i8Pns7I/eCSKRBgM1taq+tWT
         VXnLpHguaXkCgW7A1VdSPGpBw6VvDpwKGqPDJvIu1spTml6OWTNIt7d7gE62/qhhpTvF
         k8vzXltBHpLF7i/y7WANYg4SyQoH699KGyQtaFuCmJ/jxDmNPziM3WXWjsHdGtDfO2F2
         vTdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6LuNuKmmafY/8+L5plt9XbkZFuRw6uaxaVJlHjjMsbtylWyQXdMi1AR/sGIHIUNOnVpFEt679zUsVoQSzQzpVMFpxcDX02UbOHRvn6Q==
X-Gm-Message-State: AOJu0YwOgcSmhbEvg5xeB6DN/0OGAEz7aKUZCl1qlrJsDYS9sS2YrYCj
	Q+R+mUY8QtGAfVopXS80gNk9+yPXsBX657rbcR1n0NMzZI9t5xa3Aj4tvMN/7+AH8zxZwpJR3Ft
	HDAzGsmm/bsy1q14RTF6VibcaU7Y=
X-Google-Smtp-Source: AGHT+IHG/cdNyRJKtw4V9g/L3iA7GhxhTbwyQWeYGTSldR9zCwRllml9D5e5tkJOxIA8j5wkoc541lhD4jVMtdaK+BI=
X-Received: by 2002:a05:6102:3ed4:b0:493:c81c:3148 with SMTP id
 ada2fe7eead31-495d822673amr5585382137.0.1723430021400; Sun, 11 Aug 2024
 19:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808190110.3188039-1-joannelkoong@gmail.com>
In-Reply-To: <20240808190110.3188039-1-joannelkoong@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 12 Aug 2024 10:33:03 +0800
Message-ID: <CALOAHbCOBy66VQVBax4BEnGaadaq3x=8_GSBc2OXJQ1WOntvkw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] fuse: add timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 3:02=E2=80=AFAM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> There are situations where fuse servers can become unresponsive or take
> too long to reply to a request. Currently there is no upper bound on
> how long a request may take, which may be frustrating to users who get
> stuck waiting for a request to complete.
>
> This patchset adds a timeout option for requests and two dynamically
> configurable fuse sysctls "default_request_timeout" and "max_request_time=
out"
> for controlling/enforcing timeout behavior system-wide.
>
> Existing fuse servers will not be affected unless they explicitly opt int=
o the
> timeout.
>
> v2: https://lore.kernel.org/linux-fsdevel/20240730002348.3431931-1-joanne=
lkoong@gmail.com/
> Changes from v2:
> - Disarm / rearm timer in dev_do_read to handle race conditions (Bernrd)
> - Disarm timer in error handling for fatal interrupt (Yafang)
> - Clean up do_fuse_request_end (Jingbo)
> - Add timer for notify retrieve requests
> - Fix kernel test robot errors for #define no-op functions
>
> v1: https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joanne=
lkoong@gmail.com/
> Changes from v1:
> - Add timeout for background requests
> - Handle resend race condition
> - Add sysctls
>
>
> Joanne Koong (2):
>   fuse: add optional kernel-enforced timeout for requests
>   fuse: add default_request_timeout and max_request_timeout sysctls
>
>  Documentation/admin-guide/sysctl/fs.rst |  17 ++
>  fs/fuse/Makefile                        |   2 +-
>  fs/fuse/dev.c                           | 197 +++++++++++++++++++++++-
>  fs/fuse/fuse_i.h                        |  30 ++++
>  fs/fuse/inode.c                         |  24 +++
>  fs/fuse/sysctl.c                        |  42 +++++
>  6 files changed, 303 insertions(+), 9 deletions(-)
>  create mode 100644 fs/fuse/sysctl.c
>
> --
> 2.43.5
>

Hello Joanne,

I have tested this version, and the crash no longer occurs. Thanks for
the update.

--
Regards
Yafang

