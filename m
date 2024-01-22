Return-Path: <linux-fsdevel+bounces-8406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2FB835EE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 11:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D391C24AD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 10:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5301439FF2;
	Mon, 22 Jan 2024 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIcm4MVm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C500E38FBC
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917676; cv=none; b=ufwDpiDGb5pUmw2bD6gthna8um4a0pI8PDOISr7Y6lXcAa+90t2SNsRfne61MwXHqSegpZlT7/HHNTwIjGz020tHleRDCNRrPfAaF33svxOijwB1O7VkwbH2yvKjY1AQxUyn1uNzz0EHTG9VIWuyXTUugv5IzaUUVoDvOxZk8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917676; c=relaxed/simple;
	bh=jf4yKSzlqqbyUEc6YGETM2QKbR10sPDe2DBRx+D5MRg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KMXfyVF30wpzr624POUfAwvNBE4C9MA85L3HS6Ex1XYNPRMoBel9Ju7X3Rh+H+K3/UiJOIpwqN+Rx00irlrjeHhCgKjVphIUzrdlZ9DdzNOQ4zEz5e1J8AbieOUVIG6xzFat8S0mCRDb8x8uqiwlrvIqrNfAfM3RdUvuC1o6NTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIcm4MVm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705917673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jYyhFaRmFtpWxmu2ZytE1Jd2nh2JmIcnia5u3w5cavE=;
	b=GIcm4MVmMthVbsJlxsiSAEgSo5JU4gwWKBtIfktGZqkF6OHH9Y92WqdNmO8WkJuXGuBYkE
	mq0Mgg08wTvdvUFq51EOKOfPzr9XH1b+IwfmHJpRd5E3bBliiMvdnirqtwsJHF7D5MXHHr
	wH5oUEYK5VGFnKJlqNVESRK08j8wQd8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-7cLhrqgcPX-4TDkh4Wvj0g-1; Mon, 22 Jan 2024 05:01:12 -0500
X-MC-Unique: 7cLhrqgcPX-4TDkh4Wvj0g-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50edf4f4767so2397493e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 02:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705917670; x=1706522470;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYyhFaRmFtpWxmu2ZytE1Jd2nh2JmIcnia5u3w5cavE=;
        b=GMpAysjdsItZ9wA/8wKDndxMhxu+Nqv6mR/UCDhmjdv+UqSz5QHUxt8O1GYHNFUUML
         eUjCWbaX+UZbGVaRvNWKF7BbMUVFWJjz4M/VKTqDOLUuKx/CEPUovMHgcpcvTTALBsvU
         XcsT5n2V/cKhzu5PhvWLsLpTjA+sOG14UuKw78D9gUqmY48VIHzZ4g/vOr3bxFqyHsB3
         +chnt0hRleKI0+5bORHmk5d0p6TvjHnDk2rTzjMwP5UjImjXldpWS64UrSldi8hHPOTb
         phdaIaVbzSHTx++uDy0LACc/7ypT2h68JQ/J17iLQGqLn7aZEcsQ6Z9iQC1DFHqUKpkv
         W1XA==
X-Gm-Message-State: AOJu0Yz8tgImptTi/NG+GgVWoDfUnjqNEQSyUTkXGOjR+HGkhxbELCZx
	Zmx5cs0OHDw0iIBUqpvSJeJmx68NdFyaVHU7KGMIUlnzJkFOd6dpgXSuWk5V4wxzYvFu8h+yS56
	uFsBP+Acl9Jqoq9GQGHhjmrHmC0eIv8mD6PvXxeNyaHAYLjhEmMabST1aTE1sJSM=
X-Received: by 2002:a2e:9f44:0:b0:2cd:f896:fb0d with SMTP id v4-20020a2e9f44000000b002cdf896fb0dmr784363ljk.33.1705917670620;
        Mon, 22 Jan 2024 02:01:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMcOQaGW+jKYJE4kpzjr0tA1+2WlJYdfFWcNTFIW3o21pi7ekxsqSJRcxOTu5efaPgtRwvcQ==
X-Received: by 2002:a2e:9f44:0:b0:2cd:f896:fb0d with SMTP id v4-20020a2e9f44000000b002cdf896fb0dmr784356ljk.33.1705917670235;
        Mon, 22 Jan 2024 02:01:10 -0800 (PST)
