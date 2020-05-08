Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCBF1CB4CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 18:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgEHQQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 12:16:48 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:50852 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728174AbgEHQQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 12:16:46 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 1DA522E14C4;
        Fri,  8 May 2020 19:16:43 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id FUmgX13TVC-GeAWkgPx;
        Fri, 08 May 2020 19:16:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588954603; bh=fBUtwXBek4NM+L2c+v6a5Q30Xgg4O7DzdNaSB/H01/M=;
        h=In-Reply-To:References:Date:Message-ID:From:To:Subject;
        b=dAECvcdKmUWk2CVnMXeTHO8Vk04t0GhdKk6GVVazxHMmEd4vqdRBdWvIWqkI271c7
         CSAWWDV/ZA13LhBGUZXu96IhmqX7dtLDQOdPEN9crnTRzNnC73pXVD2TgYv1vXjxGT
         5ykQhY615zHDuCC3cU53VoEyWgY+W+NlFyLvCwzM=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7008::1:4])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id qhpQEsyI8M-GeWCH2g5;
        Fri, 08 May 2020 19:16:40 +0300
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
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <ac1ece33-46ea-175a-98ef-c79fcd1ced90@yandex-team.ru>
Date:   Fri, 8 May 2020 19:16:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7c1cef87-2940-eb17-51d4-cbc40218b770@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/05/2020 17.49, Waiman Long wrote:
> On 5/8/20 8:23 AM, Konstantin Khlebnikov wrote:
>> Count of buckets is required for estimating average length of hash chains.
>> Size of hash table depends on memory size and printed once at boot.
>>
>> Let's expose nr_buckets as sixth number in sysctl fs.dentry-state
> 
> The hash bucket count is a constant determined at boot time. Is there a need to use up one dentry_stat entry for that? Besides one can get 
> it by looking up the kernel dmesg log like:
> 
> [    0.055212] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)

Grepping logs since boot time is a worst API ever.

dentry-state shows count of dentries in various states.
It's very convenient to show count of buckets next to it,
because this number defines overall scale.

> 
> Cheers,
> Longman
> 
