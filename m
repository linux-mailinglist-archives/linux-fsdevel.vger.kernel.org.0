Return-Path: <linux-fsdevel+bounces-47362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739BCA9C889
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 14:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF72165C60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 12:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED538248868;
	Fri, 25 Apr 2025 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="X4M6m3Wj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C06247296
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745582625; cv=none; b=tisaaJgTi4MD6Xj61zg6aDhaZN+r9xVYIq/o3go1bqQ4jH30utCHmldaWuJghr250QMLG+JcT8YGrvPXUFi/03cbodPmIfQivgdoBXmcZSrvsqSc8NUZ4WmArlhlQeBRn1n5FuW5TfXIU+GREJBT3ZJmO6fLcxRrcpmG5AWuUPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745582625; c=relaxed/simple;
	bh=+yCdIbqh0JDT/YnzT3SbvfcEJYjw99NBFeUPTICH+54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lkWedG8hqUpI7/eWC3xml4RsGYnhu7VZplnjBERoJEqspCNpuaN0NuZ5f510sF57cSedsLU1kGCsXiK5vqHp+2ZGv5NzbYXw3X7xhINMb6G9RgELGc+GtkqCRWqYe+a37C4o86DYVkQuk+67JJS0FbR6La2wGiOdAl+Tp+Gpgu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=X4M6m3Wj; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EBF553F2B6
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 12:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1745582620;
	bh=Q+wrgajh/EZ4gUyKC9kPcfGizfJbkaKPpvglylqfVSY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=X4M6m3Wj0scrQvk5eo2zu/wiwHw93+I9jhg5dXSbB6aNG4EMcKN0kTADmxL6a9SWS
	 fI6IrxL0EaGNm9yoT8wBORpkuoJln3NhgMeAUNKVYjz070ZHKJgDgscNDh+hr62m6A
	 sJKnBw7PEALEbY/uuSEW9KD2P3h+/Gi6rwPuTZC7TyyvhlXHSdNCdfLpDjq0DwbGvU
	 1SugXC8W9wzwk+uIvTlvz3FhpvaGn1uh38aoIXrhi2bbRc1BDq4ANJlzUmtbqRYgvR
	 GwS2CEmXbvUYRgNgU32p/hO/0NGWKedjflyhZgoCXD29njwmEYuuuofGOhimQYrsQ0
	 1RTWwDepeoegA==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac3d175fe71so146942966b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 05:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745582620; x=1746187420;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+wrgajh/EZ4gUyKC9kPcfGizfJbkaKPpvglylqfVSY=;
        b=oBOPdA/4Gc5Fd7OGdQYxvBxhPNs72i12c3Sv2CUiIlGjQCn86AJtFb+Y+ACRG9yhOE
         T8jri7/17SiTfrwsrTKr3LUp/zg3gnCmmrNlEXLjGoIEpsJHO18K8bvtMYOCiMXtj57K
         idx0izrlpQPVq5CiQLWjEtJmVJ/fdzY8SCIAjGk2wTZf+f8h0QFvPZPYGTVBvBkh5kz7
         6WjZbVkLWyseqXSv4uqm9HHpOkT0AZ1UQIjneUdtWWk/yjVnXK6RRH5iNIgE4+b4xGZn
         qBmtUDQQGYRfe9xGO5KWyxJoXjaN00NKUcEQX6jUmjfmLNjFWdNmrV9zl/F0h/9Wt+yc
         BHCw==
X-Gm-Message-State: AOJu0YzNt6puQjGqtezX7zN5KSC9AcVemVyaDmUYgnqNmKe4noZsta7i
	j0NlJ37NlGWLOuDlH2cxQzqlz/gXxtcaWRINSRZvh9HiTCCqV0YyR8mADy16M8cTbZzkkRj5aP7
	AXsJRtK4JW7+RYbOdsxBffX0n4eXMUy8UAdwEJUM/L1WkiZld+nqn5PHibbZjwzTWGsgsU+wZkr
	9kJQE=
