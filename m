Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2B61EB2E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 03:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgFBBQn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 21:16:43 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18273 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725793AbgFBBQn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 21:16:43 -0400
X-IronPort-AV: E=Sophos;i="5.73,462,1583164800"; 
   d="scan'208";a="93611258"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Jun 2020 09:16:38 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 582184CE03C1;
        Tue,  2 Jun 2020 09:16:36 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 2 Jun 2020 09:16:36 +0800
Message-ID: <5ED5A871.4070101@cn.fujitsu.com>
Date:   Tue, 2 Jun 2020 09:16:33 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Jan Kara <jack@suse.cz>
CC:     Ira Weiny <ira.weiny@intel.com>, <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 6/8] fs/ext4: Make DAX mount option a tri-state
References: <20200521191313.261929-1-ira.weiny@intel.com> <20200521191313.261929-7-ira.weiny@intel.com> <5ECE00AE.3010802@cn.fujitsu.com> <20200527235002.GA725853@iweiny-DESK2.sc.intel.com> <5ECF7CD3.20409@cn.fujitsu.com> <20200528094144.GD14550@quack2.suse.cz>
In-Reply-To: <20200528094144.GD14550@quack2.suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 582184CE03C1.AA45D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/5/28 17:41, Jan Kara wrote:
> On Thu 28-05-20 16:56:51, Xiao Yang wrote:
>> On 2020/5/28 7:50, Ira Weiny wrote:
>>> On Wed, May 27, 2020 at 01:54:54PM +0800, Xiao Yang wrote:
>>>> On 2020/5/22 3:13, ira.weiny@intel.com wrote:
>>>>> From: Ira Weiny<ira.weiny@intel.com>
>>>>>
>>>>> We add 'always', 'never', and 'inode' (default).  '-o dax' continues to
>>>>> operate the same which is equivalent to 'always'.  This new
>>>>> functionality is limited to ext4 only.
>>>>>
>>>>> Specifically we introduce a 2nd DAX mount flag EXT4_MOUNT2_DAX_NEVER and set
>>>>> it and EXT4_MOUNT_DAX_ALWAYS appropriately for the mode.
>>>>>
>>>>> We also force EXT4_MOUNT2_DAX_NEVER if !CONFIG_FS_DAX.
>>>>>
>>>>> Finally, EXT4_MOUNT2_DAX_INODE is used solely to detect if the user
>>>>> specified that option for printing.
>>>> Hi Ira,
>>>>
>>>> I have two questions when reviewing this patch:
>>>> 1) After doing mount with the same dax=inode option, ext4/xfs shows
>>>> differnt output(i.e. xfs doesn't print 'dax=inode'):
>>>> ---------------------------------------------------
>>>> # mount -o dax=inode /dev/pmem0 /mnt/xfstests/test/
>>>> # mount | grep pmem0
>>>> /dev/pmem0 on /mnt/xfstests/test type ext4 (rw,relatime,seclabel,dax=inode)
>>>>
>>>> # mount -odax=inode /dev/pmem1 /mnt/xfstests/scratch/
>>>> # mount | grep pmem1
>>>> /dev/pmem1 on /mnt/xfstests/scratch type xfs
>>>> (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
>>>> ----------------------------------------------------
>>>> Is this expected output? why don't unify the output?
>>>
>>> Correct. dax=inode is the default.  xfs treats that default the same whether
>>> you specify it on the command line or not.
>>>
>>> For ext4 Jan specifically asked that if the user specified dax=inode on the
>>> command line that it be printed on the mount options.  If you don't specify
>>> anything then dax=inode is in effect but ext4 will not print anything.
>>>
>>> I had the behavior the same as XFS originally but Jan wanted it this way.  The
>>> XFS behavior is IMO better and is what the new mount infrastructure gives by
>>> default.
>>
>> Could we unify the output?  It is strange for me to use differnt output on
>> ext4 and xfs.
>
> If we'd unify the output with XFS, it would be inconsistent with all the
> other ext4 mount options. So I disagree with that. I agree it is not ideal
> to have different behavior between xfs and ext4 but such is the historical
> behavior. If we want to change that, we need to change the handling for all
> the ext4 mount options. I'm open for that discussion but it is a problem
> unrelated to this patch set.
Hi Jan,

Thanks for your quick feedback.
Of course, this doubt should not block the patch set.

Best Regards,
Xiao Yang
>
> 								Honza



