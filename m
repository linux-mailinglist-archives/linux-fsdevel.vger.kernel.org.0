Return-Path: <linux-fsdevel+bounces-50874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5006EAD0A21
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 01:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83EF1885C3D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4007223C4FC;
	Fri,  6 Jun 2025 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="WpuUmer3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7823C506
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 23:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749251040; cv=none; b=BJHH2sVXO9AVKQt+KMJ6o/biG1KSi1Zy6Fayn6a+U0WMMQarY96qVADy1sen7UliPCYIbiKuN3547qb/l6AL37BzO+12owwaGlnY0fcv8Kh4xLQM1TJQBtOh2x70IzH0QlVDPRy1Zynahza5I6kV5toEj1KmCui78WDCQzjWWF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749251040; c=relaxed/simple;
	bh=uZpZCkykzxv8QTaVF7jXVf1FBFZe6xEcW8XfkFIBC0Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JHGyTV2aA94qS0bAxi0ECgZkuR1Bmr2lJjO9p+yvXnFJlCM33A06hiZ/0Pal8Z4FvjZ3H8+ufCu+VfXUHkiEJCcrvFa4ogehbg416XrxdozSGMpqeL2mBQfuDTN5yyRaDqTD62OUsSuc1AcRa35vh3x/EclYUQGuidMwKKBw72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=WpuUmer3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22e16234307so23169865ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 16:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1749251038; x=1749855838; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yyIYtKhtRUkQ/Xh6w92n8CqURWS4JLP5swxGsv9ToYc=;
        b=WpuUmer3qMGW3eQ1MTGwddcfU+fGoeMmQTAaDhceGExddw6QEje9EwzISsdCMmTmDX
         P3eUSnpAyEKAv/pLxLZrAWkztKjWxlKiampQpbsuYLS+YpcigUuzGc3O+gWsLK93aR8s
         osuZN9RUOgkiXsB9S1d0tpSuXGxrOOsJX589A7Pw1goAr4tN6oHVGAEeC5EWcNxv4EfI
         VHepaXyS1MTC+TWyZoHwy9TJkB+AB1XM9IYWC10FpaEfFOy5ClH0bJmHglHBjBjwriQ7
         wkTzVjatlXX1om9KkI647NvebFwuG+OPB5p0IeqLWO/7+3rm8zySDaBOvP6wQmAA6SF1
         +KXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749251038; x=1749855838;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yyIYtKhtRUkQ/Xh6w92n8CqURWS4JLP5swxGsv9ToYc=;
        b=khGZ1Qs5W93A5gQ60vrUHWYQZNudgdCumRHi7NCiLmtnn3bTiwVibXPluD1eJcfU0X
         +OP0wtvL8x4pmZUmnKwrQUoQt7cgydyJvo6oJLVazcqXMqttk/RFSB7IG70RQbJC2ard
         NZiIwynnaWFbzjE0jRnnPLB+XSK3sFo0UiK2AhIO9dWml8h9193o1FRB7RoD7yif3irg
         xstWhRRB8OS489ulyIT72Jc6DorgBfO7EoFbOKZq51Nenv3kLfOTNUSBp24fEru1m8XJ
         HJDfSi5IAqgqHie5vyf9eGcWxZx6tuEVHWApnxMqV4SklhrG/LFOF8ivYAUXxdNrl6rZ
         A3Lg==
X-Forwarded-Encrypted: i=1; AJvYcCV/rVjqSVGZPAiZiI7uM+Abx/IMCRcv8FZaSFP+myhOrLmdc5yn1bh7S1o2dwwWJUZjL/EQ1BUu2US6zA+G@vger.kernel.org
X-Gm-Message-State: AOJu0YzX4iOtM/LMjJhPfhNUNJbzFd/AVSslYB2iSWrBpUicFpJkLvri
	QSxsCM4ti81WrsJW5lXsgGmI0Ie1Rio/J7MPgsPdn7y0FkKizoe0My/XZm/MwvaO7f4=
X-Gm-Gg: ASbGncvlHyjf0GlNqMxBr914wcazthxmNHyaQMCwTHIX5z1WsSS6AG+uSbiGC+vJaPX
	OauHUU79cy+QKX7o31ukL1MYBvGgfMQu67GpIqUXIqPVuMqn/j9e5BeQkOJIWd7VeBqrUQctGlB
	+pCwWZm6kv84PDOLEP/AtfupjKDguvuOfb7nq3ZnnglN2SFsalW+/AlkG9nAGGq6NUU1bTcd+GM
	XpdMbXp13eA3c3cA68mRPJuR/Pa8bE6PDrI+EnCFnxWdnTlBY+raEY4aTnsdlzekzb/UW8sxU9A
	vF8Q+SQSKQFzy/Bchezaq6IDcAEeyweqYG9K1qvfZiUrhuIUVX5p+Tuh4woOICBsCG6wpHN/R5V
	oeWIsMctDWmzix9myqdOOI9m+ZJ3czx8=
