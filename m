Return-Path: <linux-fsdevel+bounces-34237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD06C9C3FCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 14:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6A11C21B27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 13:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AFC19DF61;
	Mon, 11 Nov 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="n6UnrEpg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE514F126
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332865; cv=none; b=SfcS9QMSrEz+H1rfEphrjZsREMLbFOSf0WsGIGTHkBNnR2fOcTrerv0sRHfbQnPM5Wz5b52LYNfxMjaPw1VE8B4tDIrj72aaRouoaeg07USvxlJKjFk0M00PgZH6uX2wYIbqVADbhNG2LT2N704MsCE4Lspo0govCA4N9ZiDT6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332865; c=relaxed/simple;
	bh=OpR1uy9hZsh00tk5dSc3QDB+ieIkGNqAAI80PQu1zT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVKe5tDVZ+Xo26QuJ6PpKmQNhJ9LHc5jl4M83yv0F8yURcrrzfBt5Qdj00GvgRVG6KqP28JLbQHHefy6frVl1Zmt6vr4F6JulVSd+S7QvP0iEvNLaT3xuNMscrh6CVPIRe03eErfx7q7GIjucpTk3zK/tN8LpdH3ZfrCoKxYayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=n6UnrEpg; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460b04e4b1cso34344411cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 05:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731332862; x=1731937662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=97RwJbF3REv6/4w5Vk4X/bZS49+40N6d/CBLx5LRIRY=;
        b=n6UnrEpgHKDL4rw7onn5a2hTX4ZT3jsHgcdOx78xcx7YOcGRzxydxHfvnU+/4OUzmE
         2MEJw/sSTU8tOWBHZ+p+McCBHUIdmEPgT0SQPCc8zFXM6jwA3cvgc3Jc+uPws38D/aUy
         3mxcBW0t4l+Mbi4fB2AI3z6RXPDPMt8mvw9Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731332862; x=1731937662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97RwJbF3REv6/4w5Vk4X/bZS49+40N6d/CBLx5LRIRY=;
        b=Uq7niQfN6aKpVtmdDZlWTmDxqWOhQE3VAF7mIt6X/Z5uWXwyPOs72Qh2juhhzYQv7p
         niDChMzL1LG+DQNbLbMYlZRwJbhPmbbscLYkXnlyYMaI0h8U+FZTGCW5SCu0HFBehd7q
         19R46IVzC9ZZhXIYek0ZyB6SDaa9eGD3VN43LU+UtyPeEh5hUM+ndfQGRKf+1onJ3Zop
         mf1tRgljiCxsVK2HylkgDUbrJA6BWClNGqaADTK3sd44kF0b3Y24dsgUG/4Vyt1On8fn
         uCN8ehOV340Wmbi5bw/iqy3oqAR0r0hK3kj8KUiuig6RJuJbfh+pLkm8uxiF18wxOZC/
         EkFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdaOoVKmrx4hDMomlhkKgvHte/P5YqdA0FXqXudxRO8dVRSgDIw23L0eh8Qnkmjxv8qQ5zXMK2F5fB2PTJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2uuIceqqJ+UOiE/NJ5vp0syoCBstgDFljCkua4zdhGWqAhL5b
	noUIJPVcgpycDLJBSkcw9jzn5HDdbqJ6cMUxsR9rYimG5QWHs+Gxm26UZ17d2C98KePBuJNPEa1
	y4oTI0TMQn2UUzrNa/AXY8FGUUbCxtuIM7LB6JQ==
X-Google-Smtp-Source: AGHT+IH8VY1Pv0jpeNjDwGLfk6hnswMJmLtmvUWZIbj1N3KjFg3BxHShIyt5iBzuF1E+fKTwiK/XvA5Iqyu33500Lb8=
X-Received: by 2002:ac8:5e4d:0:b0:45d:82a0:5028 with SMTP id
 d75a77b69052e-4630931ea9cmr217648991cf.1.1731332862450; Mon, 11 Nov 2024
 05:47:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719257716.git.josef@toxicpanda.com> <20240625-tragbar-sitzgelegenheit-48f310320058@brauner>
 <20240625130008.GA2945924@perftesting> <CAJfpeguAarrLmXq+54Tj3Bf3+5uhq4kXOfVytEAOmh8RpUDE6w@mail.gmail.com>
 <20240625-beackern-bahnstation-290299dade30@brauner> <5j2codcdntgdt4wpvzgbadg4r5obckor37kk4sglora2qv5kwu@wsezhlieuduj>
 <20240625141756.GA2946846@perftesting> <CAJfpegs1zq+wsmhntdFBYGDqQAACWV+ywhAWdZFetdDxcL3Mow@mail.gmail.com>
 <CAJfpegs=JseHWx1H-3iOmkfav2k0rdFzr03eoVsdiW3rT_2MZg@mail.gmail.com> <20241111-tosend-umzug-2a5a4c17b719@brauner>
In-Reply-To: <20241111-tosend-umzug-2a5a4c17b719@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Nov 2024 14:47:31 +0100
Message-ID: <CAJfpegsG17+3Zu-LPTjYJaB6_tQTuq6YG14WduxMeHHp_Tinxg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add the ability to query mount options in statmount
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 14:29, Christian Brauner <brauner@kernel.org> wrote:

> I understand your frustation but multiple people agreed that the
> interface as is is fine and Karel as main consumer agreed as well. So
> ultimately I didn't see a reason to delay the patchset.

This was actually in the first versions that I sent out, but then was
removed per your request.  Then Josef's crufty version added back.
Yeah, for libmount it's fine, but the de-crufted version would've been
alright as well.  Oh, well...

> None of the issues you raised are really things that make the interface
> uncomsumable and Karel succeeded to port libmount to the new interfaces
> with success (minus the mnt_devname we're adding now that he requested)
> and was happy.

The problem is with non-libmount users.  They won't implement
unescaping until they run into trouble.  And that will be too late
because these cases are rare.

> If there's genuine behavioral problems that cause substatntial issues
> for userspace then I would request that you please add a new flag that
> changes escaping and parsing behavior for statmount().

Need to take a look at what this now does to overlayfs filenames with
commas and other special chars in them and see if it can be salvaged.

Thanks,
Miklos

