Return-Path: <linux-fsdevel+bounces-71498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08527CC5652
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 23:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A38CE3035A4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 22:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD4E33F362;
	Tue, 16 Dec 2025 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4DHTN1O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2FA2248B3
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765925151; cv=none; b=BVC6ZEJxEe3jkbW1he0/z2Z+0CZuZspNTR1QAxirWFvvC5cJ7N4EaBv70ayxTY3sLtNPjZqWQr0ifR3uwHWeFLinLNzUdVlwBuU6QOe7o+Aehz39k763SbMxEWi+bVyUCuyLAzQwsoHj1o37s5uhhP+LVYIcnqZ4lKGu+NJY4u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765925151; c=relaxed/simple;
	bh=LAP6LHcD3Su7xaethfzzqudUyr5Li9WQh4nKiqzlITQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDzcHR49mdfpzsy1LQYohXDmgP8uA53IKKAaUVZ3LmoWd/jRiyfhunGMP9d6OVWhzMLzQagocjQLLpYNFDgu4ebSzdgGLjv/BgaTshmihNQ0EJDrQAks27LfqwClN2g2WrTwugCmYWspeM0Pq/Zceqq+HWqWM5GF6tLxYht2MLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4DHTN1O; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64475c16a11so5954532d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 14:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765925148; x=1766529948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAP6LHcD3Su7xaethfzzqudUyr5Li9WQh4nKiqzlITQ=;
        b=A4DHTN1ODFh8KiK4z5jyUJX0SqYtEeiPaZ+z7wLD7NeOQBvkXE9ofLu6qf6PXdM/6u
         JCGyXqjF6bRSTtlf8TOC+wzYEtypAhHkZrl4rzz5S4aE5NFeSGXwGjn2AN1acxMGTK5K
         DcvzzUzagTa9rMMIeqqIKwYMDx7f3ogD4KF8vnFgUNHG55RQTDJlaWlaQ0OR05HCZTuN
         Fc2U6Gl5OGL8e7eNHDW8Ji10fLIKdx4uY0ia+LCiU8OG/5zrM35449broaYYtALoMzi2
         Tvsuq4+EIeUD0zEM2KzWUZWm/GDpgWgU8QI22iJVZ4BWYgjjhxkbogkDpBE7U2s8a40Y
         WArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765925148; x=1766529948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LAP6LHcD3Su7xaethfzzqudUyr5Li9WQh4nKiqzlITQ=;
        b=guviQpeWTTDe3EYSiCI91XI1eWOFBwpiHScJj/phaQeCr8NcWO0HgCIfXiy5AtA+sx
         eXVVdm3mYMjT7iNe0L6oihuFXfdUGy1rSCsH/x3focG2xKeHlZWXuT88GZSfDWGiaq5Y
         /HuHOC0xwDh4Z3v+Z9hCnOJG1vKj6Vc6h1eDSsea6qMn213w59ihB/VlvrKwDzILCdjP
         RCDVJ9SLJ3TG3++gYk55WT7MRuFW7cuXafGPA1p5ST9Nlw9Sx9AH3+UF8A9efthO3gS+
         FmormYsyYR4m5SkuXdQYSqIkVqZzPHCtTEjS08vXQyX/ndpfT9eHkhs/9/iHjeqisvra
         6+aw==
X-Forwarded-Encrypted: i=1; AJvYcCVolO0bLfv8ECLe8STdr78iVOahI6UgU8q7YHXNa5rz17tV5Wf+tNsf/JeVuH/5Ubu3FR3lFabGkEbqWUdy@vger.kernel.org
X-Gm-Message-State: AOJu0YzW/tccflPlGwsT0DC2w2e5HalHEh9AjteHnEKUH0DSfUT+SY/l
	Cjksz3eK5T6hJ3HwuyLV5DZV6mX3BEQxI6Zhu3S5TP6is4kz6WqO9yjcHHFz7n814/f4zpntk/H
	t6BDwctxXK7SeXxPkhKVQ5agAWDhnbQU=
X-Gm-Gg: AY/fxX4SSJlB8iJSTHvqZicxOju5UHoDsBB55YudpchAIpDjA4wW5JNSk5D1tkrFxSB
	FzwFxNy8KFNY/HD3tRWzeqbtN/zuc/UxkZAEjhj1Q5Qa6fEDQuxPwAs2lttIuVk+ANQ95XkRP/3
	HGE475ca+UYkpNERlvzHHg8N5T+VevexzF5SLhO0S5duSX05dFv70cxscdurlJVSoi4KKbpSnR+
	+g/m2/HuNzUL4SfDRHitboSa1UaeaC5Yj9RxDNXFYHj/PZ/U8V49cJnbNIFUPkBG1f7NFn8
X-Google-Smtp-Source: AGHT+IGpFAsrngbxqe/HmWMoCoRhFNHPRNAT6Z1HRXcRBsGBTmoeVU3ivOhU+MVrs3Ek4vxm1Ba3BhlI2IrQIlUHb4s=
X-Received: by 2002:a05:690e:4289:20b0:63c:ed4b:e53 with SMTP id
 956f58d0204a3-645555e8ebfmr10013123d50.25.1765925147865; Tue, 16 Dec 2025
 14:45:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251214170224.2574100-1-safinaskar@gmail.com>
 <87cy4g2bih.fsf@wotan.olymp> <CAPnZJGBtHf3p=R+0uxNuK42s5wteMi01Fs+0yhW3gUDMF0PC6w@mail.gmail.com>
 <b59c5361-c800-4157-89e9-36fb3faaba50@bsbernd.com>
In-Reply-To: <b59c5361-c800-4157-89e9-36fb3faaba50@bsbernd.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Wed, 17 Dec 2025 01:45:10 +0300
X-Gm-Features: AQt7F2o8ZuJVGa7gLMytxeYeHRUHzvOfFA_VcOrwXVjOF1dGEt-RxSQrrFG78Yo
Message-ID: <CAPnZJGA7HGR5UgA0hNAmUuohfV+2xLpBNTj2ChfNXCHSMiDJjg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] fuse: LOOKUP_HANDLE operation
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Luis Henriques <luis@igalia.com>, amir73il@gmail.com, bschubert@ddn.com, 
	djwong@kernel.org, hbirthelmer@ddn.com, kchen@ddn.com, kernel-dev@igalia.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mharvey@jumptrading.com, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 9:49=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
> I have an idea about this, but this is not a one-liner and might not
> work either. The hard part is wait_event() in request_wait_answer().
> Probably also needs libfuse support, because libraries might complain
> when they eventually reply, but the request is not there anymore. We can
> work on this during my x-mas holidays (feel free to ping from next week
> on), but please avoid posting about this in unrelated threads.

Thank you!!! Please, CC me when you have some patches. I will test them.



--=20
Askar Safin

