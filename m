Return-Path: <linux-fsdevel+bounces-49394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CD3ABBB67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 12:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8C7179604
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E9F267B95;
	Mon, 19 May 2025 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9svh31E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE21DC98B
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747651615; cv=none; b=I4DXWP7ozDvVAsWVkga1ky0wwpJirEn5W7CgHoiwpulKWH7gJYbhEcRo+qegPVaYhHzg7iZrrX6cx4qX50DpF+Ju074vSzgLTy9v6feR8aIXJ3f2mSWkBlEHWKM0cE17c2j2BWak2rStglNW6E/lxO8cYelR8LrVmrqqlZrwSsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747651615; c=relaxed/simple;
	bh=LaLjgV+kyqjqRygdZUHEvyapXEdIIdulsydMsuCk9to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIc8QEpb++M6dxImJm74CPjpfwlPhLrSFfMl3TxryHt++CQA65XXoZaVf71Na9D1V393tt8Shb/Zq84emIaoZxj1xTyEEOsf9xPEaY7MXsALktvdOsGUri7i/rW/02QUHufmjZCta6rYObYNhLT7QaOC1XB17r9/0mLnag4rEoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9svh31E; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad51ef2424bso609006066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747651612; x=1748256412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqwVldrrVQfYaUxnvxKLY+VMoMoo2tXmalWtj+QPuXM=;
        b=L9svh31EGQXw/BZze2kOYZWTXacg8EaSY+K1s+egWTqMs2tv0At5gD2g9bNl+Ymi8w
         1+iVnRvk21grEeMUZp0BElJ4+IkG+4h9yfRxxi9mOGP78G5GXJhY8VV5FTbjRK/JS0hg
         20uvGt8R6v44wUd3Un7Zezyo1gqObgHxjKs/4+a2Ra44Z9wjEyWqkBAwvhGE6vTe1lrx
         zu63cFLAfowlFvjCrFrvwycjHV7Q0diyfO86yYg9UPO9PEwuTn/StOTKARe6Hca2D09v
         EeTnZuXM1ZBKC2j+fCGy7tSR9G5nN/4ggM3m+sW6K9ed6Etu4BnNgKBf+h3C6Kcx4eKx
         5v+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747651612; x=1748256412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqwVldrrVQfYaUxnvxKLY+VMoMoo2tXmalWtj+QPuXM=;
        b=RKbKXFRZFX6MqidstQTX7jmDXcR2HpKIlptbOsrpbn/36456YywEHOC4Df3Jzl6fBX
         R/+crTJ7gI0tWbzv/kJZo6+xhncsS4a397abhMImsI9eEZ0j2pj9aw5auCmeyhj09+Ui
         0M9pamF/lu0n5S0FF8W6vK4iijbV1Rs8XHq/689ffANWuqxn6O2Bgy2mc3dAFFd5rWME
         DyvIBbr3AbulNf00bM3L6BemS71z0uHRD/fmXNp7uqwNdpvx+JNsyseV+Jtj9bY1z1nS
         hE99ho/0qNa0Mifs97hxChg5jUWuipMj239tXmVRcjQg84PK5VMOx2xqVxzs7HX7TzT3
         CYRg==
X-Forwarded-Encrypted: i=1; AJvYcCWm1s2G63DdJvI+Td+BDxzEWSvRWuSrb5r3uTTDqRd23Tk6cc/NciVNPeaJHslalDP2JQcPGncjzWVWAAq6@vger.kernel.org
X-Gm-Message-State: AOJu0YzFn+v3nb8oaPgx3QkykBIqoH/ErqsGcmZsb/d1fDEQSwzg7wVA
	VHtGFcjTUesKxZnpu4xWEdm/wLh/GJG1/zPd1ROeMiOlUDJpzAVVielXp42E2KzXn5MLYeT2JTf
	lgX890KcsiPeNg5LRxvnWDgaqRFLPAHE=
