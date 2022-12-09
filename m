Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E7B647F42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Dec 2022 09:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiLII3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Dec 2022 03:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLII33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:29:29 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F0F5E3FE;
        Fri,  9 Dec 2022 00:29:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670574545; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Kp9f9qDxAe0hlfK5vFCbM5y8/3ZlMd4DRhe7eK3dZ3iJFb/9oIGwRt4KkICv8tjgjnsyJOM6VtXNp5rCSiKqc958LUh4AKIp81x3vwbXRBXyNzANxVIeN1iMjYfJxkZ1hwUd7Omkvxv0Y1Df6xpjKwpKlnsbfauv/tatb3kz8l0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1670574545; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=lgXvQW8T8idwqTG2o/i6+KoDTaqrhbyGX00cZFdE/wE=; 
        b=DjBLN7xsKF/wjkmLQzRNaC5Qo1TaRGtGlVU1EygBU4bESeG0MWzbYUlMdX1HwCUKMj5Aj4lVHBAMaJcug+2ioWywOnEVTr87StiBpALrb9W8nxQ4RELM5rza3LSfWRsW+SI7MYKi9rjrJNiwqZZe+j4qrBOG7FVBlWIwsIlr8rU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670574545;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=lgXvQW8T8idwqTG2o/i6+KoDTaqrhbyGX00cZFdE/wE=;
        b=NCjulmO8gZs+W/M/oOaiCbmVcWKYiJNVz/fXgM0ojRz9vl+R9CKr/y0vyviOcjCP
        6IQ6LkIa2ZkgzbPo6PCHIezrKiYyJmAGY3yzPaV4miLOe/5oqt4o41NYyCWd4Hdqt8q
        XB6La6DEZYyPN1FOHh8vdKfvIKsD3Ptz2pEPsbh4=
Received: from [192.168.1.9] (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1670574543792307.4749119019116; Fri, 9 Dec 2022 13:59:03 +0530 (IST)
Message-ID: <7c836cf0-d978-c892-bec8-0992e2347512@siddh.me>
Date:   Fri, 9 Dec 2022 13:59:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH] erofs/zmap.c: Bail out when no further region remains
Content-Language: en-US, en-GB, hi-IN
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>
References: <Y3MGf3TzgKpAz4IP@B-P7TQMD6M-0146.local>
 <917344b4-4256-6d77-b89b-07fa96ec4539@siddh.me>
 <Y3Nu+TNRp6Fv3L19@B-P7TQMD6M-0146.local>
 <Y5K+p6td52QppRZt@B-P7TQMD6M-0146.local>
From:   Siddh Raman Pant <code@siddh.me>
In-Reply-To: <Y5K+p6td52QppRZt@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 09 2022 at 10:20:47 +0530, Gao Xiang wrote:
> Hi Siddh,
> 
> On Tue, Nov 15, 2022 at 06:50:33PM +0800, Gao Xiang wrote:
>> On Tue, Nov 15, 2022 at 03:39:38PM +0530, Siddh Raman Pant via Linux-erofs wrote:
>>> On Tue, 15 Nov 2022 08:54:47 +0530, Gao Xiang wrote:
>>>> I just wonder if we should return -EINVAL for post-EOF cases or
>>>> IOMAP_HOLE with arbitrary length?
>>>
>>> Since it has been observed that length can be zeroed, and we
>>> must stop, I think we should return an error appropriately.
>>>
>>> For a read-only filesystem, we probably don't really need to
>>> care what's after the EOF or in unmapped regions, nothing can
>>> be changed/extended. The definition of IOMAP_HOLE in iomap.h
>>> says it stands for "no blocks allocated, need allocation".
>>
>> For fiemap implementation, yes.  So it looks fine to me.
>>
>> Let's see what other people think.  Anyway, I'd like to apply it later.
>>
> 
> Very sorry for late response.
> 
> I've just confirmed that the reason is that
> 
> 796                 /*
> 797                  * No strict rule how to describe extents for post EOF, yet
> 798                  * we need do like below. Otherwise, iomap itself will get
> 799                  * into an endless loop on post EOF.
> 800                  */
> 801                 if (iomap->offset >= inode->i_size)
> 802                         iomap->length = length + map.m_la - offset;
> 
> Here iomap->length should be length + offset - map.m_la here. Because
> the extent start (map.m_la) is always no more than requested `offset'.
> 
> We should need this code sub-block since userspace (filefrag -v) could
> pass
> ioctl(3, FS_IOC_FIEMAP, {fm_start=0, fm_length=18446744073709551615, fm_flags=0, fm_extent_count=292} => {fm_flags=0, fm_mapped_extents=68, ...}) = 0
> 
> without this sub-block, fiemap could get into a very long loop as below:
> [  574.030856][ T7030] erofs: m_la 70000000 offset 70457397 length 9223372036784318410 m_llen 457398
> [  574.031622][ T7030] erofs: m_la 70000000 offset 70457398 length 9223372036784318409 m_llen 457399
> [  574.032397][ T7030] erofs: m_la 70000000 offset 70457399 length 9223372036784318408 m_llen 457400

Thanks for the detailed explanation!

> So could you fix this as?
> 	iomap->length = length + offset - map.m_la;
> 
> I've already verified it can properly resolve the issue and do the
> correct thing although I'd like to submit this later since we're quite
> close to the merge window.
> 
> Thanks,
> Gao Xiang

Sure, I'll send the patch for now, which can be merged after the window.

Thanks,
Siddh
