Return-Path: <linux-fsdevel+bounces-36637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA339E7184
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 15:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745512837B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 14:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB1F1FBEB9;
	Fri,  6 Dec 2024 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+OQavps"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56AF1494A8;
	Fri,  6 Dec 2024 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497011; cv=none; b=merNssP/5udeKPsVM+6UW1Bf+bhpNt6cg5f31GSfJL2oq9oyM+jT2P9maiYt8CavLJyaDxuTigWoKPbU8lGEZpC94ZEdkoGirbhvAbahOzTZU99c1KTWT4K5CnmxMYkdHP855V4PI2x8CXDBjLZ2lDedvvRF6Lc2XVxKwxCKuLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497011; c=relaxed/simple;
	bh=XgLZDE0L+3IfV0yth2uDUAUVqNfm/D7z1GB9Pl0dfic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nzwbs2KVuTcsHdKS8WfB1uBYm/Wr+BrzUHixahL7lY7omGSUY6QUbXAPpHf3Cl+GoZu0BBq1hT67argBJxM0BOMwvFY0Vsg+F0pSmTiQ7e091c51D6L+PW5tMNJHsOlL33naZHlmADrLVR6r6XPyL+vjxcCDngWYOUruFZQ3QNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+OQavps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EAFC4CEDC;
	Fri,  6 Dec 2024 14:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733497011;
	bh=XgLZDE0L+3IfV0yth2uDUAUVqNfm/D7z1GB9Pl0dfic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z+OQavpsVLkBByke+FQjn2SmcCiB/9A5v7km0F5rK0fqYPyZkqkjIjVOuualQY109
	 AJkEVeYxqJT5y97hd5nw3sOC+UaZkmuHWpAU8v0PkTsi58rUNMjxtdrCVyTH9MPS/m
	 0V/HX/g2bNmHFLynvQNOvHmMnpJcwrqOd1qKU2TdML8AXf1Sd3AxDHV9SqnaWdV9lI
	 rnVF228WW+SuSP34BQSHmlY99rFcpb6TUaPl4BiQw/kGsWwVuoRkzQLx+ztEu9ANCU
	 DygMVHGmeP/rI4HLla06WCRPz2FJNELy9dnhrJScqryHayz+qwEUUvKV1pHg/umCP4
	 /TWeQwTalEUqg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-29e70c9dc72so1242973fac.0;
        Fri, 06 Dec 2024 06:56:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmCMZd9cVRuJ8d1YL+X0V+pkau/nA6Tak0E9vI7/roGhB/M8eovgQA9P40WOq1LVlkMCDp+d1GPoNj@vger.kernel.org, AJvYcCVNbLM2Rz1WPOe+49umYIydx7MyTczNTIjTYiqEvWIXv9iqPQp0rbyp1xWcs3iyad8b64vJAjoe/kQ9kBkzzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo+7JQp9m+Ty8dyljchKI6EW3yRkSRqb+cabJr3TuSs/iY66KB
	/MKDvOqAghYz1EA/AEkVZRUx4xxlMpJN9MSMuvtEdtLjU9rliBfRkJ0/SwG7GW8uEfcBRdKPY7c
	/SULtDYMFmO5mXvg9Wd6DirE0A9I=
X-Google-Smtp-Source: AGHT+IE4PHAtUQ85vUjMtstEGTEOcMtHIQm3DFsimoekg2HprS6Hh/iAhcI/QyggWWq+9gimg+SAvK4lzHXYZF+d0xg=
X-Received: by 2002:a05:6870:96a6:b0:254:bd24:de83 with SMTP id
 586e51a60fabf-29f73255815mr1972282fac.12.1733497010863; Fri, 06 Dec 2024
 06:56:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206164155.3c80d28e.ddiss@suse.de> <CAKYAXd8U-kQa5+fg4QvcUeOkAuX128v_VLxNz5=trF85ZONrYA@mail.gmail.com>
 <20241206233654.3a3207ba.ddiss@suse.de>
In-Reply-To: <20241206233654.3a3207ba.ddiss@suse.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 6 Dec 2024 23:56:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-7otRiYAZdMZtZxp3Rp_X0X4DaTWF6mJTjpMmejOC7nQ@mail.gmail.com>
Message-ID: <CAKYAXd-7otRiYAZdMZtZxp3Rp_X0X4DaTWF6mJTjpMmejOC7nQ@mail.gmail.com>
Subject: Re: ksmbd: v6.13-rc1 WARNING at fs/attr.c:300 setattr_copy+0x1ee/0x200
To: David Disseldorp <ddiss@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, 
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 9:37=E2=80=AFPM David Disseldorp <ddiss@suse.de> wro=
te:
>
> On Fri, 6 Dec 2024 16:35:18 +0900, Namjae Jeon wrote:
> ...
> > > 300                 WARN_ON_ONCE(ia_valid & ATTR_MTIME);
> > >                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^--- here.
>
> I should mention, fstests generic/215 atop a 6.13.0-rc1 cifs.ko SMB3
> mount was the trigger for this ksmbd warning.
Okay, I have reproduced it. Thanks. I will take a look.
>
> > > Looking at smb2pdu.c:set_file_basic_info() it's easy enough to see ho=
w
> > > we can get here with !ATTR_CTIME alongside ATTR_MTIME.
> > >
> > > The following patch avoids the warning, but I'm not familiar with thi=
s
> > > code-path, so please let me know whether or not it makes sense:
> > mtime and atime will probably not be updated.
>
> Unless I'm missing something, this patched ksmbd still triggers mtime
> update via the setattr_copy_mgtime()->(ia_valid & ATTR_MTIME_SET) path.
If FS_MGTIME flag is not set in the fstype of local filesystem, mtime
is not updated with only ATTR_MTIME_SET.

Thanks.
>
> > I will change it so that ATTR_CTIME is also set when changing mtime.
>
> That should also work. I was turned off that path due to the
> 64e7875560270 ("ksmbd: fix oops from fuse driver") ATTR_CTIME changes.
>
> Thanks, David

