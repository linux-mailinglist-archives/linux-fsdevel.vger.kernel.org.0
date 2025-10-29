Return-Path: <linux-fsdevel+bounces-66178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B67C184BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 06:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1B844E6AAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 05:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC29C2F0C73;
	Wed, 29 Oct 2025 05:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzZIQzPf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D02D0C7B
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 05:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716030; cv=none; b=V+oc6zeovA9VdQUbbtUEmulnGOMHo5zMcL5jDOYEg9DLsPwKmRSOmsVlE8bCK3ngi5iJeKo03aLf3Xs0pc8mpBajOSQlWap9UT28ZNmN9eeSkD9pka4O5qqDjTiLkYN462bFXlpapaitscrkTfwY//92eJLJHrrIeyzCHPjspyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716030; c=relaxed/simple;
	bh=iYJd3vHJIXTc6hZG0GxoiTrBKJlN3crRcnS+AFt3FQ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=uujIsHppmktCH/GaG+GTjdGHZD5VSb26a/e0VOXm4AiHWTWUG3k5N8keFcykb53ugDNvrszoJUz6QiXintcLM+Z6aCO+pj2WJdYJxHGhZyLQsob07al+TreFp6ZOI4+QjR1lnmWh5iehRpihEn8EtCBr+8GjD1X/AKmuniaW4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzZIQzPf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso5778477b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 22:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761716028; x=1762320828; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYJd3vHJIXTc6hZG0GxoiTrBKJlN3crRcnS+AFt3FQ8=;
        b=kzZIQzPfZkgRUr/3rktZfdRgr08rc4+j1FM24QyTA9Dtahu88tR/ZefOBzUzIF5h5B
         iOWV8Cz0aAD3Xzylqb5/ORu75hXTBS6ssda4ececrGzCIiBLOyF9Vusxqi2PB8n5E0wi
         foxsDfay659sXLa47vMTTnWB2elpGS4ezFx64EL9y3JEfj1Z39BXfwvgJxl1CFBWLJhn
         TXvSe3Y7021fURtAxSYcQyDUmesmWBXL5fG8Sz0e336DstzXkLnNVB29+/hSrdHOmZ+r
         R6BZqAh8PEsEMniaXdN3aFY2vFiJ/xLLmVKED4iqKU7kzfPEaber96Cpi9bO2DjvWHYB
         DIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716028; x=1762320828;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iYJd3vHJIXTc6hZG0GxoiTrBKJlN3crRcnS+AFt3FQ8=;
        b=LrV9yYOW+DeUiKSzyJ5jOBqDjS5cTG9FuFiPuKmB+j+LXovGI/to1zIDFc+/k5ISrW
         ND1BI8VEF6K1Zw68Xy9dUmUWayOkkuivJV1NGf8DI4f4bAGjpzoXft2WfiuOO++wxMZu
         xyKbP3oH0haI7GyKAw69bFwMsg0Cal1YASEBGl765dcvetaDmiFmERNXUtqRucpoctnT
         TuR9dKd308efoKeGPeAfp77A3bk2K7OqDcK56jsu1thpRZKtfq8+zhTDwKJHMVYyYPKw
         g5x20oeuDMtOfYScfj1eFEN1JjvALNUQlAdDt76IearhYnjw/WwG4A2ZYgcrEbuvDqRP
         InWw==
X-Gm-Message-State: AOJu0YwOJPBGJ8dp4OZV50kRg37VWNtj6E5J09yLQ0WL4qgSesT927sS
	/JoT5NvZu50cdAG0t8IJrb1pmJn/h8owpuG9vFdOQMX7cIM5HorCyqVc
X-Gm-Gg: ASbGncvqnKTG1CJaBcnTuMvqhE+PFoVC99gd7QiKx9BBPYsi5XKwt44Y7v9rQMsDlvP
	nmg2YAplPG4h/S1elCmkNNG55Iv4UXD/dIGZWOpq9LFAFbatBQcscYIq9sY4DgjZpB7n6nV5fRp
	ODPpr1DUdeY+2rnDSKVg7elbixu86vAKSgD8jokyncOdKyJdkSZfwb/H2i0MYCUX9lOQeXaMGsE
	SN1PG5t75LN1F0dsGrFkVAeaFWRcBRpn+KYyhnadVBnx8VF/zykvjbIeRVSxvUNlJYU++tpZcbJ
	xzq/lRRNFA7XTyzcvapGHosihwNm/St4w66OKhq/DBTiIr5M1yhAea2HUXiti/RGXCZv/g9Na9+
	BT+8cqp5VM3uNqt+IOZA+YnXI+4EEf73bpe0FtEj2lPtBAfIyzrsep8pCnYLwmY4HWLG6KFAp5P
	VEl6rE
