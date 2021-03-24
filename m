Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE13348310
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 21:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbhCXUo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 16:44:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39144 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbhCXUog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:44:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id A18681F45E95
Subject: Re: [RFC PATCH 2/4] mm: shmem: Support case-insensitive file name
 lookups
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        krisman@collabora.com, smcv@collabora.com, kernel@collabora.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Rosenberg <drosen@google.com>
References: <20210323195941.69720-1-andrealmeid@collabora.com>
 <20210323195941.69720-3-andrealmeid@collabora.com>
 <YFp3ZF+gAnhKMJIA@zeniv-ca.linux.org.uk>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <7826ef62-49a0-d140-2920-5bdab5bda58a@collabora.com>
Date:   Wed, 24 Mar 2021 17:44:25 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFp3ZF+gAnhKMJIA@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al Viro,

Às 20:19 de 23/03/21, Al Viro escreveu:
> On Tue, Mar 23, 2021 at 04:59:39PM -0300, André Almeida wrote:
> 
>> * dcache handling:
>>
>> For now, negative lookups are not inserted in the dcache, since they
>> would need to be invalidated anyway, because we can't trust missing file
>> dentries. This is bad for performance but requires some leveraging of
>> the VFS layer to fix. We can live without that for now, and so does
>> everyone else.
> 
> "For now"?  Not a single practical suggestion has ever materialized.
> Pardon me, but by now I'm very sceptical about the odds of that
> ever changing.  And no, I don't have any suggestions either.

Right, I'll reword this to reflect that there's no expectation that this 
will be done, while keeping documented this performance issue.

> 
>> The lookup() path at tmpfs creates negatives dentries, that are later
>> instantiated if the file is created. In that way, all files in tmpfs
>> have a dentry given that the filesystem exists exclusively in memory.
>> As explained above, we don't have negative dentries for casefold files,
>> so dentries are created at lookup() iff files aren't casefolded. Else,
>> the dentry is created just before being instantiated at create path.
>> At the remove path, dentries are invalidated for casefolded files.
> 
> Umm...  What happens to those assertions if previously sane directory
> gets case-buggered?  You've got an ioctl for doing just that...
> Incidentally, that ioctl is obviously racy - result of that simple_empty()
> might have nothing to do with reality before it is returned to caller.
> And while we are at it, simple_empty() doesn't check a damn thing about
> negative dentries in there...
> 

Thanks for pointing those issues. I'll move my lock at IOCTL to make 
impossible to change directory attributes and add a file there at the 
same time. About the negative dentries that existed before at that 
directory, I believe the way to solve this is by invalidating them all. 
How that sound to you?

Thanks,
	André
