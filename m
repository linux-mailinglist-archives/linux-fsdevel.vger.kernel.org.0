Return-Path: <linux-fsdevel+bounces-40061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAE5A1BC9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319AA188F712
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB3E224B01;
	Fri, 24 Jan 2025 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAWGp/1a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC551CCEEC;
	Fri, 24 Jan 2025 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745662; cv=none; b=p3ErCv6UlpRenLW8aIK/GrWZfzsM2akFqptaaXcDhuSaLzXkD8Lm6/jmrab+mRUbQrsK2MvCCWMSvhhTnIC/oRUkzK2jZ0B1hj/uYLd8SNB3xSY+yL1AFwcuGafdRRzPXLUFsLxS0OosuOjo3xltG/t+BAvoWM0lYaD/aAp+36Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745662; c=relaxed/simple;
	bh=PXrJs9ZPNIEquEYhRhDNDhbsr5oSKmZUVYbDQcYYsTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DG69UiqvGJ/zTYvfsxCMEKbB6EbA7g1jNK6VHJjz5szk1fpw745xU5DSHRCkj+wC5sUv6hv5WTjCDkbWixwHD9/dp6iKpVHdsnp6BqU737H9AgfmWZfg644+aUh/pVGPhqssc5DE1qNLc5W3aWxNky70dT4aSxbT862ac3GhFt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAWGp/1a; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aab925654d9so448722066b.2;
        Fri, 24 Jan 2025 11:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737745658; x=1738350458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M64ccCiSMLIZYqvDwKn2KQG8TzxywkOKAzy05Y8MZaw=;
        b=FAWGp/1aLDCHa5FxSvDu+g350bbKTX5P62ur4VwZrrTBgGHaPybmvEuKJa2QJNBFC+
         8yODhlNgOB6Moc1NY4iNybalQSMCMaPqZ9LLojg7Kewgth2Wa0XUk0XB8WxWNJL5nqrg
         gVuOK63TqFE5I/aagdfpVvyDYN/3cTsU+mm3e0olw7S1F1HzDv7quNP59km+Ug900iBg
         2MxDj+EofGfUir5nHhtbp4SU33Mqtxatsy7sOPn6G0Li3Ft2EzAnMg4N8xUJSz+sA0r8
         BuGVmOdDCca+RiSzoGADL69qzR+Z1EyXeyepMeUsdJK5djKou/OUiDm7PDugwsrpRUs7
         IOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737745658; x=1738350458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M64ccCiSMLIZYqvDwKn2KQG8TzxywkOKAzy05Y8MZaw=;
        b=L/HrfKUrwELWE7e17Ma3BdE90Trxl+FfAGdEQoA4D9fZvT2eFUMKw29as3iVJlHbZx
         t8bl16/ofl2IkXe5uc7Sqi0FmZyu9X6ogE7KhuPjSj12cPLaDVGgh8RWKkR1ew4Bj8ba
         aosmj2oWWgTl1yxUWPXjmcLzv1g02ousqBVRUIosRtXDtEPC+kszSV4y0CUrFoe3QilJ
         eltkAhiHPeoYCcPRzs1yo7XYwpBWQCEdOkU8ZmxgMs1gr5pJD0IcEMfX1bfkaHK0M3O9
         NRuJAZ+XYB91K6Sr/njfMzcGyqdmXKMhvc2j6O8cFTPmfvfwOYRDKINq31bclSAUFtJQ
         HVIg==
