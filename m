Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1781E89233
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 17:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfHKPJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 11:09:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42047 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfHKPJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 11:09:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id b16so5783391wrq.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Aug 2019 08:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ztZBTGKKcpdO3aZ4X17mpY2EtCpkPl1wXOrEUa9jPCg=;
        b=U9sGmPbMwxnhPHOPN/0+VUyu2DAQLuXDa7ox+SvaGMvSUOSD92wUFc42h+BXp3iWPS
         cEW9HXi5G61UR5CKFoFQpkdg05IVmwbCuZv8h7RqYuQP2B6A3/Ohg46y90WZwogWUL/z
         v628ohTk7126hRE8wIdultKBFeURBTkzL0xNY8/3w8HP3jF4CR7Sp48OwsDxqFrkQMsW
         sU3IRI3N76TKQx6ZHXeYuRUZpRUrIeuEW8AqViFVDN+X5ANJUt5srfzt5ycCKti0oNRI
         ZO0R4khcPkM1PaCjjro4SEgT2WQc884HQBzymHHgcLvp9XeVvqcz8cw2LAqsKq1MoD8m
         DkIA==
X-Gm-Message-State: APjAAAUGWtBtCKprwZOmXOY4IZCVZt2I1jzAcT3qAU/D0i68Kbi4aGRi
        peSkN+eNir1ClTK1w/+kHFjOQc6YjzY=
X-Google-Smtp-Source: APXvYqwcHlXUzJyAKAUB776XuILM4KMEfoiFLCHtQO3yKCX2JACrEqlySH24WPSO52qzEvYJUEN42Q==
X-Received: by 2002:a05:6000:1007:: with SMTP id a7mr36871711wrx.172.1565536162653;
        Sun, 11 Aug 2019 08:09:22 -0700 (PDT)
Received: from dhcp-44-196.space.revspace.nl ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id k128sm5107530wme.15.2019.08.11.08.09.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 08:09:21 -0700 (PDT)
Subject: Re: [PATCH v12 resend 0/1] fs: Add VirtualBox guest shared folder
 (vboxsf)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
References: <20190811133852.5173-1-hdegoede@redhat.com>
 <8277d9de-4709-df2d-f930-d324c5764871@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <68fecb6e-7afa-d39d-2f0f-5496aeff510a@redhat.com>
Date:   Sun, 11 Aug 2019 17:09:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8277d9de-4709-df2d-f930-d324c5764871@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 8/11/19 5:07 PM, Randy Dunlap wrote:
> On 8/11/19 6:38 AM, Hans de Goede wrote:
>> Hello Everyone,
>>
>> Here is a resend of the 12th version of my cleaned-up / refactored version
>> of the VirtualBox shared-folder VFS driver. It seems that for some reason
>> only the cover letter of my initial-posting of v12 has made it to the list.
>>
>> This version hopefully addresses all issues pointed out in David Howell's
>> review of v11 (thank you for the review David):
>>
>> Changes in v12:
>> -Move make_kuid / make_kgid calls to option parsing time and add
>>   uid_valid / gid_valid checks.
>> -In init_fs_context call current_uid_gid() to init uid and gid
>> -Validate dmode, fmode, dmask and fmask options during option parsing
>> -Use correct types for various mount option variables (kuid_t, kgid_t, umode_t)
>> -Some small coding-style tweaks
>>
>> For changes in older versions see the change log in the patch.
>>
>> This version has been used by several distributions (arch, Fedora) for a
>> while now, so hopefully we can get this upstream soonish, please review.
> 
> Hi,
> Still looks like patch 1/1 is not hitting the mailing list.
> How large is it?

Thank you for catching this:

[hans@dhcp-44-196 linux]$ wc 0001-fs-Add-VirtualBox-guest-shared-folder-vboxsf-support.patch
   3754  14479 100991 0001-fs-Add-VirtualBox-guest-shared-folder-vboxsf-support.patch

Regards,

Hans

