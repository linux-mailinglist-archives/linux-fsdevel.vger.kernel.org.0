Return-Path: <linux-fsdevel+bounces-54401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32744AFF4BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 00:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D38C1C84328
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 22:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B66124679D;
	Wed,  9 Jul 2025 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPT5pmnV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FDF218821;
	Wed,  9 Jul 2025 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100326; cv=none; b=CBvf5/dWighMgPySmPNI8TxB3LGdvRaNID3HMSQcU9RQ16CqvhfGF/dRrDuGm/4RqpdBg2EKzfHIul7hG6Hbf8iESkYFXVA3npQdwQ6+/t4ZBSPR53EF76lDn1EWHvjZu8mOFz5AUeACLCDF6uhfFgi5cCYfkAiWcrZKoLA9FeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100326; c=relaxed/simple;
	bh=1McGgLdm606Z00KEINY5kt1JkZk/Tuk74qM5f1qRaKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3hANrzdpnyWIBsq/NOHJ2TGGHGegV3Is1ArKT7qR3a8ZazJgGHOvk8ZUkt2LgZbyaVwfRmoZmBI+WeBgJIqZ7YII+LmpQIQ2g0VHGeCAkNmohuVeTmMzyNyPKFBJIZvVb4S4WrBPhBTpm0/lPBLVMF5DjSiZhch5EJiNilNxMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPT5pmnV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32b3b250621so2827831fa.2;
        Wed, 09 Jul 2025 15:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752100323; x=1752705123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0vCCNe1kaK9nYgw+uNh0fKsxB1qET3iJlussJtaUx4=;
        b=QPT5pmnVDtrDKGyUkeJZtwQZM3igtVNQyef8/2Z1LkADW2RPQgy77bQd4IQUnzxeeb
         wkInlVEPl3d0dabY7a6BV767AKj5qhbQD6dN4re+NkBnONczoVL74e+VarvO48VBhcKr
         peMFQMSyovAjNUSZnfFV7cZ3YdpQgsZyEUykvR0/TnAs7IuQfm8l/IFTNRt8AWaBvgZV
         rpNEW/l0UYwtDt9lhM73HQjZGPi4gAfGumQ084C0Ouo6X6vJIOPxNBFrhipgduYdpWVa
         Kj0vExZaWNShNCtJsRxciImX/yxI61vcnIiwqh/KR1SGT4ovaw99ixeD0HemQc/ezcx4
         3aOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752100323; x=1752705123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0vCCNe1kaK9nYgw+uNh0fKsxB1qET3iJlussJtaUx4=;
        b=cImBXuqBnik6nn6ZwOpV633klfwWAgzsptVEJo8KE5Hq91Of7sW8F4+SnTrmHMRHai
         5smrqiUBTnaBfDhKAvqOOAzfdbu9YOH1VYSfEfN2zNfZyAwSAOuRy6DjVrNWWyWwuE9W
         UyqNGRlfXb/7GTRO0TdCF/npNxMMK//6l4AkzJhP56rHQPmSomb8T4w0iLYNyIUNQKtK
         eqKIdvMb5QioaR2DGKtd6A/HK+R5My4c7UrUDb7q7Gsb0LnDZbXsjK1IjqBNuDnjoW8A
         xxNleGnaK1BORmBvoBgqZY/B7pdG0W0MAC3W0wRJJjZIUbbdV4/5GEVTi1I65Zz/eSh1
         AavA==
X-Forwarded-Encrypted: i=1; AJvYcCWQaIa2vRyHM2VS06cAIMCC6U6Db2a8i5aJsvyXEvH4KQuPseI7iGyxUdAzL+a/07V0Iq1k/5/And2bdVE=@vger.kernel.org, AJvYcCX7kq3CY6Lmg71hhtIgZG46tEFiwlAupX6Gwd8AQT0R0nKbLCUCh7WbNruF/rnb8oNsZnndltrgAu10BcFg@vger.kernel.org, AJvYcCXTsbQUBEcO8siKK5cXtWs2E6L+zJPI0bE9+TNVec1U3+X5YRPp/E5l3lCTGAZ/lzYrE0ANRlhQL1ZSNhx5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5sj8D5a4/VrXJnq3h5zXbqfSpr3zg4XnnDpRF7vwnMZ+OG9EK
	S7IT4TJCoLIPB3xZBmoCHp/F9/AKA3ZdqdVvxa8IE8eEgyI9TVOan4+DnTbZvoIiBKKGjIX5eTk
	vzrEXJhzVbcbKk4TEFKoCxrSiXDX1DJs=
