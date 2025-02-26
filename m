Return-Path: <linux-fsdevel+bounces-42678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA1A45F8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 13:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6FE1887CEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 12:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBE0215769;
	Wed, 26 Feb 2025 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8t0Nn9i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C321214803
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573732; cv=none; b=ZPI5LVBmDr+MX45xXON6P2KM3w/a2b7XqPbBBTpfLOp+XI3hJ1SSMT2LdzYQQsejdQcko5hEJ5kV9DSh4iz1wc0n2j7lSkc5RO7D16wbhdtvmZYOeo/wORvefGmZzZZUCIYhZ0yFKZcEJDRhxeTZE6S41RLhTEb30Xod5skfpT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573732; c=relaxed/simple;
	bh=r+mavr0K16kKbXuJfJTWynKmQrv3ndE3z1N72eZjxVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SalyXKW6JvQxZRaVveOPbpAu2PniyMZKd2/MLdiSHCcSVJj5BignNkK5hP18a4vdR8PqxIgq8KkYaNfQ1GeLTxg+T6dLmGCG7fIaOUOOmRJMy4Afqygwq87K5eJZXYP6ZvfrPCqhHSF7sRv8YpqD8vXmhoI7vb4KnyRteUZTyj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8t0Nn9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2745FC4CEE9
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740573732;
	bh=r+mavr0K16kKbXuJfJTWynKmQrv3ndE3z1N72eZjxVM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p8t0Nn9ijhQl3pPxQk+0ZRdc351MDl5XWt207SugwrXQfo+WSc2vLXgiYH4ucmvii
	 0ZmA4DBdIEF2qfVihupgAVxfcLBfYjIfisecHbYPIEb/rtza/3QbUuDU/YiEGhkrAj
	 2Ix/hmILF2ZOcLBlEI110PkOmy5axGgl/I12kqiPXvTaBXCv0CKzdHuYByOpFSctlO
	 vZfY0VqTrPomN+y71fEijBmQzqH48SioSlePoFA+n/3uSJ6YJmN085jW00fSUZR3nc
	 WZxDXGzA8+lfJCJnFSMu3hZecB9AaVMOSQl8qAGiDcZ7jRTsH8fvRe5J2EmNiVpmfw
	 W5oIj82GacBXw==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3f422d51e67so2777960b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 04:42:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWwTWGeNn3apGk9g/Qcy3ELZrE+Vw2JCe8uiqRhkDDCJ+B0YCTqk8Omd0e+xWstGswYkbXnM3bVKhDdrc7v@vger.kernel.org
X-Gm-Message-State: AOJu0YxVi4XX977IkBEnutD9prndP/O1NY4ujDXCUFNqv8OsKldQJ+bS
	2KWXBy8AHJ76Gy49aJmhlLCZzvMBbx0zvWe+H9RAVhOYiJrLJrMfuGHVZ29+JAp6inKTRJXcjkL
	iLw6l9qv6QwPNRefwwAlY46jeB3k=
X-Google-Smtp-Source: AGHT+IEGSsW+bySR2A91ysPYFj4r2Phenz0Fno1TEduTcnx0jG72Fl+na45g+Qiyyaa910eCfekK0yF3FYpwmoDWQ7Y=
X-Received: by 2002:a05:6808:3a0f:b0:3f4:917:c970 with SMTP id
 5614622812f47-3f540fc3caamr4573339b6e.26.1740573731419; Wed, 26 Feb 2025
 04:42:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB63166087C78BBC8ECA38B0EC81C42@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB63166087C78BBC8ECA38B0EC81C42@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 26 Feb 2025 21:41:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9QXbOvGevXXq_R6Oq+6E-4eiqsDpFZrHaNexbXn9Ho1A@mail.gmail.com>
X-Gm-Features: AQ5f1Jrg_byif07h1pzlyqxCSczXqcDwkqqDoYzBbZ7RBkvslv9r8Vd_UTYBlvU
Message-ID: <CAKYAXd9QXbOvGevXXq_R6Oq+6E-4eiqsDpFZrHaNexbXn9Ho1A@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: support batch discard of clusters when freeing clusters
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:21=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> If the discard mount option is enabled, the file's clusters are
> discarded when the clusters are freed. Discarding clusters one by
> one will significantly reduce performance. Poor performance may
> cause soft lockup when lots of clusters are freed.
>
> This commit improves performance by discarding contiguous clusters
> in batches.
>
> Measure the performance by:
>
>   # truncate -s 80G /mnt/file
>   # time rm /mnt/file
>
> Without this commit:
>
>   real    4m46.183s
>   user    0m0.000s
>   sys     0m12.863s
>
> With this commit:
>
>   real    0m1.661s
>   user    0m0.000s
>   sys     0m0.017s
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied 5 patches to #dev.

Thanks!