X-Gm-Gg: ASbGncvpn/YE+USgM44S7MCJMvU6pOujhy1g74ndWPhM0e08Sp3FeRAJ9IyJFVTN5sZ
	FXJjp5eYbyy9IunyOFSuACrO+USLFqX5KZhm4jnY6JMkSDAv4HyKuAcTXtruONqR5974jpvCwNu
	8DhXvlDu/6JJ4qTQxIQauHr6ObZzEW19+d
X-Google-Smtp-Source: AGHT+IFT5LwrHmGKQTkzSrS21UCyLxa+CWhseYaxtu/HPTbVnf1Dso5Ma/cMdKrHWyKziZY+0STlUB7PTahtMyOuzFY=
X-Received: by 2002:a17:906:f58c:b0:ad5:59c5:a4f0 with SMTP id
 a640c23a62f3a-ad559c5cfefmr580914166b.39.1747651611900; Mon, 19 May 2025
 03:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419100657.2654744-1-amir73il@gmail.com> <20250419100657.2654744-3-amir73il@gmail.com>
 <20250519-faust-umrunden-47d15c4b288d@brauner>
In-Reply-To: <20250519-faust-umrunden-47d15c4b288d@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 19 May 2025 12:46:40 +0200
X-Gm-Features: AX0GCFs6c1cdS6t091JXa7Uzz_BvgPZwdko1kzi2ZLfZeUYkkKyJn5ZBoxdyTy0
Message-ID: <CAOQ4uxiyJd4haJ7EJrjkOqb+Gj3x36yjtN82i+iSj=RDbxE6hQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fanotify: support watching filesystems and mounts
 inside userns
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 12:03=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Sat, Apr 19, 2025 at 12:06:57PM +0200, Amir Goldstein wrote:
> > An unprivileged user is allowed to create an fanotify group and add
> > inode marks, but not filesystem, mntns and mount marks.
> >
> > Add limited support for setting up filesystem, mntns and mount marks by
> > an unprivileged user under the following conditions:
> >
> > 1.   User has CAP_SYS_ADMIN in the user ns where the group was created
> > 2.a. User has CAP_SYS_ADMIN in the user ns where the filesystem was
> >      mounted (implies FS_USERNS_MOUNT)
> >   OR (in case setting up a mntns or mount mark)
> > 2.b. User has CAP_SYS_ADMIN in the user ns associated with the mntns
>
> So the crux of the problem is that we need to be sure that for all
> options we need to be sure that the scope of the permission guarantees
> necessary privileges over all the associated objects are held.
>
> CAP_SYS_ADMIN in the owning user namespace of the filesystem (1.) seems
> trivially ok because it means that the caller has privileges to mount
> that filesystem.
>
> If the caller is just privileged over the owning user namespace of the
> mount namespace (2.b) then they are able to listen for mount
> notifications starting with v6.15. Note how that the permissions are
> specifically scoped to mount objects in that api.
>
> But what you're trying to do here is not scoped to mounts. You're using
> that permission check to delegate privileges over non-mount objects such
> as directories accessible from that mount as well.
>
> IOW, if I set up a mount mark on a mount based on the fact that I have
> privileges over that mount's owning users namespace then it reads to me
> that if I have:
>
> mount --bind-into-unprvileged-container /etc /my/container/rootfs/etc
>
> such that the new bind-mount for /etc that gets plugging into the
> container is owned by the unprivileged containers's mount namespace then
> the container can see write/open/read events on /etc/passwd and
> /etc/shadow? But that bind-mount exposes the host's /etc/shadow and
> /etc/passwd. That seems like a no go to me.
>

You are absolutely right.

This is why I change the mount mark to require same privileges
as filesystem mark in v3:

https://lore.kernel.org/linux-fsdevel/20250516192803.838659-1-amir73il@gmai=
l.com/

Sorry that I have not clarified this in this thread.

Thanks,
Amir.

