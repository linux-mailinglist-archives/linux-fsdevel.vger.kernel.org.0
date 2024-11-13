Return-Path: <linux-fsdevel+bounces-34595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E099A9C68E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 06:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B32CB2426E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 05:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6C81714A8;
	Wed, 13 Nov 2024 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2EaF0bt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9F1527A7
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476943; cv=none; b=JwJh8K8G9QT8WwOaHMYUnSo98lRSlemeHzzky7UO9xTWxY9s7PaMAR5X7AD/ooNlyKXr4yxDGiCHq6KY9z8652id88tBVmodIZcLqXR2KBkJR9jE62eMweBiBv1cE386DvelpoTd8woIWX3ipu4X/h9Q+WHRUKYzcFo5x2YE+YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476943; c=relaxed/simple;
	bh=QCgNl/wapxTuyeQQ2qT39du63x1O2ULwVt+24SMWAIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMln0fgUlptJL4KQPiSwwRlstqdHUYLqF7qDTVaQpnS2pGgMqCkvMnS+ZTds+87gF/3o+EKagzh99EjfpUC7D9sKOrxqwmnhs7O1h0SIlOGXx8opq/AW662ZCzJRRrgx9tCRNW54ATSAY0AOtu0mrd5wU6P3avruG7lOUL5M320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2EaF0bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA8DC4CECD
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 05:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731476943;
	bh=QCgNl/wapxTuyeQQ2qT39du63x1O2ULwVt+24SMWAIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m2EaF0btcVpgrvsZ9bpen6MJ8ceE20d1Lry/JsBQ5rb8vamQybPDPIIwQtHJ8dGua
	 2a5hWbs5xc1nuY7r/3VCohN7M0lO+IGTVzlcsMu/Gg7FU0l6gpels3w0PyxosulroM
	 8ELW05yTi5kn1/g358R0AbRoYx90Xk8WVxWr7TJX+yn75zXIfRDc4eaqKjALg1Qstx
	 p905CHQi7xZecrK73wIdHbM9mRm2jNCIuDtt6eqftJpFuqr6Fs5fwJVRhgPMmQnQVy
	 ZU7h3XYeFTZJpnJtfyC06OG4+sF5skElsN9dDlBwngnLfqR+6DBEv/ZRKohZOyFcvh
	 Qv3219bEl8dEw==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ebc5b4190eso3059124eaf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 21:49:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWE25n4pFHkleencQkVEJ4FK7bzvJHffcp1v/YJVBKFjnC3jloVLMSVrl58F03XhJGgoA4qMIlSDce40A9V@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1xFVPbG3bcqz95tkvHpziovemvCiSQVV1THu0GY9kzmrtDSV3
	7QmugWadqdMWxdVGTLAs5537bv1u4sSs3RVmVVHWL2KBaMy5hOcpFhT7Ienz5r+uQGMtpgoT8ML
	yi756TjGcvkeqOekAGt0NdebDS7k=
X-Google-Smtp-Source: AGHT+IGpV5EUOMdRhtAWROW6D5SbgLnq2H7ADiKRLq/aF03/BGUWG5NefIxYAk8LVE7jOqKGuOX1XC0uYyi9MUZYtY0=
X-Received: by 2002:a05:6820:2d04:b0:5eb:c72e:e29b with SMTP id
 006d021491bc7-5ee922804b0mr1501838eaf.7.1731476942361; Tue, 12 Nov 2024
 21:49:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB631668A9BA5D0478A0CAA28081542@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB631668A9BA5D0478A0CAA28081542@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 13 Nov 2024 14:48:51 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9y=bsuvKMO_bya0gO2Tc_4Ac58SRE=E4v3fB5z1-onrg@mail.gmail.com>
Message-ID: <CAKYAXd9y=bsuvKMO_bya0gO2Tc_4Ac58SRE=E4v3fB5z1-onrg@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] exfat: add exfat_get_dentry_set_by_inode() helper
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"

[snip]
>  static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
> -               int oldentry, struct exfat_uni_name *p_uniname,
> -               struct exfat_inode_info *ei)
> +               struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
>  {
>         int ret, num_new_entries;
>         struct exfat_dentry *epold, *epnew;
> @@ -999,7 +992,7 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
>         if (num_new_entries < 0)
>                 return num_new_entries;
>
> -       ret = exfat_get_dentry_set(&old_es, sb, p_dir, oldentry, ES_ALL_ENTRIES);
> +       ret = exfat_get_dentry_set_by_inode(&old_es, &ei->vfs_inode);
It is better to just use exfat_get_dentry_set rather than
exfat_get_dentry_set_by_inode here.

>         if (ret) {
>                 ret = -EIO;
>                 return ret;
> @@ -1053,21 +1046,18 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
>         return ret;
>  }
>
> -static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
> -               int oldentry, struct exfat_chain *p_newdir,
> +static int exfat_move_file(struct inode *inode, struct exfat_chain *p_newdir,
>                 struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
>  {
>         int ret, newentry, num_new_entries;
>         struct exfat_dentry *epmov, *epnew;
> -       struct super_block *sb = inode->i_sb;
>         struct exfat_entry_set_cache mov_es, new_es;
>
>         num_new_entries = exfat_calc_num_entries(p_uniname);
>         if (num_new_entries < 0)
>                 return num_new_entries;
>
> -       ret = exfat_get_dentry_set(&mov_es, sb, p_olddir, oldentry,
> -                       ES_ALL_ENTRIES);
> +       ret = exfat_get_dentry_set_by_inode(&mov_es, &ei->vfs_inode);
It's the same here. It is better to just use exfat_get_dentry_set().
Thanks.
>         if (ret)
>                 return -EIO;

