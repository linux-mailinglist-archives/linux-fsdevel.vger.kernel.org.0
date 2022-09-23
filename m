Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673805E846A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 22:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiIWUxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 16:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiIWUxb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:53:31 -0400
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D6DF08BB
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 13:53:29 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MZ49x2KMxzMqJ3F;
        Fri, 23 Sep 2022 22:53:25 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MZ49v4FbDzMppMm;
        Fri, 23 Sep 2022 22:53:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663966405;
        bh=Sy8Qe7yyNodDWdxuir5PEFXPJgoKcFpmwJZUYBiDMy0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jXqqro7ab8vlWheOfGaSMxYtyeRnaeNYaDrx5/+EBWD57nav3VTeAXhiUKheu+/2L
         cUzWMIfuA3f0KdIMyFoToOooTfcuYDG4FlRYpK7BWwTmjhQ983iR8xBXqsi+Zw63NI
         1EH0eFGrr9kPCA7Nw63dTVMf/WDl5SA+J0976PdM=
Message-ID: <0dea6e07-dd98-0d3c-4c2b-7f45e06374ed@digikod.net>
Date:   Fri, 23 Sep 2022 22:53:23 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v6 2/5] landlock: Support file truncation
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-3-gnoack3000@gmail.com>
 <2c4db214-e425-3e40-adeb-9e406c3ea2f9@digikod.net> <Yy2W14NMQBvfG9Fw@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <Yy2W14NMQBvfG9Fw@nuc>
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


