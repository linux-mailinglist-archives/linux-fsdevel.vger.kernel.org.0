Return-Path: <linux-fsdevel+bounces-24922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD59946A8D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 18:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785202818EE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBB015491;
	Sat,  3 Aug 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGWl5g1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E26210A11
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Aug 2024 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722703983; cv=none; b=hNAPJEDIvvXDclTcpbMBQN1BtZzIo/bI7hlkaBbvxfBrAGyvWLKtWTe6pB2pW5A3AlDbkz6hdnZ25EoN3n3zf4T0+UlcrJ13mjO67CKQvscZhBu2AX4pO9virWs2wcjlzh+ww6mD/aBRvxvhQHrlF5/iCCE/XC2qs1klFDD3Bzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722703983; c=relaxed/simple;
	bh=eEEMZ8cjQ7ucYcq4tG6xYlNLpvab1Ax7If1SESbq95c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmPWpSIZ7/VHJqRVPgbFiayUiAfl6tFQorXbbmA7RPnU7Kcz+4pmcZGxC76HM0JMVdhx3FCJeP3dwoJBopVyxZvoga/KaF9eQ1JwGOEL9p7k6D/P8mwOdyU7vTn6tPZRxjR8TVpbEUXFbcQu/0+MOeue4G1fZZHZ7kbKKf2qYLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGWl5g1T; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0b9589a72dso5885784276.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Aug 2024 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722703981; x=1723308781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yokoAh7/K3vtsU+mND2PdtHQQMOGuWzc9xxgGyQjgEM=;
        b=nGWl5g1ToWdp3+0xR5EO4yjzxKr+GhWx1l1AdUK0Eoyh+eiNIccvHwz0WJ5PnKb7FK
         KnBBF3sFrlZoRCodGvJmEgByGW/caDs5njpRrz4GWaPOeN3F48cGbNGqA1aXOzb25WJe
         Scx24sSTu9OOYq4BJVPXIzoSin3B1rTNImwRjgKXAyQX2pUqRysKRiZy/6Jt7U3GZXIt
         SRGTKDz0NK2PgULZIn6sDar24YyCXiCLV0mfQGF1MLSyxodKvW8QkBOtu26LjHHrcX1g
         DFOFX21/s3UHpPdylbWRuIDv/AmVf/0PG6uBefn89EhdXUw1WSStXN1o34HlxWyiz2sW
         qegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722703981; x=1723308781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yokoAh7/K3vtsU+mND2PdtHQQMOGuWzc9xxgGyQjgEM=;
        b=LYnxu1aQphI0a8scW6rgMYyWCNEFzgq/RnbHIEwHTf4LRyChIKju1HYuUYZT/vubKQ
         2KTa5TsqfvwvS8CAfZVHG25iYiDOWFPkOau2uxcDFA/hGqzKJdfRweEfzdwQDXJck8L0
         UwXwSxKr2DS/wDr9Ct+8v7SwHmit0IDdLcQPPybUl6U96fy3Pfw4dcfc/Ymly7gYGMZe
         YqV4faX8YMh5p9dVnC6txzRlWIlYENERsqf1MXCUllMN9OsQpjkaKdu9U16nG2KQfVV/
         WB2DhO8jg7m8i+syrFo7Y8MWvA47m0VLUTDDVK9Zdvlw5T8dNbWo0XmOI8vkYqDcjpYF
         O0qw==
X-Forwarded-Encrypted: i=1; AJvYcCXPo7PYm2A5Uhr44vseRuA2Wq6BEXsZ1nuqCL8wNwK8+j6oeFLiE+DywU4NPQhqHHngQCpWQmorJrKgIIqr2XkAqKSXw68Hbnby6ny65Q==
X-Gm-Message-State: AOJu0YxmrgadaQSeicKMlpQWPSOFHjnhixnq3sKLA5F7WGmOqIC2QqE+
	T6gGvohT549NAzWQpfV0ipU8pAEDEJgwXrcSvOzvpiF3qec3T+aScyaFg0RgyxK7V5nVN33Lc+r
	VoQ/A1+/oNiZCvmetuiTreDHak3s4/cMDed8=
X-Google-Smtp-Source: AGHT+IE4hz4N3TaL8/xXs/G+d52LqL1JAFUlMt3pw2+B6dDXZ6yML/2BQjZUpMtAn0rHPhp+KuUJe8ntoHtvk/4MLdQ=
X-Received: by 2002:a25:8491:0:b0:e0b:322c:1165 with SMTP id
 3f1490d57ef6-e0bde523712mr7496541276.52.1722703981037; Sat, 03 Aug 2024
 09:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721931241.git.josef@toxicpanda.com> <a6010470b2d11f186cba89b9521940716fa66f3b.1721931241.git.josef@toxicpanda.com>
 <20240801163134.4rj7ogd5kthsnsps@quack3>
In-Reply-To: <20240801163134.4rj7ogd5kthsnsps@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 3 Aug 2024 18:52:50 +0200
Message-ID: <CAOQ4uxg83erL-Esw4qf6+p+gBTDspBRWcFyMM_0HC1oVCAzf4Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] fsnotify: introduce pre-content permission event
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 6:31=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 25-07-24 14:19:39, Josef Bacik wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > The new FS_PRE_ACCESS permission event is similar to FS_ACCESS_PERM,
> > but it meant for a different use case of filling file content before
> > access to a file range, so it has slightly different semantics.
> >
> > Generate FS_PRE_ACCESS/FS_ACCESS_PERM as two seperate events, same as
> > we did for FS_OPEN_PERM/FS_OPEN_EXEC_PERM.
> >
> > FS_PRE_MODIFY is a new permission event, with similar semantics as
> > FS_PRE_ACCESS, which is called before a file is modified.
> >
> > FS_ACCESS_PERM is reported also on blockdev and pipes, but the new
> > pre-content events are only reported for regular files and dirs.
> >
> > The pre-content events are meant to be used by hierarchical storage
> > managers that want to fill the content of files on first access.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> The patch looks good. Just out of curiosity:
>
> > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_=
backend.h
> > index 8be029bc50b1..21e72b837ec5 100644
> > --- a/include/linux/fsnotify_backend.h
> > +++ b/include/linux/fsnotify_backend.h
> > @@ -56,6 +56,9 @@
> >  #define FS_ACCESS_PERM               0x00020000      /* access event i=
n a permissions hook */
> >  #define FS_OPEN_EXEC_PERM    0x00040000      /* open/exec event in a p=
ermission hook */
> >
> > +#define FS_PRE_ACCESS                0x00100000      /* Pre-content ac=
cess hook */
> > +#define FS_PRE_MODIFY                0x00200000      /* Pre-content mo=
dify hook */
>
> Why is a hole left here in the flag space?

Can't remember.

Currently we have a draft design for two more events
FS_PATH_ACCESS, FS_PATH_MODIFY
https://github.com/amir73il/man-pages/commits/fan_pre_path

So might have been a desire to keep the pre-events group on the nibble.

Thanks,
Amir.

