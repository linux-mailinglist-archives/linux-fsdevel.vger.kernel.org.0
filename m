Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C92A2C5198
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 10:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgKZJs3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 04:48:29 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8125 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgKZJs3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:48:29 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ChXxd1PWwz15PXS;
        Thu, 26 Nov 2020 17:48:05 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 26 Nov 2020
 17:48:20 +0800
Subject: Re: [PATCH] fs: export vfs_stat() and vfs_fstatat()
To:     Christoph Hellwig <hch@lst.de>
References: <1606374948-38713-1-git-send-email-yangyicong@hisilicon.com>
 <20201126071848.GA17990@lst.de>
 <696f0e06-4f4d-0a61-6e13-f5af433594bf@hisilicon.com>
 <20201126091537.GA21957@lst.de>
CC:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <79b19660-f418-f5ac-943c-bc49a88eb949@hisilicon.com>
Date:   Thu, 26 Nov 2020 17:48:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201126091537.GA21957@lst.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/11/26 17:15, Christoph Hellwig wrote:
> On Thu, Nov 26, 2020 at 05:08:26PM +0800, Yicong Yang wrote:
>>> And why would you want to use them in kernel module?  Please explain
>>> that in the patch that exports them, and please send that patch in the
>>> same series as the patches adding the users.
>> we're using it in the modules for testing our crypto driver on our CI system.
>> is it mandatory to upstream it if we want to use this function?
> Yes.  And chances are that you do not actaully need these functions
> either, but to suggest a better placement I need to actually see the
> code.
> .

Sorry for not describing the issues I met correctly in the commit message.
Actually we're using inline function vfs_stat() for getting the
attributes, which calls vfs_fstatat():

static inline int vfs_stat(const char __user *filename, struct kstat *stat)
{
	return vfs_fstatat(AT_FDCWD, filename, stat, 0);
}

after the vfs_fstatat is out-of-line it will make the moduler user of vfs_stat()
broken:

[ 5328.903677] crypto_zip_perf_test: Unknown symbol vfs_fstatat (err -2)

so the simplest way i think is directly export the vfs_fstatat().

Thanks,
Yicong




>

