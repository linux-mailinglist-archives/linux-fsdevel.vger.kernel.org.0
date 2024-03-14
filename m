Return-Path: <linux-fsdevel+bounces-14398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F1F87BD48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 14:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E53E285A8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 13:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D6A5B5D3;
	Thu, 14 Mar 2024 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="AdKXiqpb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833A5A11F
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421699; cv=none; b=uNa/oW5PNmVpbaFvh62PDwWzoILABPXKe9QIsiU0XqTP15NT8W/kBJoLIgNyNU9XNWDxbUJe/kLd0entfn1p6cZoIiKd0ERnqBUVS71+PV3HP+cXFxOEZmBRaJN1NbA1K9ttgx8yFo4Prkx91O5PwMIjmmd1zgbYRVc6LcApMnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421699; c=relaxed/simple;
	bh=f1RjpYk+wUVGcUzWsEOUuhMJaZVlrsH0nJwtARIVQis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxTJhqbXZa9XoDB31+ZoWPKGYd7RHLQHPNnhJIzM4aFtwuzjOmfRyiZJ+Rc3spILj+saQo+hAN5OCCPz/KQ5AAbi710MmGzlq4y4D7YRq4FKQB+K2xSM3Q7HXbKx3c8UaiFIur/OduK6rZjX9tA0bEQLBUmeCCaR0Ve/5zGFeIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=AdKXiqpb; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513d3746950so453952e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 06:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710421696; x=1711026496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7F+GMfmTIeHQjgM+fN0XugEriGVcEET+uvRlxfdDDkg=;
        b=AdKXiqpbZbTRHaHNMUfFQIz7Cos0PIjajNXdkrEmCIer4vIXHcyZm9IIwDrOhv8RIz
         NHcV2ARyBMypBYLHttp9otFiT7wszy9N2U0UbX77I6hPBoUH9BflyydkFgGEjj9rOljo
         sH4oE2gfBTnNQqQiWC7v+s1hdf6bBzIi8hK7yKVDaPrkmwEHzmWY/VSePDH/g7afRl9d
         Oqrcg3MUpsu3Gd9tbaiNIEhrS0ixRDv1zjIels9DnZuZmrA1JfIaoCKMlooI6WOcx9x3
         5uQuTETc/ZSy9iN4PsL3XAjox3HCGuShOPQEmQWGs4+rRrv74dmYhtcDrNraSVlzLxdV
         BCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710421696; x=1711026496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7F+GMfmTIeHQjgM+fN0XugEriGVcEET+uvRlxfdDDkg=;
        b=IU+y08aL8ayrLHDDcBRG8m2w5tMVLJNCX7cVs0XQqtsJnzTGKjCE5d0llk8lpDavvp
         0BlfRxmqb2l5Ev2B/a1gBqg4ISrhW36xuc2NgnqbOvyZW9My6/i36b+rTTbiOW2d2BbQ
         dsSRTvzfG9XB8TX9vJ0n7nVdY842Miwmo7kjgUV6HVbUgF58q4a5BahFRjLo1uN1+3mQ
         gdj2rvbWLxhj4ht/kEQdX+qs0cxBUNcI6DcfZs+cw3YfvkaaarmndquMJVwrtgVXBk5c
         zXBvl5k7K+sLvdd/eJ+4BAJJYMFHtRz9TYQRV/kqeQ2vZCDHAd+51marQ7Bn27lk/ZFr
         wWcg==
X-Forwarded-Encrypted: i=1; AJvYcCXjV9iXVRSf7cP8xZvWxNOd/ah3PzUIjQoEzv8dnxf9FDQn1u8ijHO9+VEBDY5XGisFlmCD1YzSRIpvhawUtlozGtSDsfsEahLfUa3+MA==
X-Gm-Message-State: AOJu0YwsXqdQbfSVbhxuXs1dnOt3I/37pkEK+1+2YUic6CLthm/ZpxHW
	62h/hr9XVf/QaVwR8/M0Y8pRJO7BfZXibHXFY6vRcSVjElQPs3ngd4WBryKS4BbxsHuEAg4W26T
	4MSzHTZ100zwL/OaS03kOo2wokZRkOFujjuYo0w==
X-Google-Smtp-Source: AGHT+IFHtrfJtNBtI2EsrPtjKBAkxhfSnsboFEe2tmEPRF+rDfTqUN6uL/var8SH6nCXb1/uJK+v42k/DM67/PYhulU=
X-Received: by 2002:a2e:be90:0:b0:2d4:6aba:f1a3 with SMTP id
 a16-20020a2ebe90000000b002d46abaf1a3mr1474815ljr.6.1710421695825; Thu, 14 Mar
 2024 06:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011100541.sfn3prgtmp7hk2oj@quack3> <CAKPOu+_xdFALt9sgdd5w66Ab6KTqiy8+Z0Yd3Ss4+92jh8nCwg@mail.gmail.com>
 <20231011120655.ndb7bfasptjym3wl@quack3> <CAKPOu+-hLrrpZShHh0o6uc_KMW91suEd0_V_uzp5vMf4NM-8yw@mail.gmail.com>
 <CAKPOu+_0yjg=PrwAR8jKok8WskjdDEJOBtu3uKR_4Qtp8b7H1Q@mail.gmail.com>
 <20231011135922.4bij3ittlg4ujkd7@quack3> <20231011-braumeister-anrufen-62127dc64de0@brauner>
 <20231011170042.GA267994@mit.edu> <20231011172606.mztqyvclq6hq2qa2@quack3>
 <20231012142918.GB255452@mit.edu> <20231012144246.h3mklfe52gwacrr6@quack3> <28DSITL9912E1.2LSZUVTGTO52Q@mforney.org>
In-Reply-To: <28DSITL9912E1.2LSZUVTGTO52Q@mforney.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 14 Mar 2024 14:08:04 +0100
Message-ID: <CAKPOu+910gjDp9Lk3sW=CmTM8j_FHEYyfH-kQKz-piRJHkQiDw@mail.gmail.com>
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
To: Michael Forney <mforney@mforney.org>
Cc: Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Jan Kara <jack@suse.com>, Dave Kleikamp <shaggy@kernel.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, Yang Xu <xuyang2018.jy@fujitsu.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 9:39=E2=80=AFPM Michael Forney <mforney@mforney.org=
> wrote:
> Turns out that symlinks are inheriting umask on my system (which
> has CONFIG_EXT4_FS_POSIX_ACL=3Dn):
>
> $ umask 022
> $ ln -s target symlink
> $ ls -l symlink
> lrwxr-xr-x    1 michael  michael           6 Mar 13 13:28 symlink -> targ=
et
> $
>
> Looking at the referenced functions, posix_acl_create() returns
> early before applying umask for symlinks, but ext4_init_acl() now
> applies the umask unconditionally.

Indeed, I forgot to exclude symlinks from this - sorry for the breakage.

> After reverting this commit, it works correctly. I am also unable
> to reproduce the mentioned issue with O_TMPFILE after reverting the
> commit. It seems that the bug was fixed properly in ac6800e279a2
> ('fs: Add missing umask strip in vfs_tmpfile'), and all branches
> that have this ext4_init_acl patch already had ac6800e279a2 backported.

I can post a patch that adds the missing check or a revert - what do
the FS maintainers prefer?

(There was a bug with O_TMPFILE ignoring umasks years ago - I first
posted the patch in 2018 or so - but by the time my patch actually got
merged, the bug had already been fixed somewhere else IIRC.)

Max

