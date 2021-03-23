Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4DC3468D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 20:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhCWTUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 15:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhCWTUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:20:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14783C061574;
        Tue, 23 Mar 2021 12:20:15 -0700 (PDT)
Received: from [IPv6:2401:4900:5170:240f:f606:c194:2a1c:c147] (unknown [IPv6:2401:4900:5170:240f:f606:c194:2a1c:c147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1A3DC1F455BB;
        Tue, 23 Mar 2021 19:20:10 +0000 (GMT)
Subject: Re: [PATCH v2 4/4] fs: unicode: Add utf8 module and a unicode layer
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     krisman@collabora.com, jaegeuk@kernel.org, yuchao0@huawei.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, drosen@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com, andre.almeida@collabora.com
References: <20210318133305.316564-1-shreeya.patel@collabora.com>
 <20210318133305.316564-5-shreeya.patel@collabora.com>
 <YFPAjYDOCXqpqgV8@gmail.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <594df967-606d-235f-ac49-5676009f543e@collabora.com>
Date:   Wed, 24 Mar 2021 00:50:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFPAjYDOCXqpqgV8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19/03/21 2:35 am, Eric Biggers wrote:
> On Thu, Mar 18, 2021 at 07:03:05PM +0530, Shreeya Patel wrote:
>> +struct unicode_ops {
>> +	struct module *owner;
>> +	int (*validate)(const struct unicode_map *um, const struct qstr *str);
>> +	int (*strncmp)(const struct unicode_map *um, const struct qstr *s1,
>> +		       const struct qstr *s2);
>> +	int (*strncasecmp)(const struct unicode_map *um, const struct qstr *s1,
>> +			   const struct qstr *s2);
>> +	int (*strncasecmp_folded)(const struct unicode_map *um, const struct qstr *cf,
>> +				  const struct qstr *s1);
>> +	int (*normalize)(const struct unicode_map *um, const struct qstr *str,
>> +			 unsigned char *dest, size_t dlen);
>> +	int (*casefold)(const struct unicode_map *um, const struct qstr *str,
>> +			unsigned char *dest, size_t dlen);
>> +	int (*casefold_hash)(const struct unicode_map *um, const void *salt,
>> +			     struct qstr *str);
>> +	struct unicode_map* (*load)(const char *version);
>> +};
> Indirect calls are expensive these days, especially due to the Spectre
> mitigations.  Would it make sense to use static calls
> (include/linux/static_call.h) instead for this?

Hi Eric,

I just sent a v3 with static_call implementation.


>
> - Eric
>
