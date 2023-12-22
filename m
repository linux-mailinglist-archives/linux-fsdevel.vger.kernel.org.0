Return-Path: <linux-fsdevel+bounces-6764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F108A81C488
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 06:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAA91C2406F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 05:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B51B539F;
	Fri, 22 Dec 2023 05:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCwEpp7q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE646A8
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 05:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B597C433C8
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 05:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703221544;
	bh=/oY7WVSqI7wH20q5c5Bp3wRTFLW8CFPQ0WbPtFlYu2M=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=CCwEpp7q+P08zqKvW7dt5b/XJEoNX2uzFWfxmAVtkTrFquBD+L/3/74PRkrgLbUz5
	 Qm0vn1oUWEHSg9ThjIVs2Zxaqyjfj3EDdWCqzbzMQhvchl8TUWEj3swKuIo9cft1fK
	 jja43R8M469k2FptPllEWZ95/iMj7VKOtBatTiX0B/H9OD/eJCNfiTsvkVhMHnVYDX
	 Lr3TXPjtNspZBv6DJgmskhJL0H8ldPExLawOfmJZXnmgf8NO3LQSEFKbxSSspKURGV
	 et01YBz6sIScrWrNnWQoXegJzejmx2CfPaCtULXEJcPG2vniMyeySe7IM1kdssqjCo
	 79bj/pquIWAYQ==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dbc32051a9so171601a34.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 21:05:44 -0800 (PST)
X-Gm-Message-State: AOJu0YzKNGmFil4c41DfKD58tHCkJfZpwpbBIvCrlPZOpg5qMPYaEyOQ
	kiGLhV6SEx8W1M6kzTi/znmmmUVv94CiiPlrxyQ=
X-Google-Smtp-Source: AGHT+IFtXiPGdVqB86b1K97ejeSGM7AqNsSEvMfZjHHYxqfNKJ2aRsrozVcYXfmchSlagT0CsDICIr8rmmG10h5oDz8=
X-Received: by 2002:a9d:73d6:0:b0:6db:9d60:34fb with SMTP id
 m22-20020a9d73d6000000b006db9d6034fbmr743138otk.68.1703221543324; Thu, 21 Dec
 2023 21:05:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5990:0:b0:507:5de0:116e with HTTP; Thu, 21 Dec 2023
 21:05:42 -0800 (PST)
In-Reply-To: <tencent_7DD31A2AA74D2EFCA9667E52E9D7E2CB0208@qq.com>
References: <20231208112318.1135649-1-yuezhang.mo@foxmail.com> <tencent_7DD31A2AA74D2EFCA9667E52E9D7E2CB0208@qq.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 22 Dec 2023 14:05:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9c=JhgkXaPYke3XRmC8wYbmhLrUm1958OxYr_odGJDmg@mail.gmail.com>
Message-ID: <CAKYAXd9c=JhgkXaPYke3XRmC8wYbmhLrUm1958OxYr_odGJDmg@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] exfat: add __exfat_get_dentry_set() helper
To: yuezhang.mo@foxmail.com
Cc: sj1557.seo@samsung.com, linux-fsdevel@vger.kernel.org, Andy.Wu@sony.com, 
	wataru.aoyama@sony.com, Yuezhang Mo <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

> - * Returns a set of dentries for a file or dir.
> + * Returns a set of dentries.
>   *
>   * Note It provides a direct pointer to bh->data via
> exfat_get_dentry_cached().
>   * User should call exfat_get_dentry_set() after setting 'modified' to
> apply
> @@ -842,22 +836,24 @@ struct exfat_dentry *exfat_get_dentry_cached(
>   *
>   * in:
>   *   sb+p_dir+entry: indicates a file/dir
> - *   type:  specifies how many dentries should be included.
> + *   num_entries: specifies how many dentries should be included.
> + *                It will be set to es->num_entries if it is not 0.
> + *                If num_entries is 0, es->num_entries will be obtained
> + *                from the first dentry.
> + * out:
> + *   es: pointer of entry set on success.
>   * return:
> - *   pointer of entry set on success,
> - *   NULL on failure.
> + *   0 on success
> + *   < 0 on failure
         -error code on failure.
>   */
> -int exfat_get_dentry_set(struct exfat_entry_set_cache *es,
> +static int __exfat_get_dentry_set(struct exfat_entry_set_cache *es,
>  		struct super_block *sb, struct exfat_chain *p_dir, int entry,
> -		unsigned int type)
> +		unsigned int num_entries)
>  {
>  	int ret, i, num_bh;
>  	unsigned int off;
>  	sector_t sec;
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> -	struct exfat_dentry *ep;
> -	int num_entries;
> -	enum exfat_validate_dentry_mode mode = ES_MODE_STARTED;
>  	struct buffer_head *bh;
>
>  	if (p_dir->dir == DIR_DELETED) {
> @@ -880,12 +876,16 @@ int exfat_get_dentry_set(struct exfat_entry_set_cache
> *es,
>  		return -EIO;
>  	es->bh[es->num_bh++] = bh;
>
> -	ep = exfat_get_dentry_cached(es, ES_IDX_FILE);
> -	if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
> -		goto put_es;
> +	if (num_entries == ES_ALL_ENTRIES) {
> +		struct exfat_dentry *ep;
> +
> +		ep = exfat_get_dentry_cached(es, ES_IDX_FILE);
> +		if (ep->type == EXFAT_FILE)
> +			num_entries = ep->dentry.file.num_ext + 1;
> +		else
> +			goto put_es;
I prefer to avoid else{}.
               if (ep->type != EXFAT_FILE)
                        goto put_es;
> +	}
>
> -	num_entries = type == ES_ALL_ENTRIES ?
> -		ep->dentry.file.num_ext + 1 : type;
>  	es->num_entries = num_entries;
>
>  	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
> @@ -918,8 +918,27 @@ int exfat_get_dentry_set(struct exfat_entry_set_cache
> *es,
>  		es->bh[es->num_bh++] = bh;
>  	}
>
> +	return 0;
> +
> +put_es:
> +	exfat_put_dentry_set(es, false);
> +	return -EIO;
> +}
> +
> +int exfat_get_dentry_set(struct exfat_entry_set_cache *es,
> +		struct super_block *sb, struct exfat_chain *p_dir,
> +		int entry, unsigned int type)
> +{
> +	int ret, i;
> +	struct exfat_dentry *ep;
> +	enum exfat_validate_dentry_mode mode = ES_MODE_GET_FILE_ENTRY;
> +
> +	ret = __exfat_get_dentry_set(es, sb, p_dir, entry, type);
You need to change type to num_entries ?

> +	if (ret < 0)
> +		return ret;
> +
>  	/* validate cached dentries */
> -	for (i = ES_IDX_STREAM; i < num_entries; i++) {
> +	for (i = ES_IDX_STREAM; i < es->num_entries; i++) {
>  		ep = exfat_get_dentry_cached(es, i);
>  		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
>  			goto put_es;
> --
> 2.25.1
>
>

