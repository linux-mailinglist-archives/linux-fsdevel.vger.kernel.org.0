Return-Path: <linux-fsdevel+bounces-50081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0240AC8138
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 18:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA7D7A2026
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 16:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0062F22DF85;
	Thu, 29 May 2025 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2RC6zXZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4763078F34;
	Thu, 29 May 2025 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748537615; cv=none; b=H67+cVSNybtwJzTBqB9wRThT0N1y2Em1CJ51hGKS1e7xxch9uRdhr4lWsxiogsNIuB4DiwMGaWl6F8ltt1dpF94i7bge0qAi9y0kj1sNsDSZt+kJ1DHZj4geTOHMGazmbrYQrbYiMY3LoQ7OjC/eDb/9NaV+uaG/hiK1/0+ifTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748537615; c=relaxed/simple;
	bh=UtEunc93gX1CpA2f4qmI5Od6rQOn3rdgClOKZFQfFU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7RlfqV6uXcwPr0n25UyrmXKTAlRkqI+WGTyoQGKjubufQfxH2oaBL+5UVsUQ4pnAGnU/HuVj74MhXirj9uLSQDnY9lREhWN+/fNfURJl8L4JhcqOlMiVcCDWcjfFbDe6QQENwqi+JKXn4IvFKM9F6yTlOCex9u/KoFnqmJ2kW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2RC6zXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF25C4CEF0;
	Thu, 29 May 2025 16:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748537614;
	bh=UtEunc93gX1CpA2f4qmI5Od6rQOn3rdgClOKZFQfFU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q2RC6zXZ+4NCe342QGMpVJQFO5So6N4mTx0xcCsajie+aHBmCM4U8n6DdOXDJqjGN
	 cq28+ffp2DgaQSbtgG9Qj0jPB+9cR6TU/Q5vKvQLVDCBjbeT4+N6o+If1R2JFSUngU
	 mw71oJ7wJT9ZY7itmwLPrQMkuj0gaVziMoMnswLUBzemJw5SzNWzMu5F+JGu+3CK7U
	 raoYIKRI/kmS6qaRG5U6pOk/46p4qUFOWfGXI40yXFJ4Q0diAv3ZayvwATSwdcDWVw
	 QDH8aiba7sd1SoCK383H57mRZ2mj8soURHedwJUcM4SVgor6ZBlCsZow8NkFd6URMB
	 LGNjcfk83DgdA==
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7cd0a7b672bso75900885a.2;
        Thu, 29 May 2025 09:53:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURtjlWXzI+pQTCnHc6P9jhWxA3w+MeOGDx5PMTkYImaz552QDrWBhV2y2eer/UxLV/JwAymXo3PubJHBy7rNTFcHDpThfn@vger.kernel.org, AJvYcCUjfK2CzX8/NFomjYoPiMjcFrAThVMhZJG93QkmqPpF+gujIPlPEgfbr6fOjWkJVnst0Ya6xH3e4aemz7v8gg==@vger.kernel.org, AJvYcCW7xVOPzUYto2LtQUIwqQ+p5TEeZsdOtqUrYfquZFqhLRjnuVFcy7IM3IIfWApyc+Awbw2WTTeRfTjFwNUP@vger.kernel.org, AJvYcCXWw9qP0X5ySQ6e7tFHP6phjiUJ0r8mi+hoR+yUUoWkSnBl05U4W5hhCBjWPQ0DoHlklWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDembsVUhhkxUQ8NPSK1w9+5MatJQTsW+pkJX4XaDbLZibSl/e
	Dg8zSR/Ct/Ri2a9D3WjJw4D3ABQ6vvwmmSrc97gvcHxONr5wFZni+uYd5mGIcUIxItHJThK+nUF
	fxZTKwO6tSeOfIrcWea12Hfp3NuyCUPA=
X-Google-Smtp-Source: AGHT+IEEEibPylYu3D1KsFoeefHSm++FNME0VmZZ+vB4utHS73EQFAKRtBg5oQAt1vvG9GKpYqeUbO/o3GjJTznkiew=
X-Received: by 2002:a05:620a:170d:b0:7c5:9c12:fc8 with SMTP id
 af79cd13be357-7d0a203e718mr29873985a.38.1748537613800; Thu, 29 May 2025
 09:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528222623.1373000-1-song@kernel.org> <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV> <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
In-Reply-To: <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
From: Song Liu <song@kernel.org>
Date: Thu, 29 May 2025 09:53:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
X-Gm-Features: AX0GCFvYCS_xA9xNRqMdAIU4bXgKkiIvXrY3HrR-OxBWf_rIfVKBsXSnt7wWCFg
Message-ID: <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
To: Jan Kara <jack@suse.cz>
Cc: Al Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, brauner@kernel.org, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Al and Jan,

Thanks for your review!

On Thu, May 29, 2025 at 4:58=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 28-05-25 23:37:24, Al Viro wrote:
> > On Wed, May 28, 2025 at 03:26:22PM -0700, Song Liu wrote:
> > > Introduce a path iterator, which reliably walk a struct path.
> >
> > No, it does not.  If you have no external warranty that mount
> > *and* dentry trees are stable, it's not reliable at all.
>
> I agree that advertising this as "reliable walk" is misleading. It is
> realiable in the sense that it will not dereference freed memory, leak
> references etc. As you say it is also reliable in the sense that without
> external modifications to dentry & mount tree, it will crawl the path to
> root. But in presence of external modifications the only reliability it
> offers is "it will not crash". E.g. malicious parallel modifications can
> arbitrarily prolong the duration of the walk.

How about we describe this as:

Introduce a path iterator, which safely (no crash) walks a struct path.
Without malicious parallel modifications, the walk is guaranteed to
terminate. The sequence of dentries maybe surprising in presence
of parallel directory or mount tree modifications and the iteration may
not ever finish in face of parallel malicious directory tree manipulations.

Current version of path iterator only supports walking towards the root,
with helper path_parent. But the path iterator API can be extended
to cover other use cases.

Thanks,
Song

