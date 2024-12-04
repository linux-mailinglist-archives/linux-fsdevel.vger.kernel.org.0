Return-Path: <linux-fsdevel+bounces-36391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887399E32A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 05:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6E928517D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 04:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6396D155398;
	Wed,  4 Dec 2024 04:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrrQu0S0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A2219E4
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 04:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733285934; cv=none; b=EATlxzZu0ytIMWcjjvo/XwZge2o/z3yCSykslg4re314lojkMGOldzp6NrG7rh9nCsMkEz4Y70NETIHLE7jlJ8gNbLDR+9j4z1QpUHmxLdyh9y5zxXST1zDR7OPLtwuoeQShoCU0xJAGFwoy8Xohw1EjN3kpNhC1dzNBrG+RUMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733285934; c=relaxed/simple;
	bh=TIlU0oa1BdFrbP9YvY5A/zdXg+9xFh5+860svCS5FtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZSqg1hRS4WeJZrKQLxZgjm/3JrpApJY1YUvtXflxVCbwEVx/s6zJssERSlwgZo1OzzV3D0TyLgnxSXo3zcxBaVyGbVIN0/uAIWVB+tkrRtY22bXtZYddRNsmxOIzcOA3d8kuvisXM0AjE603vZ/BbpJRLMyFWg9BdEvv+qgRqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrrQu0S0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F1CC4CED1
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 04:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733285934;
	bh=TIlU0oa1BdFrbP9YvY5A/zdXg+9xFh5+860svCS5FtM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QrrQu0S0BPorYiPNDWbc3EzRaHr6QwGWJsRL5IzKV5Z3zgc1S3P87fe6rZg3U2EIf
	 JRX3W9PtKVr8v3t0AOCcDKN0rL54oV1FTH63VeIZ6IkaQOxEzAdaiKTry4eJ+VsLuJ
	 w+u5prIgaEn7d5zOkKprvpY/V7HgcbpeHvZJbkNZeerq4blQKREG74B+u2VNWb/hvo
	 j5eGmMEem89UQN05D3TRvjeNrMz/zSiqJJrdmZd9WWweTcYsYH6QDjgC4yzm/9yYMm
	 XHpYOKsGfIIgXxL9JgeWr+kuR7nunvxv69I8bcC0NXApBOLeKlqEfG5odwu8wqVgF/
	 FEmHk+BNr4XBg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-29e44714bfcso294510fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 20:18:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqCqoNu/lBtb3Le8nEhrCMN/rfCMRfUKZK0j8Nlq5rxrvwIahhOZEqrcHF/z5Osnyo0FFvRoPr/kV8OU6W@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8m01kb/v6oqSdfKw+6levzOeTLZV8b1ziN7xDP+ftbgx5+2An
	PUYLUrp0MKeXqq6Uesq1ClPXw2jD7GfJ0lQNqtt4DbVOpB4rcqMRVMZpO6wE719nSMHmefwly/x
	5irLaJ/ZUELHXxj9mzdiSp9TPzEc=
X-Google-Smtp-Source: AGHT+IFb0tfPwLuYi5HO1WwpTtjJGETlqNlZCzT7X5LFk9IsQQHsuIYZzYk9dvldUa5+EnPiWKtIEFdYC+l/r4wsO9I=
X-Received: by 2002:a05:6871:ca03:b0:29e:47cb:f1ed with SMTP id
 586e51a60fabf-29e47cbfa47mr8372498fac.17.1733285933500; Tue, 03 Dec 2024
 20:18:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB63164E8CDD8EF7E1F5638C1F81362@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB63164E8CDD8EF7E1F5638C1F81362@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 4 Dec 2024 13:18:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd88mcrcLuMsMJ4VfQqod9MFo=fR8863mPv2EBZxzj2HvQ@mail.gmail.com>
Message-ID: <CAKYAXd88mcrcLuMsMJ4VfQqod9MFo=fR8863mPv2EBZxzj2HvQ@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: fix exfat_find_empty_entry() not returning
 error on failure
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 2:33=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> On failure, "dentry" is the error code. If the error code indicates
> that there is no space, a new cluster may need to be allocated; for
> other errors, it should be returned directly.
>
> Only on success, "dentry" is the index of the directory entry, and
> it needs to be converted into the directory entry index within the
> cluster where it is located.
>
> Fixes: 8a3f5711ad74 ("exfat: reduce FAT chain traversal")
This issue caused by this patch ? If yes, Could you elaborate how this
patch make this issue ?
> Reported-by: syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com
> Tested-by: syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com
I can not reproduce it using C-reproducer. Have you reproduced it ?
Thanks.
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> ---
>  fs/exfat/namei.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index f203c53277e2..c24b62681535 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -330,8 +330,8 @@ static int exfat_find_empty_entry(struct inode *inode=
,
>
>         while ((dentry =3D exfat_search_empty_slot(sb, &hint_femp, p_dir,
>                                         num_entries, es)) < 0) {
> -               if (dentry =3D=3D -EIO)
> -                       break;
> +               if (dentry !=3D -ENOSPC)
> +                       return dentry;
>
>                 if (exfat_check_max_dentries(inode))
>                         return -ENOSPC;
> --
> 2.43.0
>

