Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B75E8ECE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 15:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbfHONdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 09:33:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53444 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbfHONdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:33:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id 10so1305019wmp.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2019 06:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IZSyysRAAgSD74VsmsQ6qEERpltshf4dwXy2Ucm6QKA=;
        b=nZdbu9dqTUbbTYq79/uVkzIevhHJgrwGvLtOUKVRHwaP0qVSVkM1SEtdatNZl+KVqa
         t6Un7d6KOH5uaSjFJddZCq74g4DkSghKFbQVkhX9DuEo5+KzBgBoeq8viA+h6b7nSZzU
         dVqw00tJB02WXNEBvUShbhaetFMDgeKo0NPxsyWVS7SccmwLElJjU6usKYKeR7Fx5j6D
         wZuZJ/NMcXJVdoM22X4NVSOxPLrYTVAV/18GzKoLrJNEoSldChPnv9IC37cCF187bORG
         bHiHtO/JcRL1rJ+I47MyNW5Ae5OVY68a5LzXkyoAH7vunMyhVBWuT3365TWaAyTIBRWA
         QC9A==
X-Gm-Message-State: APjAAAUIBBWX+QvuLBkfwsNas5CQ0anbzWKAc//3o/F5bcaIQjEwqz/v
        fAeFHbOD8sTIpoHkjC+24Vtzbw4Rhm4=
X-Google-Smtp-Source: APXvYqzdGxDwXVHquY64vOBK/K0FUx++jevoTuxLRv5Y9BchvAEJZkPIXPyyJ/OQ8ROhyekTdO4LSQ==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr2762862wmg.155.1565876012785;
        Thu, 15 Aug 2019 06:33:32 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id q20sm8454472wrc.79.2019.08.15.06.33.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 06:33:32 -0700 (PDT)
Subject: Re: [PATCH v13] fs: Add VirtualBox guest shared folder (vboxsf)
 support
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20190815131253.237921-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <da593279-4765-09c8-0594-3e9b4cbec3a1@redhat.com>
Date:   Thu, 15 Aug 2019 15:33:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815131253.237921-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 15-08-19 15:12, Hans de Goede wrote:
> Hello Everyone,
> 
> Here is the 13th version of my cleaned-up / refactored version of the
> VirtualBox shared-folder VFS driver.
> 
> This version hopefully addresses all issues pointed out in Christoph's
> review of v12 (thank you for the review Christoph):
> 
> Changes in v13:
> - Add SPDX tag to Makefile, use foo-y := to set objectfile list
> - Drop kerneldoc headers stating the obvious from vfs callbacks,
>    to avoid them going stale
> - Replace sf_ prefix of functions and data-types with vboxsf_
> - Use more normal naming scheme for sbi and private inode data:
>      struct vboxsf_sbi *sbi = VBOXSF_SBI(inode->i_sb);
>      struct vboxsf_inode *sf_i = VBOXSF_I(inode);
> - Refactor directory reading code
> - Use goto based unwinding instead of nested if-s in a number of places
> - Consolidate dir unlink and rmdir inode_operations into a single function
> - Use the page-cache for regular reads/writes too
> - Directly set super_operations.free_inode to what used to be our
>    vboxsf_i_callback, instead of setting super_operations.destroy_inode
>    to a function which just does: call_rcu(&inode->i_rcu, vboxsf_i_callback);
> - Use spinlock_irqsafe for ino_idr_lock
>    vboxsf_free_inode may be called from a RCU callback, and thus from
>    softirq context, so we need to use spinlock_irqsafe vboxsf_new_inode.
>    On alloc_inode failure vboxsf_free_inode may be called from process
>    context, so it too needs to use spinlock_irqsafe.
> 
> This version has been used by several distributions (arch, Fedora) for a
> while now, so hopefully we can get this upstream soonish, please review.

I just noticed I forgot to add 0/1 to the subject of this cover letter,
the second mail with the same subject (sorry) is the actual patch.

Regards,

Hans
