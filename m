Return-Path: <linux-fsdevel+bounces-23635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE679306D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 19:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0739284B7D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 17:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D7B13C8FF;
	Sat, 13 Jul 2024 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn4quDl6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB7D10E0;
	Sat, 13 Jul 2024 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720893230; cv=none; b=gv7vBnDrPp/PB0WrCj976lTksm8cpjlagkFoaMDmq9FSiQ2RoSaEfETZKbTY7QFjclnjIxVFMY2STl+gEQ6gnM+EjGwEQXQmQ8Hh7pfdJcq2jzCl/2UH+YBPlXuUqZoj5++kaDGAVbU6/0HdheFPhfgSUn0La/DIrzjV7VQn6Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720893230; c=relaxed/simple;
	bh=cd61UGN1hXhy0kAv1K/wuyAmkSx2gBn3GFv+gejQQRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzTPqaZoiPcZhGNRcz9Ihy/EfkQJTYr8GAnbpMjBogl9OMcOAYzc7pcVHyXM7o9QLEj60o8Vyjjha76De1/UsxApKj1Bvh89IW1VwGbD92q6fzgey519xNP44ZMd4ButjGPyLezHYawyuraKzWkKOFwcLU9h0CyFfqXuMi7yUac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hn4quDl6; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79f323f0898so186441985a.0;
        Sat, 13 Jul 2024 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720893228; x=1721498028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ycp4k891NLy87LdmuRU/3LkBhRv1C53uny6tA+sGKw8=;
        b=Hn4quDl6l9XCcSPOqoxMG4rSJQ1+f2ZOpBMsUGNUn+Y+QwroaPGr1DFKY9Dc3+4cA/
         VuSUmldtVOOGAN9pxqiOnR5OCW5beB+dqKAQPlJ+GHEiZnMH31FO1HSM19HxChrJLtbT
         EBSvs2vNlTPynS2/c3K2yKnoXPX6lN5vGQX8M3XBkXUmhQP7bOEoDBZis8BavB5Z0Cxa
         kT2ZGr7UEUF0CjH563d82B+ScZwcSWRmSeBmJBtSSYkcNlVuwzGyRMvucHjr/rP5SIxH
         WjIzD9d76BupZSBBRAJnUptsUaLRXIFrE4i22MqOMMKswj09HpkvWfYCF18WsgSGcMpu
         ZnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720893228; x=1721498028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ycp4k891NLy87LdmuRU/3LkBhRv1C53uny6tA+sGKw8=;
        b=UO2chaaMj1V/9UQlnJYLp7xADwOHokeD+hz2omXaIoF5Gor9kFEsz3P8V0czPWgYeb
         Pnrjcc6XIpJQo+aW+NRs3m9GCVDNIPmNjTsjhhlSSFiaTmmNtJUpgwdiJOfVwyqHAZzB
         3kvIQdQou2R7R/2nIX6q6qZV+CNoZepI5En8v8PVYoazAmhJ3n9NiObhZLi+bt9hDS6B
         +75d8H3bkCbWrQjvBEPux7nrXIF8L1zhQMWQw/g67lq3YvLCIPf0h+PvPbcikkzphTFK
         SIhZ7g56qWmZTEHCFgAB1TZQBjFDk8vc8pZE7etbytMSgWCK43Ybr0sG8zXLYppOXcEL
         ftcA==
X-Forwarded-Encrypted: i=1; AJvYcCXl68FfVIQoo8jqVBJZUsa80Y4N20Nunc1KjcoGRiHthfNQXoJQxuSNytkneRKIEwj1Ya0k7efn6QOnzuucp99IH9UCwju7/Y6iBLAS5v0JiX1DMLNwm6P4BVNy5o0+auC1SFWBklLnEg==
X-Gm-Message-State: AOJu0YwZEzmeNPIfSl82ISSkE5PqGKbOuVGav9az+uLlIbzDWUm2Hcwc
	OP8Wwlvia29XKEgUsjIVEoAGDrnWxSiAnshr47kb1nMqvDdc+hTyctI/Lct7CoGl4BBRdJfLM4b
	uAvhxQ3yyORZ0BVGvIbauu5X99go=
X-Google-Smtp-Source: AGHT+IHCKNjImJaPrxketklZPKn6IlSY7ZTSXDv3IkjSgjMzeiZGMSXs3xA0A1CY0TxkDvdrZcFU1kbJA75/l+aGcfU=
X-Received: by 2002:a05:620a:201c:b0:79e:f9aa:8746 with SMTP id
 af79cd13be357-79f19a51460mr1492898885a.40.1720893228109; Sat, 13 Jul 2024
 10:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712175649.33057-1-cel@kernel.org>
In-Reply-To: <20240712175649.33057-1-cel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 13 Jul 2024 20:53:37 +0300
Message-ID: <CAOQ4uxiTfyKhM5Jf=VoaaKTszFwt8Fvcr3Zx1RV4oQhzBNfRkA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] fa_notify_mark(2): Support for FA_ flags has been
 backported to LTS kernels
To: cel@kernel.org
Cc: alx@kernel.org, linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 8:57=E2=80=AFPM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Apart from misspelling the syscall in title

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  man/man2/fanotify_mark.2 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
> index f3fce0c4e4c4..edeadc883029 100644
> --- a/man/man2/fanotify_mark.2
> +++ b/man/man2/fanotify_mark.2
> @@ -176,7 +176,7 @@ the update fails with
>  .B EEXIST
>  error.
>  .TP
> -.BR FAN_MARK_IGNORE " (since Linux 6.0)"
> +.BR FAN_MARK_IGNORE " (since Linux 6.0, 5.15.154, and 5.10.220)"
>  .\" commit e252f2ed1c8c6c3884ab5dd34e003ed21f1fe6e0
>  This flag has a similar effect as setting the
>  .B FAN_MARK_IGNORED_MASK
> @@ -271,7 +271,7 @@ error.
>  This is a synonym for
>  .RB ( FAN_MARK_IGNORE | FAN_MARK_IGNORED_SURV_MODIFY ).
>  .TP
> -.BR FAN_MARK_EVICTABLE " (since Linux 5.19)"
> +.BR FAN_MARK_EVICTABLE " (since Linux 5.19, 5.15.154, and 5.10.220)"
>  .\" commit 5f9d3bd520261fd7a850818c71809fd580e0f30c
>  When an inode mark is created with this flag,
>  the inode object will not be pinned to the inode cache,
> @@ -362,7 +362,7 @@ Create an event when a marked file or directory itsel=
f is deleted.
>  An fanotify group that identifies filesystem objects by file handles
>  is required.
>  .TP
> -.BR FAN_FS_ERROR " (since Linux 5.16)"
> +.BR FAN_FS_ERROR " (since Linux 5.16, 5.15.154, and 5.10.220)"
>  .\" commit 9709bd548f11a092d124698118013f66e1740f9b
>  Create an event when a filesystem error
>  leading to inconsistent filesystem metadata is detected.
> @@ -399,7 +399,7 @@ directory.
>  An fanotify group that identifies filesystem objects by file handles
>  is required.
>  .TP
> -.BR FAN_RENAME " (since Linux 5.17)"
> +.BR FAN_RENAME " (since Linux 5.17, 5.15.154, and 5.10.220)"
>  .\" commit 8cc3b1ccd930fe6971e1527f0c4f1bdc8cb56026
>  This event contains the same information provided by events
>  .B FAN_MOVED_FROM
> --
> 2.45.1
>

