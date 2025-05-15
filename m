Return-Path: <linux-fsdevel+bounces-49090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE380AB7C90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 06:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770424C1D7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 04:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2EB1CCB40;
	Thu, 15 May 2025 04:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0/TgGOp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF07E55B
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 04:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747281992; cv=none; b=oLpvy2XlcJMvq6oLT50q3DzveeNPTtuqMvIatzKgEfgj4xd7qUft1LvWoY8/hHYgQMecfdDAvBp5mACr4fSVUmYbwudVO1bPIz52wzWS+ZUgeLgZ7aRCKmGKUZR348Flz8D+pQAWRsYd4PCIOx4Y4+MCgmq7jX60tua7FOWTPzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747281992; c=relaxed/simple;
	bh=n5OSYCfox/wFSCicXOADXUM1vEXJBOwB0PpPZAJA6wE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iNAAQ1PFhg+NRGE48Josdut4HJSrv7LDvNYQs0yZjr+MskAa0VNd9J5BB/1HtmeIqzJHChDG+lJgstwEmf5U8RYW2P6LPJkWh2UX7pIlKvFii0YMPB53hxvBM3JMJEj/zO+V9j+RbbIP5Mluc73iBLmqAAdxnD8Eq6/FAa5SzYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0/TgGOp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747281987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0J45K/iFRRT3Gwux5AeqoSUQbVKEAJKYzYrLt1oWZCQ=;
	b=Z0/TgGOp+AvmxOw7cG5Ats6iaFFLawb7M293HeOkxD25BTntJuhvGPHriLdp7SctVvCZKg
	25bvJRsU7NrWPV0tXRCwI4qFSncWE5Oa+b8Nxwr4wtzj144bzn8hpg/gzkdDUF+jGt09rE
	XizPFP6BeWLB4XblkwC8n5kx8nrhHgg=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-8GDpJEOVNj6BgjVmcAhYIA-1; Thu, 15 May 2025 00:06:25 -0400
X-MC-Unique: 8GDpJEOVNj6BgjVmcAhYIA-1
X-Mimecast-MFC-AGG-ID: 8GDpJEOVNj6BgjVmcAhYIA_1747281984
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-607d4777b1dso505951eaf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 21:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747281984; x=1747886784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0J45K/iFRRT3Gwux5AeqoSUQbVKEAJKYzYrLt1oWZCQ=;
        b=CL1XGIoaIcxAi99yddJSRxy6d3ATem9ZbzsX4w4YWXn1pj/fSl/BOjANkDUG2ovF4V
         Fxz03zvvWbEOvSFnWh+6CgwK08W6ik5q0vHp76ncZTkvRl+kL1rts3+a7ZmlYmCok+aK
         Hz+rvA31Tn9aC9h3LbRonFlyC3l0stP4GR6mpfkrN5MCbTpC3b657+71SOmWqFOQzn/h
         Z9RidEEoiCkhC0VTsy4fkOB6woQsmMMz345JfdA5qnUMQBUxvl0SraLuQurltCaZZ7E3
         RAdndlzvWZfo/ztr4u9rTH/5PWy7DQYq8zwIs9Kpqe8yCffl61ZGe9V0E38eMsZQG/PV
         3EGQ==
X-Gm-Message-State: AOJu0YxU/G1FDVeJ1SEvz3hYu2jJNJYc2XrHIM74WMuZzsV/2v7qq6eG
	Njc+htiaUViIyFM7/ZEpB4zpeJejGVExSDB+RZEJ4C7LDTRHWI+VF+1/8yUA/Ia3944zkw/EWiC
	kfHTWWMeRPGYssI3gFS8LsGZWcEwi1QI/u2OH2kSBNTRk7b/iIXjQWCKUbuNzztMGjWhPTcWydj
	mTD1oerTHTGvNvoYRtI9RrUaGYKeMhv2cHTbUEoH/LiB9cLj+5
X-Gm-Gg: ASbGnct625MhIRscwkQ/sJxyrCJeNDBZCB15BSg4ELhFXlQdkZqGEXcMVaymbdbNajo
	B5vVgxDP6dM7L/PBszC3Aitqzx6yJlsjlEWnS1+L/AkriTBR2iTyyNI9RrXWy6HtcUTcRJmVWKf
	hXAiNHsybEu2cJiwIcCYBdiE4=
X-Received: by 2002:a4a:ec44:0:b0:603:f29b:85b4 with SMTP id 006d021491bc7-609df088777mr2745180eaf.0.1747281984447;
        Wed, 14 May 2025 21:06:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqgdBMnryuq7yqHoW9nDwEEchC4FIpzmCag+pikXaPOpq4DhHhbVzl0n2e/jb7xD81CvaDywTL9I4QES/gipI=
X-Received: by 2002:a4a:ec44:0:b0:603:f29b:85b4 with SMTP id
 006d021491bc7-609df088777mr2745173eaf.0.1747281984144; Wed, 14 May 2025
 21:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Allison Karlitskaya <lis@redhat.com>
