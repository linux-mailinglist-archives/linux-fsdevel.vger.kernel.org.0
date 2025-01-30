Return-Path: <linux-fsdevel+bounces-40382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44B7A22D03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 13:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2915A1888EDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 12:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880641D88DB;
	Thu, 30 Jan 2025 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXi2AH24"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7F31EEE6
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738240658; cv=none; b=RXbI8vnKZ/1vRJQYshJ4hd6Eax1/LvnbJeR8fFs8We/OGddjRBweCp6qdFIX3nTpJLjsxR/jmzFZGad70hs8pM52+v+OiZBfIF/BqkMcirti08gIEeuOZXNo6AoRDcHQ4yBXVQN+lrHDyZM/oOLrSj/Ohib+n8s75ijx/hnZ2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738240658; c=relaxed/simple;
	bh=k6R1Q4zpwVXM8eSkbtak8n4hkEL+XBToRJIFriNI0rM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pu2H8jS0ndWqbzFAj8uwkZKIbFKWDanyaG5YZ3fpWJDnVMYitlcpMSLspaM7qqgdwOS4ljxmJQFucqVDl3LeisZ3LcA8Rtw4eCz94AgCgl+UfNMigwkGoTibH3fJwdR/90mFRVPWo8MSdNHXS6IwZmPYqMkbnJ/PBsi9v/KSQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXi2AH24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC69C4CED2;
	Thu, 30 Jan 2025 12:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738240657;
	bh=k6R1Q4zpwVXM8eSkbtak8n4hkEL+XBToRJIFriNI0rM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gXi2AH24IKpLVOYMuvnKNjxuyOxRQAt/BsnkdprN89kqBSqBhegHrL1fR3Cq5RIDO
	 F69TU3XWfSM6Oke08MWiKH0SynucXJ0sS+de5sx7pSxy25/ObfGIbaU/CfEU9/chEG
	 USOS6dcMSvYb68lvnqJQ0Y8n2iR65QwCdxTVGBQSMl0GJLvEBKCYkNzrCJB7oIhXXx
	 cugUI+uh7PfIPI45ZYN7Sq443c9GHDA530la1xsl7lZTYyrzgXawPZjtdR8dcW49gx
	 pmXLGdrLoqyJx/6sFQFJD7ug67FVvFyZtKHobyYDcq06TUqGJ4hTQw/RBe7Z1X/phV
	 UyDmJQT9k/DLw==
Message-ID: <e5d90fbe3b8d569e11b5968c8b02f13536021f69.camel@kernel.org>
Subject: Re: [PATCH 2/4] statmount: allow to retrieve idmappings
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Lennart Poettering
	 <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, Seth
 Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 30 Jan 2025 07:37:35 -0500
In-Reply-To: <20250130-work-mnt_idmap-statmount-v1-2-d4ced5874e14@kernel.org>
References: <20250130-work-mnt_idmap-statmount-v1-0-d4ced5874e14@kernel.org>
	 <20250130-work-mnt_idmap-statmount-v1-2-d4ced5874e14@kernel.org>
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

