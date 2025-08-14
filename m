Return-Path: <linux-fsdevel+bounces-57827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 137EDB25A4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 06:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E464C5A2D31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 04:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C9F1E8332;
	Thu, 14 Aug 2025 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpNPRiDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06652114;
	Thu, 14 Aug 2025 04:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144543; cv=none; b=XSo3aEhpsQP5681cZsRRYL+2qBT2kOATTgdXiiGz7+ggqLlh6ylKAwnOvz2Nx/A+h8Vk8V+BP79gv+k6Jv9iMccmrQlREDXGPR8ZQNwNGaNsWGXkUHy6B0oovc461DH6+1sW+THUT7YtDK7USg8Q98gRNeYVz8olZeEsimkmZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144543; c=relaxed/simple;
	bh=KMepZn3j6P2ZdrPCrd3OUv6DxkECDXp1XE6iQNQmjwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1QAvQyRomK2++H4w0XtBlKxTzE7xXRssg/6GhUOH8LI/Cr2iQbMO5P5VnAo+ZnIDdx4dwfUI8ExG8iQZKdFdrFr76iWhOW61TLqE1nkLd0MCOA/pgrtVSErxpbX1o4tSUgJwk9B76IXgMI9oJIh1cvw8+T+qDJyR/FNKyOjqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpNPRiDV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32326df0e75so441224a91.2;
        Wed, 13 Aug 2025 21:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755144541; x=1755749341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PU+08Hj7IdON/EOEoKrMGF/qgHczkSyXAOKfclSXjI=;
        b=lpNPRiDVFeGx58BM9EX5dZi+FWrSMEWU9EOTX77rTZeSpjna2R5jJNiMYAX8y9Ae6W
         hSRAJ8s+6xmbQw1GR1O+5ZHru2cZkjTeZFXnwRxSgAejHWYvoZ7ikl8frzkIVW3D/0dU
         NaewNEo6jD3w5AkCIY6cKPu89Id3KIQdV8EbnDKOVNyF4Uv9W7iwkBbiT9DiGO5pqCch
         k55aSbNFvUxkDhP31GgadJt2z/UqzqTs6eJ8QY4PMpvSmS1yRb3FH3u/fCGZTHnoP4QF
         ZgM0Q6X/zxMtC4i0mkS/fU3H6FS4YGF++IO8PiQDUHIZbW66ls+3iwYLXM3j0KdRWl6Q
         5gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755144541; x=1755749341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PU+08Hj7IdON/EOEoKrMGF/qgHczkSyXAOKfclSXjI=;
        b=ETfTTeZ/Cv+ZmjP6YsTeE1EV7Rdkx71Jydt7oZDifLZiz9ghb6kAgBbrg89qTFFcIE
         4ymGvirBpSJzSYkEGiPA3OJQHwv5Xg5Jshadv5liLTT9PSpFHX/zHlANyhTXBaHv6CCP
         Ihp052W2waEYeV2iSqW6Ysl0eFpW37CKxYQD+vzaCgC6QsirJaXyinRQUmxYtGTE5KRg
         FIWW22GR/s/UbX5U58u+tj394vXGNZf3kTK5VKox+45VGs32jgIpUDwU4aEqr/ZuvLMf
         ++2y8YultDSpsemF8P0DmynCsqukSsMmxp+MpeOErv6rK4asXuEM1I3Kb5zrkDAVqTw+
         1fLA==
X-Forwarded-Encrypted: i=1; AJvYcCURHu+HVEvrcCCfqQ85h+qsmpH4Z6F/tLGXdr2xRPudfDnTioPKsf1T2SCjulFpn01ckpmKbEcjIdQHJLorGA==@vger.kernel.org, AJvYcCV/O654BgMVHeqYT1zrxVlOILIzrMbEeuaWHnIz67pscSD0/faK+5IpWkFiM5d5Llnb76iGA0H6VGE=@vger.kernel.org, AJvYcCVpxowCf0MW7uaJseRFH5QIvXeTvO1lMldfDbJCOpP2RhQ7gzPVoGySQeTjdnTDf6iR4v2f9qVadkG1VlI+@vger.kernel.org, AJvYcCVrqfHy/mGTj1WPXbdwaYBrwwcLZqw8/w+QkDjLp65nXH1u+bO9jow+VM3Hq3Ua2gpot8IPKEm8@vger.kernel.org
X-Gm-Message-State: AOJu0YwS9ZuWSO+KuXX6QWgSXQkrQxoqY91CKaUZaZHu56ECKX+a5dPM
	ZZDAfJ1zhypNVTvTZFvMPHqaB9IOjF5IRsq2YWrvvKf7KdZPxVsyNQq78KczUyER5V6zJmq0kk7
	/jd/qOK+Rr8x9P0xk0uAWusdbPZBavsw=
X-Gm-Gg: ASbGncvs3kETBP0cKNwppLz2G9H9cTLOOWm4e0MXmn94e89znv7W7vT+WNGT4LfSn/c
	zoKvIrVH8UnbhbHDHefI1qVP5Sbk4ANQXpcm+Q9hT7+pa7+NfKqWYNS5Q6bX6OnG3157lRiE7GP
	mKr59ip1li10I214BeRuftBxi/PQaOj/VEu1TC564iCVxzxhXs+uEQ7NzFkosxHAIjoxVyANlqp
	UKYVDC6LA==
