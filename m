Return-Path: <linux-fsdevel+bounces-77167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIy+Ct50j2kpRAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 20:00:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C48E713913D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 20:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10D713018F3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 19:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F0E2E401;
	Fri, 13 Feb 2026 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LToKbEbi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSmi0Qyf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2126F35972
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771009240; cv=none; b=CqsPLbrd0QMICuBcHqvOPyzG9XbpSADup4u/L2l2CZ3OAHL0OkvC8mdpEtP7m9h61SexqNNFUCHFC5ZfwHEwc7HzrKxRFnwWuhvp+7+stlBDRGEWotMigGDl7JHcHD5sBnn6UB7fXInP3yBt+nfZjcvI2PEJUTiqDG1/xtPR/nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771009240; c=relaxed/simple;
	bh=ONBwyQn5va1xbAtHtgoC5yGtb+S3ojsM6kXRDLgQ1Ek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=asoanpqigXvW4iKiNAtij1Y5jtQ9fwdV4obzcuvoIc3pXpSehkbg09KwP8QBc7TVb2QQZiF6ssYES35IgoGGe3bO989/TjjVhGGjEBlFGbJKoAKw7vS1kMJMoBYrQWKD86shqOK5rhtG/cQj8LyN2tkPGv2XMS4HAEBFOZAv5B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LToKbEbi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSmi0Qyf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771009237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7fDH2pAmkBoWhhlSNG0knE2qMaQGN7FqBQLjXzJEJI=;
	b=LToKbEbiBAnQ91MpJrfJfvSywhtYg4KZj3oZj3Zt1kxdJmu9RPwvpYmiKStOR2fqgGfUTy
	Tc5ZaxtivoyiooJcG+NsN9rpRTwAtBAbjJmwou7Vq2Rj5DoacDBUPjR7XWj6HlIKAY38oa
	kcmFumidUVHLcNWir8tsgkIY3SLTApI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-MKfXT_z7NziM_0wTuO_6JQ-1; Fri, 13 Feb 2026 14:00:36 -0500
X-MC-Unique: MKfXT_z7NziM_0wTuO_6JQ-1
X-Mimecast-MFC-AGG-ID: MKfXT_z7NziM_0wTuO_6JQ_1771009235
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79620564c62so23188427b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 11:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771009235; x=1771614035; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P7fDH2pAmkBoWhhlSNG0knE2qMaQGN7FqBQLjXzJEJI=;
        b=JSmi0QyfLOq5vQp6i1Bfw7XWB+yulJWwA4R9K9eEmRvwlGxelKTpjQruzoGz20Hs6H
         QqXqA7p2B0L/0uWC8L2IghutGiA2DDhgidRUB+Srj4Zq2INOP5Oo/ZsATQGtg+5ZlE4u
         dBgpAx4/18vimyjv2zDHrHg6twT32S60j51uT5ZN/aWPXCWnFAV7aBGiWRMhKXFqqk9h
         z3ew36gxPhZVgRrZnQbFK0vj4RCMcHHQiu21iwGtIiyxujr0e1JpRlSDl5FtH7SgwFvQ
         8BmNBCjKbJvK7bVVhzzC74xE3SpMX1NGx8XRs6dpq+WA1hfzUx8nvArq6vSpYrPNHjfX
         PiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771009235; x=1771614035;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7fDH2pAmkBoWhhlSNG0knE2qMaQGN7FqBQLjXzJEJI=;
        b=a2b/2dJUq4cmCKWHHWkKfYPOAHC0lp4xKhllSJB3aWRobYx/sBzEs9nupB+fBptJRX
         0UARXzrKJehOOW2G+NixIOVCvIUL1lnhKVIAAblgWUfuoOa+4kwYf7LOHnhY3EeekVJb
         pFBnGaq7zJ3FURHymTFYY1GPdCEKNDYAb47Lwfcv24dyzqwzUFfmTJIoxzi+FIZDo4Cj
         s7kfR7zjh89MjQC4pDBp1iD8FkLjigmYsJQDKSjdxDV018I2JnlWjWq93vGRDnJYQ2+y
         JgFwzDha2k9dtwTbY5CuwdVuV00dyUEs7DPcaTR6fR4nfhutzIgpNDEayMSWB5xJDYIh
         iEsw==
