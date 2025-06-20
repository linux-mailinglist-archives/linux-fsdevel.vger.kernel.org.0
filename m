Return-Path: <linux-fsdevel+bounces-52323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 366ECAE1C9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 15:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F372E1893F5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A541328DF2B;
	Fri, 20 Jun 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ao6lcT4c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0412628B4E1;
	Fri, 20 Jun 2025 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427423; cv=none; b=aBR4AS3F6MxSSRWaNP7yuiA+Q8zsRG6D6vJSv8y+Uh2l3fm7p8QiDlkZZAbM2fqPH0EKYG0PMJ7F9wZjfE6oFVz5jkQIS9T8EfYQr/LwJEPvDEQnSzwlhdtyqrv/+YYZRDC1MH0xt9TGHz7gqjgMbrWsPZD276d7LYiSrzSgR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427423; c=relaxed/simple;
	bh=Pmbu545g0y8Z5tDvcWsZaI+7dbDf3hK0chejmT6OVWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9nBYqPGt03NybJfj+qv3R1ME/d2r2DL5+cxK7K5OMJYaYWY9LZplo4BCqQDqFcUroraDbMRP863GcjJLrEgeU7x0xj7Ub646tWPyrL+Ugkhhkwfchx2y+2vQqQ2SJTCl9VnRqPujawuKN9aHpb+EHmX+17W0nO29XpcUZSsqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao6lcT4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE4AC4CEF0;
	Fri, 20 Jun 2025 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750427422;
	bh=Pmbu545g0y8Z5tDvcWsZaI+7dbDf3hK0chejmT6OVWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ao6lcT4cY8yem9U1zmLcBnST74EfjH6x2jYil7xPZcdcGLZIpdfWyElZ5VfllM4Aq
	 JcL4+VL8xBs2pUeCG/fUeIWNv+eEloF8vFWhafJPH3sgxw7ubYLxA7JpJ22dpGD9Hw
	 mA+ZYO6C8vX/ynkl9oWp7q0C3vNYTWZCWZZDhLwmaWyDuA6TCHbQx12Ujd2Fzaeesx
	 xVrnbAJFV4EuQzMkBs/ob1qb0agAo6H3TsFH4DUSREuXPnUYdsLqbX4s1Ko9dVlCv2
	 25J9rMicqBacqqkX5awmw76p011WEIDktCBKZXl3IlqWOqwmd828DDxQWyydZHHNds
	 fxaFS25vOF7kg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-606b6dbe316so3727413a12.3;
        Fri, 20 Jun 2025 06:50:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFNBpznNKJ8RFUvIJvymXyjuHdNtSedV3e0PkSSfo6XzGXUSlmZ3ohbBZ3L7i6faxReRuNGk+zGVzi4651@vger.kernel.org, AJvYcCXnO88XnyrKnGleSxJp9pz1DzFNWsgFmmsMcBEuBCCsgifv503r4NMAWUYSXM7GbCkk5jWrDX8ysZKHB3XJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj/XA8xeLp2UF2uil5gBH/fh1t0og4JkK6JDMCr85heOOSzDnQ
	xqVzX9FO5n8NXVQGWUhANw78BVQjoT6VBAvpACL9vRLOBnNsfY1D+g9lsVpHuyj4EUK0Tgf7rVd
	TD5xdQP1LAv3P114mnEmmFu4flsX0YD0=
X-Google-Smtp-Source: AGHT+IEocA9K4Yuv/cWHLZWe9Fn+X0HysoAkBHdG2IcKgUlrvB9TEGfs5kODpypGKIknfAlOtHG4Vn7t92uFLZn33IY=
X-Received: by 2002:a17:907:1c8d:b0:ad8:8ac5:c75e with SMTP id
 a640c23a62f3a-ae057c709dcmr253785066b.60.1750427421414; Fri, 20 Jun 2025
 06:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619013331.664521-1-zhengxu.zhang@unisoc.com>
In-Reply-To: <20250619013331.664521-1-zhengxu.zhang@unisoc.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 20 Jun 2025 22:50:10 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_aBgCwmrS6FjaDRBxSGvOxB8t4XdxJ+Qf8x=quu4Yv=g@mail.gmail.com>
X-Gm-Features: Ac12FXxJLnOAxDPONASWzj_Kp-et6cKeAeoQIyHxlHBCjAvTYuiKyiO5IAQzB24
Message-ID: <CAKYAXd_aBgCwmrS6FjaDRBxSGvOxB8t4XdxJ+Qf8x=quu4Yv=g@mail.gmail.com>
Subject: Re: [PATCH V2] exfat: fdatasync flag should be same like generic_write_sync()
To: Zhengxu Zhang <zhengxu.zhang@unisoc.com>
Cc: sj1557.seo@samsung.com, Yuezhang.Mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cixi.geng@linux.dev, hao_hao.wang@unisoc.com, zhiguo.niu@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 10:34=E2=80=AFAM Zhengxu Zhang <zhengxu.zhang@uniso=
c.com> wrote:
>
> Test: androbench by default setting, use 64GB sdcard.
>  the random write speed:
>         without this patch 3.5MB/s
>         with this patch 7MB/s
>
> After patch "11a347fb6cef", the random write speed decreased significantl=
y.
> the .write_iter() interface had been modified, and check the differences =
with
> generic_file_write_iter(), when calling generic_write_sync() and
> exfat_file_write_iter() to call vfs_fsync_range(), the fdatasync flag is =
wrong,
> and make not use the fdatasync mode, and make random write speed decrease=
d.
>
> So use generic_write_sync() instead of vfs_fsync_range().
>
> Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")
>
> Signed-off-by: Zhengxu Zhang <zhengxu.zhang@unisoc.com>
Applied it to #dev.
Thanks!

