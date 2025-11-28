Return-Path: <linux-fsdevel+bounces-70114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32324C9100A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 08:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE04D3508F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 07:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFE72D7DD1;
	Fri, 28 Nov 2025 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GajzLi9m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632B2D595A
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764313364; cv=none; b=J1g8gfhvC/Nfc7gDegpUr9vGsuFH+/yXNqKmz5oI2+mNWN+uiOsGmzSTeogAD5ZpaoSCpYAmDtQ1RCwFDlPj3QsyknagnG9O57jVmOaxNEGJlEYFtl84djTT8YxT1RlL3NZEzGzut1VaeABmonHjVUcz8h/oHr7m9u6B1q5nLEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764313364; c=relaxed/simple;
	bh=qMP2biutnCSJkQyOiUfsVaE9SeK/dpNUE5VoJ/a9b9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hds0xH4GQnAxHXksZbCcUJCr3FW41xNxA+cHHujqm20dm8FAvVrErkKNbK+8QbgWUOrH+ib7jJ2czqYqCwhyQ7W06qYEhBcN7bGU5PAOVCAkNsEX7b5Evn/OCOVuwD4Yx8HZhulKoE1uhP2C25DRwaYRrqDnqbvpxGj1nzKklsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GajzLi9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D162C19421
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 07:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764313364;
	bh=qMP2biutnCSJkQyOiUfsVaE9SeK/dpNUE5VoJ/a9b9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GajzLi9msvWlNokEbTVJMBKbFjvgbgx1+f43Igphbef1rX4xb1i6EN9r+UU5ohKRn
	 t7Er0kt50UadiJjUokj9Ck4alSb3oXdjeTge9OwWYSXv6h3JO7HHqgwyAapAIl0TT0
	 N1z9cCwgAkizOejQx4aIGLUmX2HJLoF66QBu9xwlEm5P3I1F9ovbvut8Wydjmr8LOB
	 5zF3xQv5o0IrWEheBpIilaZA8g4BGeMtYJ3NULcXd5GNmO5w/Xm84g6tQxazmbZolc
	 0lOriu22yNtaEblYvdYcwzP1w3sqCWKM3XnK/rJOZ1d0WqpZ1U9ThgqBzd9jeYmyiV
	 ylx+0t+OUUcbw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so2760470a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 23:02:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQOscfO1sEd6SGehTY7zVEcJIhJsp7HjhdghvEwZ9+V1TC+3AoyO4LOAs4Slvv7mPK7U7d2gDCB4bCzFt8@vger.kernel.org
X-Gm-Message-State: AOJu0YwsrtZDXwr9NtIhffIpA0ACARugtOGd9hGIZLHbx5+xkXUUvzib
	vnOzwoGXlXAmKO3p1Wtd5LClR0Opi1lN3w4kqx0VfRPTawRy88dwAfDVl/Wyb+YixjhNUYKbwBW
	QRi+VuJZDCEnTXCmaHk/Xv0UIfO9DxDU=
X-Google-Smtp-Source: AGHT+IGVblNzWW1qFGrdcFyuTZV0IJLi0KY2g14PBhxJl6/xCEm3DtKufQAbQkay4SCD8zzslbHL5JD6JjunoZk5phE=
X-Received: by 2002:a05:6402:13ce:b0:640:947e:70ce with SMTP id
 4fb4d7f45d1cf-64555b85acamr23438751a12.5.1764313362404; Thu, 27 Nov 2025
 23:02:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <85070A96ED55AF8F+20251128094644.060dd48e@winn-pc>
In-Reply-To: <85070A96ED55AF8F+20251128094644.060dd48e@winn-pc>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 28 Nov 2025 16:02:29 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8sFP_sDGpg-ajsuCYw_GjH-AgKZoqoQL0wweg7OduVbg@mail.gmail.com>
X-Gm-Features: AWmQ_blWPMQrusUITFXowsVIaIhpDBxPGJWTTWQSdGc_yUhVbvhq_RaZFeHDESk
Message-ID: <CAKYAXd8sFP_sDGpg-ajsuCYw_GjH-AgKZoqoQL0wweg7OduVbg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] ntfsplus: ntfs filesystem remake
To: Winston Wen <wentao@uniontech.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com, cheol.lee@lge.com, 
	jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 10:47=E2=80=AFAM Winston Wen <wentao@uniontech.com>=
 wrote:
>
> On Thu, 27 Nov 2025 13:59:33 +0900
> Namjae Jeon <linkinjeon@kernel.org> wrote:
>
> Hello Namjae,
Hello Winston,
>
> Thank you for posting this patchset. We are very interested in the
> development of ntfsplus.
>
> In our production environment, we have been relying on the out-of-tree
> ntfs-3g driver for NTFS read-write support. However, it comes with
> several limitations regarding performance and integration. While we
> have been closely monitoring the in-kernel ntfs3 driver, we feel that
> features like full journaling support and a robust fsck utility are
> critical for our use cases, and we have been waiting for these to
> mature.
>
> Given your proven track record with the exfat driver upstreaming and
> maintenance, we are confident in the quality and future of this
> ntfsplus initiative. We are hopeful that it will address the
> long-standing gaps we've observed.
>
> We are eagerly following the progress of ntfsplus. Once it reaches a
> stable and feature-complete state=E2=80=94especially with reliable journa=
ling
> and fsck=E2=80=94we would seriously consider deploying it to replace ntfs=
-3g in
> our production systems.
fsck.ntfs is supported through ntfsprogs-plus, and we plan to continue
updating it. I believe that fsck.ntfs will partially cover the issues
caused by the lack of journaling. I don't know your usecase but I
don't have any major difficulties supporting NTFS on our products
using ntfsplus yet, even without journaling. And I plan to begin
implementing journaling support for ntfsplus early next year, and
welcome any feedback or collaboration from you. I'll make sure to CC
you when sending the journaling patches to the list.

