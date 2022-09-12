Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DDA5B6127
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiILSjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiILSiw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:38:52 -0400
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [IPv6:2001:1600:3:17::1909])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F91474E8
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 11:37:12 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MRFgp3yCDzMqgPX;
        Mon, 12 Sep 2022 20:37:10 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MRFgn4Hw7z3Y;
        Mon, 12 Sep 2022 20:37:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663007830;
        bh=ky1nClPljWIM6vArVhth4/gMKoMFtE47EE1MTmDa5Gw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=0GUePxShnRXVWzjyPE9nSl0GVn8XlmXhdwRHHb7UQzMLxRF+GTu/3Uz6SnhPb+lW/
         egiWVJjraCBNVDXOI7eYyRINkKbiuM3rJUXsKCrdhPhce2td9PfTy9Lc/QIAqEXrQW
         CGPdotlu95J3PqVjvsCuJGcG0NGXbnzmyL7SPC5k=
Message-ID: <bce9b221-e379-7731-31c3-38df5cda6152@digikod.net>
Date:   Mon, 12 Sep 2022 20:37:09 +0200
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
 <b5984fd3-6310-9803-8b33-99715beeccfb@digikod.net> <Yx9QMbOA3i2i12ve@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <Yx9QMbOA3i2i12ve@nuc>
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