X-Google-Smtp-Source: AGHT+IGtegqE8ssfls2e4AbItrtetr6/6zgIGeNOXrBmAC/E3qliCvGannlglVRZ3w+Qo7qx2YPMsw==
X-Received: by 2002:a05:6a20:3945:b0:33b:f408:7b98 with SMTP id adf61e73a8af0-34654eed372mr2245725637.45.1761716027875;
        Tue, 28 Oct 2025 22:33:47 -0700 (PDT)
Received: from localhost ([2405:201:3017:184:2d1c:8c4c:2945:3f7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7ffeab2617sm6991799a12.33.2025.10.28.22.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 22:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 11:03:40 +0530
Message-Id: <DDUK7IZ56YJW.1UVWZS6GIOPUW@gmail.com>
Subject: Re: [PATCH v4] statmount: accept fd as a parameter
From: "Bhavik Sachdev" <b.sachdev1904@gmail.com>
To: "Bhavik Sachdev" <b.sachdev1904@gmail.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Aleksa
 Sarai" <cyphar@cyphar.com>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>,
 "Jan Kara" <jack@suse.cz>, "John Garry" <john.g.garry@oracle.com>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>, "Darrick J . Wong"
 <djwong@kernel.org>, "Namhyung Kim" <namhyung@kernel.org>, "Ingo Molnar"
 <mingo@kernel.org>, "Andrei Vagin" <avagin@gmail.com>, "Alexander
 Mikhalitsyn" <alexander@mihalicyn.com>
X-Mailer: aerc 0.21.0
References: <20251029052037.506273-2-b.sachdev1904@gmail.com>
In-Reply-To: <20251029052037.506273-2-b.sachdev1904@gmail.com>

On Wed Oct 29, 2025 at 10:47 AM IST, Bhavik Sachdev wrote:
> Changes from v3 [2] to v4:
> * Change the string returned when there is no mountpoint to be
> "[unmounted]" instead of "[detached]".
> * Remove the new DEFINE_FREE put_file and use the one already present in
> include/linux/file.h (fput) [3].
> * Inside listmount consistently pass 0 in flags to copy_mnt_id_req and
> prepare_klistmount()->grab_requested_mnt_ns() and remove flags from the
> prepare_klistmount prototype.
> * If STATMOUNT_BY_FD is set, check for mnt_ns_id && mnt_id to be 0.
What I meant to say is that, we check that mnt_ns_id =3D=3D 0 and mnt_id =
=3D=3D
0, when STATMOUNT_BY_FD is specified.
>
> Changes from v2 [4] to v3:
> * Rename STATMOUNT_FD flag to STATMOUNT_BY_FD.
> * Fixed UAF bug caused by the reference to fd_mount being bound by scope
> of CLASS(fd_raw, f)(kreq.fd) by using fget_raw instead.
> * Reused @spare parameter in mnt_id_req instead of adding new fields to
> the struct.
>
> Changes from v1 [5] to v2:
> v1 of this patchset, took a different approach and introduced a new
> umount_mnt_ns, to which "unmounted" mounts would be moved to (instead of
> their namespace being NULL) thus allowing them to be still available via
> statmount.
>
> Introducing umount_mnt_ns complicated namespace locking and modified
> performance sensitive code [6] and it was agreed upon that fd-based
> statmount would be better.
>
> [1]: https://github.com/checkpoint-restore/criu/pull/2754
> [2]: https://lore.kernel.org/all/20251024181443.786363-1-b.sachdev1904@gm=
ail.com/
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/include/linux/file.h#n97
> [4]: https://lore.kernel.org/linux-fsdevel/20251011124753.1820802-1-b.sac=
hdev1904@gmail.com/
> [5]: https://lore.kernel.org/linux-fsdevel/20251002125422.203598-1-b.sach=
dev1904@gmail.com/
> [6]: https://lore.kernel.org/linux-fsdevel/7e4d9eb5-6dde-4c59-8ee3-358233=
f082d0@virtuozzo.com/

