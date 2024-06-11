Return-Path: <linux-fsdevel+bounces-21468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA28490444C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 21:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CCC71F245C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 19:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B92D8004E;
	Tue, 11 Jun 2024 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SyD07bS5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEE9171A1
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718133358; cv=none; b=RETY//0/vVSAImjrESjbM3qkS9CDWzobaZ03FsM1n/qWc76yCse0wst2/iOjCHDXue28sm54dGcDl5IiZJuK+W31VL+/YbJGgOfmbEQqawNh/Edi7zd2WhWOckRShxLwgsWQ3OEREy+AckIwu0gDgXPeL2pcGhCycg04wPs5c50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718133358; c=relaxed/simple;
	bh=w1tHpoNflMHLU1BMbnQsRhT8eRZjHEXH0n4iT8Vx5VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6yDHZCWciLgm0FP084hJvja5kycwYffpzcfvYbNTOL993tAXI4eX3G4peeUVY5R3XSO+f2R8teDwGEQNoSjBOQV37WFHbnadaE1pc+M/MYESHtIxgBnv4oylPU0J0zN65eLrKuW0ik84OVtrs6ewBIK1L3fvwsg5agxUToXoGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SyD07bS5; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebdfe26217so25226221fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718133354; x=1718738154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RqPB8BlA8DCladvuPMlN1eyIX4+W0uRp0KQVO/oj8jY=;
        b=SyD07bS57Rs/PB4Do/IA6v0fCLCHZmuA9RA/lQOQgPmPFnromUpNfpKJ7aF+eDsNsK
         WYQPA0ZGdOcPjuYh+1iSrDywdao3nwyTjqd5cy2TwEph9XH6gYt45EY7v87vvXI0wDo6
         ShKEL2KMSY7jxHu/dVV01oHBnPegxJN0Zw47U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718133354; x=1718738154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqPB8BlA8DCladvuPMlN1eyIX4+W0uRp0KQVO/oj8jY=;
        b=dMAylv2H8XB9cZZwkpm4t//VrnqWHmDVwAEtyOtJMwSX12x/XVZRNbZI7/nSOfJGsl
         +MxHMXqOkwMwP1hAbCv+r1gtHO4Pmh0gbg8SHGh7vG30/KXMlNFy8l0ffEZN3ZpHPHA2
         fjcF4a7EuPasduf1hiR0Q1UzmAMP8q96C5VqoVZstUFua9uPm5eJ6kinrtmqevaP40xu
         OJb3eWszbW8xeyyi1x0NX4vGzctY/4OnAn+jr7WNxupfjJKzW4hrXbeGokVk6VHt54Aq
         AopBkGv82aHswfD9BKbRkNLDXKjGNNp58vN2Iyw24yYK4fqrAacGCOKvxO4djmaNCxeg
         YxjQ==
X-Gm-Message-State: AOJu0YydiC/Au0qQmw130Vz/hDPqeg+Fysm7yuCOIvpWqlAqipznDBQs
	mW8n+GOrPtAUqRhSwJ7WzY4MvTUSyXMCZjnl6dv5V6rwlMGdsJVtPvfrmhXdkE88f1u/KDQkeVs
	BNkwOeg==
X-Google-Smtp-Source: AGHT+IF9PPY/JoLxPNCPKoH/hJ3pJ5WpiNkNyRtHXuLlNiV7Xfg/iPHtg42zNFXOd510JU+kdw+BoQ==
X-Received: by 2002:a2e:2c16:0:b0:2eb:fbba:cbe6 with SMTP id 38308e7fff4ca-2ebfbbacdedmr447901fa.1.1718133354525;
        Tue, 11 Jun 2024 12:15:54 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57ca472956bsm469904a12.29.2024.06.11.12.15.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 12:15:53 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a68b41ef3f6so686346466b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 12:15:53 -0700 (PDT)
X-Received: by 2002:a17:906:ca0b:b0:a6e:fc25:27b6 with SMTP id
 a640c23a62f3a-a6efc252c38mr551476666b.38.1718133353529; Tue, 11 Jun 2024
 12:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610-vfs-fixes-a84527e50cdb@brauner>
In-Reply-To: <20240610-vfs-fixes-a84527e50cdb@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2024 12:15:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgojM8mH8Bm3iNL6P+O7qcN24OrhpbpfR02J+ePUp_J9w@mail.gmail.com>
Message-ID: <CAHk-=wgojM8mH8Bm3iNL6P+O7qcN24OrhpbpfR02J+ePUp_J9w@mail.gmail.com>
Subject: Re: [GIT PULL] vfs fixes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 07:10, Christian Brauner <brauner@kernel.org> wrote:
>
> This contains fixes for this merge window:
>
> * Restore debugfs behavior of ignoring unknown mount options.
[...]

Note: I organized this a bit differently to make it more obvious what
areas the fixes were to.

I tried to be careful, but I may have gotten it wrong.

I do like being able to read the merge messages and get more of a
"toplevel feel" for what changed, though, which is why I did it (as
opposed to it being a "list of details").

I'm mentioning this in the hopes that your generally excellent
summaries would be even more excellent in the future in case you agree
with my changed merge log.

              Linus

