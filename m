Return-Path: <linux-fsdevel+bounces-31319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A93E0994867
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 14:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B191F26D53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0511DE4FA;
	Tue,  8 Oct 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaICPzIG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E151DE4D7;
	Tue,  8 Oct 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389552; cv=none; b=ZlKnp2r2z28sOWOYxPgYSa/thK4UbXSxvULgbqDuhH3P3vn5me0fu0N7boJLms0MMGjbdXH/QxlLOjGu3iW+qh2COcaSPMyJoY+sQ45iDPTTopmRwYdBbbHQntpPczmiJVWxm0oRy9xnwV4+jwSI0zspoSEvjT1DnhZKS41lF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389552; c=relaxed/simple;
	bh=cugPA40RPde9DsEbr75A8IW96Rq3WSwMwom3AM+D5kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGel8Eh1LK2j+ChC7ayw6YT/Dmxe67tLu4wNbEprj9thqSYRXrK0+J+4fISrEuX4WW5Zst8stMOMJKoY9lYPhjM4o/rfrP2r+bJEhZByZORdQjtmLo/E2+u5b4vxW/1JxMCmSNKPS3T4s8tf4+MpeWUNmod4O0jSza0tAxWPbYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaICPzIG; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e2d36343caso30207807b3.2;
        Tue, 08 Oct 2024 05:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728389550; x=1728994350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cugPA40RPde9DsEbr75A8IW96Rq3WSwMwom3AM+D5kc=;
        b=DaICPzIGdkg90wf/WfQ31/jv//ChXH2hviZYJqbfqOyuWp9dIsdXztwFE1T2Id4bSo
         YMjCQAWEpoZDXtL8brW9XIeV2J2AD6/Hk+sqv+U81MggEri+pU6QhBw5zlW+WgdgEM9O
         o4jsC2VRQT6mHfX1GXcF2PBqQV3a725p38fDnSoqxJLeMduBURmsO94fK+YeDMf+CzJw
         1Zg1F1dSx6llRRswruY188Dvy/jJINmaJ0lQ/QT1Sj6MXNUv2zi9/HC0STeWKDeydr2x
         GRQe2/UuMSOc131/J3l72+xfZZUfrFVQgaGtJTdfe10cBPEWB5yBj/Li9TtIoGSA7d8Z
         cy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728389550; x=1728994350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cugPA40RPde9DsEbr75A8IW96Rq3WSwMwom3AM+D5kc=;
        b=T2m0b9PPgJsrr+F9Qw4OX7HGltpZsd0XwEqs+dv5kW2y+r/z8TKdXyjMqM6tSLvjd1
         k22Uv5CqlC7tZuLGwEDtzWXRBfAuz7KI+SkIPPZGe6BXgR+CJlS2OVhwWbR2tbXp6+nv
         o7ih7G6AbnzaYsX5c0+V98ttZIEic/1cHtAnDyxeo2hHOBQ79UEZSLT1dmgQHC1bnY4O
         lDQQqq6IUocyZJFjt7flTz2OFdRWSQ5ue4/Vmyfvk5BPGNPRym0OYCMzp4R6TtOEKhGw
         IY9l5I9Fz6MRbEgVORJFzV5G/bQAFOva1KyFZPjXtbSmblW/dC4opqRrUIbxg9b3aqHA
         kMTw==
X-Forwarded-Encrypted: i=1; AJvYcCXokXAqCgd5ZcHb4DRWFA9ZxLuF29DXqaM9xD2oFk5gTBIjpXGwnjp3kqwyxTvn0LbW1WHrnfrVwnexswk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4FypIt3rqjgBS+ZIQ9bRkyaGzb0N5HmDx4g3epoDkSAq7ri4/
	2HpfWNv0oa73J2lpxecZS4El7Ma0ZKHkhSJNzv5Cogm4FLOLBENTrAHMxoNQkITMpOXGjbu+x5r
	d5ghqjLN3BOESwqE0c8Y0F5v4VzA=
X-Google-Smtp-Source: AGHT+IGAVlY3ADITh24dULSvSAh8uAfWTbcSH3kHeG43kBUnKs0GhZvNm0TfNqV5wbdAxyywFb/tn1kg5L/CHPvu04w=
X-Received: by 2002:a05:690c:d84:b0:6e2:1742:590d with SMTP id
 00721157ae682-6e2c6ff1453mr121254307b3.3.1728389550090; Tue, 08 Oct 2024
 05:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008090819.819724-1-luca.boccassi@gmail.com> <20241008-eliminieren-trieb-f7a22e6f3d69@brauner>
In-Reply-To: <20241008-eliminieren-trieb-f7a22e6f3d69@brauner>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 8 Oct 2024 13:12:18 +0100
Message-ID: <CAMw=ZnQLN3KA8pBtEGKGMcM4sKtWN2inz=EhB=Y5JN7CSBEgpQ@mail.gmail.com>
Subject: Re: [PATCH v8] pidfd: add ioctl to retrieve pid info
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, christian@brauner.io, 
	linux-kernel@vger.kernel.org, oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 13:10, Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Oct 08, 2024 at 10:07:18AM GMT, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <luca.boccassi@gmail.com>
> >
> > A common pattern when using pid fds is having to get information
> > about the process, which currently requires /proc being mounted,
> > resolving the fd to a pid, and then do manual string parsing of
> > /proc/N/status and friends. This needs to be reimplemented over
> > and over in all userspace projects (e.g.: I have reimplemented
> > resolving in systemd, dbus, dbus-daemon, polkit so far), and
> > requires additional care in checking that the fd is still valid
> > after having parsed the data, to avoid races.
> >
> > Having a programmatic API that can be used directly removes all
> > these requirements, including having /proc mounted.
> >
> > As discussed at LPC24, add an ioctl with an extensible struct
> > so that more parameters can be added later if needed. Start with
> > returning pid/tgid/ppid and creds unconditionally, and cgroupid
> > optionally.
> >
> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > ---
>
> I think Josh's point about dropping result_mask is fair. I can do that
> when I apply though.

I can quickly test and send v9 dropping result_mask, not a problem

