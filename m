Return-Path: <linux-fsdevel+bounces-40746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFEFA271F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269603A16D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBDB20FAA6;
	Tue,  4 Feb 2025 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4fhxhk9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9596206F3A
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738672692; cv=none; b=Y7fcixf42z312TgxEY3rFz+FT7TgeHN/PSYHFKO6txlxbq2jDzarsIcqxQ7fLD0BnVjDOHPlge5+RDpQB/P3fKRtq1pBvQJhvyr73wbbpseWPq5QeENZBHPHfA6IztlHsE1jYwiVYn0tT2umCmwDK39Qcu0iu5TZ7RCwjvlGR+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738672692; c=relaxed/simple;
	bh=eo0COx2iTEMDcOo0xtXARoiFwSJ7fGBTHN89G0lGvWw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hx9W5EywRs4xteNyavxeB7XjmPquXpl1SWmvpG9fCOWchU3rk8xTwk019/6RyC80Sm1JSbABi+xxVf2Clkdpty1CdI9IUR0e75254qJR33Bl3cr0UH+8PtT6Sfx8+SwI/RKjGAYgbrTAVF7nE8Y178gGwoVVjvOXNY6AnGr/U3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4fhxhk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49C9C4CEDF;
	Tue,  4 Feb 2025 12:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738672692;
	bh=eo0COx2iTEMDcOo0xtXARoiFwSJ7fGBTHN89G0lGvWw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=q4fhxhk96Dy0HWNjnX5u/bhpV3lORsxa5dolBbx3pnFCX+70wUx6AJp39p8E2fpQB
	 /x2PayK23dAZ2FLGNGjZIAWzsAFYgOjNIYL2r0ntWP/xi1qVG/S6WwP9zQrfdRLXOE
	 p3y4WMi8+RnNb4sJCv0YTfafTJYxvLi8gbJlGtAfjXn+5gTYiFmm5sO15ItCqrzqh+
	 FZ2I9TZSnp4pXUDCMNRaS8VzLiYH3txVtv+EW4MNAbO51MYSnz3BrqwYe/0oSDnodj
	 skmwf7DWVh5YbtdS5uscHSKrLpj/Hrwr8vJKLFbngOSMMRdNvzFtnkpdb6ZjnUtTxj
	 eN9sLtHWW8JEw==
Message-ID: <dac5331e7e23b077cd3590fca6254118b64c00b0.camel@kernel.org>
Subject: Re: [PATCH v2 0/4] statmount: allow to retrieve idmappings
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Lennart Poettering
	 <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, Seth
 Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 04 Feb 2025 07:38:10 -0500
In-Reply-To: <20250204-work-mnt_idmap-statmount-v2-0-007720f39f2e@kernel.org>
References: <20250204-work-mnt_idmap-statmount-v2-0-007720f39f2e@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-04 at 12:27 +0100, Christian Brauner wrote:
> This adds the STATMOUNT_MNT_UIDMAP and STATMOUNT_MNT_GIDMAP options.
> It allows the retrieval of idmappings via statmount().
>=20
> Currently it isn't possible to figure out what idmappings are applied to
> an idmapped mount. This information is often crucial. Before statmount()
> the only realistic options for an interface like this would have been to
> add it to /proc/<pid>/fdinfo/<nr> or to expose it in
> /proc/<pid>/mountinfo. Both solution would have been pretty ugly and
> would've shown information that is of strong interest to some
> application but not all. statmount() is perfect for this.
>=20
> The idmappings applied to an idmapped mount are shown relative to the
> caller's user namespace. This is the most useful solution that doesn't
> risk leaking information or confuse the caller.
>=20
> For example, an idmapped mount might have been created with the
> following idmappings:
>=20
>     mount --bind -o X-mount.idmap=3D"0:10000:1000 2000:2000:1 3000:3000:1=
" /srv /opt
>=20
> Listing the idmappings through statmount() in the same context shows:
>=20
>     mnt_id:        2147485088
>     mnt_parent_id: 2147484816
>     fs_type:       btrfs
>     mnt_root:      /srv
>     mnt_point:     /opt
>     mnt_opts:      ssd,discard=3Dasync,space_cache=3Dv2,subvolid=3D5,subv=
ol=3D/
>     mnt_uidmap[0]: 0 10000 1000
>     mnt_uidmap[1]: 2000 2000 1
>     mnt_uidmap[2]: 3000 3000 1
>     mnt_gidmap[0]: 0 10000 1000
>     mnt_gidmap[1]: 2000 2000 1
>     mnt_gidmap[2]: 3000 3000 1
>=20
> But the idmappings might not always be resolvable in the caller's user
> namespace. For example:
>=20
>     unshare --user --map-root
>=20
> In this case statmount() will skip any mappings that fil to resolve in
> the caller's idmapping:
>=20
>     mnt_id:        2147485087
>     mnt_parent_id: 2147484016
>     fs_type:       btrfs
>     mnt_root:      /srv
>     mnt_point:     /opt
>     mnt_opts:      ssd,discard=3Dasync,space_cache=3Dv2,subvolid=3D5,subv=
ol=3D/
>=20
> The caller can differentiate between a mount not being idmapped and a
> mount that is idmapped but where all mappings fail to resolve in the
> caller's idmapping by check for the STATMOUNT_MNT_{G,U}IDMAP flag being
> raised but the number of mappings in ->mnt_{g,u}idmap_num being zero.
>=20
> Note that statmount() requires that the whole range must be resolvable
> in the caller's user namespace. If a subrange fails to map it will still
> list the map as not resolvable. This is a practical compromise to avoid
> having to find which subranges are resovable and wich aren't.
>=20
> Idmappings are listed as a string array with each mapping separated by
> zero bytes. This allows to retrieve the idmappings and immediately use
> them for writing to e.g., /proc/<pid>/{g,u}id_map and it also allow for
> simple iteration like:
>=20
>     if (stmnt->mask & STATMOUNT_MNT_UIDMAP) {
>             const char *idmap =3D stmnt->str + stmnt->mnt_uidmap;
>=20
>             for (size_t idx =3D 0; idx < stmnt->mnt_uidmap_nr; idx++) {
>                     printf("mnt_uidmap[%lu]: %s\n", idx, idmap);
>                     idmap +=3D strlen(idmap) + 1;
>             }
>     }
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://lore.kernel.org/r/20250130-work-mnt_idmap-statmount=
-v1-0-d4ced5874e14@kernel.org
>=20
> ---
> Christian Brauner (4):
>       uidgid: add map_id_range_up()
>       statmount: allow to retrieve idmappings
>       samples/vfs: check whether flag was raised
>       samples/vfs: add STATMOUNT_MNT_{G,U}IDMAP
>=20
>  fs/internal.h                      |  1 +
>  fs/mnt_idmapping.c                 | 51 ++++++++++++++++++++++++++++++++
>  fs/namespace.c                     | 59 ++++++++++++++++++++++++++++++++=
+++++-
>  include/linux/mnt_idmapping.h      |  5 ++++
>  include/linux/uidgid.h             |  6 ++++
>  include/uapi/linux/mount.h         |  8 +++++-
>  kernel/user_namespace.c            | 26 +++++++++++------
>  samples/vfs/samples-vfs.h          | 14 ++++++++-
>  samples/vfs/test-list-all-mounts.c | 35 ++++++++++++++++++----
>  9 files changed, 187 insertions(+), 18 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250129-work-mnt_idmap-statmount-e57f258fef8e
>=20

This all looks pretty sane to me.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

