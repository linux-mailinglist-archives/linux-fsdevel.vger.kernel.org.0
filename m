Return-Path: <linux-fsdevel+bounces-51855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FFAADC248
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 08:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CDF41716E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3213928B7DB;
	Tue, 17 Jun 2025 06:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lhlp6DqN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8020C4430;
	Tue, 17 Jun 2025 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750141244; cv=none; b=dnVNj7cwYGFri80AKf22+zSGZjlQnGhOlBS0jvS4IAlWQ3oIjW8pEOyJ06Mupp9e3WUadFhYwhmffn3Jv+mnfiMrFDo8BOgISTFmY4giHq1LNi3exgLeYBsQYsrw1y/MW9jYtZ5Ozsemh2HUKvRMuwTsCT4npqtgY8a/YnLu06A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750141244; c=relaxed/simple;
	bh=u3O95KE8NMjq/YtPJoQWCUtVyluWqez6mFmjxn3YSVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdF3604zg5AWMDBpzgwW5STwhi0nTMvOu9e2pVHF8NyWUIWYcFC9E9Od9A/JekA+083qUzhC2y+nstni0DCEM5IATU5yd9F0l8Z/WucERhiLnxLCLcY/jbsbHdQiuhIex5LPkhL0TPESu/W11SOj5kTiCY4b6IxJWpMPcymg9wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lhlp6DqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063E7C4CEF9;
	Tue, 17 Jun 2025 06:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750141244;
	bh=u3O95KE8NMjq/YtPJoQWCUtVyluWqez6mFmjxn3YSVI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lhlp6DqNxVcVz1dCamkFKPpzu8pZRNdo1CZN3k9RSsKSDLS0BHn8DRL54JH9Da2/m
	 nvwn6jQYCnHBg18M1P9I8nMCLGvKCEJvxTswESLpo6DTwZsvt5yDGql3TgVhc/9ksF
	 5/l+8lvDEhj0JwTWvFAYz4PRHglvTagx/0H1tOI4haIIWmGOeNPsWa0cHm9Xo0FcJg
	 /hG86EZPJrwQv33KmPZifburIvG0ts1b495o+7kxnf4qj8yhFZToS48+NsnG4VXKJ3
	 TpP0cpKGUuADk0rgDZeh2Vo/htyYRDMb1jzS4Li0RcIgT6Gc+3cNqXWbAD2aPJxNZJ
	 EZcxTZaYv5EKQ==
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a58f79d6e9so66528311cf.2;
        Mon, 16 Jun 2025 23:20:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnxCfVn0pZPUNEys9wQrAf0b9feLDc86L+QBe1KU7wEmbN1697qTlk6D0N0hhzpkFDGuHSN2pGaD5MAUVulg==@vger.kernel.org, AJvYcCV6BY/ep6oKYVwrhTCFEnqesoDm1babUyarMWsGCG5PRjB02VFS9ce+oasW/60/FX6P0hoUJdrcQZpdl0Y2@vger.kernel.org, AJvYcCVqJ77O2jN1W6tukGOe5AnAM24eoKuh/RnUaNhp8PP/cPdWS8OVdvPr1WK5TmPD30nDxUkmJodpEabiuahAKcbhto4JcifV@vger.kernel.org, AJvYcCWmOAGWZim5R+eKxD1BF3D4A/0dqe2RUT5LWqZhi25/EQUucWEX2zIi+s1cfviuNVcH8Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxz/b0K2tfguwKQh589GqxaIdtZ8PXf9E+2141PzbeLcEinxkt
	KSQiPToWHu1SnpVUbEY8tL/Rz2J5Wn4jUs0QNHQvic65PSHwjG81FuiNDhT3YDJQJsDjknVeR+F
	QhyPypwsXIjIPCi+cu0nSftVWFB5IN6g=
X-Google-Smtp-Source: AGHT+IFZ2TRPLBFHmBOZTnfR5Pb1FyA1L8NE+zM+lH2GvsQm33BUwd4NKksdhGTBuyRJIy1l1HDMxjixcrU9dVrUJJ8=
X-Received: by 2002:a05:622a:1a24:b0:494:aa40:b0c3 with SMTP id
 d75a77b69052e-4a73c51f9b5mr161338631cf.10.1750141242988; Mon, 16 Jun 2025
 23:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606213015.255134-1-song@kernel.org> <20250606213015.255134-2-song@kernel.org>
 <174959847640.608730.1496017556661353963@noble.neil.brown.name>
 <CAPhsuW6oet8_LbL+6mVi7Lc4U_8i7O-PN5F1zOm5esV52sBu0A@mail.gmail.com>
 <20250611.Bee1Iohoh4We@digikod.net> <CAPhsuW6jZxRBEgz00KV4SasiMhBGyMHoP5dMktoyCOeMbJwmgg@mail.gmail.com>
 <e7115b18-84fc-4e8f-afdb-0d3d3e574497@maowtm.org> <CAPhsuW4LfhtVCe8Kym4qM6s-7n5rRMY-bBkhwoWU7SPGQdk=bw@mail.gmail.com>
 <csh2jbt5gythdlqps7b4jgizfeww6siuu7de5ftr6ygpnta6bd@umja7wbmnw7j>
 <zlpjk36aplguzvc2feyu4j5levmbxlzwvrn3bo5jpsc5vjztm2@io27pkd44pow>
 <20250612-erraten-bepacken-42675dfcfa82@brauner> <afe77383-fe56-4029-848e-1401e3297139@maowtm.org>
In-Reply-To: <afe77383-fe56-4029-848e-1401e3297139@maowtm.org>
From: Song Liu <song@kernel.org>
Date: Mon, 16 Jun 2025 23:20:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW735dqFzHyVnZXOX3AVRtuVZ5QPCvss+DkHCWB7wHkw1A@mail.gmail.com>
X-Gm-Features: AX0GCFvvMXRiZXydmA5bWHytCJnIjryEUzvxUctPeTuiH78KsqQ-oZiOBzDBAJ4
Message-ID: <CAPhsuW735dqFzHyVnZXOX3AVRtuVZ5QPCvss+DkHCWB7wHkw1A@mail.gmail.com>
Subject: Re: Ref-less parent walk from Landlock (was: Re: [PATCH v3 bpf-next
 1/5] namei: Introduce new helper function path_walk_parent())
To: Tingmao Wang <m@maowtm.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	NeilBrown <neil@brown.name>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, 
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, 
	gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 5:24=E2=80=AFPM Tingmao Wang <m@maowtm.org> wrote:
[...]
> >
> > I would not want it in the first place. But I have a deep seated
> > aversion to exposing two different variants.
>
> Hi Christian, Jan, Song,
>
> I do appreciate your thoughts here and thanks for taking the time to
> explain.  I just have some specific points which I would like you to
> consider:
>
> Taking a step back, maybe the specific designs need a bit more thought,
> but are you at all open to the idea of letting other subsystems take
> advantage of a rcu-based parent walk?

I cannot really speak for VFS folks, but I guess rcu-based parent walk
out of fs/ is not preferred.

> Testing shows that for specific
> cases of a deep directory hierarchy the speedup (for time in Landlock) ca=
n
> be almost 60%, and still very significant for the average case. [1]
[...]
> I'm happy to wait till Song's current patch is finished before continuing
> this, but if there is strong objection to two separate APIs, I would
> really appreciate if we can end up in a state where further change to
> implement this is possible.

In v5, path_walk_parent API is not exported. We can easily change it
in the future. Therefore, I don't think we need to rush into a rcu-walk
design before landing path_walk_parent.

Thanks,
Song

[...]