X-Gm-Gg: ASbGncuf1d6URc/DoomZTo5qukarcs7aG+pQEDL7dSV6gAbt9+Sxk5CCA0Cyy/kRsRw
	KDBLjH0JIs2/ZY2on8i+iYBrY9u33TBbYDlgHlhxFVn22MgjQulTAAXAwU/YWiujhr+Z5fWM7XI
	ogv3VoAOK1UxkjY/H1gJu3l1hMNQ39T5B6LFcs3p42ye3dCkiRaKsSDp1UuLFvO+yFjkADHHbPA
	2rDx6B8TWZ4PsuIc3Kq7f318FpZpjlXbRKWN+fRbCYlzG762waLNT6pEPyKDfC0NxSw6zr/TcVx
	iZj4x9YrQ1AHL9P67am74rTmi32gY3LY
X-Received: by 2002:a17:907:a0d:b0:abf:6f87:c720 with SMTP id a640c23a62f3a-ace7115a87fmr195519266b.29.1745582620208;
        Fri, 25 Apr 2025 05:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKbF1Rn25qJdjXUkhhr1KfCDu1pbaFTkw3E4SCmhjeAMJEUmJXi3Zne8iULBFBMSe+K9yUEQ==
X-Received: by 2002:a17:907:a0d:b0:abf:6f87:c720 with SMTP id a640c23a62f3a-ace7115a87fmr195482566b.29.1745582616129;
        Fri, 25 Apr 2025 05:03:36 -0700 (PDT)
