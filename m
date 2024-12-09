Return-Path: <linux-fsdevel+bounces-36842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB619E9BB7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 17:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AEB1888462
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 16:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98C614D283;
	Mon,  9 Dec 2024 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYUJ+Zlu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670FA148838;
	Mon,  9 Dec 2024 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761839; cv=none; b=Ll1MNF6ppSSuVjOFO7Q1Pp9D1aVrVt2NBmCTDV6ydyza3+MdN3+LywiCRJFIpb270z+aYLolDViAYH3nrFf7pOcRMf4yk9lOTmCMW1iBTvv7J9H7a8MNZJ8QGJC3w2CksZC9OIpnSVrh4JmTpH/LzC3EuuQbtnaAMlHGaAALjnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761839; c=relaxed/simple;
	bh=UqFmyUyCnqL3Joi4dxVsrc/QHwDIjKuol/h0eu0pRlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3E5UShqSxFEAKc2EPwyeWP9D269/AHHT64GJOCUwc5UPuLJZfDUacroPzAYmQdNOL2iKuVjC9sCIK2gth6txms9KN97tHU77bQSpNxdTj1j/3/wYicnIgDpjQYNueMNa8Xh6Dm3fHaVMbMeLMZ7nLOcejNEr2CfFXud7POVFQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYUJ+Zlu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3d74363cbso4178717a12.2;
        Mon, 09 Dec 2024 08:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733761836; x=1734366636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PXZFahQEQ9+MH6nwCFL4u3GPn69RCf5jv5+RxOCeQE=;
        b=bYUJ+ZludQOks/rxAghEud8Q2yjTkv9oKUWN7pryXJIsYiXV/+8jRQ5vQDChhiDdmk
         EzL8nRpfkxrjkYrKOyMfCiaz491xjybt3eDYTcCuU4E4rJHGdbruHAXUHCvf0Z2hQ+en
         ySoFGSSudfTK/Q46FMQMlAWN3DVk2396QTmcfuXOUYJ4QhFdcUmqWot8TFspr3EF5VPQ
         /ahrUvWsOe07iY6sWOAY6/fCO17BPT3agEz+TUFb4DJSZIIM433wxmmchONBsCtSIlcb
         CHidkT79YtXYAVu7n32oW7rfy61smfjYq6yTwbX/ENomBsjjMejlVrZhf2dXzhCzg55v
         Dzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733761836; x=1734366636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PXZFahQEQ9+MH6nwCFL4u3GPn69RCf5jv5+RxOCeQE=;
        b=jI/Ipi8lZtHFuxw34VR+4lxM8j7pT89sEgBYpC8dezruvit2JiSZ5CrmkOuQwuQ45t
         Owca2TBUDi9jGw4IPfDvcSUHmJGW0VlI3l5UBhuZrZfhA4DLhjHj2qxTtw4wtBoMb5LI
         LoL8RUnfQ9Oc0BCGjzCmpCYsorQHXjImcLcbAQw+YwyLY59Fd6W3nRO2vUqwD93ixae/
         Ea067IJ48cecBmj2fBl3AYCmYSAfuqJG8Q+DtbC3+N798og/lELW1Nn+4GAfZaDGCuaB
         Cz2tPkpJRzFCF8lS9NzTZpalcxvgV2DBL8uzwmaBZAR/I4ELzc4cqtAEheiuiw1JfDPW
         ySDA==
X-Forwarded-Encrypted: i=1; AJvYcCUF+Tn8gYKN3QnYZX7CDkw4AzObRYbL9TLWaGi2oBrmbwn1HXct0RbjZpQccHevI5x3PwZe7hKmjiH/@vger.kernel.org, AJvYcCUgurNssaSBkpQJXRK+q5pVlwHSUtqgrJ3X+hgmsn3K8ibWGPKnV/dBsMPYPdm95SGAAwdj1BJX938/GgcN@vger.kernel.org, AJvYcCV1sQUx0So8e25lat80O26/mTlQgkJ3puznTlLdsibTDtFr8mA3511vsbq0bTe2MInG3y3tpUhuJUB4bEVP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9IIoN3Q8wTaBFgN1MDnrap9BZ0SQSLZFzp/v+yN/MPO2t7Oj
	i7tk21B1LYnQLYUU3lIDSrEOHN4nMzkVUszktBkdMaWO8GCV0T17vmTA5Pod7eeiCmsH4plrEBs
	dFeCP4q2AG5PMm4ZCYPAPsYP+/SQ=
