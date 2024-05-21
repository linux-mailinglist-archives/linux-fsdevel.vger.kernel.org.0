Return-Path: <linux-fsdevel+bounces-19935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5C48CB3F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 21:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830D41F22B1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 19:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987C214901F;
	Tue, 21 May 2024 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MY8IaQyA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6208D142910
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318104; cv=none; b=Kd3FRKsZMjx5s6WfbkL/GwqwYTYMRnLzEoU5hGYCGF8lyZVvHHDCFI8l3uET1aPE7z+ty7Nauo+1aTc8XkZa+9mWdVKXtG88geKICOi3GSp3chrs0K/1bUl0d6upTpDq+mL0lR/6cS1/a99KNlTUBzPrs3bniLKd0CapIQwcJcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318104; c=relaxed/simple;
	bh=8ix/SXPQG+wpfYFllBOv3clmJtpOeRZmoQkniDsFhak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKmXPuz0gPDepRUszyEnWS8RGYbjcX2DcL3YDjrLch9OpVHypAG4qP4DZd8QWsG7H8ExNLVpB97qOmvR3Zo+DyJG4nleD1dpOYH8NXEfjqJPCtbltGH3ut9cdpSNtHVTcXBvgB8Les7l6E5KwGepeiphJiOylm5qn06vi9q49ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MY8IaQyA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso2462a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 12:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716318101; x=1716922901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ix/SXPQG+wpfYFllBOv3clmJtpOeRZmoQkniDsFhak=;
        b=MY8IaQyAFt2/cSwIUVwocQeGFOQ997oO8BDpQP18iW2Oq2Mmq4AURBfi7nrJtIKKOm
         imlZqPQpfpwY7WUQ7bCw095vWRkIGXPuIUbTPsRdTYPPwAUh6FwJMgoMYYJ+9SrLiH3H
         d1E/QSCgowrw2PFb4gfcEJnndvndIadzWLimPcjoCKbb4MOpyL0f+zO4R6zAqDV/EV85
         TFqAEXrdszqND+CEF7XKQINn7t6gf+/IcDBNJD9Hr3P45tVHYvvY50rpuSvbwY/gZwkF
         sn6bRrjCvrSWs80jSoGrLiPpHjYljdc3MOzAGXVJ492kFKhU39jrnPch+KR/uvRQyHYj
         uPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318101; x=1716922901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ix/SXPQG+wpfYFllBOv3clmJtpOeRZmoQkniDsFhak=;
        b=Iq/DjgcbTyt0LGezcgGyq7K4Xwvq2lcN4IqW/nXpkchug7QsHFXonGT9fiRzN8IPm1
         pNRgGlKR5H5kd9Kl4rdXdebicIhe/yFIUFvtfewDQ+F5VCpYl7MBLTv2iqNOICiR687/
         cQVWXYcGtC6gfEHyRTy2vTlPr+wRbjN+s/ircSQ1yHFI9x4oZlB3bIzNpyL450/mN+IU
         pR8HR+2bkZKLkE/OihCJmbI94eICAcgO8sYlaWbAv/UWnl2Tv/awkOMfGfwNuqA4vtVR
         mH4FVcL5PExROEDIZmxmxodwC19etX5qwls27N9rA0NR6IjWFvLFHxWE8Vnr7HybLGRH
         Qh8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrGklcwFSRfVpOJ9kfoojV+lQ7fN4Kh6eEN2/1ciGAxVtS1YF3idtAEe9h3V3K16KoEbzYWXVVsAx4w8Wsgv9IWJTF6zqL9SCAegPs3g==
X-Gm-Message-State: AOJu0YwLA5zQh0T05cKPDinXk8159iA/WClUNaiDm05QdISrQ1XB2/13
	oEi5pZY1mNzaDY/XOGfx+0NPpIsqzdYyGQh83AciLo6bUeAZ7vBUBBPcBQr1ExTNMEwuAdnmEUt
	Ztbfr73ODtnUSWXlbvPw29vkuUOce1GR988+3
X-Google-Smtp-Source: AGHT+IGsZHMYwB17/rHm2GPw8sDf3nKxTSkcIsaApOp5bux/QDPAPBCrzCKud52Dm0FNps4wM/XTSDtjC7pz3lXd3Qs=
X-Received: by 2002:a05:6402:3594:b0:572:a154:7081 with SMTP id
 4fb4d7f45d1cf-5782fc1d68amr18531a12.4.1716318100237; Tue, 21 May 2024
 12:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427112451.1609471-1-stsp2@yandex.ru>
In-Reply-To: <20240427112451.1609471-1-stsp2@yandex.ru>
From: Jann Horn <jannh@google.com>
Date: Tue, 21 May 2024 21:01:02 +0200
Message-ID: <CAG48ez0rOch3wemsmrL-ocadG1YeJ6Lyhz1uLxJod22Unbb_GA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] implement OA2_CRED_INHERIT flag for openat2()
To: Stas Sergeev <stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andy Lutomirski <luto@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, David Laight <David.Laight@aculab.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 1:24=E2=80=AFPM Stas Sergeev <stsp2@yandex.ru> wrot=
e:
> This patch-set implements the OA2_CRED_INHERIT flag for openat2() syscall=
.
> It is needed to perform an open operation with the creds that were in
> effect when the dir_fd was opened, if the dir was opened with O_CRED_ALLO=
W
> flag. This allows the process to pre-open some dirs and switch eUID
> (and other UIDs/GIDs) to the less-privileged user, while still retaining
> the possibility to open/create files within the pre-opened directory set.

As Andy Lutomirski mentioned before, Linux already has Landlock
(https://docs.kernel.org/userspace-api/landlock.html) for unprivileged
filesystem sandboxing. What benefits does OA2_CRED_INHERIT have
compared to Landlock?

