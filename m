Return-Path: <linux-fsdevel+bounces-75799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ5hFa5vemlI6QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 21:21:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E93F2A8708
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 21:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 702403041BF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 20:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773D532AAC6;
	Wed, 28 Jan 2026 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjCpvTyM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvWGHNWo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E1332862C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769631630; cv=none; b=E5gYYaXzV5pDdiFnVm7ZaJHMVLISxXPLGU7j/9NNVrXdNfyb0+vMLJuG/Pxwr8DXmxxi0qf4ml4EnDwwtL1UEQQOW43nvSwqAmNLI50WsVS1tcsxVxwhNnVpqUUe4ILxBVIc1LV2QjJ4vqT0cPEqWTwuqId4wtthFETk+KK/eRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769631630; c=relaxed/simple;
	bh=cQhp4NTBavRL5M7vVIbsiOmyCf2bKMbXtu54XvEzlQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dGcMVx+6Ij1A8hn1EVxux6bSqFHPUv5D1Q66EiXM5cinJCg3QAA2qWmduM0VmQuiTKyAhtxmsl/EcsQm7xy/0quWhh09he+fZvYs0+0HQlR00XSFN9fKr4fN2l7m3PdQOvkrBCuV89kV/oFETgIdN9syfJL+a8VcI8RaPglEKD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RjCpvTyM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvWGHNWo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769631627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2BpxOQY18A0qNxNJaWmNereaJFQzVlpvBrrpAuc1v8=;
	b=RjCpvTyM7UTqXeqq9+z+FLTpNhZP75Xzb8GWOsWt3oPn0qnAUcCI1VcafABgc5uliB9UOb
	b3UiOpuIHVszmjHO5HYoAqhwz++wyWi5+HQRmCvxXnmskglW6POeF+Z8msqsSFWxz2QQEO
	JIau4AyiFzdU8Dyx9Bh/eDG6VGgGZR4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-bjasDQ6VMbmM8kMUkxdipQ-1; Wed, 28 Jan 2026 15:20:26 -0500
X-MC-Unique: bjasDQ6VMbmM8kMUkxdipQ-1
X-Mimecast-MFC-AGG-ID: bjasDQ6VMbmM8kMUkxdipQ_1769631626
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-794744871cdso3823067b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 12:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769631626; x=1770236426; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P2BpxOQY18A0qNxNJaWmNereaJFQzVlpvBrrpAuc1v8=;
        b=JvWGHNWo3p5S5elRVPMOkNRHMYYnnCgqbJSKBUi1jw+baIw4GkeoEkFwmMCSrRp3EG
         KtTEh31vx2ggWT0uMd0nkoiiQjyO5GHfmaQ6Hv/700QPPMti0zOx4KPrAiw5k50PkTv+
         NLpU2oWBRMeL5w/+TEqhCCvFSGkXuLeFEoOqDpgeSFjRATi3/MrCxyF+8rNxFy1zPvi6
         E4QiB9JRP7pDCaq69rcMv5G3MXspt8mslQdYpbaONuNfauZFigzk2eLHypZ2q3O9ZDQX
         XkfEoLg/wAMx5aMAoHJIDTku01O5jdxQK2iQfQfSBDwLvZIdvG2TatUSVfuR+y2g3+SM
         dCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769631626; x=1770236426;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2BpxOQY18A0qNxNJaWmNereaJFQzVlpvBrrpAuc1v8=;
        b=p+uhtTUUgu5tZiJEiIZZFrHIYvON9HoxQSy8cxw7g7okboJd91P/BNv2+s5p/TEUAV
         NoGCtJoFLMXB1SaCygXIKepTaXq4FwjQyMy6mKwfBMGN9x5vsHqcfctDINJcxn1wUQeI
         pbazRK1VqfXuZvFnrtj9Dt0uth9OfEKMihzDpz7WAA4CaraB9b8d9Coy7kx0ZzzsDtwe
         0dhy2q1oyiZVj1az+hl9jDBHUNTOz4za+GU4c9jGXUsWtnh8m7/lXipso9tdDuvUWoaQ
         RnWqZZfB8fm8OB3eYMK8gnL5gw2iNX9sQGTfPfnYznHTFI52YuWJpGPrAwVyvH0yarJz
         rH9w==
X-Forwarded-Encrypted: i=1; AJvYcCXCSMOGhdNVCLYetpko5kkBWsCawKiL+d13jNc4SSA03c4v9E12GpjH7z4/PPhxmIq97Q0lP42u8KHvZkWT@vger.kernel.org
X-Gm-Message-State: AOJu0YyhhFsfsFoBR7dkbcm8fbqZwahYPLxhjxWZWINAcUNJqExELN3G
	9xPthYm8CRC2F1LMAfsFdgxDDxXrxNttYvtSdX9ijVWGj6TmXKwvyI587BK+dd6fn6yxQ19p539
	3I16z0nHAbN5PdNmq+V8Gh9el5f0DXbEFArPDPJvZrdnQ2WXsuwpJMEwj+btgIrsnBfg=