Date: Thu, 15 May 2025 06:06:13 +0200
X-Gm-Features: AX0GCFu51vxwlxHphCmbzqVG2bqUcpRKDey8S07tgV_6HVlsR0hpacN27yEF4Xg
Message-ID: <CAOYeF9WQhFDe+BGW=Dp5fK8oRy5AgZ6zokVyTj1Wp4EUiYgt4w@mail.gmail.com>
Subject: Apparent mount behaviour change in 6.15
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi,

The CI in the composefs-rs project picked up an interesting issue with
the recent mount API changes in the latest 6.15-rc kernels.  I've
managed to produce a minimal reproducer.

=3D=3D> test.sh <=3D=3D
#!/bin/sh

set -eux

uname -a
umount --recursive tmp/mnt || true
rm -rf tmp/mnt tmp/new
mkdir -p tmp/mnt tmp/new tmp/new/old
touch tmp/mnt/this-is-old
touch tmp/new/this-is-new
./swapmnt tmp/new tmp/mnt
find tmp/mnt

=3D=3D> swapmnt.c <=3D=3D
// Replace [old] with a clone of [new], moving [old] to [new]/"old"

#define _GNU_SOURCE
#include <err.h>
#include <fcntl.h>
#include <linux/mount.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <unistd.h>

int
main (int argc, char **argv) {
  if (argc !=3D 3) {
    fprintf(stderr, "usage: %s [new] [old]", argv[0]);
    return 1;
  }

  const char *new =3D argv[1];
  const char *old =3D argv[2];

  int oldfd =3D syscall(SYS_open_tree, AT_FDCWD, old,
OPEN_TREE_CLONE|OPEN_TREE_CLOEXEC);
  if (oldfd =3D=3D -1)
    err(EXIT_FAILURE, "open_tree('%s', OPEN_TREE_CLONE)", old);

  int newfd =3D syscall(SYS_open_tree, AT_FDCWD, new,
OPEN_TREE_CLONE|OPEN_TREE_CLOEXEC);
  if (newfd =3D=3D -1)
    err(EXIT_FAILURE, "open_tree('%s', OPEN_TREE_CLONE)", new);

  if (syscall(SYS_move_mount, newfd, "", AT_FDCWD, old,
MOVE_MOUNT_F_EMPTY_PATH))
    err(EXIT_FAILURE, "move_mount('%s' -> '%s')", new, old);

  if (syscall(SYS_move_mount, oldfd, "", newfd, "old", MOVE_MOUNT_F_EMPTY_P=
ATH))
    err(EXIT_FAILURE, "move_mount('%s' -> (new)'%s'/old)", old, old);

  return 0;
}

On 6.14 (Fedora 42) this looks like:

[root@fedora-bls-efi-127-0-0-2-2201 tmp]# sh test.sh
+ uname -a
Linux fedora-bls-efi-127-0-0-2-2201 6.14.5-300.fc42.x86_64 #1 SMP
PREEMPT_DYNAMIC Fri May  2 14:16:46 UTC 2025 x86_64 GNU/Linux
+ umount --recursive tmp/mnt
umount: tmp/mnt: not found
+ true
+ rm -rf tmp/mnt tmp/new
+ mkdir -p tmp/mnt tmp/new tmp/new/old
+ touch tmp/mnt/this-is-old
+ touch tmp/new/this-is-new
+ ./swapmnt tmp/new tmp/mnt
+ find tmp/mnt
tmp/mnt
tmp/mnt/this-is-new
tmp/mnt/old
tmp/mnt/old/this-is-old
[root@fedora-bls-efi-127-0-0-2-2201 tmp]#

On 6.15 from yesterday (9f35e33144ae, via @kernel-vanilla/mainline
copr, on rawhide):

[root@fedora tmp]# sh test.sh
+ uname -a
Linux fedora 6.15.0-0.rc6.20250514.9f35e331.450.vanilla.fc43.x86_64 #1
SMP PREEMPT_DYNAMIC Wed May 14 04:18:35 UTC 2025 x86_64 GNU/Linux
+ umount --recursive tmp/mnt
umount: tmp/mnt: not mounted
+ true
+ rm -rf tmp/mnt tmp/new
+ mkdir -p tmp/mnt tmp/new tmp/new/old
+ touch tmp/mnt/this-is-old
+ touch tmp/new/this-is-new
+ ./swapmnt tmp/new tmp/mnt
+ find tmp/mnt
tmp/mnt
tmp/mnt/this-is-new
find: File system loop detected; =E2=80=98tmp/mnt/old=E2=80=99 is part of t=
he same
file system loop as =E2=80=98tmp/mnt=E2=80=99.
[root@fedora tmp]#

Otherwise, I gotta say I'm loving all of the new mount work this cycle!

Thanks,

lis


