Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B0E5EE46B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 20:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiI1ScO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 14:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiI1ScM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:32:12 -0400
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F3C7B2B1;
        Wed, 28 Sep 2022 11:32:06 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Md4pX1XDxzMqKj6;
        Wed, 28 Sep 2022 20:32:04 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Md4pW2xBnzMpnPh;
        Wed, 28 Sep 2022 20:32:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1664389924;
        bh=eflJSf6YLiRl3SjoPJuiiOT14gIGxe9VqHb7grpS9H4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qwFCm/3kxNfYhCz9plcG3oKiQQwKdhpG0gajN30wlRhgEmebN0CGycqm16+TCv1Z7
         7RMSoYLAzufUXNw9zrs0I5AILe/27PL1pdqqa+7qQa6HU17HVN8mihNcLIV80paS7h
         oU8GuSzKnsejXQFEN5QeHRcRfKyn3pD1YTU7Wk4g=
Message-ID: <e5b0b338-c4e5-8348-1fe0-1d434235dc01@digikod.net>
Date:   Wed, 28 Sep 2022 20:32:02 +0200
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
 <0dea6e07-dd98-0d3c-4c2b-7f45e06374ed@digikod.net> <YzCZVuP1d9GpQt+k@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <YzCZVuP1d9GpQt+k@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 25/09/2022 20:09, Günther Noack wrote:
