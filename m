Return-Path: <linux-fsdevel+bounces-44705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B45A6BA3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 13:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F62D3B5875
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 12:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2C8226188;
	Fri, 21 Mar 2025 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLlExwYz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8BB225788
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558481; cv=none; b=TB59DWX0MAj97ieaaLUa9HI89SpDp+OBlrtKfnEjKl5ZVZs6IqXfarN1QpTz3qqBsRbHTrFzmuMthj0o0PPGWN9Cz6RfPcSnpqxQOQ8aUpd2jyJedq8OejabzpKwGh4eZ72KqXRSJkQg9Vjo1supdGtFiusgIbkHyqtAVIXXtPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558481; c=relaxed/simple;
	bh=lIvoTqYCyh4CD7MM1R9bi+jS+Ww2jitNiBWq4UzzC+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HB07lBywQv2hmZi7BeeAOGijgE0VJwC1a/X2W2uJcQUHB4W0LRiMI82mWIJ6m15jpv68G8vVMHAWEm9VbW5y6cf+vFYAApXJ1OUqjU3WprH8nTyPSTugPHBaKdXRR9ym+nqJ1WpmtYL7FkFgmm+wx1s2ZrRw20O+FR3GqLkJERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLlExwYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D71C4CEEF
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 12:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742558480;
	bh=lIvoTqYCyh4CD7MM1R9bi+jS+Ww2jitNiBWq4UzzC+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sLlExwYzQhBZaMuFa4GI7BU3vOC4I25ajsFsoJT+OoNL+ycODX0D8ZkwYWWZCn5rc
	 KLhlUE7ehGWfxKdKjFTQxghKH3Kx4ij16ws9oG4z1zGjJlZI9Ulh2Uv+mqbogdQ+Cj
	 32zy9iEavAoh/rIG1JiB15Lv1d0GfSjVAv5CAtMb3w02e+7gGjKzVHXDOwYii1pxsr
	 1HkcmCxD55+DbqLky6vovUxU0sII+xSIokGUecxOa+CSugv+tPoqrZT5W0EmfyIzqu
	 W2WoSwc1A1LQ1BT7YvTLs1r7Ms6KRFKFLJ3aOU2BAqA4oi+LCifnI0lQqazud45lKX
	 zG2myvuouEHtA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2bcca6aae0bso1606987fac.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 05:01:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkkziewENN0J6/kePWe8wLuD0PnJwn3VkEF/mH1E5K9vd1rPrlan8zQmTwk8B+zn88VQ85VIw4XX9LyifG@vger.kernel.org
X-Gm-Message-State: AOJu0YzI0dZJoyOhA6Nb2Em/au/y8ddlOdzp7pIo4tDv9mWOkoOGMQZD
	iAxF8UbsJbjJih3UrVo1k8ILu7Lu6ebfe26S7tSisH83lPzgbIqJVFxXx028XcUyMWGxw6qmYNG
	/oh/SYYRqUC5Hui66p4x+f99pepE=
X-Google-Smtp-Source: AGHT+IGQLQZwc0/CrIkIOHdV2FIx1nWZelfPpfcsf9X1WR9/orOIUxvJPxrxu8PCLR3RvGDli8uNNi+blfVq1KNrIBo=
X-Received: by 2002:a05:6870:8194:b0:2c2:cd87:7521 with SMTP id
 586e51a60fabf-2c780246312mr2158633fac.4.1742558479779; Fri, 21 Mar 2025
 05:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB63160E8D5EF0855E84D9D07781D82@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB63160E8D5EF0855E84D9D07781D82@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 21 Mar 2025 21:01:08 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-sP2aSheFbfpWgz9CvH5V-NxTnrw2jQ62TT08=scLxHw@mail.gmail.com>
X-Gm-Features: AQ5f1JpJ8Om-WDziXHhHMn-q70P2ABZdwiXQ0eCJTvIjVwrM8ke_D6xDTbGyIaw
Message-ID: <CAKYAXd-sP2aSheFbfpWgz9CvH5V-NxTnrw2jQ62TT08=scLxHw@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: fix the infinite loop in exfat_find_last_cluster()
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 5:28=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> In exfat_find_last_cluster(), the cluster chain is traversed until
> the EOF cluster. If the cluster chain includes a loop due to file
> system corruption, the EOF cluster cannot be traversed, resulting
> in an infinite loop.
>
> If the number of clusters indicated by the file size is inconsistent
> with the cluster chain length, exfat_find_last_cluster() will return
> an error, so if this inconsistency is found, the traversal can be
> aborted without traversing to the EOF cluster.
>
> Reported-by: syzbot+f7d147e6db52b1e09dba@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Df7d147e6db52b1e09dba
> Tested-by: syzbot+f7d147e6db52b1e09dba@syzkaller.appspotmail.com
> Fixes: 31023864e67a ("exfat: add fat entry operations")
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied it to #dev.
Thanks!

