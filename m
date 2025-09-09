Return-Path: <linux-fsdevel+bounces-60718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0345FB50562
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 20:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5835E38ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 18:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83059301025;
	Tue,  9 Sep 2025 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS+ikj6C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD5B3002C4;
	Tue,  9 Sep 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442763; cv=none; b=umHV73Ara3SoLSBhkGR5gzJvog88dGxLOom6NE83MbkOrZyENRNQDoP15AF82knZcCMHFMnsrwCBbLx0tzXN/0lfMuUi5U/hXZIHGTcZFxfM92VudAjuCv3g1v2FZLTvB44p6Lq1TJQyHsBaJXkUeYAdcOTlBLmKnkQFTw91MrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442763; c=relaxed/simple;
	bh=GW2x3BiMlxtdXONsUQUaEy/dHtbMsT4sWtlNzRaafO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5UV1l6T1Y1oVNau2WoxfVBT/JCYtzvlo8vYkh7htHsjBpr+oTVQ/olfJ8IKijWXFshTvdJpA6wq5t1nexnqpRVgVN6+cMvcWoAxzMI/3UjRIwq38h6YdCOVuOTGhJkXPxdBxE1aK0l1ud1GJ0M6cg3ibyUU/t/xqjQ0SVvJazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS+ikj6C; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so8474119a12.0;
        Tue, 09 Sep 2025 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757442760; x=1758047560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIGs9FBrVN4ysExlh34AjdYI0YF46w+oZSmAFf3lNX4=;
        b=CS+ikj6CoktTENcKDyOs4cIG3k7BeNGQRuCdZQ2dRTEZtuVxC3K4oqUkJ0LNWNqhWH
         +3INlXxuqLLdLe0li8Ed/XRwv8yxjioDmPxzk5vPHBT9lfZ140r9jRaNpRvoBwl1tw9S
         W9S0b92vtYTbPwqwEfADIEkOZIbcdDTSW+1FM81zw9VUa0cUMRPMAuXBomwM1ZJHIeJW
         QzT6vj8H+6OP1C7tXSM4LrplfqyRAkmc/UkWb31is25zODzTTCRbaEUhhl47QYbE53x/
         qV4trjzklcNN3qsbjXbl3zArm+M+reqYViC01q9uSpd1Crj+dx/UC1GtF0CJw/TbdUyS
         9CSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442760; x=1758047560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIGs9FBrVN4ysExlh34AjdYI0YF46w+oZSmAFf3lNX4=;
        b=TaLe76O8PHSNPE8vtQ+ZkNweCdJFmM0XusNtZ1lc+gbBiEbtOaXF9we3Ypdu9eN1XD
         YYGXOrgguoiMkUHSOpxDJ7/RT+vTqAnXnbYdevluLDAG66VXOYukaMODAqdyjQdFj/ij
         IgvkRF9+DsvR0oUFyM1nfM0vcUhvCXIUTqhPTqsASMs0LbCito4Wh2iVECAiA70pXwnk
         KHUDj9QWQAvozjxlVio09WgkiNbsSnOK/2kPApC2BfjP205+DGaT7xv4WPsoArd9G0cm
         Pg9UTC+dDN38G7FBgyHzouIjrVHTPnGh5dA8CGScfEMw+j0fGvCK5k7ud5iNVKjm95qt
         zMTw==
