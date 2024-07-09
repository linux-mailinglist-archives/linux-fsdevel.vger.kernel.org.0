Return-Path: <linux-fsdevel+bounces-23341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66C892AE7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 05:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADA01F23000
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 03:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0F878C70;
	Tue,  9 Jul 2024 03:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxT5OWKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C58487A5;
	Tue,  9 Jul 2024 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720494903; cv=none; b=fFKtGTObdibf7LYZKJcwbMCNyQN7Hz6xoCK5wsSt+JC3u3ygzznpvxWuAXTfq4/Gs8CFMh0b3SuJ4iPdAPk/REP23L3qbWn1Ezj+hj/JFjPjw5lCYTvpemsbRKRjveFJDHh+1bLOlInB7B80lsOWhp2+id8eCa38lq4QRGiZBvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720494903; c=relaxed/simple;
	bh=4ZZio3Wb7LL1vgb5mt6lXU9W0NhwIVtcCUDpe3CmPn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYC7eT/GIVlUky7oiqYMFsaoWc8t4ee39TEeuZDCavUFhLOlQ01J58zyp5ePKTxBSUOLl88FP7a8KoPzlnsdNXIysQ+JNo8hWHU4n/1uBbosKmK7tKVXIDLqKkKrnhHDdbN7eRIRWH0h680KhMRz9IGBfXB8xmZA9BIHr7SUfGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxT5OWKg; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-38abd30a1c9so663555ab.3;
        Mon, 08 Jul 2024 20:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720494901; x=1721099701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZZio3Wb7LL1vgb5mt6lXU9W0NhwIVtcCUDpe3CmPn8=;
        b=JxT5OWKg9J3guX3BHjsZ3CBCNvoU0lnoTQuF/Cw6wEsPczpfWDwI0cHheNHSNg7Rw7
         lPb2gphvIUBs/lPcg1kNjDjRnsvc7+8lxtE05sLxNaTazU0U297v8Y9Qsi/4GFRktGEp
         I/nAj312sez3jmR6x79D+2BnvSbRaNNW7WuhJcHl5AKxpvJYWCrYmuxipzNWV6UNWySy
         aFMzJqYtlBbBJOw1MjXDUw1000WPP6uO5E8oMCwHJGzXui+Lk+g9tvavw3Ui3hkkiKlt
         90PHczZdUtvw1HU2eAvs+UtoLKX8bpdkyB9T1K3GffroCbCaCtMO4AYgGiV9/TO0/nIh
         apYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720494901; x=1721099701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZZio3Wb7LL1vgb5mt6lXU9W0NhwIVtcCUDpe3CmPn8=;
        b=lnNNry/ZLggmtQoQNUMvHHIfC8xdBj+wQ5O3rGYIppcg122Dx3aEcWw9KjTt++SfLO
         7B4xDfApcMB9ULx91oqXE3AJHOBNEgJyOG8pOz6sNSpSoSb8U52E8YEO6lhE5VnDbyQ6
         kz8JieLXDQxo+BWZo4CXbSvJSI5fHOz5JpE06JORggfHlwBjT9seexQuhNQL8OIl4+a1
         XUf1CxJOpBlPPo4dpxbsfmAhgxvqkm6dCFIQV7NDbj7s6lG0wnz/mqsz8wRvQYdCKkUh
         I58WBh9f98q6LtKlJkb5Zu+55HIfE2ypfouvUAFVvMiZ5DFjFBW3OVnk5Pzg+j8ZabOh
         6dgw==
X-Forwarded-Encrypted: i=1; AJvYcCXDzUxDxSu0Pgti2cZ+A/F48ts8cZIFyCDwojRm/SPoE71LEZLeNsj2fztGFQ1RhM/15uK8JUfjCkUohw6LGhNPEd4t2GGy3w5faZ8f/8Szl73/ZOe2SS5XEgwb5iRmztA3fNXGn83fTwIn0eltUXNJ83Wxn+19iozfZCPpKetsQA==
X-Gm-Message-State: AOJu0YwetvddmtMYZbivB0+xx+wiHCaMD16r9F2DQAA3BvbRFf10iqtx
	UaLDzTSSlOdZRR2neB+FSgQv6qu0eRqZHVu/vHM+wMeFFYjyT1/biQ31AQF5p7Zpj8J4iNzKVui
	Y0/FekvPd0j+C+V9uZLXmJHK0YUg=
X-Google-Smtp-Source: AGHT+IHHmXTRDZjaslqjVeI4snU9357L42htoF1UJL+C84StlG4Jwrg6KF8y1KxRD7RthYqkPyl9yDBwl8IWF0Yrv2c=
X-Received: by 2002:a05:6e02:1847:b0:374:ada1:295a with SMTP id
 e9e14a558f8ab-38a5848daeamr16806195ab.16.1720494901020; Mon, 08 Jul 2024
 20:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627170900.1672542-1-andrii@kernel.org> <20240627170900.1672542-4-andrii@kernel.org>
 <878qyqyorq.fsf@linux.intel.com> <CAEf4BzZHOhruFGinsRoPLtOsCzbEJyf2hSW=-F67hEHhvAsNZQ@mail.gmail.com>
 <Zn86IUVaFh7rqS2I@tassilo> <CAEf4Bzb3CnCKZi-kZ21F=qM0BHvJnexgajP0mHanRfEOzzES6A@mail.gmail.com>
 <ZoQTlSLDwaX3u37r@tassilo> <CAEf4BzYikHHoPGGX=hZ5283F1DEoinEt0kfRX3kpq2YFhzqyDw@mail.gmail.com>
 <ZoySCNydQ-bW6Yg_@tassilo>
In-Reply-To: <ZoySCNydQ-bW6Yg_@tassilo>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 20:14:48 -0700
Message-ID: <CAEf4Bzbj7zCUzh2thV-Wkk-YjX71tDLPjb=wc6ZF4HbG5nqPRw@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] fs/procfs: add build ID fetching to PROCMAP_QUERY API
To: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com, 
	rppt@kernel.org, adobriyan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 6:27=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wrot=
e:
>
> > So what exactly did you have in mind when you were proposing that
> > check? Did you mean to do a pass over all VMAs within the process to
> > check if there is at least one executable VMA belonging to
> > address_space? If yes, then that would certainly be way too expensive
> > to be usable.
>
> I was thinking to only report the build ID when the VMA queried
> is executable. If software wanted to look up a data symbol
> and needs that buildid it would need to check a x vma too.

I think that's way too restrictive and for no good reason, tbh. If
there is some .rodata ELF section mapped as r/o VMA, I don't see any
reason why user shouldn't be able to request build ID for it.

>
> Normally tools iterate over all the mappings anyways so this
> shouldn't be a big burden for them.
>

This API aims to make this unnecessary. So that tools can request only
relevant VMAs based on whatever captured data or code addresses it got
from, say, profiling of perf events. And if there are some locks or
other global data structures that fall into mapped portions of ELF
data sections, the ability to get build ID for those is just as
important as getting build ID for executable sections.

> Did I miss something?
>
> I guess an alternative would be a new VMA flag, but iirc we're low on
> bits there already.

I think we should just keep things as is. I don't think there is any
real added security in restricting this just to executable VMAs.

>
> -Andi

