Return-Path: <linux-fsdevel+bounces-55093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A6CB06E5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 08:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A3E4A4285
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 06:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5DB288CAF;
	Wed, 16 Jul 2025 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF5Pck/k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1224111D;
	Wed, 16 Jul 2025 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649168; cv=none; b=fuwdM/xACvY7H40Jp4kBTVja46WzgErNeXuXgmmpMAp2b8sGR4df9ATCVN/7/igl/9VCIqNvZ4Z2NjF4Q3o1SPSe683/Sb99i+vusxrJcuRSVco0ozu3AixwkCRmc3CdfzPXDveWn+Tv/VKIAf+gOvJX4Ra3x8yStBQHD3gjG78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649168; c=relaxed/simple;
	bh=1YT65WZi+HoNOGQs+MzMBsXQZvYrDhOQEHRhKgQWf5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIu9YApWGUJVasYqbyWM+HKlsm7cDfC6tryR7TqWHF9PfZHcKF+e9c+gORq/FVMWuJfMiA4wZKb41ph8LRvEM1MfgMUFMunLnVsuHf/ztOtjxnndKN6P2f17qNAgJZXawA6cTpc0XbUGQg/S3cwoaK5nxp3FICLBl0NydZkCAuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF5Pck/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33485C4CEF9;
	Wed, 16 Jul 2025 06:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752649168;
	bh=1YT65WZi+HoNOGQs+MzMBsXQZvYrDhOQEHRhKgQWf5U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LF5Pck/k/d8S9DCX0kbMVToPVEonFH+xQNHM++N6QwzI3vmpUOz3CB7/3hITAsK/m
	 wIToOrUVHmz0LivDXlcRb930EeEATqKyaxYXMuDvPpD9bECoXB/bGEBfmfOJPbTzG1
	 yzHeUPBAKoD2xbjr/Gk2VzhJWHQrGDcQ54qlOrAvYFnrRfIZJUlAm+EegGjB8Pd1hp
	 u+FySfV+owrGOFlZpA5ODo9QwP3SBz8llchEo/V0ijPesESM0HKCg0x3daJKsrzyas
	 upNcWEXdR+FF9gX5QZEQkZVGTyAE3dqW+ovaMoWAVCKgzH7KfBCR4Og/w7gTFq0d/i
	 rLZdzlrhJgTZA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso8782105a12.0;
        Tue, 15 Jul 2025 23:59:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUyjr17EiJkurphvl/wVjnrVL+DuKJxGPaWyIM/imLfeRotbxAKIp/BYW1f3eadPWzM0/Ps2t1/ZP+@vger.kernel.org, AJvYcCWIFyMYsIL8w96A3RqMZDIkkqElvsIuaKdI2gRhs8qgBZCNnNsrISktIDP5LoBbOw6yJDk3MvFZcyvwUHl3@vger.kernel.org, AJvYcCX0+u3h/N+Vv3N2E6wSW9fviQRumwMe8czoZC3GL5s1kay/Q9YQJfz4zszLY9m3uv3bFy5SwerPdabte8xxFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXhjYB9smNT5mohaMv0et+a5jj2tHIm5cu2F2rrRAaQYJHOkw7
	Rx5dr13mvSPWx4C1de+Ahf7fKrk/8fNRvgGYAGYjoZAQSCQo423Do3iFe0Xhf33rLhQj+2IeUVS
	Brx1fDKSnTY9oW9BXIZlTb0HqEzaOG74=
X-Google-Smtp-Source: AGHT+IGKo3S3B0Tw6XffFhBWZNoPLgGk8VvqoIudUlX7wPELD3zTsnE0xlx5Ew1W4zsHG++4r7Y1iPeGJUV3+0jv41Q=
X-Received: by 2002:a17:906:ef09:b0:ae0:e123:605f with SMTP id
 a640c23a62f3a-ae9ce0a4611mr134926966b.39.1752649166624; Tue, 15 Jul 2025
 23:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608234108.30250-1-neil@brown.name> <175264334224.2234665.14956053645355864817@noble.neil.brown.name>
In-Reply-To: <175264334224.2234665.14956053645355864817@noble.neil.brown.name>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 16 Jul 2025 15:59:15 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-KhOYk_fdKFV-ZbtSeX+Afc65ArnfSVrAqVxL6hMXoCQ@mail.gmail.com>
X-Gm-Features: Ac12FXwfZS2wHAoghNhMxbN-f_A8hoFnoQoeBr1SIRvTZILbUOAaB-G9Mh3M82s
Message-ID: <CAKYAXd-KhOYk_fdKFV-ZbtSeX+Afc65ArnfSVrAqVxL6hMXoCQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] smb/server: various clean-ups
To: NeilBrown <neil@brown.name>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:22=E2=80=AFPM NeilBrown <neil@brown.name> wrote:
>
>
> Hi,
Hi Neil,
>  did anyone have a chance to look at these - no replies and they don't
>  appear in linux-next ??
Sorry, these patches are not in my mailbox for some reason I don't know...
I guess I missed these ones. I will check and apply the patches now.

Thanks.
>
> Thanks,
> NeilBrown
>
>
> On Mon, 09 Jun 2025, NeilBrown wrote:
> > I am working towards making some changes to how locking is managed for
> > directory operations.  Prior to attempting to land these changes I am
> > reviewing code that requests directory operations and cleaning up thing=
s
> > that might cause me problems later.
> >
> > These 4 patches are the result of my review of smb/server.  Note that
> > patch 3 fixes what appears to be a real deadlock that should be trivial
> > to hit if the client can actually set the flag which, as mentioned in
> > the patch, can trigger the deadlock.
> >
> > Patch 1 is trivial but the others deserve careful review by someone who
> > knows the code.  I think they are correct, but I've been wrong before.
> >
> > Thanks,
> > NeilBrown
> >
> >  [PATCH 1/4] smb/server: use lookup_one_unlocked()
> >  [PATCH 2/4] smb/server: simplify ksmbd_vfs_kern_path_locked()
> >  [PATCH 3/4] smb/server: avoid deadlock when linking with
> >  [PATCH 4/4] smb/server: add ksmbd_vfs_kern_path()
> >
> >
>

