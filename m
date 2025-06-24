Return-Path: <linux-fsdevel+bounces-52748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 868A0AE631E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495B61925530
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597AB2882A9;
	Tue, 24 Jun 2025 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+NV90Xl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F315257440;
	Tue, 24 Jun 2025 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762713; cv=none; b=T6Wadpubu4xMfIJ3NWAONEh/Efaf3QQo5lrvVmVdDTS6Lq5KqgWxA0wSKQgdM57jRypwoyuwSVjvviwamQZD8Itz0YrSf2GipSDL40Xuk6h85eIAKAj8rcqR+RVgd2mE/JIxU6dn9ao7MGLmZsY8JsZgR69ULEVLtJk8hm14kGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762713; c=relaxed/simple;
	bh=tX3KIXw41x+1CukyHH5Bv3ctT3WPk5s+sqjvAqB0v+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJ1/oxk7aj54yNdKdSQjYDudCRW7C9Hc3Zr3TLiFGllu9sXc2S0wTaTe/RKT/L/44GP3e0LBN3JzD/H5nkkKclqoS4pz8vB0G4ihV/B9XbGoMQbAGpTk4sSVf+UjV1vZDAZMvRC3x2HguFh5WCG+s6jP9AGgv20/xgZ4gAUUuLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+NV90Xl; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-addcea380eeso852607866b.0;
        Tue, 24 Jun 2025 03:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750762709; x=1751367509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3EhBTDK3j9g+9WZQddqvmOqBHhj3RKW2kjGM2kTQ8M=;
        b=E+NV90Xlhqk/SrTUbW2L4HwGJhL03dMWrlF0Fto9x0Gxts+tZUwL1Y6sfomCGfDQnc
         d43nj15JuwYXJmJU8bKKA7oyLIeS3mi730s9bui3MCJxpYFAJTck3gPfE9kKrX47P01H
         FQRPPNIpO8cp6WcBEQwxs+QkpaefW/8zBnzB9T9LuzGkY8qKdYgAifj4GGC8nAy9z/TA
         QtQfHwphSPYmowgjEP12dXEYNZFI+8Y6v03a2QhBpOC+hw76//Fa4Q5wLJWpFl1Ypx13
         woUnGXYm2s0HVy7ExAR1ITqGe0rvxOVxWfEuiOXfQk1jpCO2CjRG18h70bSX4inNkLy2
         YM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750762709; x=1751367509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3EhBTDK3j9g+9WZQddqvmOqBHhj3RKW2kjGM2kTQ8M=;
        b=gxiZBrObdPQu+c6RXvrn+zPuQf7alzEhp2dq4ISdKpcTjQeK1nx0dQ6Yr/v6cNi1Dv
         VFX9cDf62l30bd+XGnMoxmKA/ad5mT3YenodbhjL4MGCvbM7UfMzOtEi8HQ6IiiPvGYm
         k61auVmSzVtH4CZa3maW8etKsDos499zcCh3ZuPtI3WcCXx7Q2ROQil710x1FKGi/+2P
         XF/x1i1u7wHLpcvnXastN/pKs/au6e9/Bx7ihtC3ht9LBWJQzDB1yLGqoMB8TMtxh1/P
         7P01uHgXg6lIHXGhFkFNgw5TfQgK9C6M5OvgkjwrNY9ca6ootLWgAfZiozJZ75wSZqno
         6Flw==
X-Forwarded-Encrypted: i=1; AJvYcCVgDl2vuLdTQSFsSTW+92UxKjswaUEMwaIHJk9P6tJRZFOyTVyfj+8L/9F1j0COHesJk1QiJO69e7cS@vger.kernel.org, AJvYcCW4F55OxpkVYwM9+0IYE1n/HEIf0j5GNjG9yjLvWKTK0ISPYVA/XmVv3zwrQf9dTQxWFL2rT7vM8WRLf39p@vger.kernel.org
X-Gm-Message-State: AOJu0YwuwiyQ7C67kXVJCLAaWdV1ooHoRslqGAQa5NkMdHzgI2OsbjZZ
	aRH7lT0j8DI6LcpCVpOiLswkacBhyMDxVIRquiZqZeTwiKSObS748rKDJ4ssG689DIFUrD6Ebk9
	7HC8BmM9kksvRxk7rriX6rGgZif5+RPg=