X-Google-Smtp-Source: AGHT+IFysmNLgAgYG7lYtdrse3SHf122YqK9Usgrv1wtEBz9XZQh06wjpzoMvbc7m9/dJU9UOsdStJIh39nzZi+htsI=
X-Received: by 2002:a17:90b:2248:b0:31f:9114:ead8 with SMTP id
 98e67ed59e1d1-32327a76babmr2707556a91.6.1755144540852; Wed, 13 Aug 2025
 21:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
 <20250724230052.GW2580412@ZenIV> <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
 <20250726175310.GB222315@ZenIV> <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
 <20250813185601.GJ222315@ZenIV> <aJzi506tGJb8CzA3@tycho.pizza> <20250813194145.GK222315@ZenIV>
In-Reply-To: <20250813194145.GK222315@ZenIV>
From: Pavel Tikhomirov <snorcht@gmail.com>
Date: Thu, 14 Aug 2025 12:08:49 +0800
X-Gm-Features: Ac12FXwDKf6o0FeR-M8ho-Ad58OjJloPtXu94TLN21ukCAu7DxWTnnpglJ78QYM
Message-ID: <CAE1zp77jmFD=rySJVLf6yU+JKZnUpjkBagC3qQHrxPotrccEbQ@mail.gmail.com>
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Tycho Andersen <tycho@tycho.pizza>, Andrei Vagin <avagin@google.com>, 
	Andrei Vagin <avagin@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	criu@lists.linux.dev, Linux API <linux-api@vger.kernel.org>, 
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 3:41=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Aug 13, 2025 at 01:09:27PM -0600, Tycho Andersen wrote:
> > On Wed, Aug 13, 2025 at 07:56:01PM +0100, Al Viro wrote:
> > > @@ -3347,18 +3360,11 @@ static int do_set_group(struct path *from_pat=
h, struct path *to_path)
> > >
> > >     namespace_lock();
> > >
> > > -   err =3D -EINVAL;
> > > -   /* To and From must be mounted */
> > > -   if (!is_mounted(&from->mnt))
> > > -           goto out;
> > > -   if (!is_mounted(&to->mnt))
> > > -           goto out;
> > > -
> > > -   err =3D -EPERM;
> > > -   /* We should be allowed to modify mount namespaces of both mounts=
 */
> > > -   if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
> > > +   err =3D may_change_propagation(from);
> > > +   if (err)
> > >             goto out;
> > > -   if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
> > > +   err =3D may_change_propagation(from);
> >
> > Just driving by, but I guess you mean "to" here.
>
> D'oh...  Yes, of course.  Fun question: would our selftests have caught
> that?
> [checks]
> move_mount_set_group_test.c doesn't have anything in that area, nothing i=
n
> LTP or xfstests either, AFAICS...

Yes, selftest is very simple and is not covering userns checks.

>  And I don't see anything in
> https://github.com/checkpoint-restore/criu
> either - there are uses of MOVE_MOUNT_SET_GROUP, but they are well-buried
> and I don't see anything in their tests that would even try to poke into
> that thing...
>
> Before we go and try to cobble something up, does anybody know of a place
> where regression tests for MOVE_MOUNT_SET_GROUP could be picked from?
>

Basically each CRIU test that is run by zdtm (if it is in ns/uns
flavor (which are most of them)), tests mounts checkpoint/restore. And
each test which has shared/slave moutns leads to MOVE_MOUNT_SET_GROUP
being used and thus tested. We have a mountinfo comparison in zdtm
which checks that propagation is topologically the same after c/r.

But, yes, we do not cover userns checks, as in CRIU case, CRIU is
expected to run in userns which has all capabilities over restored
container, and should always pass those checks.

JFYI:

The use of MOVE_MOUNT_SET_GROUP in CRIU is well-buried in:

https://github.com/checkpoint-restore/criu/blob/116e56ba46382c05066d33a8bba=
dcc495dbdb644/criu/mount-v2.c#L896

  +-< move_mount_set_group
    +-< restore_one_sharing
      +-< restore_one_sharing_group
        +-< restore_mount_sharing_options
          +-< prepare_mnt_ns_v2

This stack already has a set of precreated mounts and walks over their
sharing groups saved in CRIU image files and assigns them accordingly.

And we have a bunch of tests with different sharing configurations to
test propagation c/r specifically:

git grep -l "SHARING\|SLAVE" test/zdtm/static
test/zdtm/static/mnt_ext_auto.c
test/zdtm/static/mnt_ext_master.c
test/zdtm/static/mnt_ext_multiple.c
test/zdtm/static/mnt_root_ext.c
test/zdtm/static/mntns_overmount.c
test/zdtm/static/mntns_shared_bind03.c
test/zdtm/static/mount_complex_sharing.c
test/zdtm/static/mountpoints.c
test/zdtm/static/shared_slave_mount_children.c

It should be enough to run a zdtm test-suit to check that change does
not break something for CRIU (will do).

