Return-Path: <linux-fsdevel+bounces-51343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B45AD5C2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 18:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3564D3A8B99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B878202F9A;
	Wed, 11 Jun 2025 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJvLKc7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638511F0E39;
	Wed, 11 Jun 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659499; cv=none; b=LakKbJu9sqE64mpvVdSHD/QGc/75LotY9+Oy+aLEI43vO3ZTEouVI5VoKfi9P31xBeAnR94naBpneX62KzFIgX3BvzhDlooj5j15jS6T+qohS92iBfmj1nvhC9tJWgH2axxZUMDFGwpvH0bh0zNP1NV9atBxl3uXewASteJInCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659499; c=relaxed/simple;
	bh=wHBQRhTvoZjP5hYlhu6PAF/AqN1dtZGC7ByNEkL8uk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCTwOECmEgbXP1aNt+SPdCcpWC5gjPsyQgYUZRwfpJWqCoCbajbDaKh17OoUxl5R2FAP0PcIUVBO4igcJN/oH18ahuZK54eEIy6oxay9+QOCEOBoYh3BN4kg8Um7gjN+x60ZDYxip3TyIlcMJPMJrTYqEtebQ51N+2L8x2P1CK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJvLKc7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE8CC4CEF5;
	Wed, 11 Jun 2025 16:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749659498;
	bh=wHBQRhTvoZjP5hYlhu6PAF/AqN1dtZGC7ByNEkL8uk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JJvLKc7IROMKKelWLCQtsFKYQEuV5DVSTk4jtVvozIZtXoYprNJfLZu4kKj6ondQd
	 L2wjcqMql+MQcTw5uE2TroXEQgwmpm2W9elvE3eC8RVNpD03r4L6/XV7+eXYKuTvxF
	 kiuHceMjoaWRZ3R8IRAyVFftX4aprswSeURh3o7iqGxixiDE1im3RTbixraRi6n/tB
	 z3MX7iW6bSlCkF9FbB/DaLNAgkyD6/G2Hg9HH3Ok5/bngxo/GjSU/BU+idijJft85B
	 6SnneFTyWbUXvepgpz8urF41dLIOx1omo4cwgtPVQm242RKA8ji0VxLS8ie1msRpvR
	 o7U55sl3HkXdw==
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso85456d6.1;
        Wed, 11 Jun 2025 09:31:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUm/Y5+XONlilsbAmRz6jP7G7SKNRdjgSa1ecbeZLR4Tkl5UPJxa95NPg7cMFu1iWHFhqhDlsBSolskUKDo@vger.kernel.org, AJvYcCV92Bi7IGFFZASZr+s5IYIQmDjAZPGTrTw3PJoRPbe2kZ1Vft/p0VEhy8PCWF8jVDpfTF6pRYgqhUrLJP3NnTz3Bf15HOZ3@vger.kernel.org, AJvYcCVUv/dcnkIWyylkkmGfvFkxt9/0KzD5rVwue5fvmjOdEVWJgCEtqljYwEdP9Edb/igcrv8=@vger.kernel.org, AJvYcCVW+4ppSmsGGRQxIQGUNqqJMJboTczuILWrkbpYj7UD9P+S4YVPco3qyXaqDXs0WD5x+dqy5viiNaKQ9X9+2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQDFKZybw9e5Spxl364cF1ZG7pJo8EaJkrTHO4PkMisyIfVrjp
	8dGpQF4tDfp5uTCeSSpt39vAZ2YM/4W/uhgzeZZnRaGnNuEvPKzDBsI7GH5HGZgjaKKeIiOByyb
	syJGS0eH6rMoL4eIUi2pahpnGC3t8KC8=
X-Google-Smtp-Source: AGHT+IHww/o74BxPrTUbg+/oYp3tE0Qny5VDLaUUtEl/gCVQ64aG0JYxPSDJ7sXz6hjpvQbWvubaQVRVtTW5qUDhHi8=
X-Received: by 2002:a05:6214:500c:b0:6fa:fdf5:a604 with SMTP id
 6a1803df08f44-6fb347f3af5mr938296d6.12.1749659497922; Wed, 11 Jun 2025
 09:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606213015.255134-1-song@kernel.org> <20250606213015.255134-2-song@kernel.org>
 <174959847640.608730.1496017556661353963@noble.neil.brown.name>
 <CAPhsuW6oet8_LbL+6mVi7Lc4U_8i7O-PN5F1zOm5esV52sBu0A@mail.gmail.com> <20250611.Bee1Iohoh4We@digikod.net>
In-Reply-To: <20250611.Bee1Iohoh4We@digikod.net>
From: Song Liu <song@kernel.org>
Date: Wed, 11 Jun 2025 09:31:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6jZxRBEgz00KV4SasiMhBGyMHoP5dMktoyCOeMbJwmgg@mail.gmail.com>
X-Gm-Features: AX0GCFsKHEibU3SwfO1PDkPH059MHGcDhjOXxl4R9bB8VLTrCd0m_aTAtlTdLGI
Message-ID: <CAPhsuW6jZxRBEgz00KV4SasiMhBGyMHoP5dMktoyCOeMbJwmgg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] namei: Introduce new helper function path_walk_parent()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: NeilBrown <neil@brown.name>, Jan Kara <jack@suse.cz>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, 
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, 
	gnoack@google.com, m@maowtm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 8:42=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
[...]
> > We can probably call this __path_walk_parent() and make it static.
> >
> > Then we can add an exported path_walk_parent() that calls
> > __path_walk_parent() and adds extra logic.
> >
> > If this looks good to folks, I can draft v4 based on this idea.
>
> This looks good but it would be better if we could also do a full path
> walk within RCU when possible.

I think we will need some callback mechanism for this. Something like:

for_each_parents(starting_path, root, callback_fn, cb_data, bool try_rcu) {
   if (!try_rcu)
      goto ref_walk;

   __read_seqcount_begin();
    /* rcu walk parents, from starting_path until root */
   walk_rcu(starting_path, root, path) {
    callback_fn(path, cb_data);
  }
  if (!read_seqcount_retry())
    return xxx;  /* successful rcu walk */

ref_walk:
  /* ref walk parents, from starting_path until root */
   walk(starting_path, root, path) {
    callback_fn(path, cb_data);
  }
  return xxx;
}

Personally, I don't like this version very much, because the callback
mechanism is not very flexible, and it is tricky to use it in BPF LSM.

Thanks,
Song

