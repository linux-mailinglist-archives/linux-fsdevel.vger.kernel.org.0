Return-Path: <linux-fsdevel+bounces-38482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FA3A03251
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 22:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433647A27C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 21:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECC81E0B82;
	Mon,  6 Jan 2025 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PXcePQBv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB8815886C
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736200273; cv=none; b=EUipA+Fg2WHr9HW7OxIfq3rD97mABrhWo2eTjhQCnHmQHEBovT7qurzEhEFQpRj7eH4hIXgqjDzpOi+uZvBRdAt28368MR80DwVOb/p9NZTLvnRv3eyu25mhmwgPAsDFO/WoWRrBYXfhfaAUc1JjCubTIWfvkl2rfpX1YV91SRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736200273; c=relaxed/simple;
	bh=IwSR31+V1zc12HohVb1Y6oX2YZTzAHDke7c82kPYWcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeDpxLSxZJnMCEspXy2ZqvFhDNQ7i4QW694pJQkE+vTMn8VS5e5dpws2v15Md5iZL4rtCSCAQIDNw6548NDIGq7Vl6hxG9H858xPDzEZoTcMnmlwnlatuTg4PTkqW2PeHD6CNezWV/7LaaR8KjbM61ZgTvSfldG/SNTenhg0/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PXcePQBv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so2150122566b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 13:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736200269; x=1736805069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2Tf9kl7fMh2IKDkNrv4YmXHlRq99NuJrVWu2Sqk7+k=;
        b=PXcePQBvr6pcmAQTAe5GmJHhL1O5YxZR4oeTfrOA2DSWc0818tYS8KegFT99BglXTW
         3NwIcnVADh+LE3wdPKuiBDSlAWcpinKh4NBipFApjRwa9NKa2a0g11Fc/oJq5CCQnxfr
         P2jr4jQTve1t/lz6R75hrdiXZHvKMQ0Q0ISysczygkZ2yNG/vc6bTstgyKOAD6997C7c
         bHfpVorLoeTOFyJHWxiIIrea5ZTM2DoWQllI50ZsQdfHgnS/DVnZN4sQqWokiR3v5+m0
         W3DIsDi2ejAXptjevZ3xWz3MCXcnO/4zq1ssirZBsIktY/P+iKGvHJqySmbqkr41cxyX
         EH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736200269; x=1736805069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2Tf9kl7fMh2IKDkNrv4YmXHlRq99NuJrVWu2Sqk7+k=;
        b=rS5HLDbfr1yvBoVeTCk1wh3CE4wrgSlPjmw7gjH6vfsu5virXntaYScePxl00go91Q
         fGSV13JIcjc+kTgo6f2T7sddVySsYRaQJ6JKxFit2UXZbfTXq7Ek4k0/K/egZjEzhWAj
         MdHz8d0s4Vif27mNOZQciz9jAAtgYMvwwcnCPsK5IU3NkPncdoRxlA4gUA/ncU7K8fc/
         uaHIZdkbt1AGfTRV+7iH74KGdoRyGtqp56SlvOShzYOo7qGOoUnhUsGhuA6Fb8W66aFL
         UzFNnHOJaUvT+sG7bVDNV4BA8iUOYiapPXfmrUqWBApsE8Q1AVAPFa7qc0k33kBwu/ph
         e7jA==
X-Forwarded-Encrypted: i=1; AJvYcCX9VbaxmAyKWsF/uv8PfYG2ubvJQApCd0Ji9iNsYxGXiag5eGhcFUKzhihgEI9ZMe9iuh1bHkn8SyZ5eP2P@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1t0ZGsDBeATorZNXTQ9OFRo1d16B9X2dIwcBaIVx+Jvx0AyuK
	ar7KK/92dwLUE+mcS0K6rFJSJUvtKm+v49n1vGzF7wU9EX0/zqiaye1I6vv44NTN2m4XBLIcCiY
	QjwsxpjIx2aOwFWJToHH1E6CO4s4aMp/pw8sVIg==
X-Gm-Gg: ASbGnctPbb/+++DmDwztEQJKBG/6VWA+6+jhH4T2D3jraBQRSZZPsF7sbkmlYPOtw76
	mJjhTJrmZkfQeJpiYGRhu/rEvoMqQcGlHUo8G7hBGeBrYvQ1HJkWJQIF9jv7wY9nR0QDu9sE=
