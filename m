Return-Path: <linux-fsdevel+bounces-26419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9D6959293
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 04:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD962885D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 02:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C699E55C29;
	Wed, 21 Aug 2024 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBHe8H/V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6B02AF1F
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 02:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205728; cv=none; b=tz8HdP8MLXi3m9Jsd3pXsSfai9Pe0jvKhGf//xcFNVY0YeqYhmEiIWyRMlhwMYB43woOPs+J1m8J8jhfMof8fG1UrJAr2iRfyKpng3emaH9LcBAKsPphgEN1KKGdDpUpLcsLRLRqa6iHxA7NJEHC6XiekPgNceEZMXbih7YXBvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205728; c=relaxed/simple;
	bh=8mudymxQ/7HgncBB9sk4w++F19EYambypm0ojIDbMVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O75y8qz5e8DuwSzfQp0Xsb7nlkvWYUcg4vFo/d86cPnN+y43iPCtlYft+tFbvskYGcDsJAHPH71vWyCAyZ7qgwbyofTIPdG9YhxJGQbiZaP9ok1zKRidOMCqjJWhqsof8YkIgfmDupIioAe1YlTA3tmvQdNGVUfhxJKglDiWuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBHe8H/V; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6bf6dedbfe1so36139966d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 19:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724205725; x=1724810525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7kwNEhGz9u7v7Ztq3LMLT48OkjzG0JCGQAekVjOqdU=;
        b=UBHe8H/V+9tav/SqTt5zz+Ozay9AXbO/0eaNLJipaxSOPi9pSFajO0N6LzKSwvwExT
         6z7GXvYFGg3n/j+Z8UTd7eyiwnF6aBB2xCW43hMtgtIt/gZMUmueVflTFGMzfqeC2kRw
         QfMLNRNIoTdlNeUMEwD50T8zJVHz4qmGdTLb9vuKncIB2HsO6iQv99yia742N6CjCRYV
         jsyazP1BhUjZ+arGGlCAkR2//azeU8etToBC5mM9mEB1xCcBoLYHrELp47d0OvQg8QJY
         qgj+EYGe6QCEYT3NfxpYonFtPhQubIhjaK7s8dc+rAzXmR0na0eIGMGoR2AfIHgsdm+Z
         PNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724205725; x=1724810525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7kwNEhGz9u7v7Ztq3LMLT48OkjzG0JCGQAekVjOqdU=;
        b=ZFemzNg3NluN2nzphdpr1Sh2pc/Q8dYBSC2YX0DW0asQ5QPpsyMqoSo3W0a/lNoWIP
         bYuLzxd/FkvghQswj40iRx5baVjA4Tn3uxJybdnc2W838FvCMUh9MknIJzDdTH2EjEM+
         2gbWXx1l5q991JCM6gyC/OAzed832hoUFPYKz00lQYP0dh3QjP7lSkpTlPcIGImD7yiB
         YyKiTJs6E/UoSSDwjzbCkkUwLk3kgyyiJURFzFs4czJolFpEmTNBGH3VCft1/akKaHtA
         E/IcfJGC6zlnCS2/aCz83MUvYUN2ipSUskKxlIm4HtTC406P1RflESXMp8u3Fa493wBy
         TFTA==
X-Forwarded-Encrypted: i=1; AJvYcCUnwhWI17OnrVw4XXi1BkUHnnGJx7G0SE5OsKPcFrCf+adozONT6wjkh8SSFzlPwBWPPCS7YTUyuWTDUWEY@vger.kernel.org
X-Gm-Message-State: AOJu0YyxcI6TBKOn7o6ToVktDzn1Ud0VSBuRwyubxWb6ZwiwD7sNUQ07
	TjZVBDb5LYwsLjkHRu514S1Vv75KJ8LblX7LoaR5w6HDaxfV8wdXWmI9909a0MBguqVeyXlLO2V
	XEOenTUD6pVtlcdd6I7G7aK9ew+3ZwCF/TbY=
X-Google-Smtp-Source: AGHT+IGFCpiJKlDreYnLw5nrA+F+M8th+q7hZj+d1y7ykOfXd/JFCKrek4Sf79cPzmOHbJy9Ko1Jcyv054MsfoES/Wo=
X-Received: by 2002:a05:6214:5c02:b0:6bf:7a52:ac09 with SMTP id
 6a1803df08f44-6c155d51486mr11401236d6.6.1724205725448; Tue, 20 Aug 2024
 19:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
In-Reply-To: <20240813232241.2369855-1-joannelkoong@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 21 Aug 2024 10:01:29 +0800
Message-ID: <CALOAHbD+_2rPd6BX5z-RHBw-9vpu59LrGiiZz9C750MHx4vAQQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] fuse: add timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 7:23=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> There are situations where fuse servers can become unresponsive or take
> too long to reply to a request. Currently there is no upper bound on
> how long a request may take, which may be frustrating to users who get
> stuck waiting for a request to complete.
>
> This patchset adds a timeout option for requests and two dynamically
> configurable fuse sysctls "default_request_timeout" and "max_request_time=
out"
> for controlling/enforcing timeout behavior system-wide.
>
> Existing fuse servers will not be affected unless they explicitly opt int=
o the
> timeout.
>
> v3: https://lore.kernel.org/linux-fsdevel/20240808190110.3188039-1-joanne=
lkoong@gmail.com/
> Changes from v3 -> v4:
> - Fix wording on some comments to make it more clear
> - Use simpler logic for timer (eg remove extra if checks, use mod timer A=
PI) (Josef)
> - Sanity-check should be on FR_FINISHING not FR_FINISHED (Jingbo)
> - Fix comment for "processing queue", add req->fpq =3D NULL safeguard  (B=
ernd)
>
> v2: https://lore.kernel.org/linux-fsdevel/20240730002348.3431931-1-joanne=
lkoong@gmail.com/
> Changes from v2 -> v3:
> - Disarm / rearm timer in dev_do_read to handle race conditions (Bernrd)
> - Disarm timer in error handling for fatal interrupt (Yafang)
> - Clean up do_fuse_request_end (Jingbo)
> - Add timer for notify retrieve requests
> - Fix kernel test robot errors for #define no-op functions
>
> v1: https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joanne=
lkoong@gmail.com/
> Changes from v1 -> v2:
> - Add timeout for background requests
> - Handle resend race condition
> - Add sysctls
>
> Joanne Koong (2):
>   fuse: add optional kernel-enforced timeout for requests
>   fuse: add default_request_timeout and max_request_timeout sysctls
>
>  Documentation/admin-guide/sysctl/fs.rst |  17 +++
>  fs/fuse/Makefile                        |   2 +-
>  fs/fuse/dev.c                           | 192 +++++++++++++++++++++++-
>  fs/fuse/fuse_i.h                        |  30 ++++
>  fs/fuse/inode.c                         |  24 +++
>  fs/fuse/sysctl.c                        |  42 ++++++
>  6 files changed, 298 insertions(+), 9 deletions(-)
>  create mode 100644 fs/fuse/sysctl.c
>
> --
> 2.43.5
>

For this series,

Tested-by: Yafang Shao <laoar.shao@gmail.com>

--=20
Regards
Yafang