X-Forwarded-Encrypted: i=1; AJvYcCVHv4VKwjPLWWFaHaUD4UAnBmRsgRiJ5/Td2V/Wa6X0/xd6ePHH8NCc5vpfhHKvpM2+mxG1Yaw+Fo8G@vger.kernel.org, AJvYcCVewf/VBJvTgQttiOWldqEUZvQ8WT9sXN6QEnhn7QgSj7/PZLi9u6rfDJk3Fk7PkarK4Cw=@vger.kernel.org, AJvYcCWCfz8TNeK+g4jE6od0B+mHEJBl25lxx6KPdFESTh4BN6Ow6hHqNMoq4iufe6g6NeY03dd5AGmT@vger.kernel.org, AJvYcCWWI/Do2T1GpXskzhdceuM+iQyAhLktaTLIG8kFzlYFE/HIbz9U+74eEknvvy6hjIIBvTvOMSACAYpHTA==@vger.kernel.org, AJvYcCWZlumolwD6PFq+rfdEypE+5txegmNGNgQDffv41DIrUwUsTYs5p4DlXGeQgg2M5OqXiGkWTLwf8dLcaA==@vger.kernel.org, AJvYcCWgE1X4gdgdXCVFV3MFLK8MwDLxdmEwRtmrIb2zGEb6mG2v+IAHxfDE53VtAnN8CdFomq4BK31qWIsghr3e@vger.kernel.org, AJvYcCWgqmYYHudlT1g79u7sFvOs2rsmOEoUdiPQJntRS72qy9sfd+Hv6+/DwWrrcRf3RMl1fryX4GfCuwXhU+HZGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyYi/k9HRum2nPQJ/qoW8coy7aTBUYU7zvT5oHYvkJEWbZ/e2P
	TiCKAXvZqsjHylnNp71oD+YaEO5HjC4aMgDNopzNWIv7+MlEyZyJl1rwAHZQh47CWb2owHwoqYp
	TNUM8O5Cj9GyEBoIknVWtYBOqdSw=
X-Gm-Gg: ASbGncvYXuj9V2iaRpV59I/eOwEqJnAJSmzq6RYFIAT3pYWI+nP+xRkiUNTn9oKT1Db
	+gWiaRtq3oVTtJZ1iqbtQ5J86zI5dhNupu68LPbEk46jbVSU1IfbiqHvstoA=
X-Google-Smtp-Source: AGHT+IHVokvHgS4VPbH29H+qihMfYRv5DXmUYISCN+1KE4QC6a2L3CH+v4Rg2tloe5yQ1DMWw4vIjjDbAzeSubHjNHs=
X-Received: by 2002:a17:907:1c2a:b0:aac:832:9bf7 with SMTP id
 a640c23a62f3a-ab38b27be47mr2790084466b.24.1737745658104; Fri, 24 Jan 2025
 11:07:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216204124.3752367-1-dhowells@redhat.com> <20241216204124.3752367-28-dhowells@redhat.com>
 <a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_xwDAhLvgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=@pm.me>
 <CAB9dFdtVFgG7OWZRytL9Vpr=knNPnMe6b_Esg7rgfFfwLa8j0A@mail.gmail.com> <GHG6tQSGPRj9L93-skG-HGz4vGtXUxy6ibsUTKloUKncNmy8A7xgte0MEiI0iZJ7jD-SSrZiK2oswgvJCRan_0ZMi6xDlP11SHDi1Utf7mI=@pm.me>
In-Reply-To: <GHG6tQSGPRj9L93-skG-HGz4vGtXUxy6ibsUTKloUKncNmy8A7xgte0MEiI0iZJ7jD-SSrZiK2oswgvJCRan_0ZMi6xDlP11SHDi1Utf7mI=@pm.me>
From: Marc Dionne <marc.c.dionne@gmail.com>
Date: Fri, 24 Jan 2025 15:07:26 -0400
X-Gm-Features: AWEUYZm1VpljAqRhQQ6dX7tl5sygVWqfg2AdWCAk6rSkUpuGiA6tuCJB2vasH_k
Message-ID: <CAB9dFds_bPG1vThvOxhKcoFbUPGURYRHrY_zubPrAqpQrgHA7A@mail.gmail.com>
Subject: Re: [PATCH v5 27/32] netfs: Change the read result collector to only
 use one work item
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: David Howells <dhowells@redhat.com>, Christian Brauner <christian@brauner.io>, 
	Steve French <smfrench@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Paulo Alcantara <pc@manguebit.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 2:46=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> On Friday, January 24th, 2025 at 10:21 AM, Marc Dionne <marc.dionne@auris=
tor.com> wrote:
>
> >
> > [...]
> >
> > > A log snippet:
> > >
> > > 2025-01-24T02:15:03.9009694Z [ 246.932163] INFO: task ip:1055 blocked=
 for more than 122 seconds.
