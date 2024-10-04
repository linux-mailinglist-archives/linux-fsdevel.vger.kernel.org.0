Return-Path: <linux-fsdevel+bounces-31013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5376D99108B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D62E1B2C77C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 19:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC791B4F16;
	Fri,  4 Oct 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAcjvMxy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9901B4F0A;
	Fri,  4 Oct 2024 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067825; cv=none; b=DDXg1AUhWiEy75PnqFc+4P1f/mM8CAqDuUm+DUNzlPnrE2nPNQWXDRSvVLi+imDSSooq637SWwP9WeFRKkAltkxyLq8blCQbeU7PgyMbA9udpI7MGe+NX4cwAuDyOoOoG8Q6wNOI5DCGLT82ZW2H1MU5scNAo/aR8g78pfqyINE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067825; c=relaxed/simple;
	bh=SBe7TQOcP34HLzduHHO7+9V6k7cQxhe3xsOYusleebU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3LswmUPFDIto74rqk3Y+GzrnfTd2zBvyUp9MzqJTjMEhIOicCqhjYXakg3yIgrTNxsL9Lbi9rUiDTuEqm93DYnvwz2y+zhzUnvsianDWxf2XEDkjjICAT9Zjwefj9LMZzC1YVtgzF8EdVKn/5kA5F3/RMByod05U/iBA8iwW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAcjvMxy; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e25f3748e0so27276287b3.0;
        Fri, 04 Oct 2024 11:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728067823; x=1728672623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sLSom5bqIH+ZQb3eV5Z3STJmlIkGelI4d+VO4uSF58k=;
        b=IAcjvMxyFZxdxJHRfzHB06gwany/JDF5aDFlT2tRpOV9wnwUxWTPz/GWwjxLxCIRR7
         Ws8SoWAx1crt0950S9RVKA3lhyZIBJPqNCjmbRoGzkkr2wXqMF7OWvJecnn9nbFz0LBc
         +2QlX6SCIK71Xu2RtVCTfw4fHSfAievoggSVXE0Hn21tTY+70bgW5f2QN0vYjOCtMNUu
         U/geOMw/n2xej+Yk5/N5cdD6GrQHTdIVqz6gCxvnrkJHUa0aWGJgXCGIVDFtNFnq4mWW
         kj93K+P6xLXcj9xoc+HXqpL5TYSngZ98unHXxnYdHsy1qhXlzUQe0ifmC6AWdguoLSiT
         BP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728067823; x=1728672623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLSom5bqIH+ZQb3eV5Z3STJmlIkGelI4d+VO4uSF58k=;
        b=cj+A4gvd6b7XoFv3PnvGBjXHHVoa7qRkaQ6W0Abzy7njDD9UReWebkgQQyDi6taNz9
         4RKu5s6kYHrqCvGnN2joh0UHjkliOZdAK7opIHcswI0RG6CzPtqD767X2EGJ8Yx+gfeb
         OF7N2zfL2Y67By7cXDpmA+dyxAZtY8ZIxyf1ZN/OLcI4TUoVUzO9XznniF6NRVg6mgDG
         1SkLMXE+TKr/dIpk/BM+fzFzn8ZeDBHlb9sERHkxaWehkh2HymM0VXMNAU/VSkY+iYL8
         MyM3n0atTSmvDDygN88vzLO+Cliy/kj946ugKd8tUYicN5wFKmZS9Gd2jRwmrnTFrRUN
         Qzeg==
X-Forwarded-Encrypted: i=1; AJvYcCXhqIgnDw/nz6QJRGNkHsxCJwwNqVx1r1CmQrnhVY1lK+mIPObExKfK98WEXleKtuH8lPi9MFx8/+GYn9NJ@vger.kernel.org, AJvYcCXrEPfaa4xHc6O1sNvOlpGUYmdD/K+U4LTJuSweR/Dyc9m/8vuyXkZ6w4sZ59jVVlFASVbRUCe9dbb+B46B@vger.kernel.org
X-Gm-Message-State: AOJu0YyflMoBNnklQ0DpKzs2bRLn1mDM+vyFAoGNWlBoEEQwzbhPFDEi
	FIpAZodkCxP1BTFIjztKtDw3/JFAl1OG2jCOH0wonyUcVdbz57ozHcvjQrHH4mWiS5VWWnoprKF
	SjxrO2KqnPbtfM/pefmww5ltVSEY=
X-Google-Smtp-Source: AGHT+IEh8wUewEBzf0czGpXD2Lj077kneSfN/Eabe1LpO+WDiGnnyY/XdQfDJRXL5Hy0d6yXO++YPNaMtQrGUxYCdxw=
X-Received: by 2002:a05:690c:6ac8:b0:6de:a3:a7ca with SMTP id
 00721157ae682-6e2c728a25fmr35622767b3.32.1728067823126; Fri, 04 Oct 2024
 11:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002142516.110567-1-luca.boccassi@gmail.com> <20241004-signal-erfolg-c76d6fdeee1c@brauner>
In-Reply-To: <20241004-signal-erfolg-c76d6fdeee1c@brauner>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Fri, 4 Oct 2024 19:50:11 +0100
Message-ID: <CAMw=ZnRt3Zvmf9Nt0sDHGPUn06HP3NE3at=x+infO=Ms4gYDGA@mail.gmail.com>
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, paul@paul-moore.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Oct 2024 at 10:29, Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, Oct 02, 2024 at 03:24:33PM GMT, luca.boccassi@gmail.com wrote:
> > +             info.pid = pid_nr_ns(pid, task_active_pid_ns(task));
>
> I think this is wrong what this should return is the pid of the process
> as seen from the caller's pid namespace. Otherwise you'll report
> meaningless pid numbers to the caller when the caller's pid namespace is
> outside of the pid namespace hierarchy of the process that pidfd refers
> to. This can easily happen when you receive pidfds via SCM_RIGHTS.

Thanks for the review, I applied the rest of the comments in v2 (I
think at least), but for this one I can't tell, how should I do it?
Naively I thought that task_active_pid_ns(task) would already fulfil
this requirement and resolve it using the correct pid namespace, is
that not the case? If not, what else should I do here?

