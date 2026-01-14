Return-Path: <linux-fsdevel+bounces-73654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFB8D1DF25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 11:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB8FC30451D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 10:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF73938B7C9;
	Wed, 14 Jan 2026 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0GWDWjw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7010A38A9C4
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385552; cv=none; b=Fusibj8sgpZfTWSKgGD79lImLpcdxBMV4T+reJT7d9qW29r7f6XQKEF4tjjZXpMrNToMgiNYrrvm6gb6LIDHreq0vkwVx873l5O//uYyol5p4HVyLIHISL5u4cA+LPmFSrgx7BW6a27u+iYOxRZci46Cae3eY9tJ4T6ma1gj6Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385552; c=relaxed/simple;
	bh=1Va9HwjDwq32lvAhriwO6nDAQNuts6JUwi90oTJOako=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFloXZHjYtVlbcj+EAjmkZr8Vd45+qNFo+FxnrqRh5oPQoJYif4JvKOFcwts/am1hSEEZvdHdixY3TEmt6eJ4AULiSiXe1IA3cptoerrJzo4xhoToxEePzGzLPwn2QGNgDVXZg1/ohKPc7nbP2qB5QXIz4eeDwI27Qjms+rHSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0GWDWjw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so13629142a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 02:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768385549; x=1768990349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+HzLLUUKSv2yBuAl8H2ycC6BaMQEOnY1RWDw/qbh/E=;
        b=D0GWDWjwU7OJ/4/VVBouMgukCNGKVkzv7ClFB4kBC6nXsk+XPr792LtaLB60kz63Sk
         fSVwCAe2eOzhkpJFz1Lh0gvg9zsqdkbADBqKpAblP8uoq9nhd64r4ZGdN06Ig9slrnHw
         VuSBf21exwtBRmMfVbtZ331eoCJXdOXg9krgTGWucPa8/Mq2IIbIhRQWx1jOk2Bfrw/+
         HDlsJ+9uLt11bVNQmyXFA4pVgI432q9HCPZvWqaPhBb206bV6Ely0uPU4l1WDY9JFMWA
         5c6t5GyxSDSDDLwVDIM2tXVJdqw9QwwdjveSzKCKkFY81GK4qG4G8X4ZpVV5+A5AV7QN
         WwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768385549; x=1768990349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u+HzLLUUKSv2yBuAl8H2ycC6BaMQEOnY1RWDw/qbh/E=;
        b=Wl/ZuhDzEesej/bj51q4DP/RXfQs+nL7I2daWlGQc98NoIzZJhKYnU8hh8sHgAFkvz
         bio3l0B8yaoHlyEdi0r2JzUiLaX9qHBA+rUyGf5pO+Eji+V9VEX9ABahV6vrtlJCxO8n
         7p4m7Xx8pPFjutF7T6fyBbP0cSB+WXCrryEjU/Z26uhaQhCgeAkfnKO3KhIvZLhXrnuF
         Ap1thn7/pH89GAMySgEmA74n2wTsPcYzq5YnOnEcz9P2GczfbSKTgnSSYprqrOjpET/z
         8+f5xq3fkeDNg8J885oRtLHYNsdpylrVPcZ8LPNJQaqu84DBOLVlbfCRBcEAQUpGke0/
         r2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1k4Rhd49LV2RyWU0rfDrJnqXU6rJhG1ypAwGDTsDZgg2C99zbTe88L9mYh6eWchd29Tx490jkGdcbUlxF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9FbvVZJ3ZO93+fxuMPQjk5juGj64zXyRuD9CPwwKn++AnHIEk
	IIZNd/hL8k38bzfixpOlIOoY4Oae3FtMEKrJlN0oKmqy6OQtJ9ArgXY0fuWtxvzRYrQdMR9e035
	VYIyL4nUY4w1WmmMYbhjJv2k7kB4vZOI=
X-Gm-Gg: AY/fxX4A1bBm9WqO2AOPn5nz6yKi82ipRz6H3i+Q2p8VFwdJV15mhLq9Vr+e+viy87X
	kj7p/ckZ3YyEGiiMNMgNa/OEkKBzhJSorzHIyuRLqWcS+90WwjP9qao/floPhrkuMoGYeEYezBL
	gSgipEcL6PJGTbS/y9g23b8DCxRvrVvVUXrWUlIa8Y7E5oDHboK0i7NThRBbBJtVdoazsyvnb+Z
	5paus0IuLdZW1FtfPIV1+UipPlAA10eAeG40hhbcmvCveuAyNtusJNnEb82piSYNcg6qzr7bGpb
	lkMSOOgZz1wvVyjecf98PG4AsTvDOw==
X-Received: by 2002:a05:6402:40c7:b0:64b:5c4e:e695 with SMTP id
 4fb4d7f45d1cf-653ec45d439mr1545967a12.29.1768385548495; Wed, 14 Jan 2026
 02:12:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-1-e6a319e25d57@igalia.com>
 <20260114061028.GF15551@frogsfrogsfrogs> <20260114062424.GA10805@lst.de>
In-Reply-To: <20260114062424.GA10805@lst.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Jan 2026 11:12:17 +0100
X-Gm-Features: AZwV_QiTt3Px0boynH_rJNetCq_d0KXad0zWlO9wTho0QtDj_6Kcir8fJr34DLs
Message-ID: <CAOQ4uxjUKnD3-PHW5fOiTCeFVEvLkbVuviLAQc7tsKrN36Rm+A@mail.gmail.com>
Subject: Re: [PATCH 1/3] exportfs: Rename get_uuid() to get_disk_uuid()
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 7:24=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Tue, Jan 13, 2026 at 10:10:28PM -0800, Darrick J. Wong wrote:
> > On Wed, Jan 14, 2026 at 01:31:41AM -0300, Andr=C3=A9 Almeida wrote:
> > > To make clear which UUID is being returned, rename get_uuid() to
> > > get_disk_uuid(). Expand the function documentation to note that this
> > > function can be also used for filesystem that supports cloned devices
> > > that might have different UUIDs for userspace tools, while having the
> > > same UUID for internal usage.
> >
> > I'm not sure what a "disk uuid" is -- XFS can store two of them in the
> > ondisk superblock: the admin-modifiable one that blkid reports, and the
> > secret one that's stamped in all the metadata and cannot change.
>
> It isn't.  Totally independent of the rest of the discussion, the
> get_uuid exportfs operation is not useful for anything but the original
> pNFS block layout.  Which is actually pretty broken and should be slowly
> phased out.
>
> > IIRC XFS only shares the user-visible UUID, but they're both from the
> > disk.   Also I'm not sure what a non-disk filesystem is supposed to
> > provide here?
>
> Yeah.
>

OK. I agree that "disk uuid" is not the best name, but there is a concept
here, which is a uuid that helps to identify the domain of the file handle.

In the context of overlayfs index and "origin" xattr, this is exactly what =
is
needed - to validate that the object's copy up source is reliable for
the generation of a unique overlayfs object id.

The domain of the file handles is invariant to brtfs clones/snapshots.
Specifically, for btrfs, file handles contain an id of the snapshot,
so the domain of btrfs file handles is logically the uuid of the root fs.

TBH, I am not sure if the file handle domain is invariant to XFS admin
change of uuid. How likely it is to get an identical file handles for two
different objects, with XFS fs which have diverged by an LVM clone?
I think it's quite likely.

Naming is hard - we could maybe use get_domain_uuid() and document
what it means.

Whether or not we should repurpose the existing get_uuid() I don't
know - that depends whether pNFS expects the same UUID from an
"xfs clone" as overlayfs would.

Thanks,
Amir.

