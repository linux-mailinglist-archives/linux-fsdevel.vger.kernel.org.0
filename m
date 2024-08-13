Return-Path: <linux-fsdevel+bounces-25824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C2F950F34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945EAB230D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 21:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7150D1A76D6;
	Tue, 13 Aug 2024 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL5WfMZB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661FE17B515
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585084; cv=none; b=YvJ4l7eQLM/OhzGtyBUvh21dQLHeXcR1/BwC9gw1Jj+cBPrUFEvg+Mrj5Mfd54I7foey1Aqb4Dgl8i7kY27AIUK0eN+p6bHxanC86iYDHkzAqT43R3G73AevlkIlruLNrAgD0eeWe7W1dU2HAfG6DCBCSQEkOExBb79XXYVPvRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585084; c=relaxed/simple;
	bh=BYNcgNkhyRENcFcuQnhaRH6elMZfJ9kHkV7sXh/uBdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCPRdLcIgf+f9lRexFGIe1A9HL/A+X9fBlw8ojAsHYK2UA5olasMB/ZKu5knEHnwXev7h46/EyYjBQINd7RzD0BYTt36XX/YAnEyzGfd/C8oMNiFlfYdTyij60Hhcpp9bwhVoCYH3gtj1k/xYpBsfhvBjiHnBB63prVp79B7n70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DL5WfMZB; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44f6700addcso25676551cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 14:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723585082; x=1724189882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYNcgNkhyRENcFcuQnhaRH6elMZfJ9kHkV7sXh/uBdg=;
        b=DL5WfMZBAL/1EPGvGlDtqBLontJQwhthFUnBwG8NLGOtHw+WV9rNP3Q9x5CNS12jDK
         Dx4mcyAcdVHY9Bq3pGDwfx1wUqkmkoDV9f9mR5Bctyna07elnZcXC9TWpOC+YvebP85S
         x64tVGPva7ak+wkFgUnc7qcmbLaaWvlSn2x3VJbpNvA2wIWoBN29JPiGda/9M9Gzmijc
         Nt0NstI90jieeP/zdl0hyrYMoXdevAwVpQY2mqp4HzSUU7JMZaQaMKHF9Yz/8lH21+Gi
         lM68BsfrJsGkIh4Fc182gPLFpkExuvAcLDa9/Pjz1+nwjhKPicaSjRrEID/T8LAkSFtf
         v/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723585082; x=1724189882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYNcgNkhyRENcFcuQnhaRH6elMZfJ9kHkV7sXh/uBdg=;
        b=azzQGxQ1Pt/rn5bf8Pvwtg2Z5+w6KaE9743x7y/XKuFMQ4ccFrMqhxSkcyQTK6hLy4
         AMZORKhUvUGbPMlfJxqVf/PiuA0VjH+SQtkeM2IrdamUQ5rFKal0xIsQw0xz8hf1xOcc
         S55oy2zsLERoK6j5z5OSyBC7A/0Lxic5nU2Yd1mAOwXIjl3hyEapoLe6NbFHthKpEzhk
         ATm6YjXQrwGRHwP4GCn7dEc91CLAk4cWME+I29tqkkqJWoQDeDzcfhJt+0iXDEcjvXNK
         beVecfNvd62pQuHDrGxRCO3JpIoD7nyN72gZrVCWp5MlYPCBE6O2aVqefHucS7b762uS
         XBmA==
X-Forwarded-Encrypted: i=1; AJvYcCWYjQ6/3ehRJ2KJ/i5vGPvJDETXX+znDRpJDuWWObk5ys9JO/ha4O0tFwSxOzqzCLe2T5/LLDHIqJjLzPS3v4JXVJP3j1t8dfcnBPD3rw==
X-Gm-Message-State: AOJu0YwPbtMHsTxeDvbRb5g1V3coa+b5wwL8tQvMn7XF2DswmMBRkZQa
	4cI26w0nb4wMd9QBvSAeW7bsJi0v69HoX3Q3PLeAuy3IUCkOZXdu4qG9jZ0KdAiqIS1+g08W6Jl
	Bz995ZfyxYAqxfKWF8f7YJ56VT5g=
X-Google-Smtp-Source: AGHT+IHJjPStWE9LsqNwcuL0cLFfERwnh2/yfR/Eb+Xos0HNsIwkZaHeFo+0qQJkTk/eeZKuVsL+pMVswEpaNjEaccA=
X-Received: by 2002:a05:622a:4a8b:b0:440:6ccb:e6d5 with SMTP id
 d75a77b69052e-4535bb9e306mr7523611cf.51.1723585082273; Tue, 13 Aug 2024
 14:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813212149.1909627-1-joannelkoong@gmail.com>
In-Reply-To: <20240813212149.1909627-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 13 Aug 2024 14:37:51 -0700
Message-ID: <CAJnrk1ZGsE2Unk+71rQ7-g6dz1-cHnrgVEQ=Gq2-fHihK-zQBg@mail.gmail.com>
Subject: Re: [PATCH] fuse: add FOPEN_FETCH_ATTR flag for fetching attributes
 after open
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, osandov@osandov.com, bernd.schubert@fastmail.fm, 
	sweettea-kernel@dorminy.me, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 2:22=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Add FOPEN_FETCH_ATTR flag to indicate that attributes should be
> fetched from the server after an open.
>
> For fuse servers that are backed by network filesystems, this is
> needed to ensure that file attributes are up to date between
> consecutive open calls.
>
> For example, if there is a file that is opened on two fuse mounts,
> in the following scenario:
>
> on mount A, open file.txt w/ O_APPEND, write "hi", close file
> on mount B, open file.txt w/ O_APPEND, write "world", close file
> on mount A, open file.txt w/ O_APPEND, write "123", close file
>
> when the file is reopened on mount A, the file inode contains the old
> size and the last append will overwrite the data that was written when
> the file was opened/written on mount B.
>
> (This corruption can be reproduced on the example libfuse passthrough_hp
> server with writeback caching disabled and nopassthrough)
>
> Having this flag as an option enables parity with NFS's close-to-open
> consistency.
>

This is the corresponding libfuse change:
https://github.com/libfuse/libfuse/pull/1012/commits/a59f8e0f5ac9e09c0a54c5=
cd94e6bca7b635f57d

This is for the same overwrite/corruption issue Sweet Tea brought up
earlier this year in March in this thread:
https://lore.kernel.org/linux-fsdevel/9d71a4fd1f1d8d4cfc28480f01e5fe3dc5a7e=
3f0.1709821568.git.sweettea-kernel@dorminy.me/#t

In that thread, there was mention that Bernd's atomic open patchset
may solve the issue. However, I don't think this works for cases where
open is called without needing a fuse lookup.

An alternative approach we considered is similar to Sweet Tea's
approach, but gated behind an optional config flag that calls
fuse_update_attributes() for statx_size at the beginning of every
write and removes the FUSE_STATX_MODSIZE invalidation that every write
does (in fuse_write_update_attr). The latter is needed or else every
fuse_update_attributes() call in the beginning of the write will
trigger a FUSE_GETATTR request to the server.

