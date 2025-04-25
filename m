Return-Path: <linux-fsdevel+bounces-47356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A02FBA9C7AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 13:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441954E29EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 11:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F9224502E;
	Fri, 25 Apr 2025 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AkdcAz13"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59E24468A
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580730; cv=none; b=hx8xyINtHa8f9YXjkIPckclB7/XDIf8/fwmoVbjg7y0hfkdSu43i56YpZVxZlSdsRju5M70fEOUS0seyGnF+w88OmqtWFT/NCbt00UbE0M8BqeXyTyyIAZnDlFDYcl8FzHaF+iBULPPLQAswNjMxja8ucQDulo5WRSr2n/t2nLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580730; c=relaxed/simple;
	bh=GCpyiPt28bAiyP957AszKhnajuTF6p42u0eS2mcBsPs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RbpqqdNkVeDe+YVI9kbfmOmFy0HucOoZ+MJNVw9Ucko80sXoCcjdQBQCuiInH5r+oyqwDUPBIA09hCJS6t9GYMBjfzytYVGLYWGjkXD+5ZRSZRwdoKnDW1ViijI8R0vxUAV/VRMRuv2R+FF7K8zfbl+elh0kwV/aqxQKfFRkTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AkdcAz13; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 43DF23F277
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 11:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1745580720;
	bh=OPZfkZPQfeDRMDg000gmFj0paz2e73LM64yzf/OD1VY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=AkdcAz13Z1BukA7woGCcOnTxrBqBBVjH48QNDoLTU9ueqhfl7sJ8OJ2Fz4cu2xNxq
	 ScHWUsVwA9I4DXZd8KbX6xO0qIb4cJmq+TgvkhzyKOe3zhIkTQNeSdq+nkkQz9MYXx
	 QfB/ykZLyqzq9N4Shiu95ROFIzey+pdEo8xkuxDIfoiA0DGot/WjKbmrEe3jJ3b9pk
	 watCe8voM7UBSy75fFsnK4HPPA/xURzsSt1mzeM0EG7M1sOsUqoOxz4NFHQpkXPlgR
	 HiALP6UvzdTHYZd5wIsOmBddLuozDuA0mtDk9hQY7Eanun4F4SlsfDfnajc9g9npbH
	 oEgv2oqsfXbkA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac25852291cso185022066b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 04:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745580720; x=1746185520;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPZfkZPQfeDRMDg000gmFj0paz2e73LM64yzf/OD1VY=;
        b=VF4E/EjA59hyC8zG6GjqcdU0re69DcPfDXN/9c6NvN7Spo7nIIV0AqIsbWx5mWxvtR
         iPwPj38RsA8GxrcZ5i5/Yr+u80MORpDK8TuKZeZV2cDbtdsG7mNKHWGas7B/i6fC+Q4w
         82645kb5OiNZeKpLehvraokk3OUFWs3wgTQKJfkav95NnWNOjzFOOWltUlYctq+s2KQI
         4Gac8Dwraq63UxRM6BY2voE4dOMnudYJUjDSjnFOurcNL3y/3JfFUH7kqqDyJbSi9s7W
         KKSLm8ELrgVcmz15Q7XcZKPxNdRD943bqx3W6uSkUU3PqS2/MlTKTqIjuS6lIPJEwxc+
         HtFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWovOPjviUtLIqaoJEWUhG4mirINa2jDEOsTRUs4ctCjQLOhkJW29e8oGvXN05IwIpgb4qGFxEk5Sc+RA/Y@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmrFS7f+9crD7tpihcj0tEe8KOTvVVP9YvfkncPY4aAxyXRiO
	H1moHWuP293CN32OSu6BcxcaYzOUuOAXSIefUc21Mhlh6xVzBfqz9fG6haecfy7xafNBYSX3uLn
	hj1P3JQVoFrK936ICFOi6zlEDmoVktB1bQcAJBAyjDTT5GE1+HGVXD8Au/pVluGmQr0smtodQZ3
	+1VO0=
X-Gm-Gg: ASbGnctQ2q03AZX/E/362FaeLCOXqyzvASoM8dawajvGypJUTx/gHzdo5yRttomhU9y
	5U7ZGovMkSdDQVw1FzCFdw4VlC6EKjU6ZkHymdcTMP82vvLk++udNgp1qFBAUQ3GiyS5xNX1IHt
	BQK1RKORLR1QlSCoZH8NViQ38S07JfIHtKglYVPwZuL6mcraXJ8DvzF1Sl8dNy+6tWZUQsQDJEC
	9rb1aLF2CcZYJp8HM4PSNzmPJCCAwwc5iEFpkHN6kigS+2x/WL73GaEwVCOtrkAaw+P0oFXMq8H
	62mVpOWu41DUU5WXIOy3osXfJyGuPt+y
X-Received: by 2002:a17:907:3ea3:b0:ac1:ecb5:7207 with SMTP id a640c23a62f3a-ace7111e569mr178481566b.29.1745580719721;
        Fri, 25 Apr 2025 04:31:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCekybV1mHlYsp3NsMWbAvi9HQzJHEy9lx0bW9hT/pbvfkBEQ/uNDOfxsIMgTXkh3X+7Tqng==