> > > 2025-01-24T02:15:03.9013633Z [ 246.932709] Tainted: G OE 6.13.0-g2bcb=
9cf535b8-dirty #149
> > > 2025-01-24T02:15:03.9018791Z [ 246.933249] "echo 0 > /proc/sys/kernel=
/hung_task_timeout_secs" disables this message.
> > > 2025-01-24T02:15:03.9025896Z [ 246.933802] task:ip state:D stack:0 pi=
d:1055 tgid:1055 ppid:1054 flags:0x00004002
> > > 2025-01-24T02:15:03.9028228Z [ 246.934564] Call Trace:
> > > 2025-01-24T02:15:03.9029758Z [ 246.934764] <TASK>
> > > 2025-01-24T02:15:03.9032572Z [ 246.934937] __schedule+0xa91/0xe80
> > > 2025-01-24T02:15:03.9035126Z [ 246.935224] schedule+0x41/0xb0
> > > 2025-01-24T02:15:03.9037992Z [ 246.935459] v9fs_evict_inode+0xfe/0x17=
0
> > > 2025-01-24T02:15:03.9041469Z [ 246.935748] ? __pfx_var_wake_function+=
0x10/0x10
> > > 2025-01-24T02:15:03.9043837Z [ 246.936101] evict+0x1ef/0x360
> > > 2025-01-24T02:15:03.9046624Z [ 246.936340] __dentry_kill+0xb0/0x220
> > > 2025-01-24T02:15:03.9048855Z [ 246.936610] ? dput+0x3a/0x1d0
> > > 2025-01-24T02:15:03.9051128Z [ 246.936838] dput+0x114/0x1d0
> > > 2025-01-24T02:15:03.9053548Z [ 246.937069] __fput+0x136/0x2b0
> > > 2025-01-24T02:15:03.9056154Z [ 246.937305] task_work_run+0x89/0xc0
> > > 2025-01-24T02:15:03.9058593Z [ 246.937571] do_exit+0x2c6/0x9c0
> > > 2025-01-24T02:15:03.9061349Z [ 246.937816] do_group_exit+0xa4/0xb0
> > > 2025-01-24T02:15:03.9064401Z [ 246.938090] __x64_sys_exit_group+0x17/=
0x20
> > > 2025-01-24T02:15:03.9067235Z [ 246.938390] x64_sys_call+0x21a0/0x21a0
> > > 2025-01-24T02:15:03.9069924Z [ 246.938672] do_syscall_64+0x79/0x120
> > > 2025-01-24T02:15:03.9072746Z [ 246.938941] ? clear_bhb_loop+0x25/0x80
> > > 2025-01-24T02:15:03.9075581Z [ 246.939230] ? clear_bhb_loop+0x25/0x80
> > > 2025-01-24T02:15:03.9079275Z [ 246.939510] entry_SYSCALL_64_after_hwf=
rame+0x76/0x7e
> > > 2025-01-24T02:15:03.9081976Z [ 246.939875] RIP: 0033:0x7fb86f66f21d
> > > 2025-01-24T02:15:03.9087533Z [ 246.940153] RSP: 002b:00007ffdb3cf93f8=
 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
> > > 2025-01-24T02:15:03.9092590Z [ 246.940689] RAX: ffffffffffffffda RBX:=
 00007fb86f785fa8 RCX: 00007fb86f66f21d
> > > 2025-01-24T02:15:03.9097722Z [ 246.941201] RDX: 00000000000000e7 RSI:=
 ffffffffffffff80 RDI: 0000000000000000
> > > 2025-01-24T02:15:03.9102762Z [ 246.941705] RBP: 00007ffdb3cf9450 R08:=
 00007ffdb3cf93a0 R09: 0000000000000000
> > > 2025-01-24T02:15:03.9107940Z [ 246.942215] R10: 00007ffdb3cf92ff R11:=
 0000000000000202 R12: 0000000000000001
> > > 2025-01-24T02:15:03.9113002Z [ 246.942723] R13: 0000000000000000 R14:=
 0000000000000000 R15: 00007fb86f785fc0
