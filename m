Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D228926D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 18:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfHKQB1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 12:01:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49014 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHKQB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 12:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QkksfTdS9Zb9fABKGCjbx7pB9MkN8Q/DyS800NUQtuw=; b=wWB5BqEsRGC60oPg4k7aDqOgEV
        VD50r1gpx4jxb7iR5HrfdbEtN54fehsV/WeElqWULp1vkI0PcKXb9ZV3q0wwDWzYEIqQix/U03juN
        WxwY3DG9Zd1FrQeNrBwQtQNmUa7Fi8qfKj5+wmq7socLL/kHZL1nONqflxzQM0qiuL3nrMVSX6S6z
        YMki00gAaxSZcLxpVY4aMu8q//3kecjFz5SjspQYhad0zCzFukw3QxvcOzRqs6ZOulnlZkgJ9i2wc
        LRoBDm3YKWUDCRztwMP59GInStcUb1j3LG35SZIsblxXvhOWF6RASjmds9oVxUgmyHN0fqMsfnNHt
        EMxu9wIw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hwqHe-00054w-7H; Sun, 11 Aug 2019 16:01:26 +0000
Subject: Re: [PATCH v12 resend 0/1] fs: Add VirtualBox guest shared folder
 (vboxsf)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
References: <20190811133852.5173-1-hdegoede@redhat.com>
 <8277d9de-4709-df2d-f930-d324c5764871@infradead.org>
 <68fecb6e-7afa-d39d-2f0f-5496aeff510a@redhat.com>
 <973451c9-1681-1c73-9190-75d8ef529916@infradead.org>
 <69c4d47d-2b33-72e9-9da0-7a251070cf6c@infradead.org>
Message-ID: <0d3cd89a-b03f-f431-731e-caf945611ef6@infradead.org>
Date:   Sun, 11 Aug 2019 09:01:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <69c4d47d-2b33-72e9-9da0-7a251070cf6c@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/11/19 8:31 AM, Randy Dunlap wrote:
> On 8/11/19 8:16 AM, Randy Dunlap wrote:
>> On 8/11/19 8:09 AM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 8/11/19 5:07 PM, Randy Dunlap wrote:
>>>> On 8/11/19 6:38 AM, Hans de Goede wrote:
>>>>> Hello Everyone,
>>>>>
>>>>> Here is a resend of the 12th version of my cleaned-up / refactored version
>>>>> of the VirtualBox shared-folder VFS driver. It seems that for some reason
>>>>> only the cover letter of my initial-posting of v12 has made it to the list.
>>>>>
>>>>> This version hopefully addresses all issues pointed out in David Howell's
>>>>> review of v11 (thank you for the review David):
>>>>>
>>>>> Changes in v12:
>>>>> -Move make_kuid / make_kgid calls to option parsing time and add
>>>>>   uid_valid / gid_valid checks.
>>>>> -In init_fs_context call current_uid_gid() to init uid and gid
>>>>> -Validate dmode, fmode, dmask and fmask options during option parsing
>>>>> -Use correct types for various mount option variables (kuid_t, kgid_t, umode_t)
>>>>> -Some small coding-style tweaks
>>>>>
>>>>> For changes in older versions see the change log in the patch.
>>>>>
>>>>> This version has been used by several distributions (arch, Fedora) for a
>>>>> while now, so hopefully we can get this upstream soonish, please review.
>>>>
>>>> Hi,
>>>> Still looks like patch 1/1 is not hitting the mailing list.
>>>> How large is it?
>>>
>>> Thank you for catching this:
>>>
>>> [hans@dhcp-44-196 linux]$ wc 0001-fs-Add-VirtualBox-guest-shared-folder-vboxsf-support.patch
>>>   3754  14479 100991 0001-fs-Add-VirtualBox-guest-shared-folder-vboxsf-support.patch
>>
>> That size shouldn't be a problem AFAIK.
>> Maybe there is something else in the patch that vger doesn't like.
>>
>>   http://vger.kernel.org/majordomo-taboos.txt
>>
> 
> "Message size exceeding 100 000 characters causes blocking."
> from:  http://vger.kernel.org/majordomo-info.html
> 
> I thought the limit was higher than that.
> 

Looks like it is higher for linux-kernel@vger.kernel.org but maybe not
for other mailing lists.
I certainly see larger messages on lkml.

-- 
~Randy