X-Forwarded-Encrypted: i=1; AJvYcCVHMNNjSeTD9MZL4JSYzII65u0riPEXyZbyw0qSUyxaDQluM4pu4N/OxRXrkpCoEqHDp0Zzktzbq6tEY+xJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzYdMqgp6BO3o9kUL6znvUrPZGA1ffYzh23h04M/6QH5jYjGJHF
	e8HY+h1d996mxokI+J4gLwxFP8dK5bFieRE5s7pXHwr8FbNKXAQ1QoMs9PENvMt9JQ0SWQ41frA
	61bheu+Z9EyhIImJ6DAB13XITHbsA0dlVyVEzBdomCYrQRO4g/wbJw3G2tT07rTZ9SxU=
X-Gm-Gg: AZuq6aJSe/0IXJGjGQPWALfBrQYFlgGhLud+fUoiZgVoV0Ms6SSHOqCjXQ8hNXkZFDQ
	PIjLwiufyDRUTmipeGUlnFDSZqPUpY8TOcfQSA8mmcVbW8zDqTaWnTqm2KsAws4YapEsh+tXSEw
	+XYoMdAJqnI2hGFe0Cgjq5KWvNRTPqvH2PXSULNmYQPg80NuGsXLkkLldkrf8KUrxJu1uJHtEz2
	MItDq7EkDO4tG1hUBKXLcsLGQgEqjyyIEXTgO94sO+kZb/w+5f+zuDBV8b+Owvg3/8LVdvBWp5m
	qDNgoCfAdRHkYWm7CJ+JZl6Q5u96Zt22Nprcm+lVhtrkxmz8bAwNCccykF642RZBCZ5MlSKBFbY
	xEVdCSgadKCm8ViXn9l6RhIIwy/1m4t5UBj12qNzAN4qWBJOfkNZu
X-Received: by 2002:a05:690e:d83:b0:64a:ced2:2752 with SMTP id 956f58d0204a3-64c197a3e71mr2252256d50.20.1771009235332;
        Fri, 13 Feb 2026 11:00:35 -0800 (PST)
X-Received: by 2002:a05:690e:d83:b0:64a:ced2:2752 with SMTP id 956f58d0204a3-64c197a3e71mr2252206d50.20.1771009234655;
        Fri, 13 Feb 2026 11:00:34 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64afc95c8bfsm7692053d50.14.2026.02.13.11.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:00:33 -0800 (PST)
Message-ID: <ac9de2ac9ae274484c4010b39fc6365957d6ae10.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v6 1/3] ceph: handle InodeStat v8 versioned
 field in reply parsing
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Fri, 13 Feb 2026 11:00:31 -0800
In-Reply-To: <20260210090626.1835644-2-amarkuze@redhat.com>
References: <20260210090626.1835644-1-amarkuze@redhat.com>
	 <20260210090626.1835644-2-amarkuze@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77167-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C48E713913D
X-Rspamd-Action: no action

On Tue, 2026-02-10 at 09:06 +0000, Alex Markuze wrote:
> Add forward-compatible handling for the new versioned field introduced
> in InodeStat v8. This patch only skips the field without using it,
> preparing for future protocol extensions.
>=20
> The v8 encoding adds a versioned sub-structure that needs to be properly
> decoded and skipped to maintain compatibility with newer MDS versions.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/mds_client.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index c45bd19d4b1c..045e06a1647d 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -232,6 +232,26 @@ static int parse_reply_info_in(void **p, void *end,
>  						      info->fscrypt_file_len, bad);
>  			}
>  		}
> +
> +		/*
> +		 * InodeStat encoding versions:
> +		 *   v1-v7: various fields added over time
> +		 *   v8: added optmetadata (versioned sub-structure containing
> +		 *       optional inode metadata like charmap for case-insensitive
> +		 *       filesystems). The kernel client doesn't support
> +		 *       case-insensitive lookups, so we skip this field.
> +		 *   v9: added subvolume_id (parsed below)
> +		 */
> +		if (struct_v >=3D 8) {
> +			u32 v8_struct_len;
> +
> +			/* skip optmetadata versioned sub-structure */
> +			ceph_decode_skip_8(p, end, bad);  /* struct_v */
> +			ceph_decode_skip_8(p, end, bad);  /* struct_compat */
> +			ceph_decode_32_safe(p, end, v8_struct_len, bad);
> +			ceph_decode_skip_n(p, end, v8_struct_len, bad);
> +		}
> +
>  		*p =3D end;
>  	} else {
>  		/* legacy (unversioned) struct */

Looks good.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.


