Return-Path: <linux-fsdevel+bounces-77168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P30D/t0j2kpRAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 20:01:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C18D139154
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 20:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0190D30131C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 19:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2006924CEEA;
	Fri, 13 Feb 2026 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+a8x+LB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nejGI34S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D26617B50F
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 19:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771009260; cv=none; b=pkUaWfa2sCbyyx8ihKAGT/2Qcp0E4ehqI78CMMPORmgn84mWh9yZ5kGuJixhfEe8X1iXWHWLRvDIMm6X3n8y/zjcH/k5bg1XDPNsKefhCtFoz5I+ovVZM3ZWJeQ62c6j23VuCQTu+/h2i2GzlTLON9vD5+VhUj623wv5dlChuko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771009260; c=relaxed/simple;
	bh=aq+x6OwoJ3XzUM6wsqmO+mWDwqdjUoe1Fol3jl5bKCs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ho1E/Sd7rhFpCnL5js4j/F1oAJPXt0qahRCt0AlLAiyjb6JKNfgwM2yEKRG0P/iSCzpn8+Bc/11rmDsd8xUoghFFesijwoyey4Y5YPNV9r31HhmALK/pa84qi9Gw7eJ8zelmVMt9lW2ADeevNoNOc+W0mP2VTSffbggQWSLikPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+a8x+LB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nejGI34S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771009258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCQRvRguTRIO9fh9TMMKxv2JKv34U2thJ6ITQfdKyKc=;
	b=F+a8x+LBICcqgcylUgAebThQRjShWsot6FT6LMI6L8jsFMclz7B633VbaZvvS7dP7DIHEH
	II0bncQ/UxvF3l95JxIx71tPm4lZwwpxr0tWWQk+1aM3j3wZCwxe3GfuNgnAUkEMqcxdXR
	a0gsBqejNLIgEWAcadiv7mhDlp9DtG0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-VRMz2GZrPkyWp-R6sEzPIw-1; Fri, 13 Feb 2026 14:00:56 -0500
X-MC-Unique: VRMz2GZrPkyWp-R6sEzPIw-1
X-Mimecast-MFC-AGG-ID: VRMz2GZrPkyWp-R6sEzPIw_1771009256
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79628adff03so23191827b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 11:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771009256; x=1771614056; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kCQRvRguTRIO9fh9TMMKxv2JKv34U2thJ6ITQfdKyKc=;
        b=nejGI34ShRttIK736SCJhgeVS1Ld8KmqEDgrXWkvvvwZ+tS5oxGWouo61PaXhIm3Bp
         ql7w9Qw6CIIDYh2qgVNZjHDYGG0miuxeydUssbSI9+krCfNqVgchgUuyW2F87OFYr6rR
         ME8aF3z7hV5FOm4LnBJozwE+zcfVp2gKBdHDkp3EB+oGiqIDg+3yqDXU6m2ib6vTXBLk
         qncb038yXfukWxJILiMaL7hL3KKeugPK4edyGWWBN7fHV2aer8zWi3XemLC7VegkABNt
         r34uCE4Gd9Tj1VQN3MfMzCK1RHwVVRZx0oHn4Tz5qc/EGO8tD4XqFSiCxMvRDAuH2Wss
         GnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771009256; x=1771614056;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCQRvRguTRIO9fh9TMMKxv2JKv34U2thJ6ITQfdKyKc=;
        b=nIHYZnOueGhVfhhDg0lAvYaVXxaZJJ1rQZ4LyHEqYWOCf1KR5T4ZcnsI3JOgGmb7Ba
         GDQLiKh3+LC2ysTFv/hkhJyLoUfrYxwKmkYND5FpPegeg8S++YxHfo5xBDVNd4wp0zOA
         LuW3KQBAEyUnKTY/2xBkIImmBXY5gvwcfFmdmxYSAiUZU/qsyXgeTUIbC1BTwe2Ou+lL
         nG9flz90M1BnVFr+/M6xJXN0R9guyYgZ1eXjABxjgoNt6UEVG+J/1as6lLDYxv2AE/0z
         f6gUEQiUDKBPdwoZIFRa5gzmrvmQ99ZCkOzII39617okpGVg95X0ph+qfDAcXMeWaNOl
         nMvg==
