Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084015B61D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 21:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiILTlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 15:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiILTlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:41:36 -0400
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc08])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C398D476C1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 12:41:34 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MRH6518qGzMrFy4;
        Mon, 12 Sep 2022 21:41:33 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MRH643kQTzx5;
        Mon, 12 Sep 2022 21:41:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663011693;
        bh=coFaAtWyK4IFitTb0Comb5myJb3hPKAKsW/b7ihpOII=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LQoV6pwBQLjrYsbdWgZVN90w6vXvn3/XnND8Km95An6QFEyerDQ1Xojb5Q9rpIoCo
         dzmJpW0uo7z8iI9RcQDg9HWlqd7KQAsceMYJ4z+IXH3JX9FGCNkwmmr7QB/rE/Qy0p
         +X5D4oOAM1RJwKFAH9xHtPbhjTMkgBpdpi0/nLHA=
Message-ID: <2c4db214-e425-3e40-adeb-9e406c3ea2f9@digikod.net>
Date:   Mon, 12 Sep 2022 21:41:32 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v6 2/5] landlock: Support file truncation
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-3-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220908195805.128252-3-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 08/09/2022 21:58, Günther Noack wrote:
> Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.

[...]

> @@ -761,6 +762,47 @@ static bool collect_domain_accesses(
>   	return ret;
>   }
>   
> +/**
> + * get_path_access_rights - Returns the subset of rights in access_request
> + * which are permitted for the given path.
> + *
> + * @domain: The domain that defines the current restrictions.
> + * @path: The path to get access rights for.
> + * @access_request: The rights we are interested in.
> + *
> + * Returns: The access mask of the rights that are permitted on the given path,
> + * which are also a subset of access_request (to save some calculation time).
> + */
> +static inline access_mask_t
> +get_path_access_rights(const struct landlock_ruleset *const domain,
> +		       const struct path *const path,
> +		       access_mask_t access_request)
> +{
> +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> +	unsigned long access_bit;
> +	unsigned long access_req;
> +
> +	init_layer_masks(domain, access_request, &layer_masks);
> +	if (!check_access_path_dual(domain, path, access_request, &layer_masks,
> +				    NULL, 0, NULL, NULL)) {
> +		/*
> +		 * Return immediately for successful accesses and for cases
> +		 * where everything is permitted because the path belongs to an
> +		 * internal filesystem.
> +		 */
> +		return access_request;
> +	}
> +
> +	access_req = access_request;
> +	for_each_set_bit(access_bit, &access_req, ARRAY_SIZE(layer_masks)) {
> +		if (layer_masks[access_bit]) {
> +			/* If any layer vetoed the access right, remove it. */
> +			access_request &= ~BIT_ULL(access_bit);
> +		}
> +	}

This seems to be redundant with the value returned by 
init_layer_masks(), which should be passed to check_access_path_dual() 
to avoid useless path walk.

This function is pretty similar to check_access_path(). Can't you change 
it to use an access_mask_t pointer and get almost the same thing?


> +	return access_request;
> +}
> +
>   /**
>    * current_check_refer_path - Check if a rename or link action is allowed
>    *
> @@ -1142,6 +1184,11 @@ static int hook_path_rmdir(const struct path *const dir,
>   	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
>   }
>   
> +static int hook_path_truncate(const struct path *const path)
> +{
> +	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
> +}
> +
>   /* File hooks */
>   
>   static inline access_mask_t get_file_access(const struct file *const file)
> @@ -1159,22 +1206,55 @@ static inline access_mask_t get_file_access(const struct file *const file)
>   	/* __FMODE_EXEC is indeed part of f_flags, not f_mode. */
>   	if (file->f_flags & __FMODE_EXEC)
>   		access |= LANDLOCK_ACCESS_FS_EXECUTE;
> +
>   	return access;
>   }
>   
>   static int hook_file_open(struct file *const file)
>   {
> +	access_mask_t access_req, access_rights;

"access_request" is used for access_mask_t, and "access_req" for 
unsigned int. I'd like to stick to this convention.


> +	const access_mask_t optional_rights = LANDLOCK_ACCESS_FS_TRUNCATE;

You use "rights" often and I'm having some trouble to find a rational 
for that (compared to "access")…


>   	const struct landlock_ruleset *const dom =
>   		landlock_get_current_domain();
>   
> -	if (!dom)
> +	if (!dom) {
> +		/* Grant all rights. */
> +		landlock_file(file)->rights = LANDLOCK_MASK_ACCESS_FS;
>   		return 0;
> +	}
> +
>   	/*
>   	 * Because a file may be opened with O_PATH, get_file_access() may
>   	 * return 0.  This case will be handled with a future Landlock
>   	 * evolution.
>   	 */
> -	return check_access_path(dom, &file->f_path, get_file_access(file));
> +	access_req = get_file_access(file);
> +	access_rights = get_path_access_rights(dom, &file->f_path,
> +					       access_req | optional_rights);
> +	if (access_req & ~access_rights)
> +		return -EACCES;

We should add a test to make sure this (optional_rights) logic is 
correct (and doesn't change), with a matrix of cases involving a ruleset 
handling either FS_WRITE, FS_TRUNCATE or both. This should be easy to do 
with test variants.


> +
> +	/*
> +	 * For operations on already opened files (i.e. ftruncate()), it is the
> +	 * access rights at the time of open() which decide whether the
> +	 * operation is permitted. Therefore, we record the relevant subset of
> +	 * file access rights in the opened struct file.
> +	 */
> +	landlock_file(file)->rights = access_rights;
> +
> +	return 0;
> +}
