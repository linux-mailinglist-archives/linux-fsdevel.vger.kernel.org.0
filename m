Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3D1422767
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 15:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhJENL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 09:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhJENLz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:11:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73265C061749;
        Tue,  5 Oct 2021 06:10:05 -0700 (PDT)
Received: from [IPv6:2401:4900:1c20:6ff1:a04:f397:fd5d:ecb8] (unknown [IPv6:2401:4900:1c20:6ff1:a04:f397:fd5d:ecb8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1FE401F43751;
        Tue,  5 Oct 2021 14:10:03 +0100 (BST)
Subject: Re: [PATCH 1/2] fs: dcache: Handle case-exact lookup in
 d_alloc_parallel
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, krisman@collabora.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <cover.1632909358.git.shreeya.patel@collabora.com>
 <0b8fd2677b797663bfcb97f6aa108193fedf9767.1632909358.git.shreeya.patel@collabora.com>
 <YVmyYP25kgGq9uEy@zeniv-ca.linux.org.uk>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <589db4cf-5cab-2d1f-10ce-3a5009685948@collabora.com>
Date:   Tue, 5 Oct 2021 18:39:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVmyYP25kgGq9uEy@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 03/10/21 7:08 pm, Al Viro wrote:
> On Wed, Sep 29, 2021 at 04:23:38PM +0530, Shreeya Patel wrote:
>> There is a soft hang caused by a deadlock in d_alloc_parallel which
>> waits up on lookups to finish for the dentries in the parent directory's
>> hash_table.
>> In case when d_add_ci is called from the fs layer's lookup functions,
>> the dentry being looked up is already in the hash table (created before
>> the fs lookup function gets called). We should not be processing the
>> same dentry that is being looked up, hence, in case of case-insensitive
>> filesystems we are making it a case-exact match to prevent this from
>> happening.
> NAK.  What you are doing would lead to parallel calls of ->lookup() in the
> same directory for names that would compare as equal.  Which violates
> all kinds of assumptions in the analysis of dentry tree locking.
>
> d_add_ci() is used to force the "exact" spelling of the name on lookup -
> that's the whole point of that thing.  What are you trying to achieve,
> and what's the point of mixing that with non-trivial ->d_compare()?
>
Sending again as plain text...

Hi Al Viro,

This patch was added to resolve some of the issues faced in patch 02/02 
of the series.

Originally, the 'native', per-directory case-insensitive implementation
merged in ext4/f2fs stores the case of the first lookup on the dcache,
regardless of the disk exact file name case. This gets reflected in symlink
returned by /proc/self/cwd.

To solve this we are calling d_add_ci from the fs lookup function to 
store the
disk exact name in the dcache even if an inexact-match string is used on 
the FIRST lookup.
But this caused a soft hang since there was a deadlock in d_wait_lookup 
called from d_alloc_parallel.

The reason for the hang is that d_same_name uses d_compare which does a
case-insensitive match and is able to find the dentry name in the 
secondary hash table
leading it to d_wait_lookup which would wait for the lookup to finish on 
that dentry
causing a deadlock.

To avoid the hang, we are doing a case-sensitive match using dentry_cmp 
here.


Thanks

> If it's "force to exact spelling on lookup, avoid calling ->lookup() on
> aliases", d_add_ci() is simply not a good match.
