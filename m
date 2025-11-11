Return-Path: <linux-fsdevel+bounces-67917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A840BC4D880
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 12:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD923A458F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5533559D9;
	Tue, 11 Nov 2025 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV84svQT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573883563CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862048; cv=none; b=tf1TQ87U51oxJgU7I5TJ8L/TlGAFro1qZj8LBUBjUhCyLy4QaTKPaw9hjw/CxcFRJC8LlMLpzq+ZWG6tiECQNWm8/JwR8pIPSfHpCuH5+JIYJ9A8o0UeGCXiQTqH0yl+dK9Z3YzpLAoT0h53DCUx48vC7HjLy7IZ9zHwO/mDkOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862048; c=relaxed/simple;
	bh=ToY4TL4/qwontWIUOqwnL6q60lEkQZbsmA8tTEk2d8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qt8uHD8KRz+iJhRHUILEKKVoj8Sjt+OheKolnD27+vi3yGT9pp8FC2c9VDxDOW11gxXIThyrqUSntGr8wJJkg4iXnKQodqzMHCPdSk8r9ZZdnbrpvZnBaULxgYTJmsqq1d6IKww2ZqoWbQTsxigp1sw45v4E1GoDwEnn3xKFBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV84svQT; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b5a8184144dso538516966b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 03:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762862046; x=1763466846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToY4TL4/qwontWIUOqwnL6q60lEkQZbsmA8tTEk2d8I=;
        b=bV84svQTQU/24WPRQv3bWGaHxAB/W8QYfqeEp+4TZv0Iq3Lyuf0vJn/4HfQcX0w6q3
         o47YmmdkiL3NVAufzQdXx4NWPkWJypzmDNyTZM0yoPgzoAB51amiCD6toscbME9d3wtX
         prqktJBoNqZ/fxYm3FeHhoxJSMkR/d9p4W0qHDMCL/s6hY9taWfrIRysVP/MVyOQ0U7X
         tBid9NpCbc/ELbjI0jQaQ91XqdoPmhqDyv7qhpFG7zgKUiRXjEXkndgI7rCcZ+kUTvao
         4adGm/mu8po/4Ty6FcZTIRhCEx/Vbr1C/glyNDShUFM1b+tbPaoYdeDgeV8X5r3ihYkE
         CcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762862046; x=1763466846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ToY4TL4/qwontWIUOqwnL6q60lEkQZbsmA8tTEk2d8I=;
        b=i4lpQ3mLC9geiiw5XNBk6+s5zD0rS5eQ/hdz2gLL02jhxRuRzA5UZm42GU99RI0pM7
         ChLSPfcDDYOBjTLuyZzAzu2MZ8qNH6gN7U5s7kbZZjMwmgIRkVKgeo9Xx70dnidbAMkh
         5H6jNlEeSNcxo+6XyGihOQlJBRxvmbrL5GYLo/pCp2+3XaDJ3rqIqyYdcCtFQo9qwf5v
         Pty6g6oveRDKa59A8l4VPz+Sfk9xXEw9nzZpBLoWFDz067OWkVrf/Y29vkzjCMVR1Orq
         glRHvIu/WWVTiPqIdfODbtOk0kL0e6X1qz2PVJKVEMa+t+qbjP4fWgisA7rIs7vHB2N3
         7E6A==
X-Forwarded-Encrypted: i=1; AJvYcCWtDutg5avcyVftHCy734I0qJ7CDeBUvZr6LtcRkX2j4WZmnFyTFOOI2+BmmdfBLp9s8+yeulOn9C+94UHo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/To2TT7CeRPXNbyLhzC26UCPtFGwmtwS7nrLhqVrZDvy9UA+i
	+e5aqbxotUZ2eHxMgy5XU6eJy3a8cTDXBBKY61ZsiqKemoiYCDZkrxKIYgNDpkyg6OxQBw207Tz
	HNpLyhXwM2uaxkeIZSyLwY2LsHLMkqP4=
X-Gm-Gg: ASbGncsYYPqX4YWBEDkKx03d7najf5DTmk8MO7ukPqXoB3qT6VNrucXOG8OjIgl8xwV
	RUld/uGUsctk9EG7OEnXtS5n2Bh5fCKpZtwbnn+Pt1nV3rR07GYqEu2heUJZLiIrhhY08nqypho
	PPCIBVuTc/7Fvl51Ro11LKvfc+n/7MvZm6m63HfccJiyg70tfMM6zeyuOUCE535TAbnblz5FLWP
	gWcY5NpiFsqR/7hKqmHtlWQWuhdML3PMqCtDlRFqBl5AL33NLwmsdVU+o2Mm0qbvm2nQ2JqKxi0
	r48eDT5PsHjV031XWqh4Smvm8w==
X-Google-Smtp-Source: AGHT+IFTSzzFA3Sig6SUf+l63ywNKbdgVu6wEW6YjQvjoB9NpZdnt04WO700x9EFuZ49zyQsyzAGcOCZY6qw9HwoW9A=
X-Received: by 2002:a17:907:6e8f:b0:b6f:9da9:4b46 with SMTP id
 a640c23a62f3a-b72e056cc6dmr1243184266b.43.1762862045550; Tue, 11 Nov 2025
 03:54:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105212025.807549-1-mjguzik@gmail.com> <20251111-fluss-vokabel-7be060af7f11@brauner>
In-Reply-To: <20251111-fluss-vokabel-7be060af7f11@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 11 Nov 2025 12:53:53 +0100
X-Gm-Features: AWmQ_bmk0-blwk1PQ_lsyim7xX9U0NCT0sSRyAgQiFcSJIzJoe4wx-mIvQrdsdc
Message-ID: <CAGudoHF_9_7cEgwtX=huvSf1q-FF0gSwTn2imXHmszYoa2xPZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: add iput_not_last()
To: Christian Brauner <brauner@kernel.org>
Cc: mic@digikod.net, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, eadavis@qq.com, 
	gnoack@google.com, jack@suse.cz, jannh@google.com, max.kellermann@ionos.com, 
	m@maowtm.org, syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 12:46=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Wed, 05 Nov 2025 22:20:24 +0100, Mateusz Guzik wrote:
> >
>
>
> Applied to the vfs-6.19.inode branch of the vfs/vfs.git tree.
> Patches in the vfs-6.19.inode branch should appear in linux-next soon.
>

That might_sleep in iput is already in master slated for 6.18, so this
should land in vfs.fixes instead.

