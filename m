Return-Path: <linux-fsdevel+bounces-27829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E747E96465A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3742281417
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462D61A76D2;
	Thu, 29 Aug 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XxD0rm7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A61BC4E
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937704; cv=none; b=ie+qBQ7eA4Kytn/vBCSyOQwpXHBngj91ka8RhQFk7b6SiowsDWltel+FjchIDg48VWBPUfECgVgUaMRl7pgcfAXQvW7Nz1m8+ibOeD2Xvpisb5UFfFCnOA87S+vub3DfOke5uGltw3J5gC74AsOKl72880fguye0aSln6F8vZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937704; c=relaxed/simple;
	bh=hdV4rZzJMRAJBVUYw2ja547l7Uw/TfehnV91g5CT5jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEnqr5K56XjzZDKYxnDCO1v4ODl8AUxM2vABg3/DATd5H3bBmBmowRY1jawXhgYEZWt0BGa7dH5Rvaj/uTgPTTZg4qTMK3tZN4pKrSprBdzR9Mm8N3jvBXsOy1MhqHsjXbUuaAUW568YbWOredimtqDDeDU8rLDD5jbp4vCWz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XxD0rm7L; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-691bb56eb65so6442427b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724937702; x=1725542502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17X032zDJy+/0wMUgmzbwhIMKf3z2lFl5ldVJ4sPDf0=;
        b=XxD0rm7LkOJAUwXzSkLZwRdHMjy+qM0ZOIWLviQVXMMT74B3prBKxtMy+JEoamWEBm
         6HypZTVcDb1nRr9nptpDfzz9dfqDQ1onIG1goU7zLNnCE0YBL7gwOyGjmap1eMCyY74i
         v31jstwuVtK23YqSv5tmT2ZCMecR7tCEqnhFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937702; x=1725542502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17X032zDJy+/0wMUgmzbwhIMKf3z2lFl5ldVJ4sPDf0=;
        b=f+NGq0csmCj13viK6X+wy+LJOPee5i+ci0ts3A3cpZOjoKTd5ric0tqJ4qP6sVL1kF
         hCIJ+P828hMdiezC+yEfI5c9mLnMw7+xujebVvPdqj9dfhDMmcCAbb2OqF7AoLmbci5f
         4b+lgL1QbyXQrV29f6CwDUf2YtCt5JvT/e+34URAMidfxGqPiHK7tlyTuwuaDFYWy1Xd
         PpIT8C2Z0QDersLMTyy1LfLXIx6DtsZmXm8OxTG+cSHJbDh563hDKz0/B+l+UmOZz3kQ
         ry+3b2qUb2WM9ewv1ZJvK1IjvLV0Y9xfzv4XTfWFYLNqmEOMDlctVJZV5j7jYCaLgI0Q
         VYpg==
X-Forwarded-Encrypted: i=1; AJvYcCUX60YxGbaTuH74gRIhHmQ3nGLU9d6Gafy8Z91LPQ+8dpVzdUFb14GZlmncLuYUvdd18ExkIjv7KzymQ0Ix@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj3X6eMzWDUuFuMpuW4Yaoc+Cc9d6xvqxtUywKn4yQYyfk6ZQ6
	VYv80gSs+3EM9vRLYyB53OBKi5VZkS+0kOK9vtmBIBive1E54DH7cihdPkuSLjTBQmJbpDSPrkT
	gwQPEHq4vG6+fpCT24fsQxPyVsSVBFxXsj4fOlODmnOntC0L8pQ4=
X-Google-Smtp-Source: AGHT+IGFmmq4KYWULCCzqEFKek25OxK9x8oLjmoZmu8m4Sd2SvnaVWUH+kbP/SjW5Ho91ld6gT2dR61FWiPYKjgvHmQ=
X-Received: by 2002:a05:690c:2f0a:b0:6b0:d9bc:5a29 with SMTP id
 00721157ae682-6d277a7927emr26497587b3.32.1724937702395; Thu, 29 Aug 2024
 06:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709111918.31233-1-hreitz@redhat.com> <CAJfpegv6T_5fFCEMcHWgLQy5xT8Dp-O5KVOXiKsh2Gd-AJHwcg@mail.gmail.com>
 <19017a78-b14a-4998-8ebb-f3ffdbfae5b8@redhat.com> <CAJfpegs0Y3bmsw3jThaV+PboQEsWWoQYBLZwkqx9sLMAdqCa6Q@mail.gmail.com>
 <b82dd5f9-a214-4a13-b500-38b07f1e9761@redhat.com>
In-Reply-To: <b82dd5f9-a214-4a13-b500-38b07f1e9761@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 15:21:30 +0200
Message-ID: <CAJfpeguO_jt=fR+kMkmbJDtbD9f-+fAafkmS+CbE0qE_Z2wFug@mail.gmail.com>
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	Miklos Szeredi <mszeredi@redhat.com>, German Maglione <gmaglione@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Aug 2024 at 15:11, Hanna Czenczek <hreitz@redhat.com> wrote:

> Hm, I thought we set some things in fuse_mount and fuse_conn in there tha=
t are then queried by fuse_send_init()...  Maybe the only thing fuse_send_i=
nit() needs is fm->sb->s_bdi->ra_pages for max_readahead.

Yes, that definitely needs special treatment.

> Sounds simple.  Do you think semantically it=E2=80=99s find to block here=
?  We=E2=80=99d only do it for virtio-fs, so a denial-of-service may not be=
 of concern here.

It should be okay.  AFAIK all network filesystems block mount(2) until
setup is complete.

Thanks,
Miklos

