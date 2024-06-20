Return-Path: <linux-fsdevel+bounces-21951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A8391010D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F3A1C20D4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAA51A8C2D;
	Thu, 20 Jun 2024 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3EGJx0E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F0319DF46;
	Thu, 20 Jun 2024 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877877; cv=none; b=tUVMHEFh71N3lSZbLHF0EXtHdM+VX5IYd17SdjSjX1HJaGc9eo2MZnL1xKJhvExURy9cj8sxFX9Cs385pwGZDdZKnuaSbb1bzXwhgCePWqQ6qLPt0xR2p7YJ8JaKq6AHj+doGbuS9Jo05z3+b5H7Jmoa+b9ChEg3wam1yBqc9G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877877; c=relaxed/simple;
	bh=qssxO3H97xYgQ6phX7ShXtegLep8IN5IzW1nwrh59UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyVX3SCY1TcYs91Z0Uovvn0BY0BsOjG6KXtC3ZZJLHMX3DkPqHxvpQcMXi6E3x2R6mB0NnoT3Ub+/JZL8X364WHbtlugTKima2lmcQiiLWDnM0iohAyv7t5+ymk7ezhShVmwJnfZxBzNawGz7ZHrDf6RsPL9L2PhnxjvbyGGgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3EGJx0E; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6fc36865561so311364a34.3;
        Thu, 20 Jun 2024 03:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718877875; x=1719482675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qssxO3H97xYgQ6phX7ShXtegLep8IN5IzW1nwrh59UQ=;
        b=B3EGJx0E3p4MH7DCwhk4udRzfvOaBzSNnCG/G7cb8VY8pHHWlgaUPt3mZhm0KKsuda
         iSoXsL58n7GwFkqA7GbCyJY/PWYQCeilnUkgUQlOCKRsQ+WANdipFNuRsUT2PT9QvwWC
         dUYnAXQRP/kARMzAM1mb3Fh8zVl9jZLn0JaNSOVzoRCHMylZzYumz2I7T8P4eAsThXGu
         MRF7R1AXu9NI3stEVgeQjEj2PsTI6nuoZlxJaJ3Uc+U+HpKkaea4e9MIxS8sImbxM/c4
         3I1XuKaVI5jfzhXoqCdJq67myYJWzpIew4bEKbqe0tgL5p406QdZS4/w8OI/OW8fjTPt
         jExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718877875; x=1719482675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qssxO3H97xYgQ6phX7ShXtegLep8IN5IzW1nwrh59UQ=;
        b=PbeG4RXhUbne5d4pUzUuSszyKD4asDnOXUhJazaRxX7IceXDou0YwmHPfGuetiGh8K
         +QAmix37ttjNOayqlMZR/xhBVJ/YGQZLr58l9HmpgXtWQCr37lzFC50l+UdHXi3aWGDG
         xeutCDnJZQmFkx7c+OAqU6mV9xIbdh75F9XrXG8f3Bxw8ikDHsMUlHbAXH099ToOhaun
         Yh75hZrAJobSeLUzpWDSEbQS5nztWoXDjMQa4uZEkpuDxszwLK6EqrssJtsM3L3eUDNq
         1JQ7IidTh3MrRv7XrTkQnCpLhiELW8HcjhCC8pcKmf3VxBI7JIkOC94UiAJQYUFylglS
         5G0w==
X-Forwarded-Encrypted: i=1; AJvYcCXrVG9V9+BwSD+v4pR/saN8BqmxNDR5qPi4jwY69xr6C+vD3y6z549WZLoE5sim7G2SYaxf8AtROK7FVdU3lQoMHGuD0gDyPpWKZfNQYaVEZ3HeUCbDyOhbd1EhQC+JFvLIyGCF4VMlitLt5U2Udn/KVfTbRNkGnoOgXV3I2nkgt3HdOpbUSg==
X-Gm-Message-State: AOJu0YzXRNaHLPdqjCNMt1v72rwhGyx4rIUp1rN/0ZIT+ezkmGg67r7u
	XcNcXJ7uoaBrI94dZFPUaUvtBg31/rZTmr01NmUNDpeKBp/dmRrS8yHvOtin2PIlY5AeJwX3WGn
	cOVugNb5ga0heAQmF/e/B0hw6gQk=
X-Google-Smtp-Source: AGHT+IEsRoAAbHHrux8RoioxqnCJYdrd6SXFlI9sC177VWlo2dg4V8kucLTYTM3m9HxTRR2I126OQYwbcrhsErp1o4o=
X-Received: by 2002:a05:6830:310f:b0:6f9:b69f:b64f with SMTP id
 46e09a7af769-70076a1c558mr5925673a34.35.1718877874742; Thu, 20 Jun 2024
 03:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
 <20240615-fahrrad-bauordnung-a349bacd8c82@brauner> <20240617093745.nhnc7e7efdldnjzl@quack3>
 <20240618-wahr-drossel-19297ad2a361@brauner> <20240620094151.cuamehtaioenokyv@quack3>
In-Reply-To: <20240620094151.cuamehtaioenokyv@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Jun 2024 13:04:22 +0300
Message-ID: <CAOQ4uxgqct2ru571NwzMqVaYOJwwr05La=OTecMCVQZJko9gPw@mail.gmail.com>
Subject: Re: [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neilb@suse.de>, James Clark <james.clark@arm.com>, 
	ltp@lists.linux.it, linux-nfs@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 12:41=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 18-06-24 16:19:37, Christian Brauner wrote:
> > > AFAICT this will have a side-effect that now fsnotify_open() will be
> > > generated even for O_PATH open. It is true that fsnotify_close() is g=
etting
> >
> > Thanks! That change seemed sensible because a close() event is
> > generated.
> >
> > But I don't agree that generating events for O_PATH fds doesn't make
> > sense on principle. But I don't care if you drop events for O_PATH now.
>
> Well, I can be convinced otherwise but I was not able to find a compeling
> usecase for it. fanotify(8) users primarily care about file data
> modification / access events and secondarily also about directory content
> changes (because they change how data can be accessed). And creation of
> O_PATH fds does not seem to fall into either of these categories...

Not to mention the fact that security_file_open() and therefore
fsnotify_open_perm() is not called for O_PATH open.

It's not that we have to keep FS_OPEN balanced with
FS_OPEN_PERM, but I think it will be quite odd to get FS_OPEN without
FS_OPEN_PERM.

I think that open an O_PATH fd fits perfectly to the design "pre path"
events [1].
I have designated FAN_PATH_ACCESS (with dir id + name info) for lookup
permission.
Perhaps open an O_PATH can generate the same event with additional child id
or another dedicated FAN_PATH_OPEN event.

Thanks,
Amir.

[1] https://github.com/amir73il/man-pages/commits/fan_pre_path/