> > > 2025-01-24T02:15:03.9114614Z [ 246.943244] </TASK>
> >
> >
> > That looks very similar to something I saw in afs testing, with a
> > similar stack but in afs_evict_inode where it hung waiting in
> > netfs_wait_for_outstanding_io.
> >
> > David pointed to this bit where there's a double get in
> > netfs_retry_read_subrequests, since netfs_reissue_read already takes
> > care of getting a ref on the subrequest:
> >
> > diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
> > index 2290af0d51ac..53d62e31a4cc 100644
> > --- a/fs/netfs/read_retry.c
> > +++ b/fs/netfs/read_retry.c
> > @@ -152,7 +152,6 @@ static void netfs_retry_read_subrequests(struct
> > netfs_io_request *rreq)
> > __clear_bit(NETFS_SREQ_BOUNDARY,
> > &subreq->flags);
> >
> > }
> >
> > - netfs_get_subrequest(subreq,
> > netfs_sreq_trace_get_resubmit);
> > netfs_reissue_read(rreq, subreq);
> > if (subreq =3D=3D to)
> > break;
> >
> > That seems to help for my afs test case, I suspect it might help in
> > your case as well.
>
> Hi Marc. Thank you for the suggestion.
>
> I've just tried this diff on top of bpf-next (d0d106a2bd21):
>
> diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
> index 2290af0d51ac..53d62e31a4cc 100644
> --- a/fs/netfs/read_retry.c
> +++ b/fs/netfs/read_retry.c
> @@ -152,7 +152,6 @@ static void netfs_retry_read_subrequests(struct netfs=
_io_request *rreq)
>                                 __clear_bit(NETFS_SREQ_BOUNDARY, &subreq-=
>flags);
>                         }
>
> -                       netfs_get_subrequest(subreq, netfs_sreq_trace_get=
_resubmit);
>                         netfs_reissue_read(rreq, subreq);
>                         if (subreq =3D=3D to)
>                                 break;
>
>
> and I'm getting a hung task with the same stack
>
> [  184.362292] INFO: task modprobe:2527 blocked for more than 20 seconds.
> [  184.363173]       Tainted: G           OE      6.13.0-gd0d106a2bd21-di=
rty #1
> [  184.363651] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [  184.364142] task:modprobe        state:D stack:0     pid:2527  tgid:25=
27  ppid:2134   flags:0x00000002
> [  184.364743] Call Trace:
> [  184.364907]  <TASK>
> [  184.365057]  __schedule+0xa91/0xe80
> [  184.365311]  schedule+0x41/0xb0
> [  184.365525]  v9fs_evict_inode+0xfe/0x170
> [  184.365782]  ? __pfx_var_wake_function+0x10/0x10
> [  184.366082]  evict+0x1ef/0x360
> [  184.366312]  __dentry_kill+0xb0/0x220
> [  184.366561]  ? dput+0x3a/0x1d0
> [  184.366765]  dput+0x114/0x1d0
> [  184.366962]  __fput+0x136/0x2b0
> [  184.367172]  __x64_sys_close+0x9e/0xd0
> [  184.367443]  do_syscall_64+0x79/0x120
> [  184.367685]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  184.368005] RIP: 0033:0x7f4c6fc7f60b
> [  184.368249] RSP: 002b:00007ffc7582beb8 EFLAGS: 00000297 ORIG_RAX: 0000=
000000000003
> [  184.368733] RAX: ffffffffffffffda RBX: 0000555e18cff7a0 RCX: 00007f4c6=
fc7f60b
> [  184.369176] RDX: 00007f4c6fd64ee0 RSI: 0000000000000001 RDI: 000000000=
0000000
> [  184.369634] RBP: 00007ffc7582bee0 R08: 0000000000000000 R09: 000000000=
0000007
> [  184.370078] R10: 0000555e18cff980 R11: 0000000000000297 R12: 000000000=
0000000
> [  184.370544] R13: 00007f4c6fd65030 R14: 0000555e18cff980 R15: 0000555e1=
8d7b750
> [  184.371004]  </TASK>
> [  184.371151]
> [  184.371151] Showing all locks held in the system:
> [  184.371560] 1 lock held by khungtaskd/32:
> [  184.371816]  #0: ffffffff83195d90 (rcu_read_lock){....}-{1:3}, at: deb=
ug_show_all_locks+0x2e/0x180
> [  184.372397] 2 locks held by kworker/u8:21/2134:
> [  184.372695]  #0: ffff9a5300104d48 ((wq_completion)events_unbound){+.+.=
}-{0:0}, at: process_scheduled_works+0x23a/0x600
> [  184.373376]  #1: ffff9e9882187e20 ((work_completion)(&sub_info->work))=
{+.+.}-{0:0}, at: process_scheduled_works+0x25a/0x600
> [  184.374075]
> [  184.374182] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> So this appears to be something different.
>
> >
> > Marc

Looks like there may be a similar issue with the
netfs_get_subrequest() at line 196, which also precedes a call to
netfs_reissue_read.  Might be worth trying with that removed as well.

Marc

