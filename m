Return-Path: <linux-fsdevel+bounces-22680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8B391AFFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 21:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B588B20EE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB15619B591;
	Thu, 27 Jun 2024 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ7AjfNW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D3022F1C;
	Thu, 27 Jun 2024 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518369; cv=none; b=l7CdFkU2cN5z9pkZ8gXbGLrMJziSagTAnOOq+be1h9lGUICmHhbhPVF8Yw1Tfai6D1fqL6lSGQ/e6S+i18uNYHlxkf8GpzbqD37jMvph1fLzJneaunutVNNz4o+yqJ/cD6UGZ3fDKiEwweHxfUa6X8pjOsKybhiRsT4VIucmElg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518369; c=relaxed/simple;
	bh=/CuqMirzamFTMzjHTvMKkQol7oo8vbW7iWBXGSl+LJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtD9dlexTfsWPpCe57D/FmEA3hvXbPn/1EAbyWrq5twzEH8EfhqezRwe2u6gcSGsCOfVk0T1aOhkeRB5Z1sCI66PFaBZZzWqzGjKMPHTQmRP6XJGIdNnFRlKNBlgptGa81qVDMeg8H98uGndxAQMUKDuffs6h3rL0fAM7jZmoOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ7AjfNW; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cdc4d221eso7103981e87.3;
        Thu, 27 Jun 2024 12:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719518366; x=1720123166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QddFS/SzQm9Q8f+eZ13a9kR7kXxDTHxXbG02Tk91fGc=;
        b=GQ7AjfNWlPSTVmBqh/Sd9j5LyBluZ5K8S74ZZv9M43j0yV6rcE+v6yaGRKY7xkooTC
         gRC+SiOvkNiQLM2K2HLgKE3LE5uK5QNt8cevgj5D1huPPpAQw7iOXhKgisdties8kga0
         KOTyA+r43FBT+kOhNYz8KkBQHxw5/m2Gl8e8WMQQxzcrJsvoWRjQYxo4bbiZLhbvCDJT
         0z1FQWXdsY4bmTEpe3paDawK8FODdQxrMmvqH9eIVDRAeYm/RSgFe1m46mINKphzc6h9
         Jtnz3tOFERGnM1OugnPUfUiTfc77CthDXkpr7DJEA4NhGy7gZyYaTeCxps3+fIyOaFva
         9WOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719518366; x=1720123166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QddFS/SzQm9Q8f+eZ13a9kR7kXxDTHxXbG02Tk91fGc=;
        b=IlfXhgv+3ycGI8rg073AMu0u1Up8neJWrB3Wz4fKStSC8lqbVdPRkj0QjoUBCoTevM
         w56N0IMFyn3NR3tIRCXOXF8fEH5GWZjHuMVAGynUCon7DXAm4Io7dghAvXIVOpVFe3nN
         PuLhKFax83ZH3M/v1r5HJzJRRg2ytm3q4EyUfII0TLj22Wa1IrR/V16gkWGbK/2bVXyt
         Pa57HyrspsxbdgBcoGoFhsn4XRJsaYpDQsT7Slm2zGOzMQvKoQ2W2koixc0c18rFEPxz
         POJjLPxuqc23DL+YKQGbih0xmWamDyPmM+hPAfUAroiZo6CMUcwf7mbPyRONsL3ugn1t
         bBPg==
X-Forwarded-Encrypted: i=1; AJvYcCUbrXYUmoS4wtQopokC+ZmmErmmCAUiHn8I5xJcULuot6Yj+itgiKCn+BVpBJvQwPIH6iFpQBfp0cNir0KPDv4MVp4i7fb7DgqldiLT7rWqZt+WKaBbS5t4zm5mbzwk7u5faxY6M9onBUTHcA==
X-Gm-Message-State: AOJu0Yy2b3clKgankXYuZzLf+ZtkUYgEV5f9vnDOH/bhlJWvsWBsgHo7
	Us0gggLiIL+sXxrT8rVorSAbP+nzALvSyKEl+Q1Yuhndy34JXIPuNjGHtD+ct91bS6RX/VdZ8Ep
	xwqWMxY1I3Dh9yEqL1rhGcIW8KE4=