On 23/09/2022 13:21, Günther Noack wrote:
> On Mon, Sep 12, 2022 at 09:41:32PM +0200, Mickaël Salaün wrote:
>>
>> On 08/09/2022 21:58, Günther Noack wrote:
>>> Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.
>>
>> [...]
>>
>>> @@ -761,6 +762,47 @@ static bool collect_domain_accesses(
>>>    	return ret;
>>>    }
>>> +/**
>>> + * get_path_access_rights - Returns the subset of rights in access_request
>>> + * which are permitted for the given path.
>>> + *
>>> + * @domain: The domain that defines the current restrictions.
>>> + * @path: The path to get access rights for.
>>> + * @access_request: The rights we are interested in.
>>> + *
>>> + * Returns: The access mask of the rights that are permitted on the given path,
>>> + * which are also a subset of access_request (to save some calculation time).
>>> + */
>>> +static inline access_mask_t
>>> +get_path_access_rights(const struct landlock_ruleset *const domain,
>>> +		       const struct path *const path,
>>> +		       access_mask_t access_request)
>>> +{
>>> +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
>>> +	unsigned long access_bit;
>>> +	unsigned long access_req;
>>> +
>>> +	init_layer_masks(domain, access_request, &layer_masks);
>>> +	if (!check_access_path_dual(domain, path, access_request, &layer_masks,
>>> +				    NULL, 0, NULL, NULL)) {
>>> +		/*
>>> +		 * Return immediately for successful accesses and for cases
>>> +		 * where everything is permitted because the path belongs to an
>>> +		 * internal filesystem.
>>> +		 */
>>> +		return access_request;
>>> +	}
>>> +
>>> +	access_req = access_request;
>>> +	for_each_set_bit(access_bit, &access_req, ARRAY_SIZE(layer_masks)) {
>>> +		if (layer_masks[access_bit]) {
>>> +			/* If any layer vetoed the access right, remove it. */
>>> +			access_request &= ~BIT_ULL(access_bit);
>>> +		}
>>> +	}
>>
>> This seems to be redundant with the value returned by init_layer_masks(),
>> which should be passed to check_access_path_dual() to avoid useless path
>> walk.
> 
> True, I'll use the result of init_layer_masks() to feed it back to
> check_access_path_dual() to avoid a bit of computation.
> 
> Like this:
> 
>          effective_access_request =
> 		init_layer_masks(domain, access_request, &layer_masks);
> 	if (!check_access_path_dual(domain, path, effective_access_request,
> 	    &layer_masks, NULL, 0, NULL, NULL)) {
> 		// ...
> 	}

correct

> 
> Overall, the approach here is:
> 
> * Initialize the layer_masks, so that it has a bit set for every
>    access right in access_request and layer where that access right is
>    handled.
> 
> * check_access_path_dual() with only the first few parameters -- this
>    will clear all the bits in layer masks which are actually permitted
>    according to the individual rules.
> 
>    As a special case, this *may* return 0 immediately, in which case we
>    can (a) save a bit of calculation in the loop below and (b) we might
>    be in the case where access is permitted because it's a file from a
>    special file system (even though not all bits are cleared). If
>    check_access_path_dual() returns 0, we return the full requested
>    access_request that we received as input. >
> * In the loop below, if there are any bits left in layer_masks, those
>    are rights which are not permitted for the given path. We remove
>    these from access_request and return the modified access_request.
> 
> 
>> This function is pretty similar to check_access_path(). Can't you change it
>> to use an access_mask_t pointer and get almost the same thing?
> 
> I'm shying away from this approach. Many of the existing different use
> cases are already realized by "doing if checks deep down". I think it
> would make the code more understandable if we managed to model these
> differences between use cases already at the layer of function calls.
> (This is particularly true for check_access_path_dual(), where in
> order to find out how the "single" case works, you need to disentangle
> to a large extent how the much more complicated dual case works.)

I agree that check_access_path_dual() is complex, but I couldn't find a 
better way.


> 
> If you want to unify these two functions, what do you think of the
> approach of just using get_path_access_rights() instead of
> check_access_path()?
> 
> Basically, it would turn
> 
> return check_access_path(dom, path, access_request);
> 
> into
> 
> if (get_path_access_rights(dom, path, access_request) == access_request)
> 	return 0;
> return -EACCES;
> 
> This is slightly more verbose in the places where it's called, but it
> would be more orthogonal, and it would also clarify that -EACCES is
> the only possible error in the "single" path walk case.
> 
> Let me know what you think.

What about adding an additional argument `access_mask_t *const 
access_allowed` to check_access_path_dual() which returns the set of 
accesses (i.e. access_masked_parent1 & access_masked_parent2) that could 
then be stored to landlock_file(file)->allowed_access? If this argument 
is NULL it should just be ignored. What is left from 
get_path_access_rights() could then be merged into hook_file_open().


> 
>>> +	return access_request;
>>> +}
>>> +
>>>    /**
>>>     * current_check_refer_path - Check if a rename or link action is allowed
>>>     *
>>> @@ -1142,6 +1184,11 @@ static int hook_path_rmdir(const struct path *const dir,
>>>    	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
>>>    }
>>> +static int hook_path_truncate(const struct path *const path)
>>> +{
>>> +	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
>>> +}
>>> +
>>>    /* File hooks */
>>>    static inline access_mask_t get_file_access(const struct file *const file)
>>> @@ -1159,22 +1206,55 @@ static inline access_mask_t get_file_access(const struct file *const file)
>>>    	/* __FMODE_EXEC is indeed part of f_flags, not f_mode. */
>>>    	if (file->f_flags & __FMODE_EXEC)
>>>    		access |= LANDLOCK_ACCESS_FS_EXECUTE;
>>> +
>>>    	return access;
>>>    }
>>>    static int hook_file_open(struct file *const file)
>>>    {
>>> +	access_mask_t access_req, access_rights;
>>
>> "access_request" is used for access_mask_t, and "access_req" for unsigned
>> int. I'd like to stick to this convention.
> 
> Done.
> 
>>> +	const access_mask_t optional_rights = LANDLOCK_ACCESS_FS_TRUNCATE;
>>
>> You use "rights" often and I'm having some trouble to find a rational for
>> that (compared to "access")…
> 
> Done. Didn't realize you already had a different convention here.
> 
> I'm renaming get_path_access_rights() to get_path_access() as well
> then (and I'll rename get_file_access() to
> get_required_file_open_access() - that's more verbose, but it sounded
> too similar to get_path_access(), and it might be better to clarify
> that this is a helper for the file_open hook). Does that sound
> reasonable?

I think it is better, but I'm not convinced this helper is useful.

> 
> 
>>>    	const struct landlock_ruleset *const dom =
>>>    		landlock_get_current_domain();
>>> -	if (!dom)
>>> +	if (!dom) {
>>> +		/* Grant all rights. */
>>> +		landlock_file(file)->rights = LANDLOCK_MASK_ACCESS_FS;
>>>    		return 0;
>>> +	}
>>> +
>>>    	/*
>>>    	 * Because a file may be opened with O_PATH, get_file_access() may
>>>    	 * return 0.  This case will be handled with a future Landlock
>>>    	 * evolution.
>>>    	 */
>>> -	return check_access_path(dom, &file->f_path, get_file_access(file));
>>> +	access_req = get_file_access(file);
>>> +	access_rights = get_path_access_rights(dom, &file->f_path,
>>> +					       access_req | optional_rights);
>>> +	if (access_req & ~access_rights)
>>> +		return -EACCES;
>>
>> We should add a test to make sure this (optional_rights) logic is correct
>> (and doesn't change), with a matrix of cases involving a ruleset handling
>> either FS_WRITE, FS_TRUNCATE or both. This should be easy to do with test
>> variants.
> 
> OK, adding one to the selftests.
> 
>>> +	/*
>>> +	 * For operations on already opened files (i.e. ftruncate()), it is the
>>> +	 * access rights at the time of open() which decide whether the
>>> +	 * operation is permitted. Therefore, we record the relevant subset of
>>> +	 * file access rights in the opened struct file.
>>> +	 */
>>> +	landlock_file(file)->rights = access_rights;
>>> +
>>> +	return 0;
>>> +}
> 