X-Received: by 2002:a17:907:3ea3:b0:ac1:ecb5:7207 with SMTP id a640c23a62f3a-ace7111e569mr178478566b.29.1745580719257;
        Fri, 25 Apr 2025 04:31:59 -0700 (PDT)
Received: from deep-thought.gnur.de ([95.89.205.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e5087e4sm124035966b.73.2025.04.25.04.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 04:31:58 -0700 (PDT)
Message-ID: <ee1263a1bcb7510f2ec7a4c34e5c64b3a1d21d7a.camel@canonical.com>
Subject: Re: [PATCH v2 3/3] coredump: hand a pidfd to the usermode coredump
 helper
From: Benjamin Drung <benjamin.drung@canonical.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Luca Boccassi
 <luca.boccassi@gmail.com>,  Lennart Poettering <lennart@poettering.net>,
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Zbigniew =?UTF-8?Q?J=C4=99drzejewski-Szmek?=	 <zbyszek@in.waw.pl>,
 linux-kernel@vger.kernel.org
Date: Fri, 25 Apr 2025 13:31:56 +0200
In-Reply-To: <20250414-work-coredump-v2-3-685bf231f828@kernel.org>
References: <20250414-work-coredump-v2-0-685bf231f828@kernel.org>
	 <20250414-work-coredump-v2-3-685bf231f828@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Mon, 2025-04-14 at 15:55 +0200, Christian Brauner wrote:
> Give userspace a way to instruct the kernel to install a pidfd into the
> usermode helper process. This makes coredump handling a lot more
> reliable for userspace. In parallel with this commit we already have
> systemd adding support for this in [1].
>=20
> We create a pidfs file for the coredumping process when we process the
> corename pattern. When the usermode helper process is forked we then
> install the pidfs file as file descriptor three into the usermode
> helpers file descriptor table so it's available to the exec'd program.
>=20
> Since usermode helpers are either children of the system_unbound_wq
> workqueue or kthreadd we know that the file descriptor table is empty
> and can thus always use three as the file descriptor number.
>=20
> Note, that we'll install a pidfd for the thread-group leader even if a
> subthread is calling do_coredump(). We know that task linkage hasn't
> been removed due to delay_group_leader() and even if this @current isn't
> the actual thread-group leader we know that the thread-group leader
> cannot be reaped until @current has exited.
>=20
> Link: https://github.com/systemd/systemd/pull/37125 [1]
> Tested-by: Luca Boccassi <luca.boccassi@gmail.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/coredump.c            | 59 ++++++++++++++++++++++++++++++++++++++++++=
++----
>  include/linux/coredump.h |  1 +
>  2 files changed, 56 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 9da592aa8f16..403be0ff780e 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -43,6 +43,9 @@
>  #include <linux/timekeeping.h>
>  #include <linux/sysctl.h>
>  #include <linux/elf.h>
> +#include <linux/pidfs.h>
> +#include <uapi/linux/pidfd.h>
> +#include <linux/vfsdebug.h>
> =20
>  #include <linux/uaccess.h>
>  #include <asm/mmu_context.h>
> @@ -60,6 +63,12 @@ static void free_vma_snapshot(struct coredump_params *=
cprm);
>  #define CORE_FILE_NOTE_SIZE_DEFAULT (4*1024*1024)
>  /* Define a reasonable max cap */
>  #define CORE_FILE_NOTE_SIZE_MAX (16*1024*1024)
> +/*
> + * File descriptor number for the pidfd for the thread-group leader of
> + * the coredumping task installed into the usermode helper's file
> + * descriptor table.
> + */
> +#define COREDUMP_PIDFD_NUMBER 3
> =20
>  static int core_uses_pid;
>  static unsigned int core_pipe_limit;
> @@ -339,6 +348,27 @@ static int format_corename(struct core_name *cn, str=
uct coredump_params *cprm,
>  			case 'C':
>  				err =3D cn_printf(cn, "%d", cprm->cpu);
>  				break;
> +			/* pidfd number */
> +			case 'F': {
> +				/*
> +				 * Installing a pidfd only makes sense if
> +				 * we actually spawn a usermode helper.
> +				 */
> +				if (!ispipe)
> +					break;
> +
> +				/*
> +				 * Note that we'll install a pidfd for the
> +				 * thread-group leader. We know that task
> +				 * linkage hasn't been removed yet and even if
> +				 * this @current isn't the actual thread-group
> +				 * leader we know that the thread-group leader
> +				 * cannot be reaped until @current has exited.
> +				 */
> +				cprm->pid =3D task_tgid(current);
> +				err =3D cn_printf(cn, "%d", COREDUMP_PIDFD_NUMBER);
> +				break;
> +			}
>  			default:
>  				break;
>  			}
>=20

I tried this change with Apport: I took the Ubuntu mainline kernel build
https://kernel.ubuntu.com/mainline/daily/2025-04-24/ (that refers to
mainline commit e54f9b0410347c49b7ffdd495578811e70d7a407) and applied
these three patches on top. Then I modified Apport to take the
additional `-F%F` and tested that on Ubuntu 25.04 (plucky). The result
is the coredump failed as long as there was `-F%F` on
/proc/sys/kernel/core_pattern:

```
coredump: 7392(divide-by-zero): |/usr/share/apport/apport pipe failed
```

Did I do something wrong? Do I miss additional patches?

--=20
Benjamin Drung
Debian & Ubuntu Developer