> On Fri, Sep 23, 2022 at 10:53:23PM +0200, Mickaël Salaün wrote:
>> On 23/09/2022 13:21, Günther Noack wrote:
>>> On Mon, Sep 12, 2022 at 09:41:32PM +0200, Mickaël Salaün wrote:
>>>> On 08/09/2022 21:58, Günther Noack wrote:
>>>>> Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.
>>>>
>>>> [...]
>>>>
>>>>> +/**
>>>>> + * get_path_access_rights - Returns the subset of rights in access_request
>>>>> + * which are permitted for the given path.
>>>>> + *
>>>>> + * @domain: The domain that defines the current restrictions.
>>>>> + * @path: The path to get access rights for.
>>>>> + * @access_request: The rights we are interested in.
>>>>> + *
>>>>> + * Returns: The access mask of the rights that are permitted on the given path,
>>>>> + * which are also a subset of access_request (to save some calculation time).
>>>>> + */
>>>>> +static inline access_mask_t
>>>>> +get_path_access_rights(const struct landlock_ruleset *const domain,
>>>>> +		       const struct path *const path,
>>>>> +		       access_mask_t access_request)
>>>>> +{
>>>>> +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
>>>>> +	unsigned long access_bit;
>>>>> +	unsigned long access_req;
>>>>> +
>>>>> +	init_layer_masks(domain, access_request, &layer_masks);
>>>>> +	if (!check_access_path_dual(domain, path, access_request, &layer_masks,
>>>>> +				    NULL, 0, NULL, NULL)) {
>>>>> +		/*
>>>>> +		 * Return immediately for successful accesses and for cases
>>>>> +		 * where everything is permitted because the path belongs to an
>>>>> +		 * internal filesystem.
>>>>> +		 */
>>>>> +		return access_request;
>>>>> +	}
>>>>> +
>>>>> +	access_req = access_request;
>>>>> +	for_each_set_bit(access_bit, &access_req, ARRAY_SIZE(layer_masks)) {
>>>>> +		if (layer_masks[access_bit]) {
>>>>> +			/* If any layer vetoed the access right, remove it. */
>>>>> +			access_request &= ~BIT_ULL(access_bit);
>>>>> +		}
>>>>> +	}
>>>>
>>>> This seems to be redundant with the value returned by init_layer_masks(),
>>>> which should be passed to check_access_path_dual() to avoid useless path
>>>> walk.
>>>
>>> True, I'll use the result of init_layer_masks() to feed it back to
>>> check_access_path_dual() to avoid a bit of computation.
>>>
>>> Like this:
>>>
>>>           effective_access_request =
>>> 		init_layer_masks(domain, access_request, &layer_masks);
>>> 	if (!check_access_path_dual(domain, path, effective_access_request,
>>> 	    &layer_masks, NULL, 0, NULL, NULL)) {
>>> 		// ...
>>> 	}
>>
>> correct
>>
>>>
>>> Overall, the approach here is:
>>>
>>> * Initialize the layer_masks, so that it has a bit set for every
>>>     access right in access_request and layer where that access right is
>>>     handled.
>>>
>>> * check_access_path_dual() with only the first few parameters -- this
>>>     will clear all the bits in layer masks which are actually permitted
>>>     according to the individual rules.
>>>
>>>     As a special case, this *may* return 0 immediately, in which case we
>>>     can (a) save a bit of calculation in the loop below and (b) we might
>>>     be in the case where access is permitted because it's a file from a
>>>     special file system (even though not all bits are cleared). If
>>>     check_access_path_dual() returns 0, we return the full requested
>>>     access_request that we received as input. >
>>> * In the loop below, if there are any bits left in layer_masks, those
>>>     are rights which are not permitted for the given path. We remove
>>>     these from access_request and return the modified access_request.
>>>
>>>
>>>> This function is pretty similar to check_access_path(). Can't you change it
>>>> to use an access_mask_t pointer and get almost the same thing?
>>>
>>> I'm shying away from this approach. Many of the existing different use
>>> cases are already realized by "doing if checks deep down". I think it
>>> would make the code more understandable if we managed to model these
>>> differences between use cases already at the layer of function calls.
>>> (This is particularly true for check_access_path_dual(), where in
>>> order to find out how the "single" case works, you need to disentangle
>>> to a large extent how the much more complicated dual case works.)
>>
>> I agree that check_access_path_dual() is complex, but I couldn't find a
>> better way.
> 
> It seems out of the scope of this patch set, but I sometimes find it
> OK to just duplicate the code and have a set of tests to demonstrate
> that the two variants do the same thing.
> 
> check_access_path_dual() is mostly complex because of performance
> reasons, as far as I can tell, and it might be possible to check its
> results against a parallel implementation of it which runs slower,
> uses more memory, but is more obviously correct. (I have used one
> myself to check against when developing the truncate patch set.)
> 
>>> If you want to unify these two functions, what do you think of the
>>> approach of just using get_path_access_rights() instead of
>>> check_access_path()?
>>>
>>> Basically, it would turn
>>>
>>> return check_access_path(dom, path, access_request);
>>>
>>> into
>>>
>>> if (get_path_access_rights(dom, path, access_request) == access_request)
>>> 	return 0;
>>> return -EACCES;
>>>
>>> This is slightly more verbose in the places where it's called, but it
>>> would be more orthogonal, and it would also clarify that -EACCES is
>>> the only possible error in the "single" path walk case.
>>>
>>> Let me know what you think.
>>
>> What about adding an additional argument `access_mask_t *const
>> access_allowed` to check_access_path_dual() which returns the set of
>> accesses (i.e. access_masked_parent1 & access_masked_parent2) that could
>> then be stored to landlock_file(file)->allowed_access? If this argument is
>> NULL it should just be ignored. What is left from get_path_access_rights()
>> could then be merged into hook_file_open().
> 
> IMHO, check_access_path_dual() does not seem like the right place to
> add this. This functionality is not needed in any of the "dual path"
> cases so far, and I'm not sure what it would mean. The necessary
> information can also be easily derived from the resulting layer_masks,
> which is already exposed in the check_access_path_dual() interface,
> and I also believe that this approach is at least equally fast as
> updating it on the fly when changing the layer_masks.
> 
> I could be convinced to add a `access_mask_t *const access_allowed`
> argument to check_access_path() if you prefer that, but then again, in
> that case the returned boolean can be reconstructed from the new
> access_allowed variable, and we could as well make check_access_path()
> return the access_allowed result instead of the boolean and let
> callers check equality with what they expected...? (I admittedly don't
> have a good setup to test the performance right now, but it looks like
> a negligible difference to me?)

Good idea, let's try to make check_access_path_dual() returns the 
allowed accesses (according to the request) and rename it to 
get_access_path_dual(). unmask_layers() could be changed to return the 
still-denied accesses instead of a boolean, and we could use this values 
(for potential both parents) to return allowed_parent1 & allowed_parent2 
(with access_mask_t types). This would also simplify is_eaccess() and 
its calls could be moved to current_check_refer_path(). This would merge 
get_path_access_rights() into check_access_path_dual() and make the 
errno codes more explicit per hook or defined in check_access_path().


> 
> Here are the options we have discussed, in the order that I would
> prefer them:
> 
> * to keep it as a separate function as it already is,
>    slightly duplicating check_access_path(). (I think it's cleaner,
>    because the code path for the rest of the hooks other than
>    security_file_open() stays simpler.)
> 
> * to make check_access_path() return the access_allowed access mask
>    and make callers check that it covers the access_request that they
>    asked for (see example from my previous mail on this thread). (This
>    is equivalent to discarding the existing check_access_path() and
>    using the get_path_access() function instead.)
> 
> * to add a `access_mask_t *const access_allowed` argument to
>    check_access_path(), which is calculated if it's non-NULL based on
>    the layer_masks result. It would be used from the security_file_open
>    hook.
> 
> * to add a `access_mask_t *const access_allowed` argument to
>    check_access_path_dual(). This doesn't make much sense, IMHO,
>    because an on-the-fly calculation of this result does not look like
>    a performance benefit to me, and calculating it based on the two
>    resulting layer_masks is already possible now. It's also not clear
>    to me what it would mean to calculate an access_allowed on two paths
>    at once, and what that would be used for.
> 
> Let me know which option you prefer. In the end, I don't feel that
> strongly about it and I'm happy to do this either way.
