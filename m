Return-Path: <linux-fsdevel+bounces-31417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E4996082
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 09:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BD0285615
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 07:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AA817BB21;
	Wed,  9 Oct 2024 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9TRt2nW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9251514CC;
	Wed,  9 Oct 2024 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458284; cv=none; b=N+8DMJ96NzOV/di/6452ecnAERGUZvfuqe08j8iD9nISmcBoU+TzLwPc5vq5jRinoRNlvgVZ6Fnet2eFg6y8PPU+cfEq9cWhH8SBec5iVgnpeEBBJedWefmUglqM8t9PaIzXZwzfPoF2fDn64cD//MwAqGoicTp3pkCb1dSZ4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458284; c=relaxed/simple;
	bh=qI9A8zpS9gJKAUmkpID+nfmlpwHXQkv15ZyLgRMU8jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPgohGPCdI671hnM3LeUOSkEsSoA/xXlKFmvpxIaCLvPeGB8gMGMFtiELSYWrhwvtyiwqPyNP84RMDu2EbIA0u2qA0D84azu1wsXk4OoMe3hLxAcOE6KvZDESPlgsKkiOXa6jcb92Dbr4JZ+ln6fYRk58fI2F06aV/x/4Ivnq4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9TRt2nW; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a9ad15d11bso559356685a.0;
        Wed, 09 Oct 2024 00:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728458282; x=1729063082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yI48fFY73FdM1lgrPJQsQ6wd/GkN8i8SWdd5uNslinw=;
        b=U9TRt2nW/IiKBkOqYES/3liyIy4FTycXVkI79Vdex3V/uLIb6SwvCBFTCWnMxtJ0CG
         eYTX0w2jMBYNlV/DbfDpbd8f5feCH3IVnFNLxwbn6fsdwY2FoCs6K32opVIgLyVaT+ut
         Dtsl1K+4un1vZa+2tRwN7gFJq1AY19s2KhdBPPSAqm/aMYaUwAMs/9AQ5UqeiUNQZNHm
         aQUv21qjcnaL4BH2Dk4L+tgrPYmeK2QkPigbd/2ePUIhuuugh/7c9n6W8oNC5HYhPtad
         OvxRFqkNW7FS5MuJG4KJl8U8jby7/GwbvJ5b5if4WYJNWp9xphe/9jcqvyPbfWsOHFhY
         N4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728458282; x=1729063082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yI48fFY73FdM1lgrPJQsQ6wd/GkN8i8SWdd5uNslinw=;
        b=I/B1F3mWeQGHkGMqnPpZve40hGzRvp3+FkXl4vOHKuaEil+m/UfzIR2L+wm+yRVDSM
         qweTDohiHfbHLu2yhcrW/jn4zQQwhviUbD7YTJSKVYmxJ6gcay7cQqyxpG7DT4h8vIJU
         Z3NQ9I8GeCnHqC1Jtnn5S4gp5Fz/PUCami8d2dHRHTY5qpS4dsswjmcY8Smoc5gZ71V0
         vqzudWRheV+C8NxnMO74nZuzJOz7i4uJgMxpePAEAPzfqFabuJ/pwox0xhK8XaiZGYPz
         8FFm8yLZdrZTABXJVGg/cxYpx3GXuyLRmHBvV2Yk+MJPYU0LqWDqtVumfPG/046cCuPV
         IkXg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ8oTcOOZ+uiI2X75rS13Qu9l5s+wS8GyUd7uF/4wDJ3gNoGRZa5yUz3Oji3u/eejMIOUpOPZWVt0H@vger.kernel.org, AJvYcCV+HCDHvtF3RwCN+hNHycUXfd3h17HDiSN27ouGosV2IA2zffIG0tiP2FK4/iOXIBP8lwf7jy2TBxNV8Aon@vger.kernel.org
X-Gm-Message-State: AOJu0YxocGevGfY/sbse1KMfF/IQd71vWu/zlDaN7/pVdLxcT/GnxpUX
	XP8q8YZQ3SNLSHO1SZV/TzfbA958SNZAXYcDGbnGGQVcRiFTTXsV4QPJkplbL1E6XFs8TTeGE4c
	q68fLuUCWhZ4EOwI003d9iJQHIEs=
X-Google-Smtp-Source: AGHT+IGOQMYgvHeVFUazqNLJHvC9erzM33qH3tR5Tp8EUGtEvxdQ1+EBkfj+Zx8VsDV0Izwpjun8GCNdjBLyZ7dUxw0=
X-Received: by 2002:a05:620a:1a8e:b0:7a9:a991:f6d7 with SMTP id
 af79cd13be357-7b079547907mr215745785a.48.1728458282073; Wed, 09 Oct 2024
 00:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008152118.453724-1-amir73il@gmail.com>
In-Reply-To: <20241008152118.453724-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 9 Oct 2024 09:17:50 +0200
Message-ID: <CAOQ4uximqPkreLbWqF46hiymS+DA6GyZ-vAP=9VJieSTrN1Qpw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] API for exporting connectable file handles to userspace
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 5:21=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> Jeff,
>
> These patches bring the NFS connectable file handles feature to
> userspace servers.
>
> They rely on Christian's and Aleksa's changes recently merged to v6.12.
>
> The API I chose for encoding conenctable file handles is pretty
> conventional (AT_HANDLE_CONNECTABLE).
>
> open_by_handle_at(2) does not have AT_ flags argument, but also, I find
> it more useful API that encoding a connectable file handle can mandate
> the resolving of a connected fd, without having to opt-in for a
> connected fd independently.
>
> I chose to implemnent this by using upper bits in the handle type field
> It may be valid (?) for filesystems to return a handle type with upper
> bits set, but AFAIK, no in-tree filesystem does that.
> I added some assertions just in case.

FYI, version with softened assertions at:
https://github.com/amir73il/linux/commits/connectable-fh/

fstest at:
https://github.com/amir73il/xfstests/commits/connectable-fh/

man-page at:
https://github.com/amir73il/man-pages/commits/connectable-fh/

>
> Thanks,
> Amir.
>
> Changes since v2 [2]:
> - Use bit arithmetics instead of bitfileds (Jeff)
> - Add assertions about use of high type bits
>
> Changes since v1 [1]:
> - Assert on encode for disconnected path (Jeff)
> - Don't allow AT_HANDLE_CONNECTABLE with AT_EMPTY_PATH
> - Drop the O_PATH mount_fd API hack (Jeff)
> - Encode an explicit "connectable" flag in handle type
>
> [1] https://lore.kernel.org/linux-fsdevel/20240919140611.1771651-1-amir73=
il@gmail.com/
> [2] https://lore.kernel.org/linux-fsdevel/20240923082829.1910210-1-amir73=
il@gmail.com/
>
> Amir Goldstein (3):
>   fs: prepare for "explicit connectable" file handles
>   fs: name_to_handle_at() support for "explicit connectable" file
>     handles
>   fs: open_by_handle_at() support for decoding "explicit connectable"
>     file handles
>
>  fs/exportfs/expfs.c        | 14 ++++++--
>  fs/fhandle.c               | 74 ++++++++++++++++++++++++++++++++++----
>  include/linux/exportfs.h   | 16 +++++++++
>  include/uapi/linux/fcntl.h |  1 +
>  4 files changed, 97 insertions(+), 8 deletions(-)
>
> --
> 2.34.1
>