X-Google-Smtp-Source: AGHT+IEtK7/PRsz11Nh9SNNwm0ev2NQH/ZDdNKGeARr2dtSo5jiB2PESuhponizHFwLPSrjLtkaNxA==
X-Received: by 2002:a17:902:dac3:b0:235:278c:7d06 with SMTP id d9443c01a7336-236020639a2mr76598655ad.8.1749251037623;
        Fri, 06 Jun 2025 16:03:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:77a3:4e60:32de:3fd? ([2600:1700:6476:1430:77a3:4e60:32de:3fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034059besm17432815ad.174.2025.06.06.16.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 16:03:56 -0700 (PDT)
Message-ID: <192faa3d0713fce1c1f20479ed164a6936473919.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: fix not erasing deleted b-tree node issue
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Slava.Dubeyko@ibm.com, linux-fsdevel@vger.kernel.org, 
	Johannes.Thumshirn@wdc.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Date: Fri, 06 Jun 2025 16:03:55 -0700
In-Reply-To: <20250430001211.1912533-1-slava@dubeyko.com>
References: <20250430001211.1912533-1-slava@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Christian,

Could you please pick up the patch?

Thanks,
Slava.

On Tue, 2025-04-29 at 17:12 -0700, Viacheslav Dubeyko wrote:
> The generic/001 test of xfstests suite fails and corrupts
> the HFS volume:
>=20
> sudo ./check generic/001
> FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- hfs
> PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 hfsplus-testing-00=
01 6.15.0-rc2+ #3 SMP
> PREEMPT_DYNAMIC Fri Apr 25 17:13:00 PDT 2>
> MKFS_OPTIONS=C2=A0 -- /dev/loop51
> MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
>=20
> generic/001 32s ... _check_generic_filesystem: filesystem on
> /dev/loop50 is inconsistent
> (see /home/slavad/XFSTESTS-2/xfstests-dev/results//generic/001.full
> for details)
>=20
> Ran: generic/001
> Failures: generic/001
> Failed 1 of 1 tests
>=20
> fsck.hfs -d -n ./test-image.bin
> ** ./test-image.bin (NO WRITE)
> 	Using cacheBlockSize=3D32K cacheTotalBlock=3D1024
> cacheSize=3D32768K.
> =C2=A0=C2=A0 Executing fsck_hfs (version 540.1-Linux).
> ** Checking HFS volume.
> =C2=A0=C2=A0 The volume name is untitled
> ** Checking extents overflow file.
> ** Checking catalog file.
> =C2=A0=C2=A0 Unused node is not erased (node =3D 2)
> =C2=A0=C2=A0 Unused node is not erased (node =3D 4)
> <skipped>
> =C2=A0=C2=A0 Unused node is not erased (node =3D 253)
> =C2=A0=C2=A0 Unused node is not erased (node =3D 254)
> =C2=A0=C2=A0 Unused node is not erased (node =3D 255)
> =C2=A0=C2=A0 Unused node is not erased (node =3D 256)
> ** Checking catalog hierarchy.
> ** Checking volume bitmap.
> ** Checking volume information.
> =C2=A0=C2=A0 Verify Status: VIStat =3D 0x0000, ABTStat =3D 0x0000 EBTStat=
 =3D 0x0000
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CBTStat =3D 0x0004 CatStat =3D 0x00000000
> ** The volume untitled was found corrupt and needs to be repaired.
> 	volume type is HFS
> 	primary MDB is at block 2 0x02
> 	alternate MDB is at block 20971518 0x13ffffe
> 	primary VHB is at block 0 0x00
> 	alternate VHB is at block 0 0x00
> 	sector size =3D 512 0x200
> 	VolumeObject flags =3D 0x19
> 	total sectors for volume =3D 20971520 0x1400000
> 	total sectors for embedded volume =3D 0 0x00
>=20
> This patch adds logic of clearing the deleted b-tree node.
>=20
> sudo ./check generic/001
> FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- hfs
> PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 hfsplus-testing-00=
01 6.15.0-rc2+ #3 SMP
> PREEMPT_DYNAMIC Fri Apr 25 17:13:00 PDT 2025
> MKFS_OPTIONS=C2=A0 -- /dev/loop51
> MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
>=20
> generic/001 9s ...=C2=A0 32s
> Ran: generic/001
> Passed all 1 tests
>=20
> fsck.hfs -d -n ./test-image.bin
> ** ./test-image.bin (NO WRITE)
> 	Using cacheBlockSize=3D32K cacheTotalBlock=3D1024
> cacheSize=3D32768K.
> =C2=A0=C2=A0 Executing fsck_hfs (version 540.1-Linux).
> ** Checking HFS volume.
> =C2=A0=C2=A0 The volume name is untitled
> ** Checking extents overflow file.
> ** Checking catalog file.
> ** Checking catalog hierarchy.
> ** Checking volume bitmap.
> ** Checking volume information.
> ** The volume untitled appears to be OK.
>=20
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> ---
> =C2=A0fs/hfs/bnode.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index cb823a8a6ba9..50ed4c855364 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -482,6 +482,7 @@ void hfs_bnode_put(struct hfs_bnode *node)
> =C2=A0		if (test_bit(HFS_BNODE_DELETED, &node->flags)) {
> =C2=A0			hfs_bnode_unhash(node);
> =C2=A0			spin_unlock(&tree->hash_lock);
> +			hfs_bnode_clear(node, 0, tree->node_size);
> =C2=A0			hfs_bmap_free(node);
> =C2=A0			hfs_bnode_free(node);
> =C2=A0			return;

