Return-Path: <linux-fsdevel+bounces-36690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C889E7F1A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 09:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A9B167A5C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 08:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D502E13C690;
	Sat,  7 Dec 2024 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaqNOB1B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C413665A;
	Sat,  7 Dec 2024 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733561357; cv=none; b=ti3cy1SnoO7xcGRTLpGxM6Y9+W+ssijbfA9XsI8Xi+Kt9aFkyZDy0ioNGOQx8ewMM0sbuC7LfqEpDqXXw6Jdxj62zIelJnWL6r6WsZ2sEZVUuovDlHAGobUqD9/juXPJMxsT0TuKofGOEMwL+x1a6wMrFRUg8zYh13POeQAHNaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733561357; c=relaxed/simple;
	bh=5GKA+vbte+FsEYYxUpMwZCs4AtQKQ7dQr4JEctxyC3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cS0DVkkZOfnRk1w5z1KCoQ3m1Wzh+m4advRoftkQIT4+TR7Gj7lIEEI2ntmWAeDsi7N8SQ9ps/KGEAFKwGvIjJQ5RO1g9D6bhxaZ7rnKWBaGePQGpVfXxI9zmBcun+KM05vSQq/gx4vSOYVE1YauKx+2k1orpZ6mMUZCT38bdjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaqNOB1B; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso356206466b.1;
        Sat, 07 Dec 2024 00:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733561354; x=1734166154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hSP0puytjp0Y0zAx0eNIAWPfHJkDF0VFbADCuhWmQ4=;
        b=jaqNOB1Bod3dvcexa8nE7cuI7QEtN8hU0oh5k58l+qal30dVZi8SCcO/9UGfO+0pLm
         PPyox6sFHaQeCbvpoEp4UFrnKN77XtxlJoJd91QcOr26NshqJ7vLXsCkKgEJn25HNun+
         cEnDaCiLXQBzx9hczqJkCrGFZgeTuS+D2ts3LZ1zvJdB++p6IuEU1pvYiBcDXuo8QD3N
         hDMjU509iRgCpD1f5dXWAeUtne5O1S6RfpzX6gjQE94TymK7K9POpwr5P3ghNkSTdQqt
         IV26qiOFWXoIqSlAynjf/6HDI/hzugU4ViEJB0/SHXdOXeWlugDrzfhZtGnAyv+ZDvfQ
         9uUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733561354; x=1734166154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hSP0puytjp0Y0zAx0eNIAWPfHJkDF0VFbADCuhWmQ4=;
        b=u6xQ295OKVNu6fkFX7AQdpEFoEEIotjb8BnLHxPih583G8H2m8H0UP20zs985uCj5d
         0JRQ4dgkuXrhLrOjUzE9uaRUTJcoolY7JiDc7H8TIFgx5c3JFn6E08u/I2AuIsg4Di5H
         9xnqX1jVK4EdpvkdeU8JoOllmxD1dPkyBoQN7Bn8UjvyEJBPdgXE+Jlv991oeFrEhg+U
         ZfgQziHpFPkabB3l4+Xn7cwN0haPtRn2dTkQYNsu+5HPa+IwpXXgOFhLwhNYITr2jiQ3
         b7xbMBeW2kUbB37lQwMXV5YgiA1cF31EmjMKC69lV94kjR5mfBXKHy/W1f24fOfl99q0
         yU9w==
X-Forwarded-Encrypted: i=1; AJvYcCUWoqO4HeeGPzggrc9ceMjtnWH5OMCrYCBgxStl6Zs3/Czi5ue/6+GoQghcYUh9UBAnpldcy40Rg3CzTBAF@vger.kernel.org, AJvYcCV6an9w9Q2D/h9NvXfXhDnN5f5fqpgUgYPz2JVj5B2YyxhVqHNku1oXvz4IWJnlapBP4ZbkNUiuUEuo@vger.kernel.org, AJvYcCXvAdVo3TGyaj/o3mntOPYT/tGMKc/k3Wlkqzk8FokYhbRv75B3WrZFeyo+q2WsKjF/woA03BJt65FcDH/Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzphTQuhPPY0eJ8dVDuO8v4cJKZTVI+iu1NR4OKlGq7YV32ccBw
	E3frM5iV+lwAO/sgbYhz1ZIuas1nZlJRHX1cUrpwkBQeGIbrtdfy3lwa8yyu061wRpkGUnQa6id
	ljVIZOLf9xiXh7jbVhTnEld3qIv9JXFizPXU=
