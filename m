Return-Path: <linux-fsdevel+bounces-39730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA00A1731C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C7B1677F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928D11EEA56;
	Mon, 20 Jan 2025 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MP4wkjqF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E736618E743
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737401118; cv=none; b=p3ORZ41qEirUog+XpPZnXngOkKUBSaV/7Qs5LAtOXQ1yaw3dmNNHg1hXDa1EuztIy1BUOEpUIyLdfewxI32GTk8SlJNwqfbxA7eHw2HyeLPLAcO+ETCEbezL1xdUl4AJtB2gO0bC03P23QGklVIdDk2dh5j/0xLDFPr/r/LxUJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737401118; c=relaxed/simple;
	bh=N9JEuy5mMXz2AMptFUdFs9+Rhp/exv+/d/8MRvMK128=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvbbF9eaoUDwUc5LVwNBCa1tWfsGIlWKbKpIzJEBd1GgTUyBbxQ+CSqfAMdThUAvd7LN6TXl+grVeNdEAMce6p8+zHJv6MvrCWKtYXqsqWyCTuscX1gP1K3sFk077Zz3CGPToJjB29zo9ZzMHuNcWTBDJk+1DyCbCHkDayEV+pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MP4wkjqF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso928927566b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 11:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737401114; x=1738005914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dNz4sw+U7Buo+5PwR0gF7K0TxXOxn6SNF1fzfPj+TmA=;
        b=MP4wkjqFSclGT2WbuuCvehVoLB10bOtvPb/Fgr1yF8L3RQQ6RqlW3bI9gH584Sa9iy
         6BK6LzqU+3jecqUW/C99oyfc0PQaAI1PPB65hcleuFRwInIcjX6sS2KtsBF/x2EiQy0h
         +HyfuB4BnFMEuymfazbd/GFt61cusbPToNn9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737401114; x=1738005914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNz4sw+U7Buo+5PwR0gF7K0TxXOxn6SNF1fzfPj+TmA=;
        b=tCrBFj4oVaSZYBDOsXxGWpnB6qElxoU7jD2IaH4xtZCVrdE+qmTnEO+PwfkhN+v0q8
         LiK2FKjSM4nYIolm/NeNk3pdOpvg4fmanYzVGo+yB21B87lLbnoGZsDNAv4HVodn4X0r
         1/iZK4EFriPJr/udpQZPzV9yWb5DrCyEdTlmG90dYEun+MkJS0y16lP7IqFhjkMYNvXo
         TIZ3rIWzstzMpN1RWR4vF2khrUe/APzeNEP44QJE1RMwToTugBf4u3RMwPtA3w0iAWwl
         vuo74dS3jp4xB18UsqN+WUpHZRwTwp9qCU5evgyuapzevlOYcFQ6wB7FHsdao6cY0jf7
         dAhg==
X-Gm-Message-State: AOJu0Yz8hyq5w+GQP99mDdQ4TbBwNx4oh0YdcTwR1iglXAFohgJzoEKN
	1/4hhvqKUhx3wFfg25TDEpZ9xYY5NYyeSWZUOlnmmM9BwI8Ghl5NKOg+v4vDdFRQh0rJtGBaDCB
	lnKj1UA==
X-Gm-Gg: ASbGncsdAUUmoZTofsk67GMMq3XjKa04o7tP/eh7LJX9tBxQvp2fc6YlSIf7yg054tC
	FiZaEUkD4d0wtm+tz6IZO1zHcUN4WPRQ5JL2x1wzLPVc9sEvzXpoixzPbXuDly9kmWtwDeMI4W6
	H7AxuMjCMLu2peERKUGgaFvU8NemPER6W23XjqO+g9p9QGLvdXhCon3uBR1PgCfzEAReFV9/1lR
	zZOo2VMvvETQSPouLh6botEfH0e3Nuc/X6JW70Ff66NnnvZGYrGk1D4nm+h/97SM2urkw7o/rns
	si+NiizLX7dN+4UELeY+/eXnUXotiLHCNJXTNiXPXSl2
X-Google-Smtp-Source: AGHT+IGzpKQGhBCLYGfcrvgSvUqtAcxHh7oVt7p5Sg17+zP7Sl90HVdmfCsvbDWfwbjkgz6UzHfWag==
X-Received: by 2002:a17:907:d03:b0:aa6:730c:acb with SMTP id a640c23a62f3a-ab38b0b7ee8mr1358734266b.8.1737401113917;
        Mon, 20 Jan 2025 11:25:13 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384d2dee0sm654495566b.78.2025.01.20.11.25.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 11:25:12 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab2c9b8aecaso760643166b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 11:25:12 -0800 (PST)
X-Received: by 2002:a17:907:72d4:b0:ab3:84b2:4247 with SMTP id
 a640c23a62f3a-ab38b3808fcmr1397152466b.40.1737401112445; Mon, 20 Jan 2025
 11:25:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250118-vfs-dio-3ca805947186@brauner>
In-Reply-To: <20250118-vfs-dio-3ca805947186@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Jan 2025 11:24:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+uVo3sJU3TKup0QfftWaEXcaiH4aBqnuM09eUDdo=og@mail.gmail.com>
X-Gm-Features: AbW1kvYhzP2bJJ3Ph8xYqu3iB_SqliGiIv6xF0kucY6W1dKwdDARBRiuKzcDVdM
Message-ID: <CAHk-=wj+uVo3sJU3TKup0QfftWaEXcaiH4aBqnuM09eUDdo=og@mail.gmail.com>
Subject: Re: [GIT PULL] vfs dio
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 Jan 2025 at 05:09, Christian Brauner <brauner@kernel.org> wrote:
>
> Add a separate dio read align field to statx, as many out of place write
> file systems can easily do reads aligned to the device sector size, but
> require bigger alignment for writes.

I've pulled this, but it needs some fixing.

You added the 'dio_read_offset_align' field to 'struct kstat', and
that structure is *critical*, because it's used even for the real
'stat()' calls that people actually use (as opposed to the statx side
that is seldom a real issue).

And that field was added in a way that causes the struct to grow due
to alignment issues.  For no good reason, because there were existing
holes in there.

So please just fix it.

I despise the whole statx thing exactly because it has (approximately)
five specialized users, while slowing down regular stat/fstat that is
used widely absolutely *evertwhere*.

Of course, judging by past performance, I wouldn't be surprised if
glibc has screwed the pooch, and decided to use 'statx()' to implement
stat, together with extra pointless user space overhead to convert one
into the other. Because that's the glibc way (ie the whole "turn
fstat() into the much slower fstatat() call, just because").

So here's the deal: 'statx()' is *not* an "improved stat". It's an
actively worse stat() for people who need very unusual and specialized
information, and it makes everything else worse.

              Linus