X-Gm-Gg: AZuq6aLjnTyHJlBrp7LVo2jKl9KWcC9FoUjr92tsF0KjOPxBeH5mNRgzobyGuLrGzYJ
	cA9fp+4m5FX/t/55umHnyyDbDfZUWk7hBvBT5plIpl25j4K+opU7KMKlOQSg4PelcyX59ec0sE3
	iUSD5iyvdcl5zHzqhAglJmKWYP0gZ1tfJpWckkd7uDL3euGEGSOjaD7foFUsNAJGb2RvuWNyPIE
	jeVve7y6HSEr0yMJOM/aXgGMWUGmN6aUUk9zXAh9EY4W6xLBxAR+eOpn9300+Lf3SOGmQ/yK8iU
	KX2GYhy9dTn2P5VDG9H+ruEIERGYjOCZNlK+e4H5pYr9PRdnvL9R7IYHhiNINaF7tiNqVeIv4Xr
	tHLWZPjUgPSpEmXAcMu5Zxa+dYl9Ing84tRtMQnqP
X-Received: by 2002:a05:690c:c96:b0:794:722c:3a2f with SMTP id 00721157ae682-7947ab7f588mr49960887b3.31.1769631625739;
        Wed, 28 Jan 2026 12:20:25 -0800 (PST)
X-Received: by 2002:a05:690c:c96:b0:794:722c:3a2f with SMTP id 00721157ae682-7947ab7f588mr49960707b3.31.1769631625317;
        Wed, 28 Jan 2026 12:20:25 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794828a62f6sm15015857b3.37.2026.01.28.12.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 12:20:24 -0800 (PST)
Message-ID: <408b497e5c20549882dbe34b40adcd13b0a5df11.camel@redhat.com>
Subject: Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Patrick Donnelly <pdonnell@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, khiremat@redhat.com, 
	Pavan.Rallabhandi@ibm.com
Date: Wed, 28 Jan 2026 12:20:17 -0800
In-Reply-To: <CA+2bHPapiqj4xEobqcxmW6b1YChMLBBKaVzxdbEMw+DDZEG1NQ@mail.gmail.com>
References: <20260114195524.1025067-2-slava@dubeyko.com>
	 <CA+2bHPb66HKDZ2DX7TvzvfjW_Ym1TBeVNcPn9w_tnwytje85Nw@mail.gmail.com>
	 <CAOi1vP-G_0vPyMOyx6HvJX7VwN8_9FCe9V4Vg9zvg8gbbJNNHw@mail.gmail.com>
	 <CA+2bHPapiqj4xEobqcxmW6b1YChMLBBKaVzxdbEMw+DDZEG1NQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-75799-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E93F2A8708
X-Rspamd-Action: no action

On Wed, 2026-01-28 at 12:16 -0500, Patrick Donnelly wrote:
> On Mon, Jan 26, 2026 at 8:02=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com>=
 wrote:
> > Hi Patrick,
> >=20
> > Has your
> >=20
> >     > > I think we agreed that the "*" wildcard should have _no_ specia=
l
> >     > > meaning as a glob for fsopt->mds_namespace?
> >     >
> >     > Frankly speaking, I don't quite follow to your point. What do
> > you mean here? :)
> >=20
> >     --mds_namespace=3D* is invalid.
> >=20
> >     vs.
> >=20
> >     And mds auth cap: mds 'allow rw fsname=3D*'  IS valid.
> >=20
> > stance [1] changed?  I want to double check because I see your
> > Reviewed-by, but this patch _does_ apply the special meaning to "*" for
> > fsopt->mds_namespace by virtue of having namespace_equals() just
> > forward to ceph_namespace_match() which is used for the MDS auth cap.
> > As a result, all checks (including the one in ceph_mdsc_handle_fsmap()
> > which is responsible for filtering filesystems on mount) do the MDS
> > auth cap thing and "-o mds_namespace=3D*" would mount the filesystem th=
at
> > happens to be first on the list instead of failing with ENOENT.
> >=20
> > [1] https://lore.kernel.org/ceph-devel/CA+2bHPYqT8iMJrSDiO=3Dm-dAvmWd3j=
+co6Sq0gZ+421p8KYMEnQ@mail.gmail.com/
>=20
> Sigh, yes this is still a problem. Slava, `--mds_namespace=3D*` should
> not be treated as a glob.

OK. So, what's the modification the patch finally requires?

Thanks,
Slava.


