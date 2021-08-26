Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A683F884A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 15:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhHZNGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 09:06:03 -0400
Received: from sandeen.net ([63.231.237.45]:42942 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhHZNGC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:06:02 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 901597BD8;
        Thu, 26 Aug 2021 08:04:53 -0500 (CDT)
To:     Matthew Wilcox <willy@infradead.org>,
        Roberto Bergantinos Corpas <rbergant@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
References: <20210721113057.993344-1-rbergant@redhat.com>
 <YSeNNnNBW7ceLuh+@casper.infradead.org>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH] vfs: parse sloppy mount option in correct order
Message-ID: <a5873099-a803-3cfa-118f-0615e7a65130@sandeen.net>
Date:   Thu, 26 Aug 2021 08:05:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSeNNnNBW7ceLuh+@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/26/21 7:46 AM, Matthew Wilcox wrote:
> On Wed, Jul 21, 2021 at 01:30:57PM +0200, Roberto Bergantinos Corpas wrote:
>> With addition of fs_context support, options string is parsed
>> sequentially, if 'sloppy' option is not leftmost one, we may
>> return ENOPARAM to userland if a non-valid option preceeds sloopy
>> and mount will fail :
>>
>> host# mount -o quota,sloppy 172.23.1.225:/share /mnt
>> mount.nfs: an incorrect mount option was specified
>> host# mount -o sloppy,quota 172.23.1.225:/share /mnt
> 
> It isn't clear to me that this is incorrect behaviour.  Perhaps the user
> actually wants the options to the left parsed strictly and the options
> to the right parsed sloppily?

I don't think mount options have ever been order-dependent, at least not
intentionally so, have they?

And what matters most here is surely "how did it work before the mount
API change?"

And it seems to me that previously, invalid options were noted, and whether the
mount would fail was left to the end, depending on whether sloppy was seen
anywhere in the mount options string.  This is the old option parsing:

         while ((p = strsep(&raw, ",")) != NULL) {
...
                 switch (token) {
...
                 case Opt_sloppy:
                         sloppy = 1;
                         dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
                         break;
...
                 default:
                         invalid_option = 1;
                         dfprintk(MOUNT, "NFS:   unrecognized mount option "
                                         "'%s'\n", p);
                 }
         }

         if (!sloppy && invalid_option)
                 return 0;

-Eric
