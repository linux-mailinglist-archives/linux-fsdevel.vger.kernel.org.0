Return-Path: <linux-fsdevel+bounces-63712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B6ABCB5EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 03:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20A4C4E7CF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 01:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424801E0DFE;
	Fri, 10 Oct 2025 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rzasn+9e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08921C9E5
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 01:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760060593; cv=none; b=SvWxB9y8Y3mx68gZnHKObZCSGADMQgG6HpY+ZovRXaM29Ij5DotaOO8Vjj0Ghd8pnTyXDYp0vRnJv8FW3ritYsS8/tnPyTU+y7edJuBjzTMoDDYzyRnlYzlFarcz+pctvMYTbNwd8YRQUEnTAZ9urCur3cFVcdTrW+YGxacNeXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760060593; c=relaxed/simple;
	bh=NPtqkvv98yoDXNHLCe00Nr0xHDE7ZeJDXsad4q7/TKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmZvf2TPOe/6jZXGXe1c96zeKRnabrBG5QrsL8mINKqT67jhM/NHSd507AsXBUy0sReCjwevecamXlv+O3HTJRNwGYN38cox5qNjiff7+zT7psXUNtCfbvdQw2aDrHYY0Cw5DmFu02r4eUATluXMoA/vMGPFG/OjzPTyP2Vzsko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rzasn+9e; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4de66881569so234011cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 18:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760060591; x=1760665391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96az3arQQNj4x6OI7kGaXy8qdPeeaXxUJmGrbGqdnv8=;
        b=Rzasn+9eJppPsdUMJ3MSSJXH2S/OCfdfLO3/o7zwuilOebMaSu+By6jirbcfXXlwNA
         q7iELuvNDD3adEbN6B4GdvOs8V4aak+EWesVu80vRrtejs3GxHTXC1GUbKweuga3nyYZ
         RVWIJvAsYlsldEHXglb65xzD0J0+LGcCu5mVoqI7KYtImlKX5iw731TvVKTXUqbZuw10
         4AjUatn75XlthFJni99tkiIL3NdGmgX2+WUUB0JNBUpCtJ5+ySw64rUsv/rxw9jTMXx2
         z+3Otik7wjpNiTz1uz9WXf8J2LzQ9Clb6gfi65JPhbcGqbSL6AOABFVGSe9ylOgfwpf6
         rwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760060591; x=1760665391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96az3arQQNj4x6OI7kGaXy8qdPeeaXxUJmGrbGqdnv8=;
        b=GofD6MUGrmX4XA9R4ZlQPD1KWQDTmKkbE5tRfaI7CFXpO6NBc+JRYayvLukwhmEeXg
         80LjwcjB6cUi5YQ2iCEEjeOJ6Iq0gv1uaJY5f2tK8OgCkWhbB8g/3ghoqz0FMBLCwRQW
         wcqDJULPON8vJ3xD1NewVnXucOc3/yonhgZM1DAJrzCB47kXgGaJNNqm0fxvQbh1cq4b
         JwphlmQVOOA2QYWsoBgEU0gnbO/3m90wrH6IDtIKQnQI/P7CiUO4BDbJrNezZA3osrnK
         vleCp8ohfSxIgEx+tDtVGgbTO9KrurvuaTfcThzbfZZIuyeAx6wgA+X3BSKzTXD0aTzv
         F5Gw==
X-Forwarded-Encrypted: i=1; AJvYcCV+gbR0EtMVvkhCYplTpNa9SyGgyFHPejCrVGLsuIuFjgpA2gwsyzHXZyI7EhXS2MQzLW4Cgo/omROcTHzo@vger.kernel.org
X-Gm-Message-State: AOJu0YxPkZYS9skKbJmlMHCGibBtaFA5tH45PSx+f+ewXn8y7Q6zVEnC
	KrBAhyy0npqB1UcVeX12isZVTPHueVIcyzc2xD9PSIbM0XvhAU8Okdj0JCG/AVpeQ5NEcDSzTBt
	VU09gymPQ3X3/AEPlIx2BAf4WpgPwLyH+iyCG2SAJ
X-Gm-Gg: ASbGncuD6vxQyg0f4hlxhOt1bRxObPGieBawRmsp0Y4xgcuTmtxPGSIRLPbulvUT6QK
	dsvf1JOa7yLzc4KAFJN1p7GWgRqFyYPngZGLg4dM65wEq0FVWG+4yPibo+a/UY1pVopMxde4ljY
	hfscLqBWUyvhONLG6xK0CXhfXv96eFxyoDQyPIl1WG5cuY+PnTRUvzG19QXi7BtLnqO2/eWBjpT
	o3ApXr9W8dpsBXsweVfLnUuG9OQlQ6TpYajVyYq6GU1lF7zrdU0VnZMAbF5G438snRqEQI+Z1sE
	PYQ=
X-Google-Smtp-Source: AGHT+IGu0DK2CtCxN7hIIonTOKdPg8kH2c5mClv9tYOC7wcuhU0agjHl/Z5qabjh4i0XRN459MUgMBBjudlklfZKzww=
X-Received: by 2002:ac8:590c:0:b0:4b7:a72f:55d9 with SMTP id
 d75a77b69052e-4e6eac2a26bmr18693271cf.13.1760060590253; Thu, 09 Oct 2025
 18:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com> <20251010011951.2136980-2-surenb@google.com>
 <20251009183145.3ed17cb0819f8b7e7fb4ec43@linux-foundation.org>
In-Reply-To: <20251009183145.3ed17cb0819f8b7e7fb4ec43@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 9 Oct 2025 18:42:59 -0700
X-Gm-Features: AS18NWC-Nnw6mbU0XDp5pk62GdBblSXl-3NkXh8X6HtK-SeNhS47_j3D0edxdNk
Message-ID: <CAJuCfpEPOOFOtd-Vp4VtTJyqxP_5+7h7SaMT=6exY1YZOE9v5Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: implement cleancache
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, alexandru.elisei@arm.com, peterx@redhat.com, sj@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, jack@suse.cz, 
	willy@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	hannes@cmpxchg.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev, 
	Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 6:31=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu,  9 Oct 2025 18:19:44 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Subject: [PATCH 1/8] mm: implement cleancache
>
> Well that's confusing.  We removed cleancache 3+ years ago in 0a4ee518185=
e.

Yes, this version is a complete rewrite. Previous version was a thin
layer acting as a middleman and having hooks deep in the FS code. This
version implements most of the cleancache page management inside
cleancache itself and allows GCMA and future clients to be thin. It is
also much less invasive, limiting its hooks mostly to the MM code.
From the cover letter:

New implementation:
1. Avoids intrusive hooks into filesystem code, limiting them to two
hooks for filesystem mount/unmount events and a hook for bdev
invalidation.
2. Manages inode to folio association and handles pools of donated
folios inside cleancache itself, freeing backends of this burden.

The idea was presented at this year's LSF/MM and RFC was posted at
https://lore.kernel.org/all/20250320173931.1583800-1-surenb@google.com/
earlier this year.

