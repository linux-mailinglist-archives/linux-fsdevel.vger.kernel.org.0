Return-Path: <linux-fsdevel+bounces-46328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EC0A8703A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Apr 2025 01:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF413B1E1C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 23:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449A322E3E3;
	Sat, 12 Apr 2025 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U/C+ckdc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF6DF4ED
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744499578; cv=none; b=VX7cLs6lsBLp8SOmiRtXAzoUdfrzWkHGi5DHJHG4ampOyx0aJAqtmcgf9x1RnuGSIFkuv3ypdj3pXLwuhPUOHL+XId3DkJlLXnzOHfBOU2MNiutZAhPaJpuAWM4gbeOpweKwHJxvuCuuFpyhYgrs2htZC2Um4HP7GsIojmvbbrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744499578; c=relaxed/simple;
	bh=erErZ5IWo7k/p9GhH7CXHkyC+Mrxu7hz35nBRVmyQ94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSXbZOk69UsOb24t+YClV67LE8DH09NYuN4K9jBY42h1FcRzICJXJzOcqgK/Py8W+IHEfFY6BEk2ygjR/md4GEOaY6DN4MPTmG2Dnk+/pP/hF4PmqCqK1iUKlSDCZiiRdBR696dEnJEEFYhHxgMtnYjVUulVSmWxEg/OlgqVYzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U/C+ckdc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso615632366b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 16:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744499574; x=1745104374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FzVk3Vfm0xN6fR9iJk/fZ+HRS66Ighe4iqo3hM0TvD8=;
        b=U/C+ckdchtSaUbmAH8+RvUY+5ttLoVMuuMjvxuXnXbsMkwtOEuGmQIpqGzefMtEQDm
         aTRarfodf9K84Nmqa7QnrtWFX+v+hWA57yJfJlm5NExPH3zkKbGSgnK2Oz5Yc5B9kusD
         RGhjyhlEqQR+g3vjVqY6xL0nOl6+qlqIigbK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744499574; x=1745104374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzVk3Vfm0xN6fR9iJk/fZ+HRS66Ighe4iqo3hM0TvD8=;
        b=itt6RvuMr4xSVUSBFWklbfzTEce4OdfTtDpEXZhDzAiuUoeNSyGHv6qkXEThKzL9WA
         WqAJ9ZIR60raElwx6Cdi/OoDr/HAM+j3o8vXZLSuXD/OewTzQEZDy0EZ7FNTUN6wNwqK
         zu1gDTUWr/1vXD2ZjXsCi8g9zJBlN+JjiSEmv4j1nm0di2ddVGeZaJBsR2qyJpndErP/
         t9IrrON3hO23GPO0hsykEHZhf2UnKRowEREl+NcCuE+3b6XxPa8s9zbeNwPS2zpmDtAm
         lh6U+9p0f8SwLAa9UgZSbLF4Esk2/cypw3HrBp/iUGXJjUC6HOFAbYxzkgOCH6ZFsTad
         qY9g==
X-Forwarded-Encrypted: i=1; AJvYcCU9lITgTz1ODLgudfaHacamS+2QEbi9omEEg//4XKCh+i6J9yHOnGJ/UPZbits9ERrWQ1B1XrwHC0iQEghV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1zCgT8kYFUDjy2iWxr2HvWQi8XGhNJCXKtvsPDlcU+WeaKhOe
	NRBsXXx0FTkCTv4aP/1ccgqv7GXo0YkIuuqa067cStPznC6ziilDdgUB7tiJf8Pi7lUEz08C1pa
	izD4=
X-Gm-Gg: ASbGncsardemxTzLaF+OTJKrbq0HNB43Hfd1P2FLgHaQeMt/q/zSbFVTDM3fRhtgsTg
	KIqG2jzwlVHY/Pa5GKSluzwLjPVWf1eEUC1TdD0b62MujDZTt9eIvb24KiuCzME72Fbm2SxqCA3
	tgFTbD2B+U410AYOkp2WXqJaRdIQYGNvmCJhuXFKnKhmVwhkmL1vD3G8VafifVNIf2ruCC4PNgi
	ZD0ka9HxsR46YZQnr8FnyKGZNUXK9eRCILjikeU4dnRRHATTpeSzLRdzMyc+vThqFi9XOVwYKDO
	BKHznifZShBJsf1Wu6DSQg1+bfKMGqs2lLAMiwgh1UmKx2C+q3jWDZk22pqzY3r6ARdLsxEsv4y
	JS8jL4GW4+e5xLF4=
X-Google-Smtp-Source: AGHT+IFKq4L/GVeVP6I9gKoDGXB2DY3F69W9AttbtKOY6HBFvbJV2CvFmL7/Xe2Kdsf9Zbs8wDFgAg==
X-Received: by 2002:a17:907:3e0a:b0:ac6:ba4e:e769 with SMTP id a640c23a62f3a-acad34dd666mr644841166b.35.1744499573890;
        Sat, 12 Apr 2025 16:12:53 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccd262sm660478366b.136.2025.04.12.16.12.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Apr 2025 16:12:53 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso608833766b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 16:12:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhUe8re1cLskKE0UIKvclz6yiD9MyXBkHUo8ezaQiYoRYYO8UU5hSvt7FiKEd0dvMskkp5bxqzhzBoNE46@vger.kernel.org
X-Received: by 2002:a17:907:3e0b:b0:ac2:dc00:b34d with SMTP id
 a640c23a62f3a-acad36d943bmr647780666b.53.1744499572869; Sat, 12 Apr 2025
 16:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031-klaglos-geldmangel-c0e7775d42a7@brauner> <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
 <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
 <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
 <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
 <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
 <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
 <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
 <20250412215257.GF13132@mit.edu> <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>
In-Reply-To: <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 12 Apr 2025 16:12:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAi-La-PaktC83QhMWXyE4v3u6mzPwpE0bX7jhtRaitg@mail.gmail.com>
X-Gm-Features: ATxdqUGBBgcp2Yt3W7EErIVkfyH75cMOpLdKjddWRCzYAf_XyWMHN29s807rB00
Message-ID: <CAHk-=whAi-La-PaktC83QhMWXyE4v3u6mzPwpE0bX7jhtRaitg@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Apr 2025 at 15:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Indeed. I sent a query to the ext4 list (and I think you) about
> whether my test was even the right one.

.. I went back to my email archives, and it turns out that I _only_
sent it to you, not to the ext4 lists at all.

Oh well. It was this patch:

  --- a/fs/ext4/inode.c
  +++ b/fs/ext4/inode.c
  @@ -5011,6 +5011,11 @@ struct inode *__ext4_iget(...
        }

        brelse(iloc.bh);
  +
  +     /* Initialize the "no ACL's" state for the simple cases */
  +     if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_file_acl)
  +             cache_no_acl(inode);
  +
        unlock_new_inode(inode);
        return inode;

and I think that's pretty much exactly the same patch as the one
Mateusz posted, just one line down (and the line numbers are different
because that patch was from five months ago and there's been some
unrelated changes since.

            Linus

