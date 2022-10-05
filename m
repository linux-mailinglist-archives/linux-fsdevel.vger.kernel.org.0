Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0D15F5A2B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 20:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiJESyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 14:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiJESyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:54:12 -0400
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27CF6EF05
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Oct 2022 11:54:10 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MjNyn3d9yzMqFtD;
        Wed,  5 Oct 2022 20:54:09 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MjNym73gdz3d;
        Wed,  5 Oct 2022 20:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1664996049;
        bh=B0K/MavY19bc8L2j/r6kSHr/iMKERSXvdBIMwiY/YwU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dTPpB9C37unGo9fGnDQnz6AUvVNpa8P9bc5B+X+DaBmqnviX3GCU/3vYqQD4V2nyU
         BkcNdg5Zf7kSfm9S9iYcTcGr7Ha1f+2OQ2ENSna808lNmWDt1JGlXRuL/QO+EaApot
         qSt2XYVQ9dfaSU2Cep95dffcDW2QyGR1eWncIMpg=
Message-ID: <16f036ca-fd68-2e89-2ceb-0b9e211a4b23@digikod.net>
Date:   Wed, 5 Oct 2022 20:54:08 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v8 3/9] landlock: Refactor check_access_path_dual() into
 is_access_to_paths_allowed()
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
 <20221001154908.49665-4-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221001154908.49665-4-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Great!

On 01/10/2022 17:49, Günther Noack wrote:
> * Rename it to is_access_to_paths_allowed()
> * Make it return true iff the access is allowed
> * Calculate the EXDEV/EACCES error code in the one place where it's needed

Can you please replace these bullet points with (one-sentence) paragraphs?


