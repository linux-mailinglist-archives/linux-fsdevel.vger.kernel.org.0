Return-Path: <linux-fsdevel+bounces-54307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4656AFD95C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 23:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F4E483E1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 21:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602DC244686;
	Tue,  8 Jul 2025 21:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEYAr6aa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553FB24290E;
	Tue,  8 Jul 2025 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009175; cv=none; b=qOyK+8Zqg5rBhZggyQ0p44zhshVgJDVeyZanbi31ptk2VJNeNgyZJeRt/08YELl+sm7yuD3JEGkGjWCzCXAMuJPYuiZs9Zoz1uqwzVJ3k7uXRCRlLfpr6P8xsKknudlp+2pypVk8KJ/HHaapRqUrziZ29sEvJz3vs6C7QuPtL6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009175; c=relaxed/simple;
	bh=WHPQ1X00dK/NL0Zwe5X897Rr/QyO2GlGUXdGHCynPQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUBXGgrvyPWZ9qeytxcfAtZ6mDWj+cOj7N4b9AE6K3k5qU+C/gCWoM6GgpLA8gfgU4YBHthkQud0S5B945S4ELkyqat898Tm9wloGT6wl5Ymjkdzdmd/49PAEwiqOWqj92Kzn0A65s0ffQK28TKGgQkdgFTN0uRV/FgKoz/woYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEYAr6aa; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a58d95ea53so4790361cf.0;
        Tue, 08 Jul 2025 14:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752009173; x=1752613973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2oGPkj1+e6ZzCV+BwunmQ0FgWNvFRc97SBF/zT2kb4=;
        b=kEYAr6aa5qz8pmnC+kpz195e7Lr42kuqKzbUIC4PZk9Mu5SRb8pydgKwGMVEG1QZX+
         8KHA8IcbDj28NSRjmfRmQ7fDlX0S7yNJwXyxMHmfckbSBVdKkHMh0zcMNCTU18ymF9vC
         Z0ETpNENfVD1neI7pN1/WUgLfx1C5hWk8Wnf6UPsll/xuV639phUaqv6SEVBHQFCG15U
         3xCCEc7L4QxTDyH66cSoEkct8lmO4h8tnib32NGgqIp6xgGgCdHJk4BPsxTp1phFaUi1
         WXJ2qw5lv5leEcPGPqe+DlatiiiKdW7N18+S+whbB9hKwghkF97IS9d02M8MbFnE5kaP
         ph1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752009173; x=1752613973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2oGPkj1+e6ZzCV+BwunmQ0FgWNvFRc97SBF/zT2kb4=;
        b=KkmiSCnXofrwq+Qy3Y9RqvCx8VBDm2Qw+c0udJ/ovsmkmlVz3QDmmxmDYoVeQfthwa
         mtGpRqZzJBJe6SrDKzhWi5i9zjhIUBtI8d+Sb6vDckeHsmv3W3/H1dz4FQvtGPGRvKFm
         7IM84sdvbOgNciUqHZdi8OQACQDhxVkxmDVdVSWFNFTLjBs53jfyWXEVSOF84qOssvCp
         hzlRvZCnzYA0puuWrICMnchifGAGq4V6cMSj+NebCg9/BoA4SwNSlrvQdXNh7vU8EPEk
         icmwmcvORfvbDDFXzxIzWxDhQ7B5snooxI9EUXI51njKtG0jIORwCLfzXTq3ySOtGuR+
         utZg==
X-Forwarded-Encrypted: i=1; AJvYcCUM2SujOdrxbxpVxMY0pj2rPQvdkWVD27phxHsK1+b6kovOdOq+2IYcyxj7R1MLEL2ZDq4IePrbV0pSOgKgPg==@vger.kernel.org, AJvYcCX7yQ1L+TfN4H2RipmiA2eBOcXXndCZXUY6r723sgFNSTbWuoafWP/m0h5kR9vL1H1FzTlPurTvED+tVQ==@vger.kernel.org, AJvYcCXEvCHwdQhMcxRNsG7rrY9roW9HN6dQAondZxnlMYQ3i0txZ5MjCNveLmZddr/YRvDXDXsqQuX4evyM@vger.kernel.org, AJvYcCXII6M7OS4VUxAw2kYdyKMsQrYTKTf3qB8r1yolSLIl4CW4ODNXcIaPISSPXpPCiIq5TL9wc1lAiE8o@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLy2f8DyWtHxvHdG6cc06DpSjSjgYDthZQUrWnPdVyti1vf0p
	yIptCU4rkTjpHh5jlZRxXlKBf+Ezfuz5UWjKfnVZoc+yCmA/qymZe09uYuZQwB8Gh/Jw7Ak8pTS
	+CkTRKzegNLK2O9XimqJvERnwCiI58do7X3Hg
X-Gm-Gg: ASbGncugcEXiARYTlS604U7VNh0Xw35cCs3qQDkDnkEuP24Pjz3p4rRvEaXDazkts6s
	UFpBj1qyOJrQ2lmRWp9y5sfsNdVfb05EaF6XUUvLiofvBFCH8xm6A0Tt9onYr5hTeSYR6LZDwXY
	outq3f7Lm0RK3Z/Raakh72ozbrU75K7SDpysEjtVvYQlg=
X-Google-Smtp-Source: AGHT+IGxCVJpLD1WN9FUxd+61MwdovAd25GfBDp2pHqBMaA+5eKnsXsWYlx+E2Xzp3tgOraZ0J9J7jqGMceu4pZJfJ4=
X-Received: by 2002:a05:622a:350:b0:4a6:f0d0:d4af with SMTP id
 d75a77b69052e-4a9dc2735c4mr18050411cf.16.1752009173068; Tue, 08 Jul 2025
 14:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708135132.3347932-1-hch@lst.de> <20250708135132.3347932-9-hch@lst.de>
In-Reply-To: <20250708135132.3347932-9-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 8 Jul 2025 14:12:42 -0700
X-Gm-Features: Ac12FXzEh3jhezVsM9Yn9RD9LsQJ1pCxI4nlbDq2cmHUqPFOjSkqphPTgXPwTCg
Message-ID: <CAJnrk1acMOb=0EQe6FZwzn_3tw8g-0HrDMjR1OrCBEQsZXyt7g@mail.gmail.com>
Subject: Re: [PATCH 08/14] iomap: rename iomap_writepage_map to iomap_writeback_folio
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 6:52=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> ->writepage is gone, and our naming wasn't always that great to start
> with.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/iomap/buffered-io.c | 10 +++++-----
>  fs/iomap/trace.h       |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>

