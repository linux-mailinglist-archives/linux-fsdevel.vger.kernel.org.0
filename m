Return-Path: <linux-fsdevel+bounces-50980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E03A3AD188C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 08:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CADB1889AFF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 06:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D460280A35;
	Mon,  9 Jun 2025 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u06q4XRJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C641A7AE3;
	Mon,  9 Jun 2025 06:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749450226; cv=none; b=bMbevv++F9K037wFwwG5xuj9moa3yRmJ/mNFVQzWPgMoWN2+9tuuKBEDCsHddXMg+BoqHJLoClpP1+6OWXfXuLKZsVkw3/fQJisvgMbIcYlmw+jpGsSUEQ8aNkgmuAFZyeFDE+1VNiDoNsOJb8R2Onr6+XBeBMGfXFDbzYzElCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749450226; c=relaxed/simple;
	bh=XvsNeIKAvfYxeWu94vpzujuaP/jIFZurJxIpc+BHVpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvlrUc0a1+Cmj1vWXjQCjppfd4A6LDzLeu9Gtb1P6zKMFWnOlB4Qwwy+hN6c9bitqHQffQS8nJuJNR2R3fdl7ahmDm/UvIz9O48Q5QDS6kDzAHax4ZRSceRfMLa1xwHgYlJXKyEi3RcuU3sumpkvB1GaKOo7L9lPMk5erwxhb/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u06q4XRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EE4C4CEEB;
	Mon,  9 Jun 2025 06:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749450224;
	bh=XvsNeIKAvfYxeWu94vpzujuaP/jIFZurJxIpc+BHVpI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u06q4XRJsHiDSTpvSWKH2Z/pNiXWEcSmbPCXaa439I67fDtvI1Lu+hOcNanh8d2Te
	 Vapusw1KEUaelaQBwKBQnURlQrhBoXtAJvC1oq0JccikGONLOHZKco6sEGS++gUpj0
	 FfCPVQyrXrLjSVbEVSuxXCP7XhKV0cNBUGa++/QY1Is6lMWrGnA/q8wulLJrBfdLmv
	 t91KB0QxgT5gxAjvAY2smUWLcoRsD8TU75ZEnHlJjGsOD6pfM42IJWLe/LahNSc+3C
	 fB6jQpKo7Z9aClERVeLDNXZuTk3e6sAYfSekwc6dyaQCoN9IjKn8q9cTubf4AgudXA
	 p3UYxbFglHIXw==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f8b2682d61so54550356d6.0;
        Sun, 08 Jun 2025 23:23:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSrSavIDfN8TLsPFAaU5spdJHOknUK+WDl80p76J8THNW8WXgpQ0+s9Szuy393/0OcMNRttLdCUSyveqrRrA==@vger.kernel.org, AJvYcCWnCpMdRPiQNOZsvaLy0uFb/lnqYJEd4ReJG8kTvqdPQubZvdimJoRBJKqsfrKfknKJeV5fHf6MPqaWUec0mZkAnY4VFiKZ@vger.kernel.org, AJvYcCX7qCrI0zYJZoZhwvYTdVyQL/+F8raYyPgUldMQpk/25uV+sNnoIQHv/6eDDxL218uonLw=@vger.kernel.org, AJvYcCXKtn7z5WeRl+Uk+bBEaews8YGeNbPqX8sB3riWoFjNWG4Fr9sBkprwN0a1lRlxK1NlJukowUGOQr5k977u@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZbaXzf4cm7e/kGDVSikTPTKA8+Qh4MY8Z/B+GuC5bhp4qmOW
	tLfu3pzSuEGGXTRSaxrbkpOaQd0lKWbVsYRkrKu/y2VL8jtK5cFBIAK/5v5Z282aiYsshpYCNQs
	waC14hOOIm9O1/RHg/gV3Xl7PHNDG1k4=
X-Google-Smtp-Source: AGHT+IFZKIPiFOniWwO3JrSqHR8EFdDF+J9SLDjDaY4aBJDBvQcgJT8acvrljCKcpwaPOgLoEBVL6sspTmqVKcaeq4w=
X-Received: by 2002:ad4:5c42:0:b0:6f8:c773:26e with SMTP id
 6a1803df08f44-6fb10b73db7mr130561536d6.18.1749450223383; Sun, 08 Jun 2025
 23:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606213015.255134-1-song@kernel.org> <dbc7ee0f1f483b7bc2ec9757672a38d99015e9ae.1749402769@maowtm.org>
