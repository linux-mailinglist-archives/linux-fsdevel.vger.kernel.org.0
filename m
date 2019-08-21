Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A610696EF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 03:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfHUBeN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 21:34:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4741 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbfHUBeN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:34:13 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7E40CECFBE302ADD17A5;
        Wed, 21 Aug 2019 09:34:10 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 21 Aug
 2019 09:34:04 +0800
Subject: Re: [PATCH] erofs: move erofs out of staging
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Gao Xiang <hsiangkao@aol.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Jaegeuk Kim" <jaegeuk@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Li Guifu" <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, "Pavel Machek" <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>
References: <20190818161638.GE1118@sol.localdomain>
 <20190818162201.GA16269@infradead.org>
 <20190818172938.GA14413@sol.localdomain>
 <20190818174702.GA17633@infradead.org>
 <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190819160923.GG15198@magnolia>
 <20190819203051.GA10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
 <ad62636f-ef1b-739f-42cc-28d9d7ed86da@huawei.com>
 <20190820155623.GA10232@mit.edu>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9d8f88ee-4b81-bdfa-b0d7-9c7d5d54e70a@huawei.com>
Date:   Wed, 21 Aug 2019 09:34:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190820155623.GA10232@mit.edu>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/8/20 23:56, Theodore Y. Ts'o wrote:
> The reason why there needs to be at least some file system specific
> code for fuzz testing is because for efficiency's sake, you don't want
> to fuzz every single bit in the file system, but just the ones which
> are most interesting (e.g., the metadata blocks).  For file systems
> which use checksum to protect against accidental corruption, the file
> system fuzzer needs to also fix up the checksums (since you can be
> sure malicious attackers will do this).

Yup, IMO, if we really want such tool, it needs to:
- move all generic fuzz codes (trigger random fuzzing in meta/data area) into
that tool, and
- make filesystem generic fs_meta/file_node lookup/inject/pack function as a
callback, such as
 * .find_fs_sb
 * .inject_fs_sb
 * .pack_fs_sb
 * .find_fs_bitmap
 * .inject_fs_bitmap
 * .find_fs_inode_bitmap
 * .inject_fs_inode_bitmap
 * .find_inode_by_num
 * .inject_inode
 * .pack_inode
 * .find_tree_node_by_level
...
then specific filesystem can fill the callback to tell how the tool can locate a
field in inode or a metadata in tree node and then trigger the designed fuzz.

It will be easier to rewrite whole generic fwk for each filesystem, because
existed filesystem userspace tool should has included above callback's detail
codes...

> On Tue, Aug 20, 2019 at 10:24:11AM +0800, Chao Yu wrote:
>> filesystem fill the tool's callback to seek a node/block and supported fields
>> can be fuzzed in inode.

> 
> What you *can* do is to make the file system specific portion of the
> work as small as possible.  Great work in this area is Professor Kim's
> Janus[1][2] and Hydra[2] work.  (Hydra is about to be published at SOSP 19,
> and was partially funded from a Google Faculty Research Work.)
> 
> [1] https://taesoo.kim/pubs/2019/xu:janus.pdf
> [2] https://github.com/sslab-gatech/janus
> [3] https://github.com/sslab-gatech/hydra

Thanks for the information!

It looks like janus and hydra alreay have generic compress/decompress function
across different filesystems, it's really a good job, I do think it may be the
one once it becomes more generic.

Thanks

> 
