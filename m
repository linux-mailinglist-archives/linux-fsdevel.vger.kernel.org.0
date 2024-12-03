Return-Path: <linux-fsdevel+bounces-36336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6060E9E1CF5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 14:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3448F160F66
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 13:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A91EE01A;
	Tue,  3 Dec 2024 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asYS9Ct1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B841E0E0C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231020; cv=none; b=VAobia3Yx//L/W+8VaFstAW/8Nfav1i5FSSPgdAibhPpewQyTbghncq9aUI281QDM9I02ALaRKH66zhH/JirP8kFNHcFEDTLWgzWGrq8iAT/HRJknvUXLqRJQ/gij6NgYMf4l7Vful9w2nNEV8DEZ0gaSYQvImJpyG7JM9eE4Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231020; c=relaxed/simple;
	bh=2U7x5aA0jgitAcyZkG6CgazeD3B07cT0Z7yaSzC6UW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tox5vfS3Sig6C3boLWswg2XQ+071yq0OjfTDU29nl40QFxEQroAz1BdRjv7QLne+ANtENljf1lHG2CpItJDyKriZMhzpxFu8SavfiitrQhGzmKXxydY80tbi2JXSGqf8L5UibJFO5n6L9QCwnI2Xl1iUm1sg8GoM7DY/9v6jZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asYS9Ct1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa5500f7a75so860117166b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 05:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733231016; x=1733835816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckocanvAWmbMVUjzXTeIFmgNJ6YGDZSiOGqs6DQ6bWs=;
        b=asYS9Ct10rq2eFUTq/yvRYweMk2JokXfQF/T1DxWtrxP+z7MGNp/HwRvAfzFgbQVxC
         UohCsTm0JzysydTZKd9q0gC/meI85L8OCy6o9GX+NiMLqhahcrShLP7aL8NYMHhv8xBn
         hsbwUyN9eVX3L0+ZRuNuqJ10GPUxCpiJLqERwWOP2C+LDo2ZvCojAcvL2+ICpBxl+zNd
         M6vpa32ty9XBIms/Q9wvDq1R54HJP91frAaB75dv803YIOlp4hey3XAkEUfFo2aOm4yX
         VdYccuIJ3zfMujwjJzq5Rn+y6KKsNZkPeVp4c/s0JJ17V1RaSFdZzoblzQn+GHPiZD1O
         X7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231016; x=1733835816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckocanvAWmbMVUjzXTeIFmgNJ6YGDZSiOGqs6DQ6bWs=;
        b=oO5n+2TJ6/k3yh32tSXKsvzvgwwTTorO+B05ntnN16hu/e5BthHIX8tlly86/BUpuh
         E9bEDk+qX8KE5IZVD4NZWE4MLWHK/7igsn5VeCT47qs1GrL63MwFamDDVlQRPQvQBvi1
         uaVTwjQ1UfL5j6gFCw8IZbXrZqF2PaV0byR43CuYc9N4XUYysBBvkrJjCZW3qfRSc+qa
         CD5JT0GfoShjTvV8Nbsf1CftuSvmUje8dzHz9DhN9bTugVQOdgagpDUOOGbOq6p1T25u
         DOTN31S1o7Xd1KHSCvLNjvv0TEAn110Bg/NmAsf9R1wVrr+kck60MuIYPcNGWLHcLM6R
         q4Dw==
X-Forwarded-Encrypted: i=1; AJvYcCU9nUjkUj5gvW6YJ6KEGaQAkqSvKr7XN4OpTnuKeqoYsVkHnK7J2ijoWwgwUlbgUeYbK53ibyFeUINEBSw9@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKQDahdlZyr+CXAvsRBQGVdcXZlj2lPK/X5CKGUxF7AIGIoDd
	w6M1fPqbJ6qMfNH8OPWb71fcVahTJWn4bNV3tiY/jGS6OVJMrSBLdmPuvW1kAg5Dmt6lZKIzX3D
	uolXvXJ/cdt+NDFnxBVf/Dp14M/o=
X-Gm-Gg: ASbGncvd3JEchFSMsKvgS307IAuCiFxZ0pYloDfqQXrtGSON5Yiyo0XRWXaQUxXoUOO
	V5iU3lj27SUGjNPqe2ly1pada9cZ1wdk=
X-Google-Smtp-Source: AGHT+IG97xRU+QKV1A2oZzZ4wxkenn8V/M8q3Y2U1t/mu20UzI7FpluGda0xbrDB6RdZS/+uIjtEz0/UPgVn472y6jQ=
X-Received: by 2002:a17:907:774c:b0:a9a:6d7:9c4 with SMTP id
 a640c23a62f3a-aa5f7ca9f8dmr195346366b.12.1733231015852; Tue, 03 Dec 2024
 05:03:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128144002.42121-1-mszeredi@redhat.com> <dqeiphslkdqyxevprnv7rb6l5baj32euh3v3drdq4db56cpgu3@oalgjntkdgol>
In-Reply-To: <dqeiphslkdqyxevprnv7rb6l5baj32euh3v3drdq4db56cpgu3@oalgjntkdgol>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Dec 2024 14:03:24 +0100
Message-ID: <CAOQ4uxh0QevMgHur1MOOL2uXjivGEneyW2UfD+QOWj1Ozz5B1g@mail.gmail.com>
Subject: Re: [RFC PATCH] fanotify: notify on mount attach and detach
To: Karel Zak <kzak@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 12:40=E2=80=AFPM Karel Zak <kzak@redhat.com> wrote:
>
>
> Thank you for working on this.
>
> On Thu, Nov 28, 2024 at 03:39:59PM GMT, Miklos Szeredi wrote:
> > To monitor an entire mount namespace with this new interface, watches n=
eed
> > to be added to all existing mounts.  This can be done by performing
> > listmount()/statmount() recursively at startup and when a new mount is
> > added.
>
> It seems that maintaining a complete tree of nodes on large systems
> with thousands of mountpoints is quite costly for userspace. It also
> appears to be fragile, as any missed new node (due to a race or other
> reason) would result in the loss of the ability to monitor that part
> of the hierarchy. Let's imagine that there are new mount nodes added
> between the listmount() and fanotify_mark() calls. These nodes
> will be invisible.

That should not happen if the monitor does:
1. set fanotify_mark() on parent mount to get notified on new child mounts
2. listmount() on parent mount to list existing children mounts

I think that is how Miklos designed the API, but not certain.

>
> It would be beneficial to have a "recursive" flag that would allow for
> opening only one mount node and receiving notifications for the entire
> hierarchy. (I have no knowledge about fanotify, so it is possible that
> this may not be feasible due to the internal design of fanotify.)
>

This can be challenging, but if it is acceptable to hold the namespace
mutex while setting all the marks (?) then maybe.

What should be possible is to set a mark on the mount namespace
to get all the mount attach/detach events in the mount namespace
and let userspace filter out the events that are not relevant to the
subtree of interest.

Thanks,
Amir.

