Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038F043F8F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 10:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhJ2Ifi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 04:35:38 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:60746 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232413AbhJ2Ifh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:35:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Uu6a2.v_1635496386;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Uu6a2.v_1635496386)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 Oct 2021 16:33:07 +0800
Subject: Re: [PATCH v6 2/7] fuse: make DAX mount option a tri-state
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hub,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
 <20211011030052.98923-3-jefflexu@linux.alibaba.com>
 <YW2AU/E0pLHO5Yl8@redhat.com>
 <652ac323-6546-01b8-992e-460ad59577ca@linux.alibaba.com>
 <YXAsV3xp3aeOjaeh@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <eb0c9711-66cb-bf79-0cf6-c6d6eec5ceea@linux.alibaba.com>
Date:   Fri, 29 Oct 2021 16:33:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YXAsV3xp3aeOjaeh@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/20/21 10:48 PM, Vivek Goyal wrote:
> On Wed, Oct 20, 2021 at 10:52:38AM +0800, JeffleXu wrote:
>>
>>
>> On 10/18/21 10:10 PM, Vivek Goyal wrote:
>>> On Mon, Oct 11, 2021 at 11:00:47AM +0800, Jeffle Xu wrote:
>>>> We add 'always', 'never', and 'inode' (default). '-o dax' continues to
>>>> operate the same which is equivalent to 'always'. To be consistemt with
>>>> ext4/xfs's tri-state mount option, when neither '-o dax' nor '-o dax='
>>>> option is specified, the default behaviour is equal to 'inode'.
>>>
>>> Hi Jeffle,
>>>
>>> I am not sure when  -o "dax=inode"  is used as a default? If user
>>> specifies, "-o dax" then it is equal to "-o dax=always", otherwise
>>> user will explicitly specify "-o dax=always/never/inode". So when
>>> is dax=inode is used as default?
>>
>> That means when neither '-o dax' nor '-o dax=always/never/inode' is
>> specified, it is actually equal to '-o dax=inode', which is also how
>> per-file DAX on ext4/xfs works.
>>
>> This default behaviour for local filesystem, e.g. ext4/xfs, may be
>> straightforward, since the disk inode will be read into memory during
>> the inode instantiation, and checking for persistent inode attribute
>> shall be realatively cheap, except that the default behaviour has
>> changed from 'dax=never' to 'dax=inode'.
> 
> Interesting that ext4/xfs allowed for this behavior change.
> 
>>
>> Come back to virtiofs, when neither '-o dax' nor '-o
>> dax=always/never/inode' is specified, and it actually behaves as '-o
>> dax=inode', as long as '-o dax=server/attr' option is not specified for
>> virtiofsd, virtiofsd will always clear FUSE_ATTR_DAX and thus guest will
>> always disable DAX. IOWs, the guest virtiofs atually behaves as '-o
>> dax=never' when neither '-o dax' nor '-o dax=always/never/inode' is
>> specified, and '-o dax=server/attr' option is not specified for virtiofsd.
>>
>> But I'm okay if we need to change the default behaviour for virtiofs.
> 
> This is change of behavior from client's perspective. Even if client
> did not opt-in for DAX, DAX can be enabled based on server's setting.
> Not that there is anything wrong with it, but change of behavior part
> concerns me.
> 
> In case of virtiofs, lot of features we are controlling from server.
> Client typically just calls "mount" and there are not many options
> users can specify for mount.  
> 
> Given we already allowed to make client a choice about DAX behavior,
> I will feel more comfortable that we don't change it and let client
> request a specific DAX mode and if client does not specify anything,
> then DAX is not enabled.
> 

Hi Vivek,

How about the following design about the default behavior to move this
patchset forward, considering the discussion on another thread [1]?

- guest side: '-o dax=inode' acts as the default, keeping consistent
with xfs/ext4
- virtiofsd: the default behavior is like, neither file size based
policy ('dax=server') nor persistent inode flags based policy
('dax=attr') is used, though virtiofsd indeed advertises that
it supports per inode DAX feature (so that it won't fail FUSE_INIT
negotiation phase when guest advertises dax=inode by default)... In
fact, it acts like 'dax=never' in this case.

Then when guest opts-in and specifies '-o dax=inode' manually, then it
shall realize that proper configuration for virtiofsd is also needed (-o
dax=server|attr).

[1] https://www.spinics.net/lists/linux-xfs/msg56642.html

-- 
Thanks,
Jeffle
