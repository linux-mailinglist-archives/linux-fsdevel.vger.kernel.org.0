Return-Path: <linux-fsdevel+bounces-15523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DE288FF66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 13:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A181B253CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 12:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D590E7F7CF;
	Thu, 28 Mar 2024 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hvf5L1Nj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00CA7EEEA
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629806; cv=none; b=PnyX6XH6ktpUT8STKbUSBvhd2rq9/rVR4kI8Vklj1Cj7JqscJACzZgqJtQiHUYTV+EiPL3iac4bwT3p7ftKQTapSYhsqgKLvSVVic7TYWsrkPqAalzzbnGvCrADiCr/AzZE385ehUHBUd1wTj8PCvV2ur+6+PVqGDHWmwhqgZKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629806; c=relaxed/simple;
	bh=wCjLEiLhsGuQ94t3e93iJvctAPVhr0te7y+obw6b26g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7ZJALEBh40eMv6QDU9p3yKCm7iAQsxj/EHLyVFIPr0JIzCEqbElitixf6h0gLS2wdZ/YJ9Nze62Ch5oegJDmEJ6kxXjBuZRMUW0ljsPXOnqQv28Pz04l9pg0rlr2rB8ne57ZYPrkDayUf8NV5NHrnmYFIAImYvTbWUiM/yY2jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hvf5L1Nj; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso924825276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 05:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711629803; x=1712234603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCjLEiLhsGuQ94t3e93iJvctAPVhr0te7y+obw6b26g=;
        b=Hvf5L1NjH4/ykBgdIa5Fxa9+LpTbH2QLO6I6Ik+wPfXD9pU5SOLOmLiJ57FguVH+IW
         tgYv8SqQSDYj5wp9N08GgrTgGKI6pFWXYV4funDAmXQt1GKrD/s1K20jwUKYELyGSyQE
         CngzRlMn41zkjUTCfszyPzDEovaa/ghaCFXANuwriEUJ+1ZWrJoiCs8X9aX8jlXG3QgQ
         wJtH7q64zF/WDtL94P/Veo4cXtPbdogJRNgWCJLmZs5h8tVdB+YssXUf9HUpHLkFA8Pm
         0zshluFnIv9eRPfWuquK8U/NZB0t7+EYTNLYUm0fzjkS2rvBEU3Q//X4FqoNkxJHmmzi
         YQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629803; x=1712234603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCjLEiLhsGuQ94t3e93iJvctAPVhr0te7y+obw6b26g=;
        b=jwCNlZ0LefI9gCEFAR8wcGqRlIO7S9tf9WQBJ/sQueSDhSfi7KiEbMDLFNSlMx3isa
         87UC93vEXk9EINiGa8BKq0/8mUAdnCX1dkKIsFtbpzXgjhbzG43cIdEvnEvnZelQlSmG
         PPBKTx6rU7PcfH9rW6zpJ97S9xFdJlLMJYHn/w2zVBnLxTH0zubR3ecxNGNbtcB2RIXY
         YdYtMSlMMC+9YscNUNL8ZWFId50O9gPzwpe7NSn05iBswlVKAZZiCyysfas8cELLlYZf
         OJ7j2uFe3m5bMsJuJQ1QiFoWrSsBZjVGdg4OIkcytCuJSBgCwxgFlJe5ap7ePvsxuGKV
         zdag==
X-Forwarded-Encrypted: i=1; AJvYcCV+vAvsyyNOs8j7Q3qhonUraq5+dVLA3LsGxJ+0831diRrzY0oTUdWWJK7qhdR+iwYk60gpTlvF+ucX8YDJKMTvMYzgq/VTUb+w3QZmxA==
X-Gm-Message-State: AOJu0Ywvpd85KjfmpxyH9Ng3ZZWPtTLt0UIVcOkZ7t5j93G4s2uBdyJ7
	BTYqES8/xqpg+GmB14B3OrF/W2NXTAqer3elyimsKkSmbpHXd34en/rCGpmNRVtkV4Dhwb7fH4S
	DqfPYdMGXW4kg/DsJFkGkZIZv/p1KJo4rLMf+
X-Google-Smtp-Source: AGHT+IG7Hj+v9FZ9/91AWUqhCMCaVjwUtpSrpHnaDe3Rf5wZSA8LmhBKtZJ4gqRDkx5Ku7FJ96Rn9hqsd+NaW27OoP4=
X-Received: by 2002:a25:5f50:0:b0:dbd:4578:5891 with SMTP id
 h16-20020a255f50000000b00dbd45785891mr2423670ybm.65.1711629802827; Thu, 28
 Mar 2024 05:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV> <3441a4a1140944f5b418b70f557bca72@huawei.com>
 <20240325-beugen-kraftvoll-1390fd52d59c@brauner> <cb267d1c7988460094dbe19d1e7bcece@huawei.com>
 <20240326-halbkreis-wegstecken-8d5886e54d28@brauner> <4a0b28ba-be57-4443-b91e-1a744a0feabf@huaweicloud.com>
 <20240328-raushalten-krass-cb040068bde9@brauner> <4ad908dc-ddc5-492e-8ed4-d304156b5810@huaweicloud.com>
In-Reply-To: <4ad908dc-ddc5-492e-8ed4-d304156b5810@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 28 Mar 2024 08:43:10 -0400
Message-ID: <CAHC9VhR9EL0CQRKpdJ5C9DLnb8YKCNZze+WnpRxn10ZHKCKzPw@mail.gmail.com>
Subject: Re: kernel crash in mknod
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Steve French <smfrench@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Christian Brauner <christian@brauner.io>, 
	Mimi Zohar <zohar@linux.ibm.com>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:24=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On 3/28/2024 12:08 PM, Christian Brauner wrote:

...

> > And one another thing I'd like to point out is that the security hook i=
s
> > called "security_path_post_mknod()" while the evm and ima hooks are
> > called evm_post_path_mknod() and ima_post_path_mknod() respectively. In
> > other words:
> >
> > git grep _path_post_mknod() doesn't show the implementers of that hook
> > which is rather unfortunate. It would be better if the pattern were:
> >
> > <specific LSM>_$some_$ordered_$words()
>
> I know, yes. Didn't want to change just yet since people familiar with
> the IMA code know the current function name. I don't see any problem to
> rename the functions.

I'm sure this is what you are planning Roberto, but just so we are all
clear on this, please do the simple bugfix to resolve the mknod
problem and then do the parameter change and the name bikeshedding in
a separate patch.

--=20
paul-moore.com

