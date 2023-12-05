Return-Path: <linux-fsdevel+bounces-4840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0965D804A34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 07:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5751F21495
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA3A12E68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsv/8G0c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E98F6B;
	Tue,  5 Dec 2023 05:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7BBC433C9;
	Tue,  5 Dec 2023 05:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701754156;
	bh=nNE/2ASASv+wwkYyfwm8NKEcUKsPIRgn1S6412XMFxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nsv/8G0cJhGbvJQaLV0SGxbw51u2/0wO+PHAbi2PSVrxcrzlf2JWNO1JEThMPwcky
	 by1mPkYUo3fhQE2doxIjLcZkQDvRV/eP8yG03wf9ABKzCh+RjOuKDBUOmR/owD2smT
	 N4hCgKoH7AjAHh4+uhxam75pUZ3653PCGDpJrfGedM+HrdK3CemZb4k9YRPz8xAVrn
	 kWUJ7Ox1qybl2S3kBvZaRAQE3nicP7sh2f/eTZ/+vbDq2irfGcY8uuiXtqYYkCfCYU
	 W3KivWovnVg6Xn7zNdOWZetQhEaBd48YhIUjJOid8j9YXeNFdB9gA8qaZ6x06ZTARf
	 Iwp13daKwaj0w==
Date: Mon, 4 Dec 2023 21:29:15 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH v4 15/46] btrfs: handle nokey names.
Message-ID: <20231205052915.GL1168@sol.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <5729e533bb7e014a124cc48d793dec30507455b7.1701468306.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5729e533bb7e014a124cc48d793dec30507455b7.1701468306.git.josef@toxicpanda.com>

On Fri, Dec 01, 2023 at 05:11:12PM -0500, Josef Bacik wrote:
> +/*
> + * From a given location in a leaf, read a name into a qstr (usually a
> + * fscrypt_name's disk_name), allocating the required buffer. Used for
> + * nokey names.
> + */
> +int btrfs_fscrypt_get_disk_name(struct extent_buffer *leaf,
> +				struct btrfs_dir_item *dir_item,
> +				struct fscrypt_str *name)
> +{
> +	unsigned long de_name_len = btrfs_dir_name_len(leaf, dir_item);
> +	unsigned long de_name = (unsigned long)(dir_item + 1);
> +	/*
> +	 * For no-key names, we use this opportunity to find the disk
> +	 * name, so future searches don't need to deal with nokey names
> +	 * and we know what the encrypted size is.
> +	 */
> +	name->name = kmalloc(de_name_len, GFP_NOFS);
> +
> +	if (!name->name)
> +		return -ENOMEM;

Where is the kfree() that matches the above kmalloc()?

- Eric

