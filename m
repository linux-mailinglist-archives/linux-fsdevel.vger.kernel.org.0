Return-Path: <linux-fsdevel+bounces-68720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 808C1C6402A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 13:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A73235E4C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 12:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE29225390;
	Mon, 17 Nov 2025 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlT5rROx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mw7MuAS3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02675221F12
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763381800; cv=none; b=mtWMO5Coj/qtN2B901ZzquPXZCoCGhhqfqV2tcVpZ49BEmD63/Cu/scuGEA5Vlc/pE0wRbZ7lIWl7MzsxJff7KHwTLe7mkT4KVtpyIqrqDleLwtXahlYjuA2irYaYSy/EOTe33+0LqT2Mx81U4Yk4Rc4siprUivld5IQYXCwyco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763381800; c=relaxed/simple;
	bh=gr23ZeY1I4hSMTNuQyKnmR98iMS/Fbk0O4eN4Mdv+9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqFVw6dj2G2Y2Vx0C3hxiHOkAxrhfRRViC0Oc34wEQ5XXfoZgi43FWfrPj8sTHFxjV9u0hFPZaEufa/djnlLXfT1014lfRs4PNosc59qNjITQS1BiaL0jhUt1ttDYiFC9AuOsvrI1Skd0Pm23evnoJPFAjQCOf58czE2OzbhckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlT5rROx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mw7MuAS3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763381798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mH7dqTza5/ICxttpe5ZYHzkQvkuaT6VLnv2Ytl8moUo=;
	b=PlT5rROxLOLn8c5fpb+R8r7zOluSt8DWYVxH542JwdBFghlKMWh+ciRk9NIsSAiuMO2qdL
	TJmkM/LJilXiZXr1Tv1nxS8ogJjnUtVchAHIqaishNaGOfbPl20CZGuXJ6wn748W4gvEkx
	ETcGplehiKhSFT6IMvG6MXCJh5+Z72k=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-0hpEfcsXMGO4sbO5fY0__A-1; Mon, 17 Nov 2025 07:16:36 -0500
X-MC-Unique: 0hpEfcsXMGO4sbO5fY0__A-1
X-Mimecast-MFC-AGG-ID: 0hpEfcsXMGO4sbO5fY0__A_1763381796
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63fc8c5b002so5487299d50.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 04:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763381796; x=1763986596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH7dqTza5/ICxttpe5ZYHzkQvkuaT6VLnv2Ytl8moUo=;
        b=mw7MuAS3lzslVemwAiOAnBVr8mg15qPpSvsEOrVHYBquCc2QJ3syUeof3hAbRk9520
         RuyApxvZlHOUy6Hn3y6e13Kh7ZaXLmBCmCThJWRIBDi2sjGJwtCJ9A6i39NTnIhu394E
         RGEUCmV+cW7U7Ij1EQ+0pOaOPxAQFLro77tXr8pbEnc/YARQpU0oKxWxlYDSpwDcvfvG
         X/iQEgkJz3NaJzvRYCEIQ4BX5HsQXRaH2UONp0E/+17Z6vTA5ImjXOVbOhf/3L14ZfVH
         J4IAbONqgegijImL8VT+IgekcoID9oOB0X8NZOlVtICOf4rpF/Xdxv4BnJJA2NK8IcHG
         vVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763381796; x=1763986596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mH7dqTza5/ICxttpe5ZYHzkQvkuaT6VLnv2Ytl8moUo=;
        b=dP7Pj7QAso6BbUjE1k4G65b/j2GcpccSyRBY6hGHsHUWg8qa5kuZs0svEnkfI5g2nc
         Dn8l4hLHCtOiSb/qpZbWa8jhYRLNBTWRlbW68ODXgS9nHahaWe5ncZDXqshLJKjfYjAJ
         8R4jpquZu04ZWn/DIT+OjDZZaDdybaJ9MdbSR5aCKlglY9y82u9Cb7QU3kT4i+yJTxJV
         TipAOMxbkF4GTGV7acr+MZvRfZk88gQmbsul35llNvJEoMffV20xl0FqM6oz+77g05Az
         wkxUGdAh/vV20oDGVtw88VuGkpqjXSKoTJsWmodHe0eKiKEGGqnBK/t+yI+5LycFD26n
         AuZw==
