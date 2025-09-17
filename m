Return-Path: <linux-fsdevel+bounces-61973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB65B8126E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0F5174CBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 17:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087282F7AA8;
	Wed, 17 Sep 2025 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAfPS9Vm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB034BA25
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129755; cv=none; b=XgQjqhUFcm/aObQ77lLnwVZF5k9kD5s7/sOq7guQTo2yKJR268kvgnh13/pXnZEPXKBBZqfX+NiurRyGry5KiUwidGueT715+b5txcA01y1tXZdxIgAjz9fRlqbyVMUdKnMLEEIncaTRkuGjNQt6Uk5GWmAO6EzCscPpJxu0d90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129755; c=relaxed/simple;
	bh=RSDxu9t+D5UuL/HojUmVJ3BjyA67oJoFD+owjBDORPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRTcIlg32aqyIFkAsbQBLeNBFtnNmDKYUcNph4smlmMj/4dNpY0hPiqBmWN8/T89IqQBSdxxsqWHUWeWn8mz54kTaoWo9HqxMbgh8v8yqjSaw0uZAVxo7iCvoD8CxWHIRxllYo221AOJxmqA6Qo9SarR2SkzL5iI0etX9J06tHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAfPS9Vm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b5f7fe502dso475041cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 10:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758129753; x=1758734553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gdUx6S6T0XeY4RpC698Oo7BCydPLt/+wzQmQWUkBN0=;
        b=AAfPS9VmpTuHwUhnVtagpZK8y6KCd+JaUtMpOQcJVcLoE3f3YKLPrfxUqmtGd9dhKM
         Qa65n2d+Y+arXSHgbDkYXwWLcRKvsa4AYzLDFZJI9jvMAeakLRnx0NXGaMd6lbqrNEf5
         NQy4TVQBTshfQrHhXAYet33hFLmIIQgNghY4m2QJ0JdRV1kXXA6OhD9vj7H0LPjPr62y
         GQREd2MdAdP9PVle0kcERZqlCu9VcJNuTCtoEVBsK0UiGcyF+FNq/u7XqnFJEs7S5Yjj
         LbsdK11dYB4Vzho6EHsqk3Dh/D6pnUzV7G1DgOx5dcQjYxoVjToDD5lCyDoU5qkemvpj
         m2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758129753; x=1758734553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gdUx6S6T0XeY4RpC698Oo7BCydPLt/+wzQmQWUkBN0=;
        b=Y8LXopy27b9P7o0lG5J17aH62joa96zUwkyUm74+EW33V//UXEti5+pGyCDXdRuxj3
         yuuJSIXgtevyOTJrus0kRGC2JibQLuR081da9pvLoAyiZAr3ey0q2fx935PbsimUmUgc
         pwe6S/l0khBDh1Z0n+j+LF+wwhcUex13waWzlex2IBCWyyMHc8d18UkpS2E/l5LpiU7I
         pAc/0hzOscjtKHNcoeY4MHfOEXr6D6lIrDDZbI0ljy4Ih46lNezETRVxwWEhvkjPWe/Q
         g9gSPrlYi4OCzt3inXBPFWU9jRTPiC2SVJWcy+C6AO8Uh8xK0v4UyEUUSMjEUGEiMHOz
         Su4A==
X-Forwarded-Encrypted: i=1; AJvYcCVgy+tvYBSG94yMi/4t/mLfAaXnA9eMHckb4hpKox2wsYev9O1soWm0zu/fTILuyGKLIU6SlHYi3Brsxp/A@vger.kernel.org
X-Gm-Message-State: AOJu0YxqngFNkUzzbr7VgCm5auP6imMq2ym7XWNuIpWRmVuVtC1uyyF2
	kOG7ptXY97/ToDJYU2gqkkq5s9hfH9jrqvOcjjDJ8JfAGSsWou9dvq7wGeG58wkBZY2rfKZkMoW
	dqsTZ7ZXtZs3nLbnoSc2I7wY7X4Jm2H5QQsxqA3o=