X-Gm-Gg: ASbGncvWyvl5xjBwESHT1wNOR0w3aqCA2ctsYTZimBq/mY+D9PtXwPpRdYF8FhtxBAI
	6SWMC2PWZaIV3m9Zh6icqNtbadwvrqD8=
X-Google-Smtp-Source: AGHT+IHiPKXD6U2wEjizdAdQQpJLBRGoO27NflI25U/GTYqfvZidUlJGCeVyA9IXcSzWD+qq/+d6WVb3tjpBLX7by/o=
X-Received: by 2002:a17:907:9507:b0:aa6:38e9:9d03 with SMTP id
 a640c23a62f3a-aa63a09a422mr349425266b.30.1733561353613; Sat, 07 Dec 2024
 00:49:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <Z1D2BE2S6FLJ0tTk@infradead.org> <CAOQ4uxjPSmrvy44AdahKjzFOcydKN8t=xBnS_bhV-vC+UBdPUg@mail.gmail.com>
 <20241206160358.GC7820@frogsfrogsfrogs>
In-Reply-To: <20241206160358.GC7820@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 7 Dec 2024 09:49:02 +0100
Message-ID: <CAOQ4uxgzWZ_X8S6dnWSwU=o5QKR_azq=5fe2Qw8gavLuTOy7Aw@mail.gmail.com>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export operations
 as only supporting file handles
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Erin Shepherd <erin.shepherd@e43.eu>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 5:03=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Thu, Dec 05, 2024 at 12:57:28PM +0100, Amir Goldstein wrote:
> > On Thu, Dec 5, 2024 at 1:38=E2=80=AFAM Christoph Hellwig <hch@infradead=
.org> wrote:
> > >
> > > On Sun, Dec 01, 2024 at 02:12:24PM +0100, Christian Brauner wrote:
> > > > Hey,
> > > >
> > > > Some filesystems like kernfs and pidfs support file handles as a
> > > > convenience to enable the use of name_to_handle_at(2) and
> > > > open_by_handle_at(2) but don't want to and cannot be reliably expor=
ted.
> > > > Add a flag that allows them to mark their export operations accordi=
ngly
> > > > and make NFS check for its presence.
> > > >
> > > > @Amir, I'll reorder the patches such that this series comes prior t=
o the
> > > > pidfs file handle series. Doing it that way will mean that there's =
never
> > > > a state where pidfs supports file handles while also being exportab=
le.
> > > > It's probably not a big deal but it's definitely cleaner. It also m=
eans
> > > > the last patch in this series to mark pidfs as non-exportable can b=
e
> > > > dropped. Instead pidfs export operations will be marked as
> > > > non-exportable in the patch that they are added in.
> > >
> > > Can you please invert the polarity?  Marking something as not support=
ing
> > > is always awkward.  Clearly marking it as supporting something (and
> > > writing down in detail what is required for that) is much better, eve=
n
> > > it might cause a little more churn initially.
> > >
> >
> > Churn would be a bit annoying, but I guess it makes sense.
> > I agree with Christian that it should be done as cleanup to allow for
> > easier backport.
> >
> > Please suggest a name for this opt-in flag.
> > EXPORT_OP_NFS_EXPORT???
>
> That's probably too specific to NFS--
>
> AFAICT the goal here is to prevent exporting {pid,kern}fs file handles
> to other nodes, correct?  Because we don't want to allow a process on
> another computer to mess around with processes on the local computer?
>
> How about:
>
> /* file handles can be used by a process on another node */
> #define EXPORT_OP_ALLOW_REMOTE_NODES    (...)

This has a sound of security which is incorrect IMO.
The fact that we block nfsd export of cgroups does not prevent
any type of userland file server from exporting cgroup file handles.

I hate to be a pain, but IMO, the claim that inverted polarity is clearer
is not a consensus and there are plenty of counter examples.
I do not object to inverting the polarity if a flag name is found
that explains the property well, but IMO, this is not it.

Maybe opt-out of nfsd export is a little less safer than opt-in, but
1. opt-out is and will remain the rare exception for export_operations
2. at least the flag name EXPORT_OP_LOCAL_FILE_HANDLE
    is pretty clear IMO

Plus, as I wrote in another email, the fact that pidfs is SB_NOUSER,
so userspace is not allowed to mount it into the namespace and
userland file servers cannot export the filesystem itself.
That property itself (SB_NOUSER), is therefore a good enough indication
to deny nfsd export of this fs.
So really the immediate need for an explicit flag is only to stop exporting
kernfs/cgroupfs and I don't see this need spreading much further
(perhaps to nsfs) and therefore, the value of inverting to opt-in is
questionable IMO.

Thanks,
Amir.