In-Reply-To: <dbc7ee0f1f483b7bc2ec9757672a38d99015e9ae.1749402769@maowtm.org>
From: Song Liu <song@kernel.org>
Date: Sun, 8 Jun 2025 23:23:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7n_+u-M7bnUwX4Go0D+jj7oZZVopE1Bj5S_nHM1+8PZg@mail.gmail.com>
X-Gm-Features: AX0GCFst8MCLxlAk4KkSJ6q3kT2d11EjKvEwczcwJRDGZGVDyszvu-NNmnxwdA8
Message-ID: <CAPhsuW7n_+u-M7bnUwX4Go0D+jj7oZZVopE1Bj5S_nHM1+8PZg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/5] bpf path iterator
To: Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, amir73il@gmail.com, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, gnoack@google.com, jack@suse.cz, jlayton@kernel.org, 
	josef@toxicpanda.com, kernel-team@meta.com, kpsingh@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, martin.lau@linux.dev, 
	mattbobrowski@google.com, repnop@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 10:34=E2=80=AFAM Tingmao Wang <m@maowtm.org> wrote:
[...]
> Hi Song, Christian, Al and others,
>
> Previously I proposed in [1] to add ability to do a reference-less parent
> walk for Landlock.  However, as Christian pointed out and I do agree in
> hindsight, it is not a good idea to do things like this in non-VFS code.
>
> However, I still think this is valuable to consider given the performance
> improvement, and after some discussion with Micka=C3=ABl, I would like to
> propose extending Song's helper to support such usage.  While I recognize
> that this patch series is already in its v3, and I do not want to delay i=
t
> by too much, putting this proposal out now is still better than after thi=
s
> has merged, so that we may consider signature changes.
>
> I've created a proof-of-concept and did some brief testing.  The
> performance improvement attained here is the same as in [1] (with a "git
> status" workload, median landlock overhead 35% -> 28%, median time in
> landlock decreases by 26.6%).
>
> If this idea is accepted, I'm happy to work on it further, split out this
> patch, update the comments and do more testing etc, potentially in
> collaboration with Song.
>
> An alternative to this is perhaps to add a new helper
> path_walk_parent_rcu, also living in namei.c, that will be used directly
> by Landlock.  I'm happy to do it either way, but with some experimentatio=
n
> I personally think that the code in this patch is still clean enough, and
> can avoid some duplication.
>
> Patch title: path_walk_parent: support reference-less walk
>
> A later commit will update the BPF path iterator to use this.
>
> Signed-off-by: Tingmao Wang <m@maowtm.org>
[...]
>
> -bool path_walk_parent(struct path *path, const struct path *root);
> +struct parent_iterator {
> +       struct path path;
> +       struct path root;
> +       bool rcu;
> +       /* expected seq of path->dentry */
> +       unsigned next_seq;
> +       unsigned m_seq, r_seq;

Most of parent_iterator is not really used by reference walk.
So it is probably just separate the two APIs?

Also, is it ok to make m_seq and r_seq available out of fs/?

> +};
> +
> +#define PATH_WALK_PARENT_UPDATED               0
> +#define PATH_WALK_PARENT_ALREADY_ROOT  -1
> +#define PATH_WALK_PARENT_RETRY                 -2
> +
> +void path_walk_parent_start(struct parent_iterator *pit,
> +                           const struct path *path, const struct path *r=
oot,
> +                           bool ref_less);
> +int path_walk_parent(struct parent_iterator *pit, struct path *next_pare=
nt);
> +int path_walk_parent_end(struct parent_iterator *pit);

I think it is better to make this rcu walk a separate set of APIs.
IOW, we will have:

int path_walk_parent(struct path *path, struct path *root);

and

void path_walk_parent_rcu_start(struct parent_iterator *pit,
                           const struct path *path, const struct path *root=
);
int path_walk_parent_rcu_next(struct parent_iterator *pit, struct path
*next_parent);
int path_walk_parent_rcu_end(struct parent_iterator *pit);

Thanks,
Song

[...]

