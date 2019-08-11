Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3125C89259
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfHKPjm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 11:39:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45149 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfHKPjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 11:39:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id q12so12270915wrj.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Aug 2019 08:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A3PQqRJiKJ+tnzDhaTN167Xwq3h6LSZIGEa9z+lHBPs=;
        b=Vkxugs0+PBqXI/pF8OURw4zoqj3m2Ig53Ng0wB8a9Psgg+n+BMOuuBFab2h863JVkG
         lFXrMQa5ol5939HqBz5MswiAVS08y/e76ppItBrXmU8w4+qYH7yNhMCrA2ou0QfAmmMo
         KNx41YZnsElsxj4YVjORYyDDA9lSgglDi+k5tSmYXASaCLBUjNSOmcahXpWIGRthqS56
         1Yj4dEprLs+6AEJFiP/irDOgKgEywBQshKEqsP0OskFHIKJbOp+0kxiiNbyBDexihajV
         9crvIUi60XIWyVy4AvgvILQOgt/2sUNlzTOhuviopaDFA/oj/I4Uj1s5w2X7Mufpz7/C
         bi1A==
X-Gm-Message-State: APjAAAUcDdcTxsF1WuBfbzCRicKPsPT4WflUOFRQEBGi0v83zhRYJ2O4
        SnX7Ey7062wdu2QfjZQGheJiwxKv9Fk=
X-Google-Smtp-Source: APXvYqxp68wfpHNnotIcm1khJd6ErknKHF0/ncp3UHa0I9CYdYCRXWsQ2Fia3D3Phpko+cKedh94Ag==
X-Received: by 2002:adf:e390:: with SMTP id e16mr28142269wrm.153.1565537979428;
        Sun, 11 Aug 2019 08:39:39 -0700 (PDT)
Received: from dhcp-44-196.space.revspace.nl ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id 6sm1062556wmf.23.2019.08.11.08.39.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 08:39:38 -0700 (PDT)
Subject: Re: [PATCH v12 resend 0/1] fs: Add VirtualBox guest shared folder
 (vboxsf)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
References: <20190811133852.5173-1-hdegoede@redhat.com>
 <8277d9de-4709-df2d-f930-d324c5764871@infradead.org>
 <68fecb6e-7afa-d39d-2f0f-5496aeff510a@redhat.com>
 <973451c9-1681-1c73-9190-75d8ef529916@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c2fa3402-a1c0-d757-2228-43d310c489e7@redhat.com>
Date:   Sun, 11 Aug 2019 17:39:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <973451c9-1681-1c73-9190-75d8ef529916@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 8/11/19 5:16 PM, Randy Dunlap wrote:
> On 8/11/19 8:09 AM, Hans de Goede wrote:
>> Hi,
>>
>> On 8/11/19 5:07 PM, Randy Dunlap wrote:
>>> On 8/11/19 6:38 AM, Hans de Goede wrote:
>>>> Hello Everyone,
>>>>
>>>> Here is a resend of the 12th version of my cleaned-up / refactored version
>>>> of the VirtualBox shared-folder VFS driver. It seems that for some reason
>>>> only the cover letter of my initial-posting of v12 has made it to the list.
>>>>
>>>> This version hopefully addresses all issues pointed out in David Howell's
>>>> review of v11 (thank you for the review David):
>>>>
>>>> Changes in v12:
>>>> -Move make_kuid / make_kgid calls to option parsing time and add
>>>>    uid_valid / gid_valid checks.
>>>> -In init_fs_context call current_uid_gid() to init uid and gid
>>>> -Validate dmode, fmode, dmask and fmask options during option parsing
>>>> -Use correct types for various mount option variables (kuid_t, kgid_t, umode_t)
>>>> -Some small coding-style tweaks
>>>>
>>>> For changes in older versions see the change log in the patch.
>>>>
>>>> This version has been used by several distributions (arch, Fedora) for a
>>>> while now, so hopefully we can get this upstream soonish, please review.
>>>
>>> Hi,
>>> Still looks like patch 1/1 is not hitting the mailing list.
>>> How large is it?
>>
>> Thank you for catching this:
>>
>> [hans@dhcp-44-196 linux]$ wc 0001-fs-Add-VirtualBox-guest-shared-folder-vboxsf-support.patch
>>    3754  14479 100991 0001-fs-Add-VirtualBox-guest-shared-folder-vboxsf-support.patch
> 
> That size shouldn't be a problem AFAIK.
> Maybe there is something else in the patch that vger doesn't like.
> 
>    http://vger.kernel.org/majordomo-taboos.txt

I don't see anything there which is in the patch AFAICT :|

Regards,

Hans