X-Google-Smtp-Source: AGHT+IEbdBIHOn0SO06cyrEdOiCaD/dm+Y2tlfbyyUY+2pGFVOH+/CPxrh+Wr1PntEPavQ8d1cPYlSvzXi+zmWWeFjQ=
X-Received: by 2002:a05:6402:4405:b0:5d2:7199:ac2 with SMTP id
 4fb4d7f45d1cf-5d81dd83e12mr139504348a12.2.1736200269599; Mon, 06 Jan 2025
 13:51:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ec6784ed-8722-4695-980a-4400d4e7bd1a@gmx.com> <324cf712-7a7e-455b-b203-e221cb1ed542@gmx.com>
 <20250104-gockel-zeitdokument-59fe0ff5b509@brauner> <6f5f97bc-6333-4d07-9684-1f9bab9bd571@suse.com>
In-Reply-To: <6f5f97bc-6333-4d07-9684-1f9bab9bd571@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 6 Jan 2025 22:50:58 +0100
Message-ID: <CAPjX3FcG5ATWuC1v7_W9szX=VNx-S2PnFSBEgeZ0BKFmPViKqQ@mail.gmail.com>
Subject: Re: mnt_list corruption triggered during btrfs/326
To: Qu Wenruo <wqu@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	linux-fsdevel@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 4 Jan 2025 at 23:26, Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/1/4 21:56, Christian Brauner =E5=86=99=E9=81=93:
> > On Wed, Jan 01, 2025 at 07:05:10AM +1030, Qu Wenruo wrote:
> >>
> >>
> >> =E5=9C=A8 2024/12/30 19:59, Qu Wenruo =E5=86=99=E9=81=93:
> >>> Hi,
> >>>
> >>> Although I know it's triggered from btrfs, but the mnt_list handling =
is
> >>> out of btrfs' control, so I'm here asking for some help.
> >
> > Thanks for the report.
> >
> >>>
> >>> [BUG]
> >>> With CONFIG_DEBUG_LIST and CONFIG_BUG_ON_DATA_CORRUPTION, and an
> >>> upstream 6.13-rc kernel, which has commit 951a3f59d268 ("btrfs: fix
> >>> mount failure due to remount races"), I can hit the following crash,
> >>> with varied frequency (from 1/4 to hundreds runs no crash):
> >>
> >> There is also another WARNING triggered, without btrfs callback involv=
ed
> >> at all:
> >>
> >> [  192.688671] ------------[ cut here ]------------
> >> [  192.690016] WARNING: CPU: 3 PID: 59747 at fs/mount.h:150
> >
> > This would indicate that move_from_ns() was called on a mount that isn'=
t
> > attached to a mount namespace (anymore or never has).
> >
> > Here's it's particularly peculiar because it looks like the warning is
> > caused by calling move_from_ns() when moving a mount from an anonymous
> > mount namespace in attach_recursive_mnt().
> >
> > Can you please try and reproduce this with
> > commit 211364bef4301838b2e1 ("fs: kill MNT_ONRB")
> > from the vfs-6.14.mount branch in
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git ?
> >
>
> After the initial 1000 runs (with 951a3f59d268 ("btrfs: fix mount
> failure due to remount races") cherry picked, or it won't pass that test
> case), there is no crash nor warning so far.
>
> It's already the best run so far, but I'll keep it running for another
> day or so just to be extra safe.
>
> So I guess the offending commit is 2eea9ce4310d ("mounts: keep list of
> mounts in an rbtree")?

This one was merged in v6.8 - why would it cause crashes only now?

> Putting a list and rb_tree into a union indeed seems a little dangerous,
> sorry I didn't notice that earlier, but my vmcore indeed show a
> seemingly valid mnt_node (color =3D 1, both left/right are NULL).

The union seems fine to me as long as the `MNT_ONRB` bit stays
consistent. The crashes (nor warnings) are simply caused by the flag
missing where it should have been set.

--nX

> Thanks a lot for the fix, and it's really a huge relief that it's not
> something inside btrfs causing the bug.
>
> Thanks,
> Qu
>
> [...]
> >>>
> >>> The only caller doesn't hold @mount_lock is iterate_mounts() but that=
's
> >>> only called from audit, and I'm not sure if audit is even involved in
> >>> this case.
> >
> > This is fine as audit creates a private copy of the mount tree it is
> > interested in. The mount tree is not visible to other callers anymore.
> >
> >>>
> >>> So I ran out of ideas why this mnt_list can even happen.
> >>>
> >>> Even if it's some btrfs' abuse, all mnt_list users are properly
> >>> protected thus it should not lead to such list corruption.
> >>>
> >>> Any advice would be appreciated.
> >>>
> >>> Thanks,
> >>> Qu
> >>>
> >>
> >
>
>