On Thu, 2025-01-30 at 00:19 +0100, Christian Brauner wrote:
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
> But the idmappings might not always be resolvablein the caller's user
> namespace. For example:
>=20
>     unshare --user --map-root
>=20
> In this case statmount() will indicate the failure to resolve the idmappi=
ngs
> in the caller's user namespace by listing 4294967295 aka (uid_t) -1 as
> the target of the mapping while still showing the source and range of
> the mapping:
>=20
>     mnt_id:        2147485087
>     mnt_parent_id: 2147484016
>     fs_type:       btrfs
>     mnt_root:      /srv
>     mnt_point:     /opt
>     mnt_opts:      ssd,discard=3Dasync,space_cache=3Dv2,subvolid=3D5,subv=
ol=3D/
>     mnt_uidmap[0]: 0 4294967295 1000
>     mnt_uidmap[1]: 2000 4294967295 1
>     mnt_uidmap[2]: 3000 4294967295 1
>     mnt_gidmap[0]: 0 4294967295 1000
>     mnt_gidmap[1]: 2000 4294967295 1
>     mnt_gidmap[2]: 3000 4294967295 1
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
>  fs/internal.h              |  1 +
>  fs/mnt_idmapping.c         | 49 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/namespace.c             | 43 +++++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/mount.h |  8 +++++++-
>  4 files changed, 99 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/internal.h b/fs/internal.h
> index e7f02ae1e098..db6094d5cb0b 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -338,3 +338,4 @@ static inline bool path_mounted(const struct path *pa=
th)
>  	return path->mnt->mnt_root =3D=3D path->dentry;
>  }
>  void file_f_owner_release(struct file *file);
> +int statmount_mnt_idmap(struct mnt_idmap *idmap, struct seq_file *seq, b=
ool uid_map);
> diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> index 7b1df8cc2821..4aca8e3ba97e 100644
> --- a/fs/mnt_idmapping.c
> +++ b/fs/mnt_idmapping.c
> @@ -6,6 +6,7 @@
>  #include <linux/mnt_idmapping.h>
>  #include <linux/slab.h>
>  #include <linux/user_namespace.h>
> +#include <linux/seq_file.h>
> =20
>  #include "internal.h"
> =20
> @@ -334,3 +335,51 @@ void mnt_idmap_put(struct mnt_idmap *idmap)
>  		free_mnt_idmap(idmap);
>  }
>  EXPORT_SYMBOL_GPL(mnt_idmap_put);
> +
> +int statmount_mnt_idmap(struct mnt_idmap *idmap, struct seq_file *seq, b=
ool uid_map)
> +{
> +	struct uid_gid_map *map, *map_up;
> +
> +	if (idmap =3D=3D &nop_mnt_idmap || idmap =3D=3D &invalid_mnt_idmap)
> +		return 0;
> +
> +	/*
> +	 * Idmappings are shown relative to the caller's idmapping.
> +	 * This is both the most intuitive and most useful solution.
> +	 */
> +	if (uid_map) {
> +		map =3D &idmap->uid_map;
> +		map_up =3D &current_user_ns()->uid_map;
> +	} else {
> +		map =3D &idmap->gid_map;
> +		map_up =3D &current_user_ns()->gid_map;
> +	}
> +
> +	for (u32 idx =3D 0; idx < map->nr_extents; idx++) {
> +		uid_t lower;
> +		struct uid_gid_extent *extent;
> +
> +		if (map->nr_extents <=3D UID_GID_MAP_MAX_BASE_EXTENTS)
> +			extent =3D &map->extent[idx];
> +		else
> +			extent =3D &map->forward[idx];
> +
> +		/*
> +		 * Verify that the whole range of the mapping can be
> +		 * resolved in the caller's idmapping. If it cannot be
> +		 * resolved 1/4294967295 will be shown as the target of

nit: I think you mean '-1/4294967295'.

> +		 * the mapping. The source and range are shown as a hint
> +		 * to the caller.
> +		 */
> +		lower =3D map_id_range_up(map_up, extent->lower_first, extent->count);
> +		if (lower =3D=3D (uid_t) -1)
> +			seq_printf(seq, "%u %u %u", extent->first, -1, extent->count);
> +		else
> +			seq_printf(seq, "%u %u %u", extent->first, lower, extent->count);

Again, I think a different syntax for an unresolveable range would be
better. Another idea -- if you separate the fields by ':', you could
just leave out the middle field when it can't be resolved -- e.g.
"1000::1000".

> +		seq->count++; /* mappings are separated by \0 */
> +		if (seq_has_overflowed(seq))
> +			return -EAGAIN;
> +	}
> +
> +	return map->nr_extents;
> +}
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 4013fbac354a..535e4829061f 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4915,6 +4915,7 @@ struct kstatmount {
>  	struct statmount __user *buf;
>  	size_t bufsize;
>  	struct vfsmount *mnt;
> +	struct mnt_idmap *idmap;
>  	u64 mask;
>  	struct path root;
>  	struct statmount sm;
> @@ -5185,6 +5186,30 @@ static int statmount_opt_sec_array(struct kstatmou=
nt *s, struct seq_file *seq)
>  	return 0;
>  }
> =20
> +static inline int statmount_mnt_uidmap(struct kstatmount *s, struct seq_=
file *seq)
> +{
> +	int ret;
> +
> +	ret =3D statmount_mnt_idmap(s->idmap, seq, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	s->sm.mnt_uidmap_num =3D ret;
> +	return 0;
> +}
> +
> +static inline int statmount_mnt_gidmap(struct kstatmount *s, struct seq_=
file *seq)
> +{
> +	int ret;
> +
> +	ret =3D statmount_mnt_idmap(s->idmap, seq, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	s->sm.mnt_gidmap_num =3D ret;
> +	return 0;
> +}
> +
>  static int statmount_string(struct kstatmount *s, u64 flag)
>  {
>  	int ret =3D 0;
> @@ -5226,6 +5251,14 @@ static int statmount_string(struct kstatmount *s, =
u64 flag)
>  		sm->sb_source =3D start;
>  		ret =3D statmount_sb_source(s, seq);
>  		break;
> +	case STATMOUNT_MNT_UIDMAP:
> +		sm->mnt_uidmap =3D start;
> +		ret =3D statmount_mnt_uidmap(s, seq);
> +		break;
> +	case STATMOUNT_MNT_GIDMAP:
> +		sm->mnt_gidmap =3D start;
> +		ret =3D statmount_mnt_gidmap(s, seq);
> +		break;
>  	default:
>  		WARN_ON_ONCE(true);
>  		return -EINVAL;
> @@ -5350,6 +5383,7 @@ static int do_statmount(struct kstatmount *s, u64 m=
nt_id, u64 mnt_ns_id,
>  		return err;
> =20
>  	s->root =3D root;
> +	s->idmap =3D mnt_idmap(s->mnt);
>  	if (s->mask & STATMOUNT_SB_BASIC)
>  		statmount_sb_basic(s);
> =20
> @@ -5383,6 +5417,12 @@ static int do_statmount(struct kstatmount *s, u64 =
mnt_id, u64 mnt_ns_id,
>  	if (!err && s->mask & STATMOUNT_SB_SOURCE)
>  		err =3D statmount_string(s, STATMOUNT_SB_SOURCE);
> =20
> +	if (!err && s->mask & STATMOUNT_MNT_UIDMAP)
> +		err =3D statmount_string(s, STATMOUNT_MNT_UIDMAP);
> +
> +	if (!err && s->mask & STATMOUNT_MNT_GIDMAP)
> +		err =3D statmount_string(s, STATMOUNT_MNT_GIDMAP);
> +
>  	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
>  		statmount_mnt_ns_id(s, ns);
> =20
> @@ -5406,7 +5446,8 @@ static inline bool retry_statmount(const long ret, =
size_t *seq_size)
>  #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT |=
 \
>  			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | \
>  			      STATMOUNT_FS_SUBTYPE | STATMOUNT_SB_SOURCE | \
> -			      STATMOUNT_OPT_ARRAY | STATMOUNT_OPT_SEC_ARRAY)
> +			      STATMOUNT_OPT_ARRAY | STATMOUNT_OPT_SEC_ARRAY | \
> +			      STATMOUNT_MNT_UIDMAP | STATMOUNT_MNT_GIDMAP)
> =20
>  static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *=
kreq,
>  			      struct statmount __user *buf, size_t bufsize,
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index c07008816aca..0be6ac4c1624 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -179,7 +179,11 @@ struct statmount {
>  	__u32 opt_array;	/* [str] Array of nul terminated fs options */
>  	__u32 opt_sec_num;	/* Number of security options */
>  	__u32 opt_sec_array;	/* [str] Array of nul terminated security options =
*/
> -	__u64 __spare2[46];
> +	__u32 mnt_uidmap_num;	/* Number of uid mappings */
> +	__u32 mnt_uidmap;	/* [str] Array of uid mappings (as seen from callers =
namespace) */
> +	__u32 mnt_gidmap_num;	/* Number of gid mappings */
> +	__u32 mnt_gidmap;	/* [str] Array of gid mappings (as seen from callers =
namespace) */
> +	__u64 __spare2[44];
>  	char str[];		/* Variable size part containing strings */
>  };
> =20
> @@ -217,6 +221,8 @@ struct mnt_id_req {
>  #define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
>  #define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
>  #define STATMOUNT_OPT_SEC_ARRAY		0x00000800U	/* Want/got opt_sec... */
> +#define STATMOUNT_MNT_UIDMAP		0x00001000U	/* Want/got uidmap... */
> +#define STATMOUNT_MNT_GIDMAP		0x00002000U	/* Want/got gidmap... */
> =20
>  /*
>   * Special @mnt_id values that can be passed to listmount
>=20

--=20
Jeff Layton <jlayton@kernel.org>