X-Forwarded-Encrypted: i=1; AJvYcCXWCjejbkBGUJwc+yGsoMVG+edVr4IleBIVRj0mwe2p/yAX6mPaoLpp1+CzB8tm65DpFtn6DFDTUOxfgCf5@vger.kernel.org
X-Gm-Message-State: AOJu0YwxZpFMatG7KFGMvNr6EsRQSeyUigNW5cZ4Jy3RIoRmftTTLPr9
	oZBaB1W5T9Cg+mwxFesU67dnsbG+4wF1Ivnmk3+a4Cm1fhDEjbyM15Glz+XiF92RUKh5TYQEj80
	1dUsW9zqTGINZNG2MFQOF3LBZ7x6Zz4G1XwysdlG0qNCTfz3YE8mwOIRi19E3INYTmmg=
X-Gm-Gg: AZuq6aJzKvK67vpmgaOdDuIfKQLrWhMZecg72bag9gpAR/4MrFmgAkziVeeT12qGZXV
	QJszfxQU25XDpMi1pwYvLg5neOJhSZNgqvLvBFoOt+DLgmnkgYk/DkCUauiV6mYsRAcbYvZiDLW
	NFLCvV/N/EFH80KyyQECsVjDN49xFyCDgcMucS9UqfJTOPzrnnL5ZKjqqti5eoDNtj6WNuK3eDo
	allU3wcOwcsCunNEgM3K1VtVcc3MStEWe+ScGwcpox0g7Y3LuAuh1Gc/jTX5yt4QR9zfpXWVAOp
	YHBbWcLDi7qrv9m38cn0iC2GwRunVjLFb8qTTtA+OuQMoLkiGIhgTTmhatJvNTeJDQ0Wo8U92o0
	Tor2vmtW3JDPfx7/qburGG8ma9r8rwmJLzSYyfahxifEolbKrdMkm
X-Received: by 2002:a05:690c:f95:b0:797:a6a9:568 with SMTP id 00721157ae682-797a6a90795mr19890817b3.33.1771009255510;
        Fri, 13 Feb 2026 11:00:55 -0800 (PST)
X-Received: by 2002:a05:690c:f95:b0:797:a6a9:568 with SMTP id 00721157ae682-797a6a90795mr19890067b3.33.1771009254703;
        Fri, 13 Feb 2026 11:00:54 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c18b3desm70796927b3.14.2026.02.13.11.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:00:53 -0800 (PST)
Message-ID: <384987ebbc8a0b54ca806ad9383f2192291daf2d.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v6 2/3] ceph: parse subvolume_id from
 InodeStat v9 and store in inode
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Fri, 13 Feb 2026 11:00:50 -0800
In-Reply-To: <20260210090626.1835644-3-amarkuze@redhat.com>
References: <20260210090626.1835644-1-amarkuze@redhat.com>
	 <20260210090626.1835644-3-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77168-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C18D139154
X-Rspamd-Action: no action

