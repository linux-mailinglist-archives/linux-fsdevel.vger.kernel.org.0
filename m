Return-Path: <linux-fsdevel+bounces-20408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BB78D2E09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 09:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B22E286E64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 07:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078E216727E;
	Wed, 29 May 2024 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXO41CTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15D1E86E;
	Wed, 29 May 2024 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967415; cv=none; b=r55iKs+L2v51gKztpgwX09GhXU43NDSOE3R6fZuXXAfjd/k8cydnGG/IfQq8KEWVnq+IV/4dlELYRXerkCRL2GhKFwK3gVGxFaeDshWN9dL5XXg9PSd4jqVTsX9CUNOzxRj4lDe7Y2+2SBoX/8tsFk0v8zIHnANyG6R3xwvxIho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967415; c=relaxed/simple;
	bh=YbcMUl3Yr21K+Yi7SGoXDwuE6o2cNNmCNjhlm4eRlwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHM48LkzjixbxsSZWpbjjhwty8oy0RN5aCI0bVbdlMwgXdq4OxQ1Dd5J+tpjwfUcH2IKOcx1wXHtUgDAM+myZEDt+6avCrsGFKlpNIRZUIRJJrpxFd8XptcOfl6yJ/jQxMUsP0dIjuF2/n0vv3tsuwJSxhkJkK1NisJA6xfRt1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXO41CTm; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-794b1052194so107070485a.1;
        Wed, 29 May 2024 00:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716967413; x=1717572213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI8YKF2Ka4g09jpIM8zfOLygQWEXZLeemxzrmi+Rpio=;
        b=dXO41CTmiKomR/VS3PYisrGMb9Vkc6v1I2tfYdbPAh0etl70CPfLRpPSijckQhGqcd
         w35GQqLwEaOVR31abLYTXRY0R5qB1gZhOnrhFOBp2KKPXPgoMxoFLXvRu0Dvi1w2Kf8Z
         Qc+PtENOyd8A8NUtl/9vG1DbQnEMQilzZ5iKckNTckYemyTnpvQftL4bPNOLSH68S19E
         OFFJEWz4yKLnqmPJuEadTuS2sR3QKRs3uhEmG4zQpI/ZPKE4x45vkTu1gsQGeavf807t
         +WU33l153RY1W6qU8wzagUw4FUCq2JU3U6SR0CnZLdoX+q8LhKaQo5Cwli4Get/uaSYD
         Hqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716967413; x=1717572213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gI8YKF2Ka4g09jpIM8zfOLygQWEXZLeemxzrmi+Rpio=;
        b=e2XkkfHaT13XhES4WIJnEPhaxKLdub1vWv8+SZS1P6BYxs7lc7G9VfHBhNxM0dx/9R
         cUVXaqTp8uQ9s9DMuaNMN2QBoXbAXe1oK93ofAbJrV0kKbPe69ZGK8uUY+q6J56DRQF8
         +XSW0H9h+8G/yYK3Pv4yV4u309miiGgHkMNu8c4ceWfife58iKspvwb0fRN+5StoYGXT
         sPJ2K4rDirhylt88PdvK9l3rCuIdrDiuwZ9EGM2666vxkB9Hrt+lPyCcp2olJzR1pFWl
         1l26Qd8U27oDQSaB8m/XZ4+88FN8dpEBhcZ5AJMiI8XYQ2a48fJiIjib/uBU9krs2gUt
         Te7w==
X-Forwarded-Encrypted: i=1; AJvYcCVOT3VTj/qolKTJlzcLK1Gwzh9MDvFK5s9X5Bcb2Ke04e4LXqkieXFpjE8XzxBoAQie0i/taBoKiIhlxx6CmemD1/8A1dPwfsgLNcfsaUtSremw9enxHMMnDP2O42JC/zoKRx8b3i6WZ48tImCSzWrImhlNCK41BLhyAJiQQH9NdsXlsTanYE1k5D0tbB7aqqmspoEFg8LHlPBK4Oi+ShiCJA==
X-Gm-Message-State: AOJu0Yx5ol2YkQhGplZd/BwGevvBXc7GUl5yhEwoaM2ixLqcKf+uFCED
	zBf8DWyuEutVBQNKK8iAvbi+tPpUu1Q5LoXocvJNBU1+HagA2JQijaKExoo7ZFwx7q6ZQYJQe2Y
	9jvl4riehuTtbsCBJxcTnkNSb8v8=
