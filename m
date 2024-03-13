Return-Path: <linux-fsdevel+bounces-14359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F278A87B30D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 21:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6AF286EBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 20:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B01551C4B;
	Wed, 13 Mar 2024 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6V3JRfT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DB220DDB;
	Wed, 13 Mar 2024 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363321; cv=none; b=FWztAtoYxZC80G2HiEdwP5O9xrCWIqA0YayqjWmKkzjthJgwCZuetYxXoJgUIaK87QhzuvMAtEc4Hgpqj7AB7Yb+opQ93F0Sc6ffKc0eJ/t/SYF2C1OYlBYYWJBACVDQJrnCud5gmz4ELXWZnWsTXa+Oi0uSnlacKmnJZXQJwDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363321; c=relaxed/simple;
	bh=7am2RmdCi8uwcAW+cdVcqgn1jJuzcQg4Cm0ERpymKbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpJpWyn4jWhleqD8xTJVXWgExt7lUc1Jlv7C1PI5e8KI5YWcBCrVrDCfy2+z1KATtEotcfwg4zfn5FRGiQAcqVcjd2tzEMsMtCKqYrVp49DTYVpIwKSR8PGBpmKGqh7w+j8heqgmQ2CcjmRQj9iQuoqYkc2BtrP34irknDDnBKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6V3JRfT; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-690e2d194f6so2759236d6.0;
        Wed, 13 Mar 2024 13:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710363317; x=1710968117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+EyvDQPRu7FWvAd/ZnSMUNGQDH4f/Anl2JLfApoYgE=;
        b=V6V3JRfTdRfpnqLqSDUgRQ3eKfMdWAdDQQWa/pIrYcthsWPfrT51DoczBHgsndluZt
         738IPD39dBG4JoFQlotuRZQCriZAEwNjA/6ssS+vxysfxKf8EssvVmyOS+c0f6AdVhuz
         OAodhF8o043BJZEEQKd54E9aEoiojBkOjlNZtDQEWgADxe67xrlUbgRyY6OONCVG7UWJ
         sYYhxhwy8IiWL/MjWg8VTbWAiLl3lvBmtGImhU3pXj3Y0XnhBbfvm3P2aWiEAa1vCGEu
         5aE440TYEYqyPbpghW490BmUSfQhoV0TJl5xjFYKbQk7dtZMMkKapPmSI+o64gAC4pqN
         dZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710363317; x=1710968117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+EyvDQPRu7FWvAd/ZnSMUNGQDH4f/Anl2JLfApoYgE=;
        b=ataUyXCpQ74gO3ayRubNSx7dzTEbZdLabA8IGJ4pPNkwBvMFSbfRtFGhQD43bvC0zk
         Bp+9JwK1jqmH1jNVYeWeYFoXegvtDKj9GLnzGPggu2fb7Ida3QGJ2/RUiElAw765ZLlF
         FbCx25IZ0oeNerVMnQMUtj6QWSC/nL5CaVEZRvbFszz9bA26vn84SnDnswrQd3jibakf
         mbIty6Ot+qvfI9K00OUijLcRn21kAK/6ADL7bCNypZmOdzjVHBZO/dFRJmZ5VU4O3Jwj
         58Krrw3dceKdlf5Q9YF9Gt0OT6wZrnx8q/B96s5EPGYiiKkgCu0pUQ2xKdjuKE19mrT8
         8soQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAP0uIXMHf5Zh8eZFOgr27+WugdVDlvqORRfq4O8TVcx043wgMGU5t0FeYNuWC10yp8y2sp7YJtD9zVxtG56Pj9ByieITrQhK96dv/MiMYSiFAyliyQyYocN3pdse8PhTxdwBz3qroacRsyQ==
X-Gm-Message-State: AOJu0YzOeAFWR+EcIAn5RG9J+iQrC0qJtGmf9HmzbtY2m8TJ3Yckq+Oa
	lrmlrKJf/jxIO/EjsgihOBcu+LlhKvYaA+Wvae0TP5HJqyNHMfPiKUGwk1rB6vRhAph45uU8WzQ
	trWDahmcGy/YDzu+sHXGoaMP1aRI=
X-Google-Smtp-Source: AGHT+IHTF+h1+fGos7bCc7R3HL2ZbcVNxqZnxjKMcM3sTuZvzckJskY7jWwNSZ7kwrWNGRn/OsHQlgfaefvRAH004X0=
X-Received: by 2002:a05:6214:d0e:b0:690:9a8a:855b with SMTP id
 14-20020a0562140d0e00b006909a8a855bmr1375820qvh.29.1710363317121; Wed, 13 Mar
 2024 13:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000043c5e70613882ad1@google.com>
In-Reply-To: <00000000000043c5e70613882ad1@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Mar 2024 22:55:06 +0200
Message-ID: <CAOQ4uxjtkRns4_EiradMnRUd6xAkqevTiYZZ61oVh7yDzBn_-g@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in ovl_copy_up_file
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+3abd99031b42acf367ef@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:23=E2=80=AFPM syzbot
<syzbot+3abd99031b42acf367ef@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-trackin=
g..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux=
.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1785a85918000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcaeac3f3565b0=
57a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3abd99031b42acf=
367ef
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1115ada6180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1626870a18000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/dis=
k-707081b6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinu=
x-707081b6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/I=
mage-707081b6.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+3abd99031b42acf367ef@syzkaller.appspotmail.com
>
> evm: overlay not supported
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6187 at fs/overlayfs/copy_up.c:239 ovl_copy_up_file+=
0x624/0x674 fs/overlayfs/copy_up.c:330

Miklos,

The WARN_ON that I put in ovl_verify_area() may be too harsh.
I think they can happen if lower file is changed (i_size) while file is bei=
ng
copied up after reading i_size into the copy length and this could be
the case with this syzbot reproducer that keeps mounting overlayfs
instances over same path.

Should probably demote those WARN_ON to just returning EIO?

Thanks,
Amir.

