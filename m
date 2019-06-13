Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 823534458E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfFMQor (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:44:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730411AbfFMGUs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 02:20:48 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 075ACC0A727863C1FC1C;
        Thu, 13 Jun 2019 14:20:46 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun
 2019 14:20:42 +0800
Subject: Re: [PATCH] f2fs: separate f2fs i_flags from fs_flags and ext4
 i_flags
To:     Eric Biggers <ebiggers@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-fsdevel@vger.kernel.org>
References: <20190605055904.4039-1-ebiggers@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <ac9370d1-82a2-bb8a-4d9d-fe2e763df789@huawei.com>
Date:   Thu, 13 Jun 2019 14:20:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190605055904.4039-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/6/5 13:59, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> f2fs copied all the on-disk i_flags from ext4, and along with it the
> assumption that the on-disk i_flags are the same as the bits used by
> FS_IOC_GETFLAGS and FS_IOC_SETFLAGS.  This is problematic because
> reserving an on-disk inode flag in either filesystem's i_flags or in
> these ioctls effectively reserves it in all the other places too.  In
> fact, most of the "f2fs i_flags" are not used by f2fs at all.
> 
> Fix this by separating f2fs's i_flags from the ioctl bits and ext4's
> i_flags.
> 
> In the process, un-reserve all "f2fs i_flags" that aren't actually
> supported by f2fs.  This included various flags that were not settable
> at all, as well as various flags that were settable by FS_IOC_SETFLAGS
> but didn't actually do anything.
> 
> There's a slight chance we'll need to add some flag(s) back to
> FS_IOC_SETFLAGS in order to avoid breaking users who expect f2fs to
> accept some random flag(s).  But hopefully such users don't exist.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good to me, thanks for cleaning all mess up. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

