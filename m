Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996A641A6FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 07:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhI1FTN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 01:19:13 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:46485 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233681AbhI1FTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 01:19:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UpuW07A_1632806247;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UpuW07A_1632806247)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Sep 2021 13:17:28 +0800
Subject: Re: [PATCH v5 2/5] fuse: make DAX mount option a tri-state
To:     Dave Chinner <david@fromorbit.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, stefanha@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, bo.liu@linux.alibaba.com,
        joseph.qi@linux.alibaba.com
References: <20210923092526.72341-1-jefflexu@linux.alibaba.com>
 <20210923092526.72341-3-jefflexu@linux.alibaba.com>
 <YUzPUYU8R5LL4mzU@redhat.com> <20210923222618.GB2361455@dread.disaster.area>
 <YU0jovIYv+xeinQd@redhat.com> <20210927002148.GH2361455@dread.disaster.area>
 <a8224842-7e05-c3fd-7413-5f425e099251@linux.alibaba.com>
 <20210928034453.GJ2361455@dread.disaster.area>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <93d817b2-01a4-6e83-cb0b-ca84f67f3d95@linux.alibaba.com>
Date:   Tue, 28 Sep 2021 13:17:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928034453.GJ2361455@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/28/21 11:44 AM, Dave Chinner wrote:
> On Mon, Sep 27, 2021 at 10:28:34AM +0800, JeffleXu wrote:
>> On 9/27/21 8:21 AM, Dave Chinner wrote:
>>> On Thu, Sep 23, 2021 at 09:02:26PM -0400, Vivek Goyal wrote:
>>>> On Fri, Sep 24, 2021 at 08:26:18AM +1000, Dave Chinner wrote:
>>>>> On Thu, Sep 23, 2021 at 03:02:41PM -0400, Vivek Goyal wrote:
>>> In the case that the user changes FS_XFLAG_DAX, the FUSE client
>>> needs to communicate that attribute change to the server, where the
>>> server then changes the persistent state of the on-disk inode so
>>> that the next time the client requests that inode, it gets the state
>>> it previously set. Unless, of course, there are server side policy
>>> overrides (never/always).
>>
>> One thing I'm concerned with is that, is the following behavior
>> consistent with the semantics of per-file DAX in ext4/xfs?
>>
>> Client changes FS_XFLAG_DAX, this change is communicated to server and
>> then server also returns **success**. Then client finds that this file
>> is not DAX enabled, since server doesn't honor the previously set state.
> 
> FS_XFLAG_DAX is advisory in nature - it does not have to be honored
> at inode instantiation.

Fine.

> 
>> IOWs, shall server always honor the persistent per-inode attribute of
>> host file (if the change of FS_XFLAG_DAX inside guest is stored as
>> persistent per-inode attribute on host file)?
> 
> If the user set the flag, then queries it, the server should be
> returning the state that the user set, regardless of whether it is
> being honored at inode instantiation time.
> 
> Remember, FS_XFLAG_DAX does not imply S_DAX and vice versa
Got it.

> 
>>>> Not sure what do you mean by server turns of DAX flag based on client
>>>> turning off DAX. Server does not have to do anything. If client decides
>>>> to not use DAX (in guest), it will not send FUSE_SETUPMAPPING requests
>>>> to server and that's it.
>>>
>>> Where does the client get it's per-inode DAX policy from if
>>> dax=inode is, like other DAX filesystems, the default behaviour?
>>>
>>> Where is the persistent storage of that per-inode attribute kept?
>>
>> In the latest patch set, it is not supported yet to change FS_XFLAG_DAX
>> (and thus setting/clearing persistent per-inode attribute) inside guest,
>> since this scenario is not urgently needed as the real using case.
> 
> AFAICT the FS_IOC_FS{GS}ETXATTR ioctl is already supported by the
> fuse client and it sends the ioctl to the server. Hence the client
> should already support persistent FS_XFLAG_DAX manipulations
> regardless of where/how the attribute is stored by the server. Did
> you actually add code to the client in this patchset to stop
> FS_XFLAG_DAX from being propagated to the server?

Yes fuse client supports FS_IOC_FS{GS}ETXATTR ioctl already, but AFAIK
"passthrough" type virtiofsd doesn't support FUSE_IOCTL yet. My previous
patch had ever added support for FUSE_IOCTL to virtiofsd.

> 
>> Currently the per-inode dax attribute is completely fed from server
>> thourgh FUSE protocol, e.g. server could set/clear the per-inode dax
>> attribute depending on the file size.
> 
> Yup, that's a policy dax=inode on the client side would allow.
> Indeed, this same policy could also be implemented as a client side
> policy, allowing user control instead of admin control of such
> conditional DAX behaviour... :)
> 
>> The previous path set indeed had ever supported changing FS_XFLAG_DAX
>> and accordingly setting/clearing persistent per-inode attribute inside
>> guest. For "passthrough" type virtiofsd, the persistent per-inode
>> attribute is stored as XFS_DIFLAG2_DAX/EXT4_DAX_FL on host file
>> directly, since this is what "passthrough" means.
> 
> Right, but that's server side storage implementation details, not a
> protocol or client side detail. What I can't find in the current
> client is where this per-inode flag is actually used in the FUSE dax
> inode init path - it just checks whether the connection has DAX
> state set up. Hence I don't see how FS_XFLAG_DAX control from the
> client currently has any influence on the client side DAX usage.

Fuse client fetches the per-inode DAX attribute from
fuse_entry_out.attr.flags of FUSE_LOOKUP reply. It's implemented in
patch 4 of this patch set.

The background info is that, fuse client will send a FUSE_LOOKUP request
to server during inode instantiation, while FS_XFLAG_DAX flag is not
included in the FUSE_LOOKUP reply, and thus fuse client need to send
another FUSE_IOCTL if it wants to query the persistent inode flags. To
remove this extra fuse request during inode instantiation, this flag is
merged into FUSE_LOOKUP reply (fuse_entry_out.attr.flags) as
FUSE_ATTR_DAX. Then if FUSE_ATTR_DAX flag is set in
fuse_entry_out.attr.flags, then fuse client knows that this file shall
be DAX enabled.

IOWs, under this mechanism it relies on fuse server to check persistent
inode flags on host, and then set FUSE_ATTR_DAX flag accordingly.

> 
> Seems somewhat crazy to me explicitly want to remove that client
> side control of per-inode behaviour whilst adding the missing client
> side bits that allow for the per-inode policy control from server
> side.  Can we please just start with the common, compatible
> dax=inode behaviour on the client side, then layer the server side
> policy control options over the top of that?


Hi Vivek,

It seems that we shall also support setting/clearing FS_XFLAG_DAX inside
guest? If that's the case, then how to design virtiofsd behavior? I
mean, is it mandatory or optional for virtiofsd to query FS_XFLAG_DAX of
host files when guest is mounted with "dax=inode"? If it's optional,
then the performance may be better since it doesn't need to do one extra
FS_IOC_FSGETXATTR ioctl when handling FUSE_LOOKUP, but admin needs to
specify "-o policy=flag" to virtiofsd explicitly if it's really needed.

-- 
Thanks,
Jeffle