X-Gm-Gg: ASbGncsC4NSV/vTZoAmXkmb3CUCGtspKJOCqJw3e5HoLUaWmgAqnNZeXYBBTgrKN5lf
	OJgFPM63b0sgc2XRz5KBC9adq58vmWwY=
X-Google-Smtp-Source: AGHT+IGnw3PHTTO0WJEaz4iIAJkEZuaxE+xsctQhUNCPKjQXrjeXNmUhAvEgSjWGkC8LfBFyANkAmmYobwxezgDOiGA=
X-Received: by 2002:a50:fa81:0:b0:5d0:cfb9:4132 with SMTP id
 4fb4d7f45d1cf-5d418567f3emr1520906a12.18.1733761835276; Mon, 09 Dec 2024
 08:30:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <Z1D2BE2S6FLJ0tTk@infradead.org> <CAOQ4uxjPSmrvy44AdahKjzFOcydKN8t=xBnS_bhV-vC+UBdPUg@mail.gmail.com>
 <20241206160358.GC7820@frogsfrogsfrogs> <CAOQ4uxgzWZ_X8S6dnWSwU=o5QKR_azq=5fe2Qw8gavLuTOy7Aw@mail.gmail.com>
 <Z1ahFxFtksuThilS@infradead.org> <CAOQ4uxiEnEC87pVBhfNcjduHOZWfbEoB8HKVbjNHtkaWA5d-JA@mail.gmail.com>
 <Z1b00KG2O6YMuh_r@infradead.org>
In-Reply-To: <Z1b00KG2O6YMuh_r@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 9 Dec 2024 17:30:24 +0100
Message-ID: <CAOQ4uxjcVuq+PCoMos5Vi=t_S1OgJEM5wQ6Za2Ue9_FOq31m9Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export operations
 as only supporting file handles
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Erin Shepherd <erin.shepherd@e43.eu>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable <stable@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 2:46=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Mon, Dec 09, 2024 at 09:58:58AM +0100, Amir Goldstein wrote:
> > To be clear, exporting pidfs or internal shmem via an anonymous fd is
> > probably not possible with existing userspace tools, but with all the n=
ew
> > mount_fd and magic link apis, I can never be sure what can be made poss=
ible
> > to achieve when the user holds an anonymous fd.
> >
> > The thinking behind adding the EXPORT_OP_LOCAL_FILE_HANDLE flag
> > was that when kernfs/cgroups was added exportfs support with commit
> > aa8188253474 ("kernfs: add exportfs operations"), there was no intentio=
n
> > to export cgroupfs over nfs, only local to uses, but that was never enf=
orced,
> > so we thought it would be good to add this restriction and backport it =
to
> > stable kernels.
>
> Can you please explain what the problem with exporting these file
> systems over NFS is?  Yes, it's not going to be very useful.  But what
> is actually problematic about it?  Any why is it not problematic with
> a userland nfs server?  We really need to settle that argumet before
> deciding a flag name or polarity.
>

I agree that it is not the end of the world and users do have to explicitly
use fsid=3D argument to be able to export cgroupfs via nfsd.

The idea for this patch started from the claim that Jeff wrote that cgroups
is not allowed for nfsd export, but I couldn't find where it is not allowed=
.

I have no issue personally with leaving cgroupfs exportable via nfsd
and changing restricting only SB_NOUSER and SB_KERNMOUNT fs.

Jeff, Chuck, what is your opinion w.r.t exportability of cgroupfs via nfsd?

Thanks,
Amir.