X-Google-Smtp-Source: AGHT+IEvcGoZqmkdxcZF4LN4NpbQ2hjSYhKwzld8+9ZIuxGyepQa4vDN6npaQD/ZlKkAemorOYAaYNO0sNQHtFHno2k=
X-Received: by 2002:a05:6512:3b9c:b0:52c:e556:b7e4 with SMTP id
 2adb3069b0e04-52ce556b86cmr11118112e87.15.1719518365338; Thu, 27 Jun 2024
 12:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614163416.728752-1-yu.ma@intel.com> <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-2-yu.ma@intel.com> <20240625115257.piu47hzjyw5qnsa6@quack3>
 <20240625125309.y2gs4j5jr35kc4z5@quack3> <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com>
 <20240626115427.d3x7g3bf6hdemlnq@quack3> <CAGudoHEkw=cRG1xFHU02YjkM2+MMS2vkY_moZ2QUjAToEzbR3g@mail.gmail.com>
 <20240627-laufschuhe-hergibt-8158b7b6b206@brauner> <32ac6edc-62b4-405d-974f-afe1e718114d@intel.com>
In-Reply-To: <32ac6edc-62b4-405d-974f-afe1e718114d@intel.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 27 Jun 2024 21:59:12 +0200
Message-ID: <CAGudoHE5ROsy_hZB9uZjcjko0+=DbsUtBkmX9D1K1RG1GWrNbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
To: "Ma, Yu" <yu.ma@intel.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, 
	edumazet@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com, 
	tim.c.chen@intel.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 8:27=E2=80=AFPM Ma, Yu <yu.ma@intel.com> wrote:
> 2. For fast path implementation, the essential and simple point is to
> directly return an available bit if there is free bit in [0-63]. I'd
> emphasize that it does not only improve low number of open fds (even it
> is the majority case on system as Honza agreed), but also improve the
> cases that lots of fds open/close frequently with short task (as per the
> algorithm, lower bits will be prioritized to allocate after being
> recycled). Not only blogbench, a synthetic benchmark, but also the
> realistic scenario as claimed in f3f86e33dc3d("vfs: Fix pathological
> performance case for __alloc_fd()"), which literally introduced this
> 2-levels bitmap searching algorithm to vfs as we see now.

I don't understand how using next_fd instead is supposed to be inferior.

Maybe I should clarify that by API contract the kernel must return the
lowest free fd it can find. To that end it maintains the next_fd field
as a hint to hopefully avoid some of the search work.

In the stock kernel the first thing done in alloc_fd is setting it as
a starting point:
        fdt =3D files_fdtable(files);
        fd =3D start;
        if (fd < files->next_fd)
                fd =3D files->next_fd;

that is all the calls which come here with 0 start their search from
next_fd position.

Suppose you implemented the patch as suggested by me and next_fd fits
the range of 0-63. Then you get the benefit of lower level bitmap
check just like in the patch you submitted, but without having to
first branch on whether you happen to be in that range.

Suppose next_fd is somewhere higher up, say 80. With your general
approach the optimization wont be done whatsoever or it will be
attempted at the 0-63 range when it is an invariant it finds no free
fds.

With what I'm suggesting the general idea of taking a peek at the
lower level bitmap can be applied across the entire fd space. Some
manual mucking will be needed to make sure this never pulls more than
one cacheline, easiest way out I see would be to align next_fd to
BITS_PER_LONG for the bitmap search purposes.

Outside of the scope of this patchset, but definitely worth
considering, is an observation that this still pulls an entire
cacheline worth of a bitmap (assuming it grew). If one could assume
that the size is always a multiply of 64 bytes (which it is after
first expansion) the 64 byte scan could be entirely inlined -- there
is quite a bit of fd fields in this range we may as well scan in hopes
of avoiding looking at the higher level bitmap, after all we already
paid for fetching it. This would take the optimization to its logical
conclusion.

Perhaps it would be ok to special-case the lower bitmap to start with
64 bytes so that there would be no need to branch on it.