X-Google-Smtp-Source: AGHT+IELOGt9LVPKWDBseYrnLxtudWIlzNW87iewuhSPONjHfoQRkS3n9W6KZs0Ugv5GJ5aWYJ9yBCflxFgGxEuaQ2c=
X-Received: by 2002:a05:620a:2017:b0:792:93cb:7649 with SMTP id
 af79cd13be357-794ab1360admr1470221085a.68.1716967412804; Wed, 29 May 2024
 00:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org> <30137c868039a3ae17f4ae74d07383099bfa4db8.camel@hammerspace.com>
 <ZlRzNquWNalhYtux@infradead.org> <86065f6a4f3d2f3d78f39e7a276a2d6e25bfbc9d.camel@hammerspace.com>
 <ZlS0_DWzGk24GYZA@infradead.org> <20240528101152.kyvtx623djnxwonm@quack3>
 <ZlW4a6Zdt9SPTt80@infradead.org> <ZlZn/fcphsx8u/Ph@dread.disaster.area> <ZlbKEr15IXO2jxXd@infradead.org>
In-Reply-To: <ZlbKEr15IXO2jxXd@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 29 May 2024 10:23:20 +0300
Message-ID: <CAOQ4uxiXVX-dJTN0UOjP7Zcfnks_kJoHBE+XFBecnUzzK-e5_w@mail.gmail.com>
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to name_to_handle_at(2)
To: "hch@infradead.org" <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, 
	Trond Myklebust <trondmy@hammerspace.com>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>, 
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"alex.aring@gmail.com" <alex.aring@gmail.com>, "cyphar@cyphar.com" <cyphar@cyphar.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 9:24=E2=80=AFAM hch@infradead.org <hch@infradead.or=
g> wrote:
>
> On Wed, May 29, 2024 at 09:25:49AM +1000, Dave Chinner wrote:
> > But no-one has bothered to reply or acknowledge my comments so I'll
> > point them out again and repeat: Filehandles generated by
> > the kernel for unprivileged use *must* be self describing and self
> > validating

Very nice requirement for a very strong feature,
which is far out of scope for the proposed patch IMO.

What is "generated by the kernel for unprivileged use"?
name_to_handle_at() is unprivileged and for example, fanotify unprivileged
users can use it to compare a marked (i.e. watched) object with an
object that is the subject of an event.
This does not break any security model.

> > as the kernel must be able to detect and prevent
> > unprivelged users from generating custom filehandles that can be
> > used to access files outside the restricted scope of their
> > container.

Emphasis on "that can be used to access files".
The patch in this thread to get a unique 64bit mntid does not make any
difference wrt to the concern above, so I am having a hard time
understand what the fuss is about.

>
> We must not generate file handle for unprivileged use at all, as they
> bypass all the path based access controls.
>

Again, how is "generate file handle for unprivileged use" related to
the patch in question.

The simple solution to the race that Aleksa is trying to prevent,
as was mentioned several times in this thread, is to allow
name_to_handle_at() on an empty path, e.g.:
fd =3D openat(.., O_PATH); fstatat(fd,..); name_to_handle_at(fd,..);

Aleksa prefers the unique mntid solution to save 2 syscalls.
Would any of the objections here been called for letting
name_to_handle_at() take an empty path?

I would like to offer a different solution (also may have been
mentioned before).

I always disliked the fact that mount_id and mount_fd arguments of
name_to_handle_at()/open_by_handle_at() are not symmetric, when
at first glance they appear to be symmetric as the handle argument.

What if we can make them symmetric and save the openat() syscall?

int path_fd;
int ret =3D name_to_handle_at(dirfd, path, handle, &path_fd,
                                              AT_HADNLE_PATH_FD);

and then kernel returns an O_PATH fd to the path object
in addition to the file handle (requires same privilege as
encoding the fh).

Userspace can use path_fd to query unique mntid, fsid, uuid
or whatever it needs to know in order to make sure that a
later call in the future to open_by_handle_at() will use
a mount_fd from the same filesystem/mount whatever,
whether in the same boot or after reboot.

If we are doing this, it also makes sense to allow mount_fd argument
to open_by_handle_at() to accept O_PATH fd, but that makes
sense anyway, because mount_fd is essentially a reference to
a path.

Thanks,
Amir.