X-Gm-Gg: ASbGncs4Xq+Cn6cU3SQzfjabXuug7bhoR7mWtLlbgcfVifkPdfSDXVZsYLOuEhk7U1p
	BzAv9wfXo0+j9UrYbvhDQt1oFvLnlxUhTTTAFZruU6grJE0Ue9xoEDht9FW6snoV54b8ITUArk3
	ZXqC5HVZB0Ld0gO3rQOEpPeIg3j/7pIsKHZcwj75YLgjoF1xpr1bOyFe/KaSrZB1uIe2txY0YeN
	0qB9ne5hv8RxTs5gqC2nfnZ23rm9KvGXc8ApbOaKvqE2xcRsY1z+Rkv1gBJ6w==
X-Google-Smtp-Source: AGHT+IGhw/RAdL+Qq2ErhT+RqzctdlfmfkoP0agP9mEGuC3CqxOJ5ZYts1MnMGTbJhwI9M6YjxB3u2up4luyGrjSUu4=
X-Received: by 2002:a05:622a:3d4:b0:4b7:9b8f:77f2 with SMTP id
 d75a77b69052e-4ba69d34e9cmr44802521cf.39.1758129752501; Wed, 17 Sep 2025
 10:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798150680.382479.9087542564560468560.stgit@frogsfrogsfrogs> <175798150731.382479.12549018102254808407.stgit@frogsfrogsfrogs>
In-Reply-To: <175798150731.382479.12549018102254808407.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 17 Sep 2025 10:22:21 -0700
X-Gm-Features: AS18NWBMZSYluzPeM3z2iS9vBZBge3HQ1yV3N-msM09MJyDe4NdK72RgXGvQGco
Message-ID: <CAJnrk1ZhMnkEWqp4yhuAk6vC4xw1VcAXfYBsvLXNu7G1isWZpg@mail.gmail.com>
Subject: Re: [PATCH 1/5] fuse: allow synchronous FUSE_INIT
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, mszeredi@redhat.com, bernd@bsbernd.com, 
	linux-xfs@vger.kernel.org, John@groves.net, linux-fsdevel@vger.kernel.org, 
	neal@gompa.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 5:26=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Miklos Szeredi <mszeredi@redhat.com>
>
> FUSE_INIT has always been asynchronous with mount.  That means that the
> server processed this request after the mount syscall returned.
>
> This means that FUSE_INIT can't supply the root inode's ID, hence it
> currently has a hardcoded value.  There are other limitations such as not
> being able to perform getxattr during mount, which is needed by selinux.
>
> To remove these limitations allow server to process FUSE_INIT while
> initializing the in-core super block for the fuse filesystem.  This can
> only be done if the server is prepared to handle this, so add
> FUSE_DEV_IOC_SYNC_INIT ioctl, which
>
>  a) lets the server know whether this feature is supported, returning
>  ENOTTY othewrwise.
>
>  b) lets the kernel know to perform a synchronous initialization
>
> The implementation is slightly tricky, since fuse_dev/fuse_conn are set u=
p
> only during super block creation.  This is solved by setting the private
> data of the fuse device file to a special value ((struct fuse_dev *) 1) a=
nd
> waiting for this to be turned into a proper fuse_dev before commecing wit=
h
> operations on the device file.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_dev_i.h      |   13 +++++++-
>  fs/fuse/fuse_i.h          |    5 ++-
>  include/uapi/linux/fuse.h |    1 +
>  fs/fuse/cuse.c            |    3 +-
>  fs/fuse/dev.c             |   74 +++++++++++++++++++++++++++++++++------=
------
>  fs/fuse/dev_uring.c       |    4 +-
>  fs/fuse/inode.c           |   50 ++++++++++++++++++++++++------
>  7 files changed, 115 insertions(+), 35 deletions(-)

btw, I think an updated version of this has already been merged into
the fuse for-next tree (commit dfb84c330794)

Thanks,
Joanne

