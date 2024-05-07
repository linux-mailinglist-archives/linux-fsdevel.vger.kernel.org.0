Return-Path: <linux-fsdevel+bounces-18932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4392F8BEA29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 19:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34822812C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 17:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF86A15E5D4;
	Tue,  7 May 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcY/b8Dy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F7453E28;
	Tue,  7 May 2024 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102024; cv=none; b=kpKAlnRMZkZSdtwQaNWTGY2+S5EVXKBlRrk6mNAJgeF/YVHyYwBQmE+7f+rsqUfat1RGWRw9tvWIWGlEGL8pW2T3EOVI4s2WMatrI8yRtDjvKNYrg0W0FwUGK0SJQmH01cBQS5i/DuLapnWOfUHzAqak6L94nye6kSgNjnLQ59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102024; c=relaxed/simple;
	bh=zccQnclxIldZ+IxR9G6WltGhLfvpZ5MaRvCWBfvHgtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxcDOkLtNPSc9H2EGTtNpbkAfD/FS9L/7md2hGpkr/SPRWvEMOwHlQAgxTQmBmI6Y+fHOMJuDBk0luLkm8b0T5xtBV44+GNBMvijJ31GWEaG2x4Pvu4XZ+V+dWV/WNv4LFwaSWPAI60zmUYMT4RMGtqBkAJW1VIPuU+fSVdYPbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcY/b8Dy; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61bec6bab2bso36552757b3.1;
        Tue, 07 May 2024 10:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715102022; x=1715706822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EYum/RRI+2OZh34IaDs9A+wweg7qNiOwsJ++IUalaZs=;
        b=RcY/b8DyooeVQbJsCyVPE3lQb+HGjAAiAhDzmR63Ap9GR9nCB9Pn9sKmW3BCTuooUV
         aM5qcTLtX1JzLFijLXnxcKMFbFhNLDjXQ+sx40j+BiTXkwyldKzQLsgj77jFa73w6q4p
         NHhBVGsFHOf/DYUdZTMY8bu8gz4QGEVWYVJOAxygDm2Qc50XDjZpQNiD1Ayh74kAwcEZ
         WhfP/MKqO/loXjGjQ0ERae7kCxQak6v4SDld1krI1PX7c6WWVzqNu3BFZ41r5/d4aiw1
         3kecQIaBVJIuQ5fEp6Z1wTAt6bhn7af+rxNfhXy+c7dGGddAGKljGHTIZJSKpdZuxs31
         wybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715102022; x=1715706822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYum/RRI+2OZh34IaDs9A+wweg7qNiOwsJ++IUalaZs=;
        b=MnY1bWNSlzhuUqfNVm1+MAZQrP5QGUJwFQm6jGOwwX3fGOEsVdzeU/RkApXvmoFSXk
         XCtvYFTENitW2sbwmqLpXt8ayhNUGcWA+pgksg7lckJOYl7Dw6eIJiksOL1eYFPSKVGA
         ENgtFIbUriZwLi/8IflF7H7vdQUf04iVkp43bUYTQfu+ctx2F3KiNfIxkqBgjkxAAar7
         vkOaA/BY2p96B9mLhCSMftHd31ABvU/aYAqmsXDICM6tqSoQ4ZC//rQW4l8u9vyH2hTY
         JzqvFtLt/TCqI9hgWXlldoN3ZQ6grRH52n0UlZO1LAZbnRAVV3z2AS92f1McB4Y+oIzD
         /L6A==
X-Forwarded-Encrypted: i=1; AJvYcCXNI/R+aeS9dxilCIHvVHpbufm1WYK6tkPpn3uCrPLvTIGUcPaVC9EtKUHhjAJjmeFg/MMisxV4XSRlCxFOlEvFy+cAKPmsFannYunw
X-Gm-Message-State: AOJu0YwvT0zC97IW1twXVBP7wkJLYtcPrC7D7hB1IBgpj0PRVwon2FmF
	IYtDLVi0dRtzVU48yp3hle+Dufhy/HxVDH18rWqPW60f7zdjPaAGwXXw4uMVyWG6/KIcrHwGg6C
	fTWNW04cOu3wN79NlX5NXf0kK+b8=
X-Google-Smtp-Source: AGHT+IEtaUXVcDdFFPrSZfNzsTmU796n7ghfMyjhUtMghx8kl6qZabBPVyKTNI4/IqH+SGyg0CFCtF4iR3B+DBpgkkU=
X-Received: by 2002:a81:4c0d:0:b0:618:5e8c:c66f with SMTP id
 00721157ae682-62085d1b43dmr4533657b3.7.1715102021955; Tue, 07 May 2024
 10:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506193700.7884-1-apais@linux.microsoft.com> <171510137055.3977159.13112533071742599257.b4-ty@chromium.org>
In-Reply-To: <171510137055.3977159.13112533071742599257.b4-ty@chromium.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 7 May 2024 10:13:30 -0700
Message-ID: <CAOMdWS+u5gBpkJyryge5mWt-eX6+OmkiSkS5zc-VZ=_uJQszLw@mail.gmail.com>
Subject: Re: [PATCH v4] fs/coredump: Enable dynamic configuration of max file
 note size
To: Kees Cook <keescook@chromium.org>
Cc: linux-fsdevel@vger.kernel.org, Allen Pais <apais@linux.microsoft.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, ebiederm@xmission.com, mcgrof@kernel.org, 
	j.granados@samsung.com
Content-Type: text/plain; charset="UTF-8"

> On Mon, 06 May 2024 19:37:00 +0000, Allen Pais wrote:
> > Introduce the capability to dynamically configure the maximum file
> > note size for ELF core dumps via sysctl.
> >
> > Why is this being done?
> > We have observed that during a crash when there are more than 65k mmaps
> > in memory, the existing fixed limit on the size of the ELF notes section
> > becomes a bottleneck. The notes section quickly reaches its capacity,
> > leading to incomplete memory segment information in the resulting coredump.
> > This truncation compromises the utility of the coredumps, as crucial
> > information about the memory state at the time of the crash might be
> > omitted.
> >
> > [...]
>
> I adjusted file names, but put it in -next. I had given some confusing
> feedback on v3, but I didn't realize until later; apologies for that! The
> end result is the sysctl is named kernel.core_file_note_size_limit and
> the internal const min/max variables have the _min and _max suffixes.
>
> Applied to for-next/execve, thanks!
>
> [1/1] fs/coredump: Enable dynamic configuration of max file note size
>       https://git.kernel.org/kees/c/81e238b1299e
>

 I should have put some thought into the feedback.
Thank you for reviewing and fixing the patch.


-- 
       - Allen