> 
> Suggested-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   security/landlock/fs.c | 89 +++++++++++++++++++++---------------------
>   1 file changed, 44 insertions(+), 45 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index a9dbd99d9ee7..083dd3d359de 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -430,7 +430,7 @@ is_eacces(const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS],
>   }
>   
>   /**
> - * check_access_path_dual - Check accesses for requests with a common path
> + * is_access_to_paths_allowed - Check accesses for requests with a common path
>    *
>    * @domain: Domain to check against.
>    * @path: File hierarchy to walk through.
> @@ -465,14 +465,10 @@ is_eacces(const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS],
>    * allow the request.
>    *
>    * Returns:
> - * - 0 if the access request is granted;
> - * - -EACCES if it is denied because of access right other than
> - *   LANDLOCK_ACCESS_FS_REFER;
> - * - -EXDEV if the renaming or linking would be a privileged escalation
> - *   (according to each layered policies), or if LANDLOCK_ACCESS_FS_REFER is
> - *   not allowed by the source or the destination.
> + * - true if the access request is granted;
> + * - false otherwise

Missing final dot.


>    */
> -static int check_access_path_dual(
> +static bool is_access_to_paths_allowed(
>   	const struct landlock_ruleset *const domain,
>   	const struct path *const path,
>   	const access_mask_t access_request_parent1,
> @@ -492,17 +488,17 @@ static int check_access_path_dual(
>   	(*layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS] = NULL;
>   
>   	if (!access_request_parent1 && !access_request_parent2)
> -		return 0;
> +		return true;
>   	if (WARN_ON_ONCE(!domain || !path))
> -		return 0;
> +		return true;
>   	if (is_nouser_or_private(path->dentry))
> -		return 0;
> +		return true;
>   	if (WARN_ON_ONCE(domain->num_layers < 1 || !layer_masks_parent1))
> -		return -EACCES;
> +		return false;
>   
>   	if (unlikely(layer_masks_parent2)) {
>   		if (WARN_ON_ONCE(!dentry_child1))
> -			return -EACCES;
> +			return false;
>   		/*
>   		 * For a double request, first check for potential privilege
>   		 * escalation by looking at domain handled accesses (which are
> @@ -513,7 +509,7 @@ static int check_access_path_dual(
>   		is_dom_check = true;
>   	} else {
>   		if (WARN_ON_ONCE(dentry_child1 || dentry_child2))
> -			return -EACCES;
> +			return false;
>   		/* For a simple request, only check for requested accesses. */
>   		access_masked_parent1 = access_request_parent1;
>   		access_masked_parent2 = access_request_parent2;
> @@ -622,24 +618,7 @@ static int check_access_path_dual(
>   	}
>   	path_put(&walker_path);
>   
> -	if (allowed_parent1 && allowed_parent2)
> -		return 0;
> -
> -	/*
> -	 * This prioritizes EACCES over EXDEV for all actions, including
> -	 * renames with RENAME_EXCHANGE.
> -	 */
> -	if (likely(is_eacces(layer_masks_parent1, access_request_parent1) ||
> -		   is_eacces(layer_masks_parent2, access_request_parent2)))
> -		return -EACCES;
> -
> -	/*
> -	 * Gracefully forbids reparenting if the destination directory
> -	 * hierarchy is not a superset of restrictions of the source directory
> -	 * hierarchy, or if LANDLOCK_ACCESS_FS_REFER is not allowed by the
> -	 * source or the destination.
> -	 */
> -	return -EXDEV;
> +	return allowed_parent1 && allowed_parent2;
>   }
>   
>   static inline int check_access_path(const struct landlock_ruleset *const domain,
> @@ -649,8 +628,10 @@ static inline int check_access_path(const struct landlock_ruleset *const domain,
>   	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
>   
>   	access_request = init_layer_masks(domain, access_request, &layer_masks);
> -	return check_access_path_dual(domain, path, access_request,
> -				      &layer_masks, NULL, 0, NULL, NULL);
> +	if (is_access_to_paths_allowed(domain, path, access_request,
> +				       &layer_masks, NULL, 0, NULL, NULL))
> +		return 0;
> +	return -EACCES;
>   }
>   
>   static inline int current_check_access_path(const struct path *const path,
> @@ -711,8 +692,9 @@ static inline access_mask_t maybe_remove(const struct dentry *const dentry)
>    * file.  While walking from @dir to @mnt_root, we record all the domain's
>    * allowed accesses in @layer_masks_dom.
>    *
> - * This is similar to check_access_path_dual() but much simpler because it only
> - * handles walking on the same mount point and only check one set of accesses.
> + * This is similar to is_access_to_paths_allowed() but much simpler because it
> + * only handles walking on the same mount point and only checks one set of
> + * accesses.
>    *
>    * Returns:
>    * - true if all the domain access rights are allowed for @dir;
> @@ -857,10 +839,11 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>   		access_request_parent1 = init_layer_masks(
>   			dom, access_request_parent1 | access_request_parent2,
>   			&layer_masks_parent1);
> -		return check_access_path_dual(dom, new_dir,
> -					      access_request_parent1,
> -					      &layer_masks_parent1, NULL, 0,
> -					      NULL, NULL);
> +		if (is_access_to_paths_allowed(
> +			    dom, new_dir, access_request_parent1,
> +			    &layer_masks_parent1, NULL, 0, NULL, NULL))
> +			return 0;
> +		return -EACCES;
>   	}
>   
>   	access_request_parent1 |= LANDLOCK_ACCESS_FS_REFER;
> @@ -886,11 +869,27 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>   	 * parent access rights.  This will be useful to compare with the
>   	 * destination parent access rights.
>   	 */
> -	return check_access_path_dual(dom, &mnt_dir, access_request_parent1,
> -				      &layer_masks_parent1, old_dentry,
> -				      access_request_parent2,
> -				      &layer_masks_parent2,
> -				      exchange ? new_dentry : NULL);
> +	if (is_access_to_paths_allowed(
> +		    dom, &mnt_dir, access_request_parent1, &layer_masks_parent1,
> +		    old_dentry, access_request_parent2, &layer_masks_parent2,
> +		    exchange ? new_dentry : NULL))
> +		return 0;
> +
> +	/*
> +	 * This prioritizes EACCES over EXDEV for all actions, including
> +	 * renames with RENAME_EXCHANGE.
> +	 */
> +	if (likely(is_eacces(&layer_masks_parent1, access_request_parent1) ||
> +		   is_eacces(&layer_masks_parent2, access_request_parent2)))
> +		return -EACCES;
> +
> +	/*
> +	 * Gracefully forbids reparenting if the destination directory
> +	 * hierarchy is not a superset of restrictions of the source directory
> +	 * hierarchy, or if LANDLOCK_ACCESS_FS_REFER is not allowed by the
> +	 * source or the destination.
> +	 */
> +	return -EXDEV;
>   }
>   
>   /* Inode hooks */