X-Gm-Message-State: AOJu0YxFNRl+aPVX35atyQbDXR309ljdCQ6YGFUjmHN281MIqtEOZ5Bg
	Be6ReIWEhjjqhZnadClS14DYvZ2/98/u1pXtgDeqyRkQkoLzfEykYx/05TsP65VnJJ3hpoUpwsU
	Jkiw+t5AjCli6rUEa5m0uYjelNWgouoVgxRBHyoYghXaqAETg0hSq5VEQaT8kbdCtBH6f2RzoJi
	zySU+QWIr9Nn90rEQ5GWCe2TuTTzbvpXAxxx6qqAYvSA==
X-Gm-Gg: ASbGncudKuFrQe0CNA7hfY1DTWs1FTCMyAZHh9NUSL/LpPmZ6ngu7FLAbWmlpOKx9qd
	2GmoUcK39TlLYm5rnE88KWzzP69IoGQ1IRTpUhs7Z9lVQHP1VN3lspcBkMnKQrn4io1YzaHYlxX
	m34umN6z9rvW4MOhN7xN2hdM/D7T8gQL+qXyO7johYgPmPYQ3wZ1E1BQ==
X-Received: by 2002:a05:690e:1542:10b0:640:dfa4:2a50 with SMTP id 956f58d0204a3-641e770c6bdmr8207899d50.62.1763381796174;
        Mon, 17 Nov 2025 04:16:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQLIm+pbLoRuOW0i+kGG264Vq4lbJgRyjSePRLRntw0Ayy6GmrJaroLrGoALIRpTgAkyId8h3tJRcyUEYr8lg=
X-Received: by 2002:a05:690e:1542:10b0:640:dfa4:2a50 with SMTP id
 956f58d0204a3-641e770c6bdmr8207887d50.62.1763381795826; Mon, 17 Nov 2025
 04:16:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101080919.1290117-1-agruenba@redhat.com>
In-Reply-To: <20251101080919.1290117-1-agruenba@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 17 Nov 2025 13:16:24 +0100
X-Gm-Features: AWmQ_bkZ3PrH05zVh0ifYZcqZjBkobVJSPgRJ3dx0BZ0fazXa24uBAl24PLTRBc
Message-ID: <CAHc6FU6KW2zsmoX5XqX2aJ=2qPgt_RtZq7BDApG55Jgf0jdJGQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] gfs2 non-blocking lookup
To: gfs2@lists.linux.dev, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 9:09=E2=80=AFAM Andreas Gruenbacher <agruenba@redhat=
.com> wrote:
> This patch queue implements non-blocking lookup in gfs2.
>
> A previous attempt to implement this feature was made in December 2023
> [1], but issues were found [2] and that attempt was aborted.  This new
> implementation should be free of those problems.
>
> Please review.

Note that I'm removing this patch queue from for-next for the upcoming
merge window to give them some more bake time to.

Thanks,
Andreas

> Thanks,
> Andreas
>
> [1] https://lore.kernel.org/gfs2/20231220202457.1581334-2-agruenba@redhat=
.com/
> [2] https://lore.kernel.org/gfs2/20240119212056.805617-1-agruenba@redhat.=
com/
>
>
> Andreas Gruenbacher (5):
>   gfs2: No d_revalidate op for "lock_nolock" mounts
>   gfs2: Get rid of had_lock in gfs2_drevalidate
>   gfs2: Use unique tokens for gfs2_revalidate
>   gfs2: Enable non-blocking lookup in gfs2_permission
>   Revert "gfs2: Add GL_NOBLOCK flag"
>
>  fs/gfs2/dentry.c     | 63 +++++++++++++++++++++++++++++---------------
>  fs/gfs2/glock.c      | 39 +--------------------------
>  fs/gfs2/glock.h      |  1 -
>  fs/gfs2/glops.c      | 15 +++++++++--
>  fs/gfs2/incore.h     |  1 +
>  fs/gfs2/inode.c      | 20 +++++++++-----
>  fs/gfs2/ops_fstype.c |  6 ++++-
>  fs/gfs2/super.h      |  1 +
>  8 files changed, 76 insertions(+), 70 deletions(-)
>
> --
> 2.51.0
>


