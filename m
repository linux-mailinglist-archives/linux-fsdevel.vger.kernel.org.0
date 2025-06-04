Return-Path: <linux-fsdevel+bounces-50671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3498DACE518
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 21:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A6617A217
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 19:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436B223372E;
	Wed,  4 Jun 2025 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jyaij+1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70679227E94;
	Wed,  4 Jun 2025 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065891; cv=none; b=IqZ7T416J94j7GFb/lZq9SWMFdaX/wTwGJfLUKQzmvgE1tu96BxDQFLxt13ZO7cbYu4Ip/0lsRg7hFPDPrd+Q1QGR16EFDHT7GbcLLi6cXVl38BCpFalQ4u8ZZfu28zIX124atK/utsO6evCHKRKlVN2rOroSKNtqWx8y9BWVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065891; c=relaxed/simple;
	bh=/Fsr2JgrwCrO2YLARhwC0MuK0FfYy7hIxMp1Wh7CEko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIfkHr8WQXrDJBUUO/C/Dpyh3DjIzg4pY+jpo5oL6O+U1/SVMhBPN8kjo/NHd2D/lSgroaYNThtBdgVaZesAoLkoIcvFFmhIp7lAb6aNWahru6jNtye0cTPJ0vYJJtJppiMoFwgavA0V5ez8w4NrAoMRRFjBD8T5xA37dQmCGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jyaij+1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA582C4CEF1;
	Wed,  4 Jun 2025 19:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749065890;
	bh=/Fsr2JgrwCrO2YLARhwC0MuK0FfYy7hIxMp1Wh7CEko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jyaij+1RYNsrbeCJNkZY4AACcG5zbk/igKjumGQg8hWUaDWrgNmsm6VekfJVxE3Ir
	 LNaqRas2vuQ18NuAv+qgasubKJC1mcOwkL+4DBqUK42EmDzHsL/MKC7tYz+AzWpA48
	 ZT4Ccrx3cRWMgNH/Y71SMajjwioCfsmAyknEddjO7qE6z1C0hz3ZBZEqeDdnoIvYr9
	 jBMFq9hso9lpNkS0qKZzeIVqQ22nA7p8JMkO0anVDiIiwvLM7keij7thP0kRReo+W6
	 K7wVU73Qhpfz632RN17/HVTK5RR4E2Dybt9vo678hLdCatLK7mDAnuJxTqvNrCbJgG
	 9earos8ypQX9g==
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a4323fe8caso1107721cf.2;
        Wed, 04 Jun 2025 12:38:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvTe2rlkaa8sfAJ2PaDuu3Ueu7unQmCwc8g0ZrceUxpL5y3UuzJgYzmcXguvM3vlHqzSE8RoAF4auk6CY+@vger.kernel.org, AJvYcCWovNq9kRl4H4sk8WISUblcQ33pnEtobkQOmd9cVLyaNBVWySxqEnq0BPsex55xKBEKgVTY8pUyXnWQrAeP@vger.kernel.org, AJvYcCXYmGnxBV2ZXlMpCFUcqxo9ztLXO2hUGooGwDDsWRblBPmpyGzE58FVgOUd338RJ9GBvx/+YRIsnhxvJkK6O3bi0GR6yvcg@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxCH0D1F/KRw+GyBX77PtedeHJU/U765b3hsQqukipLu9Yzp0
	aJKbUXKN8OzorlE/zWS98Y7uJZ0chd7Wnstu82DJPn0I/yVYV+oGqs1RpzrJJqyxBrHwQ6nEYjL
	GphnOTchWblzFsIgWnBOasxQWZ+4pqyQ=
X-Google-Smtp-Source: AGHT+IHHR7SptpMPNEHrz/xa0ziqGgFVxhtqzkkl3ym1gi8z5oE6+wH/IsRr/B7okkvCHoRrEMUsjGgMNvwm/sLWuUY=
X-Received: by 2002:a05:622a:4cc4:b0:4a4:3913:c1a5 with SMTP id
 d75a77b69052e-4a5a5759b61mr71030331cf.16.1749065890044; Wed, 04 Jun 2025
 12:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603065920.3404510-1-song@kernel.org> <20250603065920.3404510-3-song@kernel.org>
 <20250603.Av6paek5saes@digikod.net>
In-Reply-To: <20250603.Av6paek5saes@digikod.net>
From: Song Liu <song@kernel.org>
Date: Wed, 4 Jun 2025 12:37:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6J_hDtXZm4MH_OAz=GCpRW0NMM1EXMrJ=nqsTdpf8vcg@mail.gmail.com>
X-Gm-Features: AX0GCFvGYg67wlJhC9iGRdUkRWP0aI7G3iTqfEbemzY0cj4E61U_duxvBA3fbBE
Message-ID: <CAPhsuW6J_hDtXZm4MH_OAz=GCpRW0NMM1EXMrJ=nqsTdpf8vcg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] landlock: Use path_walk_parent()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com, m@maowtm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 6:46=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> Landlock tests with hostfs fail:
>
> ok 126 layout3_fs.hostfs.tag_inode_file
> #  RUN           layout3_fs.hostfs.release_inodes ...
> # fs_test.c:5555:release_inodes:Expected EACCES (13) =3D=3D test_open(TMP=
_DIR, O_RDONLY) (0)
>
> This specific test checks that an access to a (denied) mount point over
> an allowed directory is indeed denied.

I am having trouble understanding the test. It appears to me
the newly mounted tmpfs on /tmp is allowed, but accesses to
/ and thus mount point /tmp is denied? What would the walk in
is_access_to_paths_allowed look like?

> It's not clear to me the origin of the issue, but it seems to be related
> to choose_mountpoint().
>
> You can run these tests with `check-linux.sh build kselftest` from
> https://github.com/landlock-lsm/landlock-test-tools

How should I debug this test? printk doesn't seem to work.

Thanks,
Song