X-Forwarded-Encrypted: i=1; AJvYcCV0LUEGC17ZtvutdgNwXrb+UQoAlUU6jR0JhJR/6eWjUSBXpENkMGBJo97rxf5jRKHHVyP307rs2Buw+A==@vger.kernel.org, AJvYcCWKPPjNeyCwrwKv80V3xOBd69K+fXREUO+jNpqpLXaFxaQpv0NBPRZ9iLgWnbxcooffgRdYW/I6jI14ug==@vger.kernel.org, AJvYcCWbMbBG/ZKy/L3g0GUnnW01e0a7XC6Cp8Fea5LmBZMrONHcphq5faA9uuM1DJpt3x02eQRyngWs0Z0oG1yT@vger.kernel.org, AJvYcCWqpN0QFo1XxElEtdb74wAgCJWhsrLs2SFm1hqnuoMWQStOKKoeUaKpcTeDmNPVl3JrxA/U9Z0IQtTD@vger.kernel.org, AJvYcCXwKFZXTIrkhM/bT2ymo+taCIzBgUit67/3UWvQzrGrxmRV+sUDvSNPvUcHknoI0UvtaQQhy6kDiKeOOifqDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMaBBvfLkAZbdh77CjUGOHHMgEy2j8deULa7leTISVMXjxABio
	LJOceoJzLZkiNJuv0QLqBszZN7wXgdoY7pLizaRdmvpQ+iowcZDHwyaQunI2rmG3DZmllP9hJ2V
	RBK8K3V85UDFiOZpsg+97yrKeDYmGYd8=
X-Gm-Gg: ASbGnctnHaLkk48SeGedWY1AzeV56ol9l4z/Gptvq+7bTZuiHA1h+RZcq0V/dF6j6L+
	y9wPeOwPVcc6HI6nvELN8CPkeVMrnzIqFJVw5+n5eSi66RDYxczMzzr9iiYFC9GhCqU9dK+VtBP
	rLYspnyalcIjLhGqD1146grQPPdsP2IaLG+zrFuRfXCNt6NftNhqiLVHfId0pEH0Lgs8gS2p8VX
	dQbuw1BDbTLtD+IIw==
X-Google-Smtp-Source: AGHT+IGIpYLmFMQhXwhapf2seoXIPbxx2/CNzBSDsmPVTyytD6TFl/TeK/249z9Axk5K8USmmiSQ3V6JXdtG0O8zPdM=
X-Received: by 2002:a05:6402:3589:b0:62c:62e1:8ff4 with SMTP id
 4fb4d7f45d1cf-62c62e1986amr2372712a12.23.1757442760027; Tue, 09 Sep 2025
 11:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909091344.1299099-1-mjguzik@gmail.com> <20250909091344.1299099-10-mjguzik@gmail.com>
In-Reply-To: <20250909091344.1299099-10-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 9 Sep 2025 20:32:27 +0200
X-Gm-Features: AS18NWBEChkhzDf6oUf2_3PrIR6nRSPRVkR8w4kTgZptP8cMl4B5_HTLHZwMBuQ
Message-ID: <CAGudoHG59Q=hQg3cQpPamCj2x8NuNZ7qhTMcOamWTkYDJB4PZw@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] fs: set I_FREEING instead of I_WILL_FREE in
 iput_final() prior to writeback
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, 
	amir73il@gmail.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ocfs2-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 11:14=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> This is in preparation for I_WILL_FREE flag removal.
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/inode.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 20f36d54348c..9c695339ec3e 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1880,18 +1880,17 @@ static void iput_final(struct inode *inode)
>                 return;
>         }
>
> +       inode_state_add(inode, I_FREEING);
> +
>         if (!drop) {
> -               inode_state_add(inode, I_WILL_FREE);
>                 spin_unlock(&inode->i_lock);
>
>                 write_inode_now(inode, 1);
>
>                 spin_lock(&inode->i_lock);
> -               inode_state_del(inode, I_WILL_FREE);
>                 WARN_ON(inode_state_read(inode) & I_NEW);
>         }
>
> -       inode_state_add(inode, I_FREEING);
>         if (!list_empty(&inode->i_lru))
>                 inode_lru_list_del(inode);
>         spin_unlock(&inode->i_lock);
> --
> 2.43.0
>

With a closer look I think this is buggy. write_inode_now() makes
assumptions that I_FREEING implies removal from the io list, but does
not assert on it.

So I'm going to post an updated patch which moves this write down
evict() after removal from the io list, and only issue the write
conditionally based on the drop parameter.

On top of that write_inode_now() is going to make a bunch of asserts
about the inode being clean after the write if I_FREEING is set.

--=20
Mateusz Guzik <mjguzik gmail.com>