X-Gm-Gg: ASbGncsZl4DnCANseP5nyrpZsMFkBI1HA3drA6pZfG8qL4XEyUdAkTWXKYUIODHdnfR
	zZXfxaL2HilDKkW+YViC4cFonvOioTR/d58ZNt2mhPs3L5x2sv5QnmVDWDt0t6hdPDOs733oLb5
	De87H94dio4KqxYr4RLDtsqytJx4TxIzS+dKme2i/3LFA=
X-Google-Smtp-Source: AGHT+IHAQiEh/h8HfrTq1sorV16zpdA/1/epzF7Ok7MLiGzFyCKirQ9pYh/4zhQVyz+aS2FvwnuYT77+z7EFupW0axs=
X-Received: by 2002:a17:907:7f29:b0:ae0:54b9:f8a with SMTP id
 a640c23a62f3a-ae057ef74ffmr1579023666b.39.1750762708791; Tue, 24 Jun 2025
 03:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
In-Reply-To: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Jun 2025 12:58:16 +0200
X-Gm-Features: Ac12FXz9SumPZZRdyAv67J0MOZi71QMYjzIPiVprkbb-iOnFNklq5rJhPpAb9Us
Message-ID: <CAOQ4uxi61BtqDKH9eEDQRbnszLC4SNbmJ7Gf=jmH6f2R1V+RXQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] fhandle, pidfs: allow open_by_handle_at() purely
 based on file handle
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 10:29=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Various filesystems such as pidfs and drm support opening file handles
> without having to require a file descriptor to identify the filesystem.
> The filesystem are global single instances and can be trivially
> identified solely on the information encoded in the file handle.
>
> This makes it possible to not have to keep or acquire a sentinal file
> descriptor just to pass it to open_by_handle_at() to identify the
> filesystem. That's especially useful when such sentinel file descriptor
> cannot or should not be acquired.
>
> For pidfs this means a file handle can function as full replacement for
> storing a pid in a file. Instead a file handle can be stored and
> reopened purely based on the file handle.
>
> Such autonomous file handles can be opened with or without specifying a
> a file descriptor. If no proper file descriptor is used the FD_INVALID
> sentinel must be passed. This allows us to define further special
> negative fd sentinels in the future.
>
> Userspace can trivially test for support by trying to open the file
> handle with an invalid file descriptor.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Changes in v2:
> - Simplify the FILEID_PIDFS enum.
> - Introduce FD_INVALID.
> - Require FD_INVALID for autonomous file handles.
> - Link to v1: https://lore.kernel.org/20250623-work-pidfs-fhandle-v1-0-75=
899d67555f@kernel.org
>

After fixing the minor nits, feel free to add for the series

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Christian Brauner (11):
>       fhandle: raise FILEID_IS_DIR in handle_type
>       fhandle: hoist copy_from_user() above get_path_from_fd()
>       fhandle: rename to get_path_anchor()
>       pidfs: add pidfs_root_path() helper
>       fhandle: reflow get_path_anchor()
>       uapi/fcntl: mark range as reserved
>       uapi/fcntl: add FD_INVALID
>       exportfs: add FILEID_PIDFS
>       fhandle: add EXPORT_OP_AUTONOMOUS_HANDLES marker
>       fhandle, pidfs: support open_by_handle_at() purely based on file ha=
ndle
>       selftests/pidfd: decode pidfd file handles withou having to specify=
 an fd
>
>  fs/fhandle.c                                       | 82 ++++++++++++++--=
------
>  fs/internal.h                                      |  1 +
>  fs/pidfs.c                                         | 16 ++++-
>  include/linux/exportfs.h                           |  9 ++-
>  include/uapi/linux/fcntl.h                         | 17 +++++
>  include/uapi/linux/pidfd.h                         | 15 ----
>  tools/testing/selftests/pidfd/Makefile             |  2 +-
>  tools/testing/selftests/pidfd/pidfd.h              |  6 +-
>  .../selftests/pidfd/pidfd_file_handle_test.c       | 60 ++++++++++++++++
>  9 files changed, 158 insertions(+), 50 deletions(-)
> ---
> base-commit: 4e3d1e6e1b2d9df9650be14380c534b3c5081ddd
> change-id: 20250619-work-pidfs-fhandle-b63ff35c4924
>