Received: from [172.31.0.10] (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id x7-20020a2e8387000000b002ce0198f8ecsm967144ljg.17.2024.01.22.02.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:01:09 -0800 (PST)
Message-ID: <ce5d443e5cd2088e00d433780302cce9623d738c.camel@redhat.com>
Subject: Re: [PATCH v2] ovl: require xwhiteout feature flag on layer roots
From: Alexander Larsson <alexl@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 22 Jan 2024 11:01:09 +0100
In-Reply-To: <CAOQ4uxgBuhx_ae=+R1LrEkkSctf9MdyZzW=WWsHD6J2ZKSJgww@mail.gmail.com>
References: <20240119101454.532809-1-mszeredi@redhat.com>
	 <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
	 <5ee3a210f8f4fc89cb750b3d1a378a0ff0187c9f.camel@redhat.com>
	 <CAOQ4uxiob0t4YDpEZ4urfro=NrXF+FH_Bvt9DbD1cHbJAWf88A@mail.gmail.com>
	 <CAJfpeguFY8KX9kXPBgz5imVTV4A0R+aqS_SRiwdoPXPqR_B_xg@mail.gmail.com>
	 <CAOQ4uxgBuhx_ae=+R1LrEkkSctf9MdyZzW=WWsHD6J2ZKSJgww@mail.gmail.com>
Autocrypt: addr=alexl@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-01-20 at 12:32 +0200, Amir Goldstein wrote:
> On Fri, Jan 19, 2024 at 10:30=E2=80=AFPM Miklos Szeredi <miklos@szeredi.h=
u>
> wrote:
> >=20
> > On Fri, 19 Jan 2024 at 20:06, Amir Goldstein <amir73il@gmail.com>
> > wrote:
> >=20
> > > How about checking xwhiteouts xattrs along with impure and
> > > origin xattrs in ovl_get_inode()?
> > >=20
>=20
> That was not a very good suggestion on my part.
> ovl_get_inode() only checks impure xattr on upper dir and origin
> xattr
> on non-merge non-multi lower dir.
>=20
> If we change the location of xwhiteout xattr check, it should be in
> ovl_lookup_single() next to checking opaque xattr, which makes
> me think - hey, why don't we overload opaque xattr, just like we
> did with metacopy xattr?
>=20
> An overlay.opaque xattr with empty string means "may have xwhiteouts"
> and that is backward compatible, because ovl_is_opaquedir() checks
> for xattr of length 1.
>=20
> The only extra getxattr() needed would be for the d->last case...
>=20
> > > Then there will be no overhead in readdir and no need for
> > > marking the layer root?
> > >=20
> > > Miklos, would that be acceptable?
> >=20
> > It's certainly a good idea, but doesn't really address my worry.=C2=A0
> > The
> > minor performance impact is not what bothers me most.=C2=A0 It's the
> > fact
> > that in the common case the result of these calls are discarded.
> > That's just plain ugly, IMO.
>=20
> ...so the question boils down to, whether you find it too ugly
> to always getxattr(opaque) on lookup of the last lower layer and
> whether you find the overloading of opaque xattr too hacky?
>=20
> As a precedent, we *always* check metacopy xattr in last lower layer
> to check for error conditions, even if user did not opt-in to
> metacopy
> at all, while we could just as easily have ignored it.
>=20
> >=20
> > My preferred alternative would be a mount option.=C2=A0 Amir, Alex,
> > would
> > you both be okay with that?
> >=20
>=20
> I think I had suggested that escaped private xattrs would also
> require
> an opt-in mount option, but Alex explained that the users mounting
> the
> overlay are not always aware of the fact that the layers were
> composed
> this way, but I admit that I do not remember all the exact details.
>=20
> Alex, do I remember correctly that the overlay instance where
> xwhiteouts
> needs to be checked does NOT necessarily have a lowerdata layers?
> The composefs instance with lowerdata layers is the one exposing the
> (escaped) xwhiteout entries as xwhiteouts. Is that correct?
>=20
> Is there even a use case for xwhiteouts NOT inside another lower
> overlayfs?

No. Strictly speaking regular whiteouts are always preferable to
xwhiteouts (as they work for both user and system ovl mounts and are
supported by older kernels and existing software, etc). The only place
where xwhiteouts are useful is when we need to escape them to put
inside an overlayfs mount.

The best way to think about the composefs usecase is:=C2=A0

  Suppose you had a pre-existing system image that someone installed a
multi layer container image in. This means that somewhere inside this
image is a set of lowerdirs, and one of them may have a traditional
whiteout. Now we want to create an overlayfs mount that when used,
works just like the above image would work, including when you mount
the sub-overlayfs mounts from the container image lowerdirs.=C2=A0


Fallout of this:

The composefs overlay lowerdir will need to contain escaped xwhiteouts,
so that the mount will have unescaped xwhiteouts. These escaped
whiteouts can be anywhere, even in a "single layer" overlayfs. But the
unescaped xwhiteouts will never be in a lowermost lowerdir.

In the composefs case we will be using lowerdata for the outer
overlayfs, but the actual unescaped xwhiteouts in the container image
lowerdirs don't need to have a lowerdata involved at all.

The container mount will be done by pre-existing software (say docker)
that isn't aware that we converted the regular whiteouts to xwhiteouts,
so having to use a mount option is not ideal (would require docker
changes).

> If we limit the check for xwhiteouts only to nested overlayfs, then
> maybe
> Miklos will care less about an extra getxattr on lookup?
>=20
> Attached patch implements both xwhiteout and opaque checks during
> lookup - we can later choose only one of them to keep.

Seems like you attached the wrong patch, but I will comment on the
other patch you sent to the list.

> Note that is changes the optimization to per-dentry, not per-layer,
> so in the common case (no layers have xwhiteouts) xwhiteouts will not
> be checked, but if xwhiteouts exist in any lower layer in the stack,
> then
> xwhiteouts will be checked in all the layers of the merged dir (*).
>=20
> (*) still need to optimize away lookup of xwhiteouts in upperdir.
>=20
> Let me know what you think.
>=20
> Thanks,
> Amir.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a benighted bohemian waffle chef on the wrong side of the law.
She's=20
an enchanted junkie safe cracker from the wrong side of the tracks.
They=20
fight crime!=20


