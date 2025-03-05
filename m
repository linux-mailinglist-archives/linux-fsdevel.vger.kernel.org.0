Return-Path: <linux-fsdevel+bounces-43257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3B7A4FED9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 13:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE320164172
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 12:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758AF241697;
	Wed,  5 Mar 2025 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBoWf6K3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D53245014;
	Wed,  5 Mar 2025 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178419; cv=none; b=m0rU7ujIGTGYrecKDgQviTUekIPwhJ36gKol9aS6IVbk7O+fmws/BSgoE5yj5zciSYZryyl2VWS2fCbA0VDJYhOO4b1SBl5L7iycacKq4Zt8gUV+26EGtOK3GJcY00Tvrd2bWLIvAH+vrJ3I+snTnOfDQaMCUpKdeT1MHtvVxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178419; c=relaxed/simple;
	bh=C3BN/HIMtEcUf1uSYuHLYfvHbZIlLdbrO0Cco+IbjlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yb82wqiN1DE49JtaZYlF6LYU1224tPULF0GNWx03NpHK6R3E1XxqbrhV4I0CdSkjJHFM6nT9W+bYsU/6N5A9MLF4Xa5yMt/+5G/ym8AA8CsCmE0yTu29kZE3CYyPCI5y6yAZ/nuWlPSV2Rhq6emAAjzqGWNZZHioAT6MvHDjRXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBoWf6K3; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-727388e8f6cso3619928a34.0;
        Wed, 05 Mar 2025 04:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741178417; x=1741783217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3BN/HIMtEcUf1uSYuHLYfvHbZIlLdbrO0Cco+IbjlI=;
        b=WBoWf6K3OC3Z0ouroGN7jRvL5/g5uyiVc4nNNxpu6QYH/wgiJ2FYHQp/9M0DBA8q4P
         Ev2bXLXMyiK4D4ZaZDdRdd53XPGGK8JFnmR+U2TH3XizzkNP3dCw3GMpVaXQfZD8u8bn
         ScHvD2S9MnhRoVz8b4sl5Eu8/5/b5Aqg75Fju2RYwtNZpP6tycjzbvk1kbQXTWy7eWUp
         z3CWPYgRux+MpnjoKzL1yVLdiF0KEbc1AVqzMCCxVTh8JgwT8Az5irsUt7YCXCyuGyYQ
         AM+q+cbGXf/Eb8lZhSJNOPUyAnXFzt7rXkpepMRv6yrKA+YOVOgGziGJMXm/lWnG7TfN
         a1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178417; x=1741783217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3BN/HIMtEcUf1uSYuHLYfvHbZIlLdbrO0Cco+IbjlI=;
        b=jli9WdXUTzekB3ASdLPE6xUfDUSNb8JxERmD9xzoVGEwvNEmgD1FMMfGOm2V1+hgSX
         h05uhIWz5+Pnjx+/4P0sbncFq6MbYxXvBjcKU+lA9lGmNwq4XtaFMPz+/vigHtd9bXCV
         8aSP3+9PIJ5befaDZ7dDB2PEBxHYTLEXID6L2xnYG7LyQKR4XFdTm7767scipz2V8LAN
         trM1dnWVu4pBXxebt2UQDp0KQ/tsCVJUa+OSiF4TDPpEsFoRgHQmsVBImGhZinb/Du5q
         DMamcm1gvTfM356GKW/o3ioNKdoQ3pLHjIaLjjrPGbeS1Yu+jyJnbuBS+EkrenNJ+SwO
         znXA==
X-Forwarded-Encrypted: i=1; AJvYcCUdyGNQS9df9BQcBKou2O2ueAmBl6i4OMyIzIuutZHQhAVBYn4FLuvl9foC6TEmY94FQZTmFFFKXgOp7rOU@vger.kernel.org, AJvYcCWGVs2+R7rTuDReFMvScfElvJR9etH7fd/aI3fTK0vIPbRuXbWlU8rMNdf1V2+uM/1ErNpJSI0aGBFtFuuF@vger.kernel.org
X-Gm-Message-State: AOJu0YxY9Uyl2GEgnkbLLSMsMbEjSR1qKQXaRgsRgd0u93ZLwTtnzuvg
	Fm5BAwQue2Ch0ysetpJzSVmIiPkMpMfSYJfZ2NSIFJbnyX5THmte+oLaDHMsd6QUej+TIJXvKd6
	qldlqcqSLLFWS3bek0BUM8n8iCIwMcw==
X-Gm-Gg: ASbGnctZTTDkXUyG80JkMbqDfQIhk8A6ThB76NXkmrClyupg3Lg8rsRIGOwyJesJ5+6
	Qb7o3RNV8axxrvWDDLBiU4pRgJciRKYr5BL4PtDCR4OqVrq3wrZBqDRlrhEDu64vS4slb8gNWTv
	6k/yVJvKlgwCSYkR+dFl0Y8FDJ
X-Google-Smtp-Source: AGHT+IFIk2TIUkPMZ9N45ATyP7LMT8PmzR4vlDHgUxaaOm3ICo2t9IYM97ZmCR8by013ZrHkHhJsjlYAGpGl3gyWZqk=
X-Received: by 2002:a05:6830:6d16:b0:727:41b6:e0f with SMTP id
 46e09a7af769-72a1faf1ff0mr1341886a34.4.1741178417282; Wed, 05 Mar 2025
 04:40:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304183506.498724-1-mjguzik@gmail.com> <20250304183506.498724-2-mjguzik@gmail.com>
 <20250305-gehversuche-ambivalent-c2c39242bb7d@brauner>
In-Reply-To: <20250305-gehversuche-ambivalent-c2c39242bb7d@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Mar 2025 13:40:03 +0100
X-Gm-Features: AQ5f1Jp-ExXc7u-VJExoEOIhOR1XE3fCAh5_huQJdKulRaRmp4T5gTcxJgIe8hs
Message-ID: <CAGudoHGXMzD-vpwgmT3_dejsPdG_sLxSRdhT25GeyyrNLxufdg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] file: add fput and file_ref_put routines optimized
 for use when closing a fd
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 11:47=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Mar 04, 2025 at 07:35:03PM +0100, Mateusz Guzik wrote:
> > Vast majority of the time closing a file descriptor also operates on th=
e
> > last reference, where a regular fput usage will result in 2 atomics.
> > This can be changed to only suffer 1.
> >
> > See commentary above file_ref_put_close() for more information.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
>
> I'm not enthused about the patches tbh because we end up with two new
> primivites and I really dislike so many new primitives with slightly
> different semantics. But it should at least all be kept private to fs/.
>

Caller-observable behavior is the same, so I don't think this is a big
deal. The intent was to keep this very much for vfs-internal usage.
The EXPORT thing was copy-pasto.

Anyhow, everyone interested can still just fput so this does not put
any burden on other people afaics. The few patched spots are very much
vfs-internal.

I sent v3 with the feedback addressed.

--=20
Mateusz Guzik <mjguzik gmail.com>

