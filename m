Return-Path: <linux-fsdevel+bounces-19326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 925C38C330B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 19:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D981F21B3E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 17:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B301C6B7;
	Sat, 11 May 2024 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoeR7FZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF64C12C;
	Sat, 11 May 2024 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715450357; cv=none; b=UYknV+SXGVMYYdnqtvhwWVY1pB3FOq5YnDeh+A4wbpQdtxx7CX0iFXWfpbr8eOZuQdvV83AUHWdUHHJejyb2Q8WoXv9G6TVJR6MNANrUBAwYkYezN4AVcqRrd0A458MR7vU4CDxJM24FavULMxV9Esak8bq7K7NFJLxZsiiuP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715450357; c=relaxed/simple;
	bh=YxL0hst5x3AoS356cPPGnYkXNHdjEvw3KOLOtBVGuaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGmOaw1KP+HuxTAVrL59uXgGptFL6TS9M1C24xDV5KCNriqgjWPBCLj0C7fsbkdv62AQKUSilYt12peSs6RyS5J7J+UWRjT9vK5rqfd3Yai7BKQO5RqqLnZwCsD+FXgn0mE16ngPOdXIp4BT7LH9pICms69lKBtrR0VRC5OlXHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoeR7FZi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f3761c96aso3574657e87.3;
        Sat, 11 May 2024 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715450353; x=1716055153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFGAW+c0/b0Kho1b9ASTvFcAPtLWemetgTYD8sxrbJ8=;
        b=FoeR7FZiX7hktUh8jA8gJ0Itm67ga7pwfzIXQDq5+gx5e0k6dWcj70e/EEICkVCN9v
         047u75XlGssrPBB5ICj00oZttXVHhFIqio1NWfLwfcQ4vIq8Y+U5riVFQ7xbpWNl2Vj3
         r9irnNIsZGxaOAlXsOnZEcLCkV1XkcnUt4QoGfGLGH/X9nJ22DLhMrjm9yUzIDCYOTfG
         JeHQCA+40JAWTV0TAL2t/Hl/FFOjuHXbDGxsGJVW+K6bLQEix0j9k9KNSz8Jvjm5RDdb
         Y8eKszk9bkj9o3hLzhQOorBMndXUu2dNl+MliqJzEtdY01K88y0DGg31VkUjL6edFIML
         W0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715450353; x=1716055153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFGAW+c0/b0Kho1b9ASTvFcAPtLWemetgTYD8sxrbJ8=;
        b=rQt2OLwIWr05X4diMi3tqFw/R3ZvqSCtoly8nzNskCRX60rXbr4PsMZLLQgUyS/8aJ
         0M2q7r66o2y0N+nnrN3FXZzoJc5IiBtohAGJTXghtAM8EVP45e5rliInrd5mMadDpWE0
         W7oVidF5wyqVlBCOooJJfK2QuG7xnb2aWHxz1L65Jfuv9/NTYBmAt95+mpKAXdgIC1Wl
         OJ/Tjcs62sQ5bRg75uT5p11mym1UslvKIKbAJA+eB41a188GVAUiAVusYgK8RWRvNAiL
         JceVh1urCrZSLdhce7VNZDZMalbMY1xpynpFPXqrpEvbwmRl8nCdqiwqfbCbPIkxOqP9
         fRGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHwerfWtqeksWp2BGG+cos95tM9obJhfuIdZ/d6lL4FMwr6ndabdguuGdXPI9ZrD20KZHmN20Yr5ISJbsGQgXl0oHfrHp22awF8nslIg==
X-Gm-Message-State: AOJu0YysvgnnYaHBbbe1g5gr8wXfRZ1UQlcm7VM4C/1xme/WBOnPljQA
	SMswh1J+dbzcTaHpRGirrX1zLCjNxukejTcIFf+r+82eLjRjRFEJfGCTxlhZruPT36F4myZwIoK
	8sH6zpfsZ99L6H+TfdhalcLzVX0Ms4Q==
X-Google-Smtp-Source: AGHT+IEZT1i0sFtp2nYBJ7Wu6udRc0e37oQ3a4LReCY8L/SBAhmCvhKE+VSGZb4kRnZPdxyFGp1g4iVe0aAIKxR/XTA=
X-Received: by 2002:a05:6512:3f08:b0:51a:d9a3:dbf5 with SMTP id
 2adb3069b0e04-5221016b4a2mr6149444e87.47.1715450353108; Sat, 11 May 2024
 10:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mvvRFnzYnOM5T7qP+7H2Jetcv4cePhBPRDkd0ZwOGJfvg@mail.gmail.com>
In-Reply-To: <CAH2r5mvvRFnzYnOM5T7qP+7H2Jetcv4cePhBPRDkd0ZwOGJfvg@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Sat, 11 May 2024 12:59:02 -0500
Message-ID: <CAH2r5ms-fSEsiusCeiRANZ10J6z1p5QQYzPRXqiDHfaYb-3Wgg@mail.gmail.com>
Subject: Re: cifs
To: CIFS <linux-cifs@vger.kernel.org>, David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This was running against linux-next as of about an hour ago

On Sat, May 11, 2024 at 12:53=E2=80=AFPM Steve French <smfrench@gmail.com> =
wrote:
>
> Tried running the regression tests against for-next and saw crash
> early in the test run in
>
> # FS QA Test No. cifs/006
> #
> # check deferred closes on handles of deleted files
> #
> umount: /mnt/test: not mounted.
> umount: /mnt/test: not mounted.
> umount: /mnt/scratch: not mounted.
> umount: /mnt/scratch: not mounted.
> ./run-xfstests.sh: line 25: 4556 Segmentation fault rmmod cifs
> modprobe: ERROR: could not insert 'cifs': Device or resource busy
>
> More information here:
> http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/=
5/builds/123/steps/14/logs/stdio
>
> Are you also seeing that?  There are not many likely candidates for
> what patch is causing the problem (could be related to the folios
> changes) e.g.
>
> 7c1ac89480e8 cifs: Enable large folio support
> 3ee1a1fc3981 cifs: Cut over to using netfslib
> 69c3c023af25 cifs: Implement netfslib hooks
> c20c0d7325ab cifs: Make add_credits_and_wake_if() clear deducted credits
> edea94a69730 cifs: Add mempools for cifs_io_request and
> cifs_io_subrequest structs
> 3758c485f6c9 cifs: Set zero_point in the copy_file_range() and
> remap_file_range()
> 1a5b4edd97ce cifs: Move cifs_loose_read_iter() and
> cifs_file_write_iter() to file.c
> dc5939de82f1 cifs: Replace the writedata replay bool with a netfs sreq fl=
ag
> 56257334e8e0 cifs: Make wait_mtu_credits take size_t args
> ab58fbdeebc7 cifs: Use more fields from netfs_io_subrequest
> a975a2f22cdc cifs: Replace cifs_writedata with a wrapper around
> netfs_io_subrequest
> 753b67eb630d cifs: Replace cifs_readdata with a wrapper around
> netfs_io_subrequest
> 0f7c0f3f5150 cifs: Use alternative invalidation to using launder_folio
> 2e9d7e4b984a mm: Remove the PG_fscache alias for PG_private_2
>
> Any ideas?
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

