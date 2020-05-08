Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0091CB868
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 21:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgEHTiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 15:38:15 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:35872 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbgEHTiO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 15:38:14 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id D9AE22E1311;
        Fri,  8 May 2020 22:38:11 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id QvZdULVM6o-cAX4svEI;
        Fri, 08 May 2020 22:38:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588966691; bh=9GLY1la68n+wI9zMyvgvDRv2pNDwrtlhLHG5G0IMGTs=;
        h=In-Reply-To:References:Date:Message-ID:From:To:Subject;
        b=OvTf+PpXtk7c6havdRnlXu1hosHaar/Pj5/xkLONgMgc//ZOb4TQlntz2NNbxteoP
         nKGm5QpGYYrY3oPg5vhtBUmNC3ZrUyU2Prue+3JmKRuePDd0LSYlSdt5z2pgxoN0ir
         flbJfpFua4c+p7FkDT2Vfv1JSxMI3cdGMEwJaJ7M=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7114::1:3])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id jDpMf4G7CS-cAWSORw7;
        Fri, 08 May 2020 22:38:10 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC 1/8] dcache: show count of hash buckets in sysctl
 fs.dentry-state
To:     Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <158893941613.200862.4094521350329937435.stgit@buzz>
 <158894059427.200862.341530589978120554.stgit@buzz>
 <7c1cef87-2940-eb17-51d4-cbc40218b770@redhat.com>
 <ac1ece33-46ea-175a-98ef-c79fcd1ced90@yandex-team.ru>
 <741172f7-a0d2-1428-fb25-789e38978d4e@redhat.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <1f137f70-3d37-eb70-2e85-2541e504afbd@yandex-team.ru>
Date:   Fri, 8 May 2020 22:38:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <741172f7-a0d2-1428-fb25-789e38978d4e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 08/05/2020 22.05, Waiman Long wrote:
> On 5/8/20 12:16 PM, Konstantin Khlebnikov wrote:
>> On 08/05/2020 17.49, Waiman Long wrote:
>>> On 5/8/20 8:23 AM, Konstantin Khlebnikov wrote:
>>>> Count of buckets is required for estimating average length of hash chains.
>>>> Size of hash table depends on memory size and printed once at boot.
>>>>
>>>> Let's expose nr_buckets as sixth number in sysctl fs.dentry-state
>>>
>>> The hash bucket count is a constant determined at boot time. Is there a need to use up one dentry_stat entry for that? Besides one can 
>>> get it by looking up the kernel dmesg log like:
>>>
>>> [    0.055212] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
>>
>> Grepping logs since boot time is a worst API ever.
>>
>> dentry-state shows count of dentries in various states.
>> It's very convenient to show count of buckets next to it,
>> because this number defines overall scale. 
> 
> I am not against using the last free entry for that. My only concern is when we want to expose another internal dcache data point via 
> dentry-state, we will have to add one more number to the array which can cause all sort of compatibility problem. So do we want to use the 
> last free slot for a constant that can be retrieved from somewhere else?

I see no problem in adding more numbers into sysctl.
Especially into such rarely used.
This interface is designed for that.

Also fields 'age_limit' and 'want_pages' are unused since kernel 2.2.0

> 
> Cheers,
> Longman
> 
