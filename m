Return-Path: <linux-fsdevel+bounces-34822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC569C8F61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 17:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DD4288360
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BFF17FAC2;
	Thu, 14 Nov 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCMUYZId"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C63415C144;
	Thu, 14 Nov 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600658; cv=none; b=C+QJoG8YDaOKMK9sW5wxH8tGx06cIZDl6ugS5hl/DjrM2wRwOMTorOWTRP5l0Wt3wTP3GWgWfXZKhmIMoxIEZ+Q2wKsePLpInuDqjAYvMZNIngZDvJ1lbcYy3TNSHrG8Efxo0UXAQY5V0yiM9gv7RKu4GCyQwdKuif19bf5gNnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600658; c=relaxed/simple;
	bh=//L4PsIT1JRM2d4ptNOmC2PbmBmzrWxAwk9MQLNI8PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQV94xM/1r5LQc1rXNQSOcqDZ+5cbY3/A8qMangYWiMYsE8ATgMaBuZyZplOsZtqTAsgmgFFaXFYb2vmhDEQpgSUp6m44dcrq7zwSpoPbtDbrsQIPSa12UJsgdaATgZsuuSOc8cdhouKnhBTfilw4xOT7qT+m1a/TAC9QR2H5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCMUYZId; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d3f35b0482so3795656d6.0;
        Thu, 14 Nov 2024 08:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731600655; x=1732205455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pHx1DacECVAEAsTiJDjC4YcmVVqKK1JDKViVGTWXq0=;
        b=CCMUYZIdJ6jHZD7Zlbs6gbL/V6LegXJO+WiqNwBuvDnyaVIM3AmyaY4unKH1ssEOW4
         YICMtXk9g38jd3NVr3FFsvpNRBkOFgULam49r2LUE93L2v2gJMyUI0iwEgbbxp4yCIrR
         qNM1/LYcw6+hPEJhC+zLqKERWCq3XuOuSMAR795txvZ5ptcc391QjP8gTQpsDxUsF3JK
         mceAyiP5ggS1uxws3C/5jlle/p59EHwPiASLg1NHeORrBPlydCodsgaErpITxK01BvNk
         vPUTfE7XBFCS1fehz2uySEsZIvJPCSxXJk1MwQ/objOvwlMF5kPw3KJCyGfe7GqAcUD4
         zj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731600655; x=1732205455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pHx1DacECVAEAsTiJDjC4YcmVVqKK1JDKViVGTWXq0=;
        b=pc/bzAhySY/r7qPxI/g0j0iVyINhiWL2qCA6Q+waMeXfoRAjFr4YchXQN8So+36Rhs
         Q5In/h6FcasScBo58zPY42vHN2GlcPZ2JdVMmLbZePpeL3k5ojB/gkhgG3g2Gyd2ehD5
         4Km3dP+KbyupeZ7HBM+AKk93hySIFlEd0LnbyffrNcXT+PMmYcTzoLDBWHnXBL9sb1xe
         fKosKBkooZTrjfJknbS3rZjytQILgXv9O9BQFMgg2454PhtXWfWd8AW0JcQqCsIhKO/U
         0GwwiTWpJuI3y/P9RYetF69RlT4/lavCbzORUvblN41ldaFA8UAgYA5vbnHWwTu0vWMx
         aYZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVTA0U3Lwh3pZ9DFHs0Q8Gjbb6/NSkMPS9SWrolxS2K9Ty7FqltaR300g3Ewo/T1gPrbqW3f3w5zF5HbfK@vger.kernel.org, AJvYcCXO0i3uNz8372laNhOBFatnEPQ7rmJ78Ew2OWi150K75tSI00CCraXJ/hlTbYAmCuxbotvEUPEy6dKV@vger.kernel.org, AJvYcCXqOKXQv3/zX0oUAaRFaIpP/KT2q6tbOdkK/VxEmuhFAO4JJgw1Kp45GEKHXod7yGdanNBetC7BAUKbqwRF@vger.kernel.org