On Tue, 2026-02-10 at 09:06 +0000, Alex Markuze wrote:
> Add support for parsing the subvolume_id field from InodeStat v9 and
> storing it in the inode for later use by subvolume metrics tracking.
>=20
> The subvolume_id identifies which CephFS subvolume an inode belongs to,
> enabling per-subvolume I/O metrics collection and reporting.
>=20
> This patch:
> - Adds subvolume_id field to struct ceph_mds_reply_info_in
> - Adds i_subvolume_id field to struct ceph_inode_info
> - Parses subvolume_id from v9 InodeStat in parse_reply_info_in()
> - Adds ceph_inode_set_subvolume() helper to propagate the ID to inodes
> - Initializes i_subvolume_id in inode allocation and clears on destroy
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/inode.c      | 41 +++++++++++++++++++++++++++++++++++++++++
>  fs/ceph/mds_client.c | 38 ++++++++++++++++++++++++--------------
>  fs/ceph/mds_client.h |  1 +
>  fs/ceph/super.h      | 10 ++++++++++
>  4 files changed, 76 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 2966f88310e3..c2edbeda19ca 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -638,6 +638,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb=
)
> =20
>  	ci->i_max_bytes =3D 0;
>  	ci->i_max_files =3D 0;
> +	ci->i_subvolume_id =3D CEPH_SUBVOLUME_ID_NONE;
> =20
>  	memset(&ci->i_dir_layout, 0, sizeof(ci->i_dir_layout));
>  	memset(&ci->i_cached_layout, 0, sizeof(ci->i_cached_layout));
> @@ -742,6 +743,8 @@ void ceph_evict_inode(struct inode *inode)
> =20
>  	percpu_counter_dec(&mdsc->metric.total_inodes);
> =20
> +	ci->i_subvolume_id =3D CEPH_SUBVOLUME_ID_NONE;
> +
>  	netfs_wait_for_outstanding_io(inode);
>  	truncate_inode_pages_final(&inode->i_data);
>  	if (inode_state_read_once(inode) & I_PINNING_NETFS_WB)
> @@ -873,6 +876,40 @@ int ceph_fill_file_size(struct inode *inode, int iss=
ued,
>  	return queue_trunc;
>  }
> =20
> +/*
> + * Set the subvolume ID for an inode.
> + *
> + * The subvolume_id identifies which CephFS subvolume this inode belongs=
 to.
> + * CEPH_SUBVOLUME_ID_NONE (0) means unknown/unset - the MDS only sends
> + * non-zero IDs for inodes within subvolumes.
> + *
> + * An inode's subvolume membership is immutable - once an inode is creat=
ed
> + * in a subvolume, it stays there. Therefore, if we already have a valid
> + * (non-zero) subvolume_id and receive a different one, that indicates a=
 bug.
> + */
> +void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_id)
> +{
> +	struct ceph_inode_info *ci;
> +	u64 old;
> +
> +	if (!inode || subvolume_id =3D=3D CEPH_SUBVOLUME_ID_NONE)
> +		return;
> +
> +	ci =3D ceph_inode(inode);
> +	old =3D READ_ONCE(ci->i_subvolume_id);
> +
> +	if (old =3D=3D subvolume_id)
> +		return;
> +
> +	if (old !=3D CEPH_SUBVOLUME_ID_NONE) {
> +		/* subvolume_id should not change once set */
> +		WARN_ON_ONCE(1);
> +		return;
> +	}
> +
> +	WRITE_ONCE(ci->i_subvolume_id, subvolume_id);
> +}
> +
>  void ceph_fill_file_time(struct inode *inode, int issued,
>  			 u64 time_warp_seq, struct timespec64 *ctime,
>  			 struct timespec64 *mtime, struct timespec64 *atime)
> @@ -1076,6 +1113,7 @@ int ceph_fill_inode(struct inode *inode, struct pag=
e *locked_page,
>  	new_issued =3D ~issued & info_caps;
> =20
>  	__ceph_update_quota(ci, iinfo->max_bytes, iinfo->max_files);
> +	ceph_inode_set_subvolume(inode, iinfo->subvolume_id);
> =20
>  #ifdef CONFIG_FS_ENCRYPTION
>  	if (iinfo->fscrypt_auth_len &&
> @@ -1583,6 +1621,8 @@ int ceph_fill_trace(struct super_block *sb, struct =
ceph_mds_request *req)
>  			goto done;
>  		}
>  		if (parent_dir) {
> +			ceph_inode_set_subvolume(parent_dir,
> +						 rinfo->diri.subvolume_id);
>  			err =3D ceph_fill_inode(parent_dir, NULL, &rinfo->diri,
>  					      rinfo->dirfrag, session, -1,
>  					      &req->r_caps_reservation);
> @@ -1671,6 +1711,7 @@ int ceph_fill_trace(struct super_block *sb, struct =
ceph_mds_request *req)
>  		BUG_ON(!req->r_target_inode);
> =20
>  		in =3D req->r_target_inode;
> +		ceph_inode_set_subvolume(in, rinfo->targeti.subvolume_id);
>  		err =3D ceph_fill_inode(in, req->r_locked_page, &rinfo->targeti,
>  				NULL, session,
>  				(!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 045e06a1647d..269bd2141cdc 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -96,19 +96,19 @@ static int parse_reply_info_quota(void **p, void *end=
,
>  	return -EIO;
>  }
> =20
> -/*
> - * parse individual inode info
> - */
>  static int parse_reply_info_in(void **p, void *end,
>  			       struct ceph_mds_reply_info_in *info,
> -			       u64 features)
> +			       u64 features,
> +			       struct ceph_mds_client *mdsc)
>  {
>  	int err =3D 0;
>  	u8 struct_v =3D 0;
> +	u8 struct_compat =3D 0;
> +	u32 struct_len =3D 0;
> +
> +	info->subvolume_id =3D CEPH_SUBVOLUME_ID_NONE;
> =20
>  	if (features =3D=3D (u64)-1) {
> -		u32 struct_len;
> -		u8 struct_compat;
>  		ceph_decode_8_safe(p, end, struct_v, bad);
>  		ceph_decode_8_safe(p, end, struct_compat, bad);
>  		/* struct_v is expected to be >=3D 1. we only understand
> @@ -252,6 +252,10 @@ static int parse_reply_info_in(void **p, void *end,
>  			ceph_decode_skip_n(p, end, v8_struct_len, bad);
>  		}
> =20
> +		/* struct_v 9 added subvolume_id */
> +		if (struct_v >=3D 9)
> +			ceph_decode_64_safe(p, end, info->subvolume_id, bad);
> +
>  		*p =3D end;
>  	} else {
>  		/* legacy (unversioned) struct */
> @@ -384,12 +388,13 @@ static int parse_reply_info_lease(void **p, void *e=
nd,
>   */
>  static int parse_reply_info_trace(void **p, void *end,
>  				  struct ceph_mds_reply_info_parsed *info,
> -				  u64 features)
> +				  u64 features,
> +				  struct ceph_mds_client *mdsc)
>  {
>  	int err;
> =20
>  	if (info->head->is_dentry) {
> -		err =3D parse_reply_info_in(p, end, &info->diri, features);
> +		err =3D parse_reply_info_in(p, end, &info->diri, features, mdsc);
>  		if (err < 0)
>  			goto out_bad;
> =20
> @@ -409,7 +414,8 @@ static int parse_reply_info_trace(void **p, void *end=
,
>  	}
> =20
>  	if (info->head->is_target) {
> -		err =3D parse_reply_info_in(p, end, &info->targeti, features);
> +		err =3D parse_reply_info_in(p, end, &info->targeti, features,
> +					  mdsc);
>  		if (err < 0)
>  			goto out_bad;
>  	}
> @@ -430,7 +436,8 @@ static int parse_reply_info_trace(void **p, void *end=
,
>   */
>  static int parse_reply_info_readdir(void **p, void *end,
>  				    struct ceph_mds_request *req,
> -				    u64 features)
> +				    u64 features,
> +				    struct ceph_mds_client *mdsc)
>  {
>  	struct ceph_mds_reply_info_parsed *info =3D &req->r_reply_info;
>  	struct ceph_client *cl =3D req->r_mdsc->fsc->client;
> @@ -545,7 +552,7 @@ static int parse_reply_info_readdir(void **p, void *e=
nd,
>  		rde->name_len =3D oname.len;
> =20
>  		/* inode */
> -		err =3D parse_reply_info_in(p, end, &rde->inode, features);
> +		err =3D parse_reply_info_in(p, end, &rde->inode, features, mdsc);
>  		if (err < 0)
>  			goto out_bad;
>  		/* ceph_readdir_prepopulate() will update it */
> @@ -753,7 +760,8 @@ static int parse_reply_info_extra(void **p, void *end=
,
>  	if (op =3D=3D CEPH_MDS_OP_GETFILELOCK)
>  		return parse_reply_info_filelock(p, end, info, features);
>  	else if (op =3D=3D CEPH_MDS_OP_READDIR || op =3D=3D CEPH_MDS_OP_LSSNAP)
> -		return parse_reply_info_readdir(p, end, req, features);
> +		return parse_reply_info_readdir(p, end, req, features,
> +						req->r_mdsc);
>  	else if (op =3D=3D CEPH_MDS_OP_CREATE)
>  		return parse_reply_info_create(p, end, info, features, s);
>  	else if (op =3D=3D CEPH_MDS_OP_GETVXATTR)
> @@ -782,7 +790,8 @@ static int parse_reply_info(struct ceph_mds_session *=
s, struct ceph_msg *msg,
>  	ceph_decode_32_safe(&p, end, len, bad);
>  	if (len > 0) {
>  		ceph_decode_need(&p, end, len, bad);
> -		err =3D parse_reply_info_trace(&p, p+len, info, features);
> +		err =3D parse_reply_info_trace(&p, p + len, info, features,
> +					     s->s_mdsc);
>  		if (err < 0)
>  			goto out_bad;
>  	}
> @@ -791,7 +800,7 @@ static int parse_reply_info(struct ceph_mds_session *=
s, struct ceph_msg *msg,
>  	ceph_decode_32_safe(&p, end, len, bad);
>  	if (len > 0) {
>  		ceph_decode_need(&p, end, len, bad);
> -		err =3D parse_reply_info_extra(&p, p+len, req, features, s);
> +		err =3D parse_reply_info_extra(&p, p + len, req, features, s);
>  		if (err < 0)
>  			goto out_bad;
>  	}
> @@ -3986,6 +3995,7 @@ static void handle_reply(struct ceph_mds_session *s=
ession, struct ceph_msg *msg)
>  			goto out_err;
>  		}
>  		req->r_target_inode =3D in;
> +		ceph_inode_set_subvolume(in, rinfo->targeti.subvolume_id);
>  	}
> =20
>  	mutex_lock(&session->s_mutex);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 0428a5eaf28c..bd3690baa65c 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -118,6 +118,7 @@ struct ceph_mds_reply_info_in {
>  	u32 fscrypt_file_len;
>  	u64 rsnaps;
>  	u64 change_attr;
> +	u64 subvolume_id;
>  };
> =20
>  struct ceph_mds_reply_dir_entry {
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 29a980e22dc2..cd5f71061264 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -398,6 +398,15 @@ struct ceph_inode_info {
>  	/* quotas */
>  	u64 i_max_bytes, i_max_files;
> =20
> +	/*
> +	 * Subvolume ID this inode belongs to. CEPH_SUBVOLUME_ID_NONE (0)
> +	 * means unknown/unset, matching the FUSE client convention.
> +	 * Once set to a valid (non-zero) value, it should not change
> +	 * during the inode's lifetime.
> +	 */
> +#define CEPH_SUBVOLUME_ID_NONE 0
> +	u64 i_subvolume_id;
> +
>  	s32 i_dir_pin;
> =20
>  	struct rb_root i_fragtree;
> @@ -1069,6 +1078,7 @@ extern struct inode *ceph_get_inode(struct super_bl=
ock *sb,
>  extern struct inode *ceph_get_snapdir(struct inode *parent);
>  extern int ceph_fill_file_size(struct inode *inode, int issued,
>  			       u32 truncate_seq, u64 truncate_size, u64 size);
> +extern void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_=
id);
>  extern void ceph_fill_file_time(struct inode *inode, int issued,
>  				u64 time_warp_seq, struct timespec64 *ctime,
>  				struct timespec64 *mtime,

Looks good.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.