Received: from deep-thought.gnur.de ([95.89.205.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6eda63aesm123108366b.164.2025.04.25.05.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 05:03:35 -0700 (PDT)
Message-ID: <e1ee6aba07c367b9518fe3fab1dd71c418e3446a.camel@canonical.com>
Subject: Re: [PATCH v2 3/3] coredump: hand a pidfd to the usermode coredump
 helper
From: Benjamin Drung <benjamin.drung@canonical.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Luca
 Boccassi <luca.boccassi@gmail.com>, Lennart Poettering
 <lennart@poettering.net>, Daan De Meyer	 <daan.j.demeyer@gmail.com>, Mike
 Yuan <me@yhndnzj.com>, Zbigniew =?UTF-8?Q?J=C4=99drzejewski-Szmek?=	
 <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org
Date: Fri, 25 Apr 2025 14:03:34 +0200
In-Reply-To: <20250425-eskapaden-regnen-4534af2aef11@brauner>
References: <20250414-work-coredump-v2-0-685bf231f828@kernel.org>
	 <20250414-work-coredump-v2-3-685bf231f828@kernel.org>
	 <ee1263a1bcb7510f2ec7a4c34e5c64b3a1d21d7a.camel@canonical.com>
	 <20250425-eskapaden-regnen-4534af2aef11@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-25 at 13:57 +0200, Christian Brauner wrote:
> On Fri, Apr 25, 2025 at 01:31:56PM +0200, Benjamin Drung wrote:
> > Hi,
> >=20
> > On Mon, 2025-04-14 at 15:55 +0200, Christian Brauner wrote:
> > > Give userspace a way to instruct the kernel to install a pidfd into t=
he
> > > usermode helper process. This makes coredump handling a lot more
> > > reliable for userspace. In parallel with this commit we already have
> > > systemd adding support for this in [1].
> > >=20
> > > We create a pidfs file for the coredumping process when we process th=
e
> > > corename pattern. When the usermode helper process is forked we then
> > > install the pidfs file as file descriptor three into the usermode
> > > helpers file descriptor table so it's available to the exec'd program=
.
> > >=20
> > > Since usermode helpers are either children of the system_unbound_wq
> > > workqueue or kthreadd we know that the file descriptor table is empty
> > > and can thus always use three as the file descriptor number.
> > >=20
> > > Note, that we'll install a pidfd for the thread-group leader even if =
a
> > > subthread is calling do_coredump(). We know that task linkage hasn't
> > > been removed due to delay_group_leader() and even if this @current is=
n't
> > > the actual thread-group leader we know that the thread-group leader
> > > cannot be reaped until @current has exited.
> > >=20
> > > Link: https://github.com/systemd/systemd/pull/37125 [1]
> > > Tested-by: Luca Boccassi <luca.boccassi@gmail.com>
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  fs/coredump.c            | 59 ++++++++++++++++++++++++++++++++++++++=
++++++----
> > >  include/linux/coredump.h |  1 +
> > >  2 files changed, 56 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/fs/coredump.c b/fs/coredump.c
> > > index 9da592aa8f16..403be0ff780e 100644
> > > --- a/fs/coredump.c
> > > +++ b/fs/coredump.c
> > > @@ -43,6 +43,9 @@
> > >  #include <linux/timekeeping.h>
> > >  #include <linux/sysctl.h>
> > >  #include <linux/elf.h>
> > > +#include <linux/pidfs.h>
> > > +#include <uapi/linux/pidfd.h>
> > > +#include <linux/vfsdebug.h>
> > > =20
> > >  #include <linux/uaccess.h>
> > >  #include <asm/mmu_context.h>
> > > @@ -60,6 +63,12 @@ static void free_vma_snapshot(struct coredump_para=
ms *cprm);
> > >  #define CORE_FILE_NOTE_SIZE_DEFAULT (4*1024*1024)
> > >  /* Define a reasonable max cap */
> > >  #define CORE_FILE_NOTE_SIZE_MAX (16*1024*1024)
> > > +/*
> > > + * File descriptor number for the pidfd for the thread-group leader =
of
> > > + * the coredumping task installed into the usermode helper's file
> > > + * descriptor table.
> > > + */
> > > +#define COREDUMP_PIDFD_NUMBER 3
> > > =20
> > >  static int core_uses_pid;
> > >  static unsigned int core_pipe_limit;
> > > @@ -339,6 +348,27 @@ static int format_corename(struct core_name *cn,=
 struct coredump_params *cprm,
> > >  			case 'C':
> > >  				err =3D cn_printf(cn, "%d", cprm->cpu);
> > >  				break;
> > > +			/* pidfd number */
> > > +			case 'F': {
> > > +				/*
> > > +				 * Installing a pidfd only makes sense if
> > > +				 * we actually spawn a usermode helper.
> > > +				 */
> > > +				if (!ispipe)
> > > +					break;
> > > +
> > > +				/*
> > > +				 * Note that we'll install a pidfd for the
> > > +				 * thread-group leader. We know that task
> > > +				 * linkage hasn't been removed yet and even if
> > > +				 * this @current isn't the actual thread-group
> > > +				 * leader we know that the thread-group leader
> > > +				 * cannot be reaped until @current has exited.
> > > +				 */
> > > +				cprm->pid =3D task_tgid(current);
> > > +				err =3D cn_printf(cn, "%d", COREDUMP_PIDFD_NUMBER);
> > > +				break;
> > > +			}
> > >  			default:
> > >  				break;
> > >  			}
> > >=20
> >=20
> > I tried this change with Apport: I took the Ubuntu mainline kernel buil=
d
> > https://kernel.ubuntu.com/mainline/daily/2025-04-24/ (that refers to
> > mainline commit e54f9b0410347c49b7ffdd495578811e70d7a407) and applied
> > these three patches on top. Then I modified Apport to take the
> > additional `-F%F` and tested that on Ubuntu 25.04 (plucky). The result
> > is the coredump failed as long as there was `-F%F` on
>=20
> I have no clue what -F%F is and whether that leading -F is something
> specific to Apport but the specifier is %F not -F%F. For example:
>=20
>         > cat /proc/sys/kernel/core_pattern
>         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h %F
>=20
> And note that this requires the pipe logic to be used, aka "|" needs to
> be specified. Without it this doesn't make sense.

Apport takes short option parameters. They match the kernel template
specifiers. The failing pattern:

$ cat /proc/sys/kernel/core_pattern=20
|/usr/share/apport/apport -p%p -s%s -c%c -d%d -P%P -u%u -g%g -F%F -- %E

Once I drop %F Apport is called without issues:

$ cat /proc/sys/kernel/core_pattern=20
|/usr/share/apport/apport -p%p -s%s -c%c -d%d -P%P -u%u -g%g -- %E

--=20
Benjamin Drung
Debian & Ubuntu Developer

