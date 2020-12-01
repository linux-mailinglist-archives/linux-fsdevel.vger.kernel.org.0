Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEB52C95DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 04:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgLADiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 22:38:11 -0500
Received: from sandeen.net ([63.231.237.45]:60626 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbgLADiL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 22:38:11 -0500
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 9991D14A06;
        Mon, 30 Nov 2020 21:37:15 -0600 (CST)
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20201125212523.GB14534@magnolia>
 <33d38621-b65c-b825-b053-eda8870281d1@sandeen.net>
 <1942931.1606341048@warthog.procyon.org.uk>
 <eb47ab08-67fc-6151-5669-d4fb514c2b50@sandeen.net>
 <20201201032051.GK5364@mit.edu>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: Clarification of statx->attributes_mask meaning?
Message-ID: <f259c5ee-7465-890a-3749-44eb8be0f8cf@sandeen.net>
Date:   Mon, 30 Nov 2020 21:37:29 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201032051.GK5364@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/30/20 9:20 PM, Theodore Y. Ts'o wrote:
> On Mon, Nov 30, 2020 at 05:29:47PM -0600, Eric Sandeen wrote:
>> On 11/25/20 3:50 PM, David Howells wrote:
>>> Darrick J. Wong <darrick.wong@oracle.com> wrote:
>>>
>>>> mask=1 bit=0: "attribute not set on this file"
>>>> mask=1 bit=1: "attribute is set on this file"
>>>> mask=0 bit=0: "attribute doesn't fit into the design of this fs"
>>>
>>> Or is "not supported by the filesystem driver in this kernel version".
>>
>> For a concrete example, let's talk about the DAX statx attribute.
>>
>> If the kernel is configured w/o DAX support, should the DAX attr be in the mask?
>> If the block device has no DAX support, should the DAX attr be in the mask?
>> If the filesystem is mounted with dax=never, should the DAX attr be in the mask?
>>
>> About to send a patch for xfs which answers "no" to all of those, but I'm still
>> not quite sure if that's what's expected.  I'll be sure to cc: dhowells, Ira, and
>> others who may care...
> 
> So you're basically proposing that the mask is indicating whether or
> not the attribute is supported by a particular on-disk file system
> image and/or how it is currently configured/mounted --- and not
> whether an attribute is supported by a particular file system
> *implementation*.

Well, not trying to propose anything new, just trying to understand
the intent of the mask to get it set correctly for the dax attribute.

> For example, for ext4, if the extents feature is not enabled (for
> example, when the ext4 file system code is used mount a file system
> whose feature bitmask is consistent with a historic ext2 file system)
> the extents flag should be cleared from the attribute mask?
> 
> This adds a fair amount of complexity to the file system since there
> are a number of flags that might have similar issues --- for example,
> FS_CASEFOLD_FL, and I could imagine for some file systems, where
> different revisions might or might not support reflink FS_NOCOW_FL,
> etc.

I've been told that I'm over-complicating this, yes.

> We should be really clear how applications are supposed to use the
> attributes_mask.  Does it mean that they will always be able to set a
> flag which is set in the attribute mask?  That can't be right, since
> there will be a number of flags that may have some more complex checks
> (you must be root, or the file must be zero length, etc.)  I'm a bit
> unclear about what are the useful ways in which an attribute_mask can
> be used by a userspace application --- and under what circumstances
> might an application be depending on the semantics of attribute_mask,
> so we don't accidentally give them an opportunity to complain and
> whine, thus opening ourselves to another O_PONIES controversy.

Hah, indeed.

Sorry if I've over-complicated this, I'm honestly just confused now.

-Eric
