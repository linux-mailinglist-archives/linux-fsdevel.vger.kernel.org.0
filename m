Return-Path: <linux-fsdevel+bounces-49158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAABAB8A68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 17:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED2E16A436
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 15:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9361F3B9E;
	Thu, 15 May 2025 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="d85cYfnh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9D4B1E66
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322115; cv=none; b=pOwsmDAt1vsI7UoaxcAMDl9K34J7zu4o52GI1z6uzv2BvVEJB6MxuuTHUHwUYr3BnkVQ1kjPa3tMB4HVUl9FOKyb0AcC2zjFxc6j19iZ86rTb8f86Z+C3j4Gt75NuKqnJjuRItA5DfzM7+OPFMAksj/x2om/5Gjv4M7uQsSuvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322115; c=relaxed/simple;
	bh=8ohJYeSYj7uAW0fOM1jc8MF1EDgmp9Wm78AuGz/F/kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAPl7mS553h9hGMJYr7TigRpRbY52gIY58pUstdrlSI8Byw0Y1MrSs/+letta4yJ83Id+5QptZwwFkIQwWY6OkbU77p6FhI0jtMMtjHTsooVctnKebYxGayaJXyDRsnUaUc7br/Hatcwu0+nrYK5izJrgmCv4ZWrMWCCAwddTMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=d85cYfnh; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-477282401b3so11974481cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 08:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747322111; x=1747926911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ2U7mP7wOlWnlfAuurgLCRedrcOPVs6hhehcyeaCWU=;
        b=d85cYfnhrFZpP6Ojql4cuwjeM/hFp7gEaYwAEg3PYz3Sm0rcwQj7P7FsAcc94+XBkO
         3j2P1iD15KSlUOdIlonzQcxERX0wJhAn92XwF/HzPIKaNqz14Q/aXWrfs1uX5EgY9oLY
         NmWHk5RXjPXw9of4H7zYio8m+BOpmTqoQXrtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747322111; x=1747926911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJ2U7mP7wOlWnlfAuurgLCRedrcOPVs6hhehcyeaCWU=;
        b=LUJZ6A3+KavfZ+yjlYfWuGe7LyyGYGFH+l6EUfmKusLzopTngC9dTvEPGPnrI4jFo7
         ng09SZsv6uK5oeOkK+5L6nZLt+xfrfjBK7EMuoHpWZ0WOUrvum03yC0drUlmcXbgO842
         gLQo9Mx1JzBOicPR7kxJ12Tg/1Mqq+Ppm/GilXHKU/DT6CgE/HSC9xdofTwLgTwmNZWW
         +ljRm+rF/b/9/XohlH5crlGguhY0rRJ7HYZhFAVcAN4ziDKiRXV4lsDUKd8rpce+wh9w
         zAmbduFGvM1IGTH8p7ug/DrgIq/XFIy7K/4EWyPQthRu6uZ12KubmYRgN3TufWhcB1gQ
         w+Mw==
X-Gm-Message-State: AOJu0Yzn/SVwNnpE3uIKunTy8b9g8xiteCeKgR8at8IkmkiF9cv2zq+u
	FTnn3l+iyHtto3I+XCLYpPb+exydogvdBflRlQaix9OzIsmTqU2Y01B5bzNvJMulXM0yKI/pe3C
	mIXi7n6nzZY/owour4KT7KVmyhQ6mqKEDQpiALA==
X-Gm-Gg: ASbGncshUDvHKFXbx1GvCl8OwrxBILCXkUAF0Y8k+JfrlhUhfhKSpQgunxG8IqNGRiL
	f0ahc410vYvhYhrDdG5YahmJWjW9maZwe7cbtWnqyYDjd1rYRhwRCLYD5Nfhlr3x/ThHiWs2fmN
	2s/KJFcNx2XlkYqvMXYPwwSSKJLEUk43k=
X-Google-Smtp-Source: AGHT+IEsdNnNKrvLi4f3e+DcLAdmyDg5a3xipV9M+uEUp2tuUsd3RIXS/GHvkJSslRZleIvoiVKqNhnNECreBNYjv60=
X-Received: by 2002:a05:622a:544c:b0:494:a495:c257 with SMTP id
 d75a77b69052e-494a495c469mr43023861cf.17.1747322111254; Thu, 15 May 2025
 08:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <vmjjaofrxvwfkse7gybj5r4mj2mbg345ganq3ydbzllees7oi2@uomtwdvj6xcd>
In-Reply-To: <vmjjaofrxvwfkse7gybj5r4mj2mbg345ganq3ydbzllees7oi2@uomtwdvj6xcd>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 15 May 2025 17:15:00 +0200
X-Gm-Features: AX0GCFtuU9oV8luuXJKOm_7ThS50mgkzYythfM_NteuPYNr6h06FwiGLumALXEA
Message-ID: <CAJfpegs-umW78v6WzX-4_2DkMLzdoFX=BY5Jp7P+QR+m62TEiw@mail.gmail.com>
Subject: Re: Machine lockup with large d_invalidate()
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 May 2025 at 16:57, Jan Kara <jack@suse.cz> wrote:
>
> Hello,
>
> we have a customer who is mounting over NFS a directory (let's call it
> hugedir) with many files (there are several millions dentries on d_children
> list). Now when they do 'mv hugedir hugedir.bak; mkdir hugedir' on the
> server, which invalidates NFS cache of this directory, NFS clients get
> stuck in d_invalidate() for hours (until the customer lost patience).
>
> Now I don't want to discuss here sanity or efficiency of this application
> architecture but I'm sharing the opinion that it shouldn't take hours to
> invalidate couple million dentries. Analysis of the crashdump revealed that
> d_invalidate() can have O(n^2) complexity with the number of dentries it is
> invalidating which leads to impractical times to invalidate large numbers
> of dentries. What happens is the following:
>
> There are several processes accessing the hugedir directory - about 16 in
> the case I was inspecting. When the directory changes on the server all
> these 16 processes quickly enter d_invalidate() -> shrink_dcache_parent()

First thing d_invalidate() does is check if the dentry is unhashed and
return if so, unhash it otherwise.   So only d_invalidate() that won
the race for d_lock is going to invoke shink_dcache_parent() the
others will return immediately.

What am I missing?

Thanks,
Miklos

