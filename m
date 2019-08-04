Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D78B480A27
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2019 11:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfHDJmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Aug 2019 05:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfHDJmR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Aug 2019 05:42:17 -0400
Received: from [192.168.0.101] (unknown [180.111.32.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A5C02070D;
        Sun,  4 Aug 2019 09:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564911736;
        bh=eHZ3LbVmL56YmqVlqrvOvSSJqzheWzSMhiY9l05NP2o=;
        h=From:Subject:To:References:Date:In-Reply-To:From;
        b=cLRH8T6ZTkrZK5qS1nnzFT8DjeL2x+uywKyjzjXJH2irPLsvRPe4dqQc6Tk1XuxHC
         6Y7KEfgh9+Y+tAVpgnfmZoe7NCQJeOKo/g4Y1DJ1F/afQry2WGDSwmae1pj6bLGNCO
         QJsggE08iTcD2KYJ7TcVNyDvJjt5HHfWLe/X0wDI=
From:   Chao Yu <chao@kernel.org>
Subject: [f2fs-dev] [PATCH v7 14/16] f2fs: wire up new fscrypt ioctls
To:     Chao Yu <yuchao0@huawei.com>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-15-ebiggers@kernel.org>
 <e3cf53a7-faf2-0321-22de-07d2e2783752@huawei.com>
 <20190802173148.GA51937@gmail.com>
Message-ID: <88479efb-6625-8778-f802-e159ec60a374@kernel.org>
Date:   Sun, 4 Aug 2019 17:42:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190802173148.GA51937@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-8-3 1:31, Eric Biggers wrote:
> On Fri, Aug 02, 2019 at 04:10:15PM +0800, Chao Yu wrote:
>> Hi Eric,
>>
>> On 2019/7/27 6:41, Eric Biggers wrote:
>>> From: Eric Biggers <ebiggers@google.com>
>>>
>>> Wire up the new ioctls for adding and removing fscrypt keys to/from the
>>> filesystem, and the new ioctl for retrieving v2 encryption policies.
>>>
>>> FS_IOC_REMOVE_ENCRYPTION_KEY also required making f2fs_drop_inode() call
>>> fscrypt_drop_inode().
>>>
>>> For more details see Documentation/filesystems/fscrypt.rst and the
>>> fscrypt patches that added the implementation of these ioctls.
>>>
>>> Signed-off-by: Eric Biggers <ebiggers@google.com>
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>> BTW, do you think it needs to make xxfs_has_support_encrypt() function be a
>> common interface defined in struct fscrypt_operations, as I see all
>> fscrypt_ioctl_*() needs to check with it, tho such cleanup is minor...
>>
> 
> Maybe.  It would work nicely for ext4 and f2fs, but ubifs does things
> differently since it automatically enables the encryption feature if needed.
> So we'd have to make the callback optional.

Correct, ubifs can leave the callback as NULL function pointer.

> 
> In any case, I think this should be separate from this patchset.

Yup, it can be done in a separated patch if need.

Thanks,

> 
> - Eric
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
