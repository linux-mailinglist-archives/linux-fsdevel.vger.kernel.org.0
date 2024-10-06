Return-Path: <linux-fsdevel+bounces-31129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ABB991F33
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 17:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B8CB21A9A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 15:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9663413CA81;
	Sun,  6 Oct 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ8/++vp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C16139D04;
	Sun,  6 Oct 2024 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728226796; cv=none; b=qSQVboMKBGZkBmUITRYiIua/wwoaRGvyP45oKk3ydJLReDiFJZNYfwiZrLcNJKqCHa/EsI6ooFe58otJTmW1MBdb+a2fqXpm0qhmKYbapRLSMNCnUp8userSKsQ6qk4UDrUVWnVwzPC57EZSbG0fOR9JKT7idnWb4guYi6RnVcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728226796; c=relaxed/simple;
	bh=lXsOWchDeB0DKztDhSEu4SLBTSpDiAINtpmIIYN2ECU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JU1lqv845N4mcFa+sXwRjLti9blJQUSNA7uSnC7ldREHdlWZddQku9Gj2ZRDvG1bP0fzuGffqCq+wC1+KDeWF7TOhg+kwBvRKauDAA5JyTGe0gLKzRcnpu1+26Cb4mimOcV9R5ZPl8Y3a0AMk8w/nnn/FeeEKLpgZ6RXqoEnsrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ8/++vp; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e25f3748e0so35201597b3.0;
        Sun, 06 Oct 2024 07:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728226794; x=1728831594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N6+Wg2986G03us2gYz8rYilG8qAjZ8Fp5YpwGKJLHPE=;
        b=aQ8/++vpVwQDBNWtzC9OMvVgnBijr/Fvwr94qVQnhdJn781jK5p182gA8oKu6zKL6G
         bdvJUTr9MjdyiKXGjFX4zwMyLel/wVQDRTh75Q2MFyv/D5cDL8nOoD1oKhiqFZAncWjz
         MYDumEoX8OS4bqSasDEqYL1NetIzxtMaA6ZkfBchZkRlQtHdl4D3/JZNZR5d19zh8FpE
         eVcfmc615aBwx6rklCS/SVToE5VhmIFeGOSlNQCr5NbmVaTVyHq5u7nafEfwzX6Z7Dkh
         fEF1nmhAFalf9v90jrOZ5ErES5Kj6d8PomiXxKfAs4+9+7+GKSrPQKVHzZPdJg7XMQzK
         cyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728226794; x=1728831594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6+Wg2986G03us2gYz8rYilG8qAjZ8Fp5YpwGKJLHPE=;
        b=rgSJ+2xPouQTihy7cB5F3XCZ44E2GDki2MXzMmzwSDqThVxOkCHZl9qopr9bzgJmf7
         yq6OOGvU1ZVfWesD0cn82mgpFXF0VgZOQ91/4jY8Q5HDFBEX+3kmoOn/r4F/Zw54sP+v
         OSJbo5rpjXVECbdZWwOPk8sO0SvxAPmOusAvoSV5IvT2XFyQ5XfxMfWi1VWutrpsvk20
         AHZA++5an+7pvmqV14Ucd9fJcUE4Nz7xp2RxvDaKB0rp2cuyzR0m6BvfqbjZuvWXcUy/
         H4MUHB8yPy4aw7R4yEtAOC2d0R1eGf8xfOy0ExpLI6S0mg72BtjV+9AodH+QPCZJe4Km
         f56A==
X-Forwarded-Encrypted: i=1; AJvYcCWPypSVwmL2EMa2HWmdzUHLeQxWZjRWeEm8tZtdWHfZJJtXho/l0WIaX/fkleZ0Zg5lfyMsrj5M+WDzv5Qt@vger.kernel.org, AJvYcCXCEjZJYrhSom3z0FRdFMXWQjf2TlgCNsgvNrk61lT0kUXPIIWdzJcb6rgywljV4n/3BG7v+fv9uY8bE0k1@vger.kernel.org
X-Gm-Message-State: AOJu0YwbKFtbugEgaU7Kj9YLtmjhjMsz0KCSGdzuS/pXNMp8jpKE31cV
	z3YMe7wAql8+30H+uMgRa1h0P3XlQnmI14kbt+Clq0LxXSWXj0W3xUdcgytWTSIc3+rF+BNGz0c
	3mIZBoli/HZhdfXJMDFY3XO9Lrd4=
X-Google-Smtp-Source: AGHT+IFm7maYo6rzOtAGgDPgWzCxAuhLdf6EWEcyPkvdTVjmROdt9OcZpx4l8tdmq9Db4QIulLYNvvxSXoTFoa+2G+Q=
X-Received: by 2002:a05:690c:700a:b0:6b1:2825:a3cd with SMTP id
 00721157ae682-6e2c728aa03mr67808637b3.35.1728226793746; Sun, 06 Oct 2024
 07:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002142516.110567-1-luca.boccassi@gmail.com>
 <20241004-signal-erfolg-c76d6fdeee1c@brauner> <CAMw=ZnRt3Zvmf9Nt0sDHGPUn06HP3NE3at=x+infO=Ms4gYDGA@mail.gmail.com>
 <20241004192958.GA28441@redhat.com> <CAMw=ZnRp5N6tU=4T5VTbk-jx58fFUM=1YdkWc2MsmrDqkO2BZA@mail.gmail.com>
 <20241005112929.GA24386@redhat.com>
In-Reply-To: <20241005112929.GA24386@redhat.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Sun, 6 Oct 2024 15:59:42 +0100
Message-ID: <CAMw=ZnQB-xsvPX6TrmaXed3KGBR1YO1qYP-iNsUAv8XAOvB=YQ@mail.gmail.com>
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org, paul@paul-moore.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 12:29, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 10/04, Luca Boccassi wrote:
> >
> > On Fri, 4 Oct 2024 at 20:30, Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > I guess Christian meant you should simply use
> > >
> > >                 info.pid = task_pid_vnr(task);
> > >
> > > task_pid_vnr(task) returns the task's pid in the caller's namespace.
> >
> > Ah I see, I didn't realize there was a difference, sent v3 with the
> > suggested change just now, thanks.
>
> I didn't get v3, I guess I wasn't cc'ed again.
>
> So, just in case, let me add that task_pid_vnr(task) can return 0 if
> this task exits after get_pid_task().
>
> Perhaps this is fine, I do not know. But perhaps you should actually
> use pid_vnr(pid).
>
> Oleg.

I have just sent v5 CC'ing you and adding a final check before the
copy to userspace, that returns ESRCH if the task has exited. This
should solve that issue, and also be future-proof against potential
additions that might slow down processing due to gathering more data
or so.