On 12/09/2022 17:28, Günther Noack wrote:
> On Fri, Sep 09, 2022 at 03:51:16PM +0200, Mickaël Salaün wrote:
>>
>> On 08/09/2022 21:58, Günther Noack wrote:
>>> Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.
>>>
>>> This flag hooks into the path_truncate LSM hook and covers file
>>> truncation using truncate(2), ftruncate(2), open(2) with O_TRUNC, as
>>> well as creat().
>>>
>>> This change also increments the Landlock ABI version, updates
>>> corresponding selftests, and updates code documentation to document
>>> the flag.
>>>
>>> The following operations are restricted:
>>>
>>> open(): requires the LANDLOCK_ACCESS_FS_TRUNCATE right if a file gets
>>> implicitly truncated as part of the open() (e.g. using O_TRUNC).
>>>
>>> Notable special cases:
>>> * open(..., O_RDONLY|O_TRUNC) can truncate files as well in Linux
>>> * open() with O_TRUNC does *not* need the TRUNCATE right when it
>>>     creates a new file.
>>>
>>> truncate() (on a path): requires the LANDLOCK_ACCESS_FS_TRUNCATE
>>> right.
>>>
>>> ftruncate() (on a file): requires that the file had the TRUNCATE right
>>> when it was previously opened.
>>>
>>> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
>>> ---
>>>    include/uapi/linux/landlock.h                | 18 ++--
>>>    security/landlock/fs.c                       | 88 +++++++++++++++++++-
>>>    security/landlock/fs.h                       | 18 ++++
>>>    security/landlock/limits.h                   |  2 +-
>>>    security/landlock/setup.c                    |  1 +
>>>    security/landlock/syscalls.c                 |  2 +-
>>>    tools/testing/selftests/landlock/base_test.c |  2 +-
>>>    tools/testing/selftests/landlock/fs_test.c   |  7 +-
>>>    8 files changed, 124 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
>>> index 23df4e0e8ace..8c0124c5cbe6 100644
>>> --- a/include/uapi/linux/landlock.h
>>> +++ b/include/uapi/linux/landlock.h
>>> + * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate(2)`,
>>> + *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
>>> + *   `O_TRUNC`. The right to truncate a file gets carried along with an opened
>>> + *   file descriptor for the purpose of :manpage:`ftruncate(2)`.
>>
>> You can add a bit to explain that it is the same behavior as for
>> LANDLOCK_ACCESS_FS_{READ,WRITE}_FILE .
> 
> Done.
> 
>>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
>>> index a9dbd99d9ee7..1b546edf69a6 100644
>>> --- a/security/landlock/fs.c
>>> +++ b/security/landlock/fs.c
>>> +static inline access_mask_t
>>> +get_path_access_rights(const struct landlock_ruleset *const domain,
>>> +		       const struct path *const path,
>>> +		       access_mask_t access_request)
>>> +{
>>> +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
>>> +	unsigned long access_bit;
>>> +	unsigned long access_req;
>>
>> unsigned long access_bit, long access_req;
> 
> Done. Made it unsigned long access_bit, access_req;
> 
>>> +	init_layer_masks(domain, access_request, &layer_masks);
>>> +	if (!check_access_path_dual(domain, path, access_request, &layer_masks,
>>> +				    NULL, 0, NULL, NULL)) {
>>> +		/*
>>> +		 * Return immediately for successful accesses and for cases
>>
>> Returns
> 
> Done.
> 
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
>>
>> Not needed.
> 
> Done.
> 
>>>    	return access;
>>>    }
>>>    static int hook_file_open(struct file *const file)
>>>    {
>>> +	access_mask_t access_req, access_rights;
>>> +	const access_mask_t optional_rights = LANDLOCK_ACCESS_FS_TRUNCATE;
>>>    	const struct landlock_ruleset *const dom =
>>>    		landlock_get_current_domain();
>>> -	if (!dom)
>>> +	if (!dom) {
>>> +		/* Grant all rights. */
>>
>> Something like:
>> Grants all rights, even if most of them are not checked here, it is more
>> consistent.
> 
> Done.
> 
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
>>> +
>>> +	/*
>>> +	 * For operations on already opened files (i.e. ftruncate()), it is the
>>> +	 * access rights at the time of open() which decide whether the
>>> +	 * operation is permitted. Therefore, we record the relevant subset of
>>> +	 * file access rights in the opened struct file.
>>> +	 */
>>> +	landlock_file(file)->rights = access_rights;
>>> +
>>
>> Style preferences, but why do you use a new line here? I try to group code
>> blocks until the return.
> 
> Thanks, done. I just do this habitually and overlooked that I was at
> odds with the surrounding style. I don't have a strong preference.
> 
>>> +	return 0;
>>> +}
>>> +
>>> +static int hook_file_truncate(struct file *const file)
>>> +{
>>> +	/*
>>> +	 * We permit truncation if the truncation right was available at the
>>
>> Allows truncation if the related right was…
>>
>>
>>> +	 * time of opening the file.
>>
>> …to get a consistent access check as for read, write and execute operations.
> 
> Done.
> 
> I'm also adding this note here:
> 
>    Note: For checks done based on the file's Landlock rights, we enforce
>    them independently of whether the current thread is in a Landlock
>    domain, so that open files passed between independent processes
>    retain their behaviour.
> 
> to explain that this is why we don't check for "if (!dom)" as we do in
> other cases.
> 
> 
>> This kind of explanation could be used to complete the documentation as
>> well. The idea being to mimic the file mode check.
> 
> Added it to the documentation.
> 
>>
>>
>>> +	 */
>>> +	if (!(landlock_file(file)->rights & LANDLOCK_ACCESS_FS_TRUNCATE))
>>
>> I prefer to invert the "if" logic and return -EACCES by default.
> 
> Done. Thanks for pointing it out.
> 
>>> +		return -EACCES;
>>> +
>>> +	return 0;
>>>    }
> 
> 
>>> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
>>> index 8db7acf9109b..275ba5375839 100644
>>> --- a/security/landlock/fs.h
>>> +++ b/security/landlock/fs.h
>>> @@ -36,6 +36,18 @@ struct landlock_inode_security {
>>>    	struct landlock_object __rcu *object;
>>>    };
>>> +/**
>>> + * struct landlock_file_security - File security blob
>>> + *
>>> + * This information is populated when opening a file in hook_file_open, and
>>> + * tracks the relevant Landlock access rights that were available at the time
>>> + * of opening the file. Other LSM hooks use these rights in order to authorize
>>> + * operations on already opened files.
>>> + */
>>> +struct landlock_file_security {
>>> +	access_mask_t rights;
>>
>> I think it would make it more consistent to name it "access" to be in line
>> with struct landlock_layer and other types.
> 
> Done.

Hmm, actually, "allowed_access" is more explicit. We could use other 
access-related fields for other purposes (e.g. cache).


> 
> I also added a brief documentation for the access field, to point out
> that this is not the *full* set of rights which was available at
> open() time, but it's just the subset of rights that is needed to
> authorize later operations on the file:
> 
>    @access: Access rights that were available at the time of opening the
>    file. This is not necessarily the full set of access rights available
>    at that time, but it's the necessary subset as needed to authorize
>    later operations on the open file.

Good!

> 
> Thanks for the review! Fixes will be in the next version.
> 
> -Günther
> 