X-Gm-Message-State: AOJu0YySJ2Op+F775AIWEgSyiw0tVm0rG+cvdEVkR3I3Qr1OvIY88kDW
	f+kTCzg/EM71JyymaJ+vbFRWXCka6RfSnmqy8hGHfb21yb7gLfF0pyTo9mkmOz2VCZWXEmY4hUO
	ByDIo9nKJVnUBm/onk3AeGNkmozIfqlnH
X-Google-Smtp-Source: AGHT+IEBZNmSicJmMxMIrf+pkl8ipfvlQ0LTTsU1MyPIfH7UoKJ4h0ni1Vk+LXwIlWS1+G70KC2Is/Xj9yDpbTc2eh0=
X-Received: by 2002:a05:6214:458a:b0:6d3:c3ee:10c4 with SMTP id
 6a1803df08f44-6d3d027b590mr135732576d6.33.1731600655583; Thu, 14 Nov 2024
 08:10:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2aa94713-c12a-4344-a45c-a01f26e16a0d@e43.eu> <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
 <CAOQ4uxg4Gu2CWM0O2bs93h_9jS+nm6x=P2yu4fZSL_ahaSqHSQ@mail.gmail.com> <431019de-b6c6-474b-bf1f-e0afcdc0ce63@e43.eu>
In-Reply-To: <431019de-b6c6-474b-bf1f-e0afcdc0ce63@e43.eu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Nov 2024 17:10:44 +0100
Message-ID: <CAOQ4uxgX=vBByudroKz+KC5JvLccxnoyBV7ybmzATCAQ-sUFgg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pidfs: implement file handle support
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 4:51=E2=80=AFPM Erin Shepherd <erin.shepherd@e43.eu=
> wrote:
>
>
>
> On 14/11/2024 08:02, Amir Goldstein wrote:
> > On Wed, Nov 13, 2024 at 7:01=E2=80=AFPM Erin Shepherd <erin.shepherd@e4=
3.eu> wrote:
> >> Since the introduction of pidfs, we have had 64-bit process identifier=
s
> >> that will not be reused for the entire uptime of the system. This grea=
tly
> >> facilitates process tracking in userspace.
> >>
> >> There are two limitations at present:
> >>
> >>  * These identifiers are currently only exposed to processes on 64-bit
> >>    systems. On 32-bit systems, inode space is also limited to 32 bits =
and
> >>    therefore is subject to the same reuse issues.
> >>  * There is no way to go from one of these unique identifiers to a pid=
 or
> >>    pidfd.
> >>
> >> This patch implements fh_export and fh_to_dentry which enables userspa=
ce to
> >> convert PIDs to and from PID file handles. A process can convert a pid=
fd into
> >> a file handle using name_to_handle_at, store it (in memory, on disk, o=
r
> >> elsewhere) and then convert it back into a pidfd suing open_by_handle_=
at.
> >>
> >> To support us going from a file handle to a pidfd, we have to store a =
pid
> >> inside the file handle. To ensure file handles are invariant and can m=
ove
> >> between pid namespaces, we stash a pid from the initial namespace insi=
de
> >> the file handle.
> >>
> >>   (There has been some discussion as to whether or not it is OK to inc=
lude
> >>   the PID in the initial pid namespace, but so far there hasn't been a=
ny
> >>   conclusive reason given as to why this would be a bad idea)
> > IIUC, this is already exposed as st_ino on a 64bit arch?
> > If that is the case, then there is certainly no new info leak in this p=
atch.
>
> pid.ino is exposed, but the init-ns pid isn't exposed anywhere to my know=
ledge.
>
> >> Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
> >> ---
> >> Changes in v2:
> >> - Permit filesystems to opt out of CAP_DAC_READ_SEARCH
> >> - Inline find_pid_ns/get_pid logic; remove unnecessary put_pid
> >> - Squash fh_export & fh_to_dentry into one commit
> > Not sure why you did that.
> > It was pretty nice as separate commits if you ask me. Whatever.
>
> I can revert that if you prefer. I squashed them because there was some c=
hurn
> when adding the init-ns-pid necessary to restore them, but I am happy to =
do
> things in two steps.
>
> Do you prefer having the final handle format in the first step, or lettin=
g it
> evolve into final form over the series?
>

I don't really mind. Was just wondering. Either way is fine.

Thanks,
Amir.

