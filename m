Return-Path: <linux-fsdevel+bounces-60027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC0B40F6B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 23:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D769C3AF21F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 21:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906DA35AAB6;
	Tue,  2 Sep 2025 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdNOL9fp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34035AAB5
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848706; cv=none; b=A/06LIQD/zTYO8qMVMXPl2C7oQ8Qe52+LiWLNSo4+P8sqU4ILgmB5GGBH8BbP9W62qRXG8flw1dd3vra0rjXIWpCQAxOZizv/9CCYTH5ThSa8V5PWxsWPyss2wqDqjgc/tmJBLNOsbcbTbh0p86bzfq+sTKfv2RypWCR7VdRT/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848706; c=relaxed/simple;
	bh=a1yJHrCFSWD1T/fQ1Rj0lKOZkeEUa0TQEUS9muhHM4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLApu6CUifQAFs2bX/8mpNbSmZ7nWZKJTfd+cgq7fAZwPdQhov9ZFr2VRCbdZMyNBZsKFGijeuEpg/d2XyZIKCp9i5Z2VFkFG2BVSpKcm3BCvpnuI3R6C0y3bBr3ofQaObP/9TLqx6sYa16jpppRtEuHUpfMLH83HpU/CATP/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdNOL9fp; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b338d7a540so26193231cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 14:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756848703; x=1757453503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id5PqTJUIq2s1nZBVwN1iuIVkwIbT5Abrm1YBS4Y/JI=;
        b=gdNOL9fpR3+zPQJR/duRDIzKMGQHI6yoEdqeYg3aQN3PriQp2ojx8+ivV7LOdFClNj
         oHgBosf04w9CnRX0giMhuazXEXPVSPhUxS15vb2RlHM4MJOUcqv4ky4yi8WC2se2XfXv
         1PKMI5AcF6OAfI3rq44gwc7TuC4PfrGEMBZtHYwQrC7DQO9ASxgupIHSSop1gPAc093I
         EJgm9aRYkPRD9uxitQvxSsVSV2ZxXjjVT/wOEwCCGkbNhK1bhi/R0Lc+P7qsm9zbHu8b
         i+SqtsJMrknDf0zc2i2YjbFx+Iz8QHQF7zttdPkylRVEUcfPrBBYAtq77Ei6SnMz1v2N
         M9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756848703; x=1757453503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id5PqTJUIq2s1nZBVwN1iuIVkwIbT5Abrm1YBS4Y/JI=;
        b=Hfwcj+H+blZ9nwht0aICJT+tlrFefj0E2Ac9IjNcAUUpQDTrdGM5uZqddI+O7k+J0f
         dzuqlYOM6iJRaW+Y/WbyPTjmjW0ualMSJ6Z6nMHq1xWbyHVJPdmj92Kwq+1R7QX9G12m
         oJ+ClzBNEbGhCpHRb2hKvbE1hLaELVBRiphydnzdn4fbQCpYcUVENqO2AhbYUecqvXWG
         i90GvEQYywOfD5GrGST6NIWt+/wAyQSYx6anjS2cqRJ4C3Ib7yzt3moyudFKFsSCO5em
         q9PuFpZHCSbBMOjfvg51BqGVJIjiSC9apUpTIw4bxfIcJeto7XvBW5Q6fwKWqYqBUmN8
         xFQw==
X-Gm-Message-State: AOJu0YxWBnAsjIl1itwRUitnAqML013Toe9i46hDlh2Tl3z4xVO/rbOi
	9Mq5ilj12PdbsMNXg3OsobqNfDnmvsqrZ4TknO80mXKaiyw5MjPndf7FCo2s2s5uaa1HUUpLP1z
	toaa95J1k5z9zZYYG9tLyUd6zSG06hts=
X-Gm-Gg: ASbGncsgUBbB6yIWAk+lLOuTxGwyZugcZgDww972CLwQg6SHzRI4NchPq36oZcoqeDX
	ge5vr656a1tbbPJVEA7tGSzzH5z6Mdb/+/XNjb/WMujs/HPj5FhVpMwy68w3fpQUO0dg+GHk2DJ
	cFTULCaWRbuGZpjsmuSUAliTZgmh+yJ3Oxac8joheFE4t83KLCUnMocpL1FcZUmc46a3CaWJEU/
	CFld4JI
X-Google-Smtp-Source: AGHT+IGbu+xA+cjbqf4Rla3WzH7yOwfBUq6UshDpr1rKailie/p8avNLJI2ORaQbZ+oi3R7X1/FccIwb+gxU/NoXiEc=
X-Received: by 2002:a05:622a:15cd:b0:4b3:d85:de90 with SMTP id
 d75a77b69052e-4b31db6a3f0mr143985151cf.39.1756848702310; Tue, 02 Sep 2025
 14:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902144148.716383-1-mszeredi@redhat.com>
In-Reply-To: <20250902144148.716383-1-mszeredi@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 2 Sep 2025 14:31:30 -0700
X-Gm-Features: Ac12FXzzCi9rR-p1hKLROKf6Ru62_vQmPZanE2-8uyN_SpVsDm_HOR0y3DlDBVQ
Message-ID: <CAJnrk1bjwbXZo2ByN8=f0ETwDqYBKq68t3Qvmh8EoSftetuYxw@mail.gmail.com>
Subject: Re: [PATCH 1/4] fuse: remove FUSE_NOTIFY_CODE_MAX from <uapi/linux/fuse.h>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jim Harris <jiharris@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 7:46=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com>=
 wrote:
>
> Constants that change value from version to version have no place in an
> interface definition.
>
> Hopefully this won't break anything.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/uapi/linux/fuse.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 6b9fb8b08768..30bf0846547f 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -680,7 +680,6 @@ enum fuse_notify_code {
>         FUSE_NOTIFY_DELETE =3D 6,
>         FUSE_NOTIFY_RESEND =3D 7,
>         FUSE_NOTIFY_INC_EPOCH =3D 8,
> -       FUSE_NOTIFY_CODE_MAX,
>  };
>
>  /* The read buffer is required to be at least 8k, but may be much larger=
 */
> --
> 2.49.0
>
>