X-Gm-Gg: ASbGncvCth3dfcpXFr2AiMohEkMovqyGDejQ9V1J4beFvMhYfJ5e6NX0BhA0rZ5qaJg
	5XXw/m21DZVTLqqix6iEtg80pKdDAOfq8Qs6g4MMLcnu8RBptiU6iB/G36gJQ5ecKQQJmmx1mz+
	x7I1Q9I8qe5W2M2vUIvJ9KLr/CWlXO5EcXuUXxlCxAKfaizm3pPkixfKmIKM4OZ9Ix5yEVDds8A
	oIm
X-Google-Smtp-Source: AGHT+IFbXOlgT4ROOR21178XUwTpOomY4dhNIM2pkgyDfppMb4TnPhF1NlbJSd0RbHs++YsgJzW/IrfJpyvZLzydKWc=
X-Received: by 2002:a2e:a917:0:b0:32a:7dd7:ff47 with SMTP id
 38308e7fff4ca-32f485853d4mr15492511fa.30.1752100322919; Wed, 09 Jul 2025
 15:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <686d5a9f.050a0220.1ffab7.0015.GAE@google.com> <xrpmf6yj32iirfaumpbal6qxph7mkmgwtra7p4hpbvzozlp4zr@2bzl4p5ejgfj>
In-Reply-To: <xrpmf6yj32iirfaumpbal6qxph7mkmgwtra7p4hpbvzozlp4zr@2bzl4p5ejgfj>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 10 Jul 2025 07:31:46 +0900
X-Gm-Features: Ac12FXw4eCeHGhJ1kXZFIcDPr8OZWRZX-aSMKBRl9njt_so4dWb4RcvDCVUSRDA
Message-ID: <CAKFNMomH8Ur3gOvps_vdbs3BU4C6UZBL7tDYxjPUG_29_Bo-8w@mail.gmail.com>
Subject: Re: [syzbot] [nilfs?] kernel BUG in may_open (2)
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, mjguzik@gmail.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, ntfs3@lists.linux.dev, 
	Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 5:30=E2=80=AFPM Jan Kara wrote:
>
> Hi!
>
> On Tue 08-07-25 10:51:27, syzbot wrote:
> > syzbot found the following issue on:
> >
> > HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D107e728c580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D72aa0474e3c=
3b9ac
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D895c23f6917da=
440ed0d
> > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6=
049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D113055825=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10952bd4580=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/605b3edeb031/d=
isk-d7b8f8e2.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/a3cb6f3ea4a9/vmli=
nux-d7b8f8e2.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/cd9e0c6a9926=
/bzImage-d7b8f8e2.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/2a7ab270=
a8da/mount_0.gz
> >
> > The issue was bisected to:
> >
> > commit af153bb63a336a7ca0d9c8ef4ca98119c5020030
> > Author: Mateusz Guzik <mjguzik@gmail.com>
> > Date:   Sun Feb 9 18:55:21 2025 +0000
> >
> >     vfs: catch invalid modes in may_open()
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17f94a8c=
580000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D14054a8c=
580000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10054a8c580=
000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com
> > Fixes: af153bb63a33 ("vfs: catch invalid modes in may_open()")
> >
> > VFS_BUG_ON_INODE(!IS_ANON_FILE(inode)) encountered for inode ffff888072=
4735b8
>
> FWIW the reproducer just mounts a filesystem image and opens a file there
> which crashes because the inode type is invalid. Which suggests there's
> insufficient validation of inode metadata (in particular the inode mode)
> being loaded from the disk... There are reproducers in the syzbot dashboa=
rd
> for nilfs2, ntfs3, isofs, jfs. I'll take care of isofs, added other
> filesystem maintainers to CC.
>
>                                                                 Honza

Thank you for taking the initiative!
I'll deal with the nilfs2 issue.

For convenience, the correspondence between the reproducers and file
systems listed in the syzbot dashboard at the moment is as follows:

Detection time      Filesystem
2025/07/08 13:03    iso9660
2025/07/08 12:34    ntfs3
2025/07/08 12:04    nilfs2
2025/07/08 04:06    nilfs2
2025/07/08 02:39    ntfs3
2025/07/08 01:41    jfs
2025/07/08 01:56    nilfs2
2025/07/08 01:21    nilfs2
2025/07/08 01:57    iso9660
2025/07/08 02:15    jfs
2025/07/08 01:34    ntfs3

Thanks,
Ryusuke Konishi

