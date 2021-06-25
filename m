Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E523B3B4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 05:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhFYDpF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 23:45:05 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:57638 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbhFYDpF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 23:45:05 -0400
DKIM-Signature: a=rsa-sha256;
        b=FjNn0Fb7aKSIR601MkG0oeWOmZVvncq980T6C0wNJRKBCUU74lP8OIA/NSXoXniOM9bFIqqGRjVcMQdXT6vsFzsnzZYiiiooAbQPPyF5wuhfL+8hEdzxvoPRPxxLXfHJdokcZdpMtxXWRpptTNPw8cytdo+YKTwltszidi1/xDE=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=sGu7bTgsv5EmJRkR6M9pzmwc4cFpkWX6TPsMI4KaOVY=;
        h=date:mime-version:subject:message-id:from;
Received: from [172.25.44.145] (unknown [58.251.74.232])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 8275EAC0230;
        Fri, 25 Jun 2021 11:42:43 +0800 (CST)
Subject: Re: [PATCH v2] fuse: use newer inode info when writeback cache is
 enabled
From:   Fengnan Chang <changfengnan@vivo.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
References: <20210130085003.1392-1-changfengnan@vivo.com>
 <CAJfpegutK2HGYUtJOjvceULf2H=hoekNxUbcg=6Su6uteVmDLg@mail.gmail.com>
 <3e740389-9734-a959-a88a-3b1d54b59e22@vivo.com>
 <CAJfpegtes4CGM68Vj2GxmvK2S8D5sn4Pv_RKyXb33ye=pC+=cg@mail.gmail.com>
 <29a3623f-fb4d-2a2b-af28-26f9ef0b0764@vivo.com>
Message-ID: <7b20f5b0-51d7-7634-a495-f6da83c287e5@vivo.com>
Date:   Fri, 25 Jun 2021 11:42:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <29a3623f-fb4d-2a2b-af28-26f9ef0b0764@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQkJCTFYfGkxKHUJJSUNDHxlVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6Agw6Qz8MDDEMIRY#KTFO
        EzwwFDBVSlVKTUlPTkJJTk1IQkhIVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WU5DVUlOSlVMT1VJSElZV1kIAVlBT0NIQzcG
X-HM-Tid: 0a7a41433da0b039kuuu8275eac0230
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos:

FYI, I run xfstest on fuse, with linux 5.4.61 + patch, no new failure case.

On 2021/6/24 15:42, Fengnan Chang wrote:
> Hi Miklos:
> 
> Thank you for the information, I have been able to reproduce the problem.
> 
> The new version of the patch as below. Previous fsx test is pass now. 
> Need do more test, Can you help to test new patch? or send me your test 
> case, I will test this.
> 
> Here is my test case, and is the problem this patch is trying to solve.
> Case A:
> mkdir /tmp/test
> passthrough_ll -ocache=always,writeback /mnt/test/
> echo "11111" > /tmp/test/fsx
> ls -l /mnt/test/tmp/test/
> echo "2222" >> /tmp/test/fsx
> ls -l /mnt/test/tmp/test/
> 
> Case B:
> mkdir /tmp/test
> passthrough_ll -ocache=always,writeback /mnt/test/
> passthrough_ll -ocache=always,writeback /mnt/test2/
> echo "11111" > /tmp/test/fsx
> ls -l /mnt/test/tmp/test/
> ls -l /mnt/test2/tmp/test/
> echo "222" >> /mnt/test/tmp/test/fsx
> ls -l /mnt/test/tmp/test/
> ls -l /mnt/test2/tmp/test/
> 
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index b9beb39a4a18..8e22a31b55c4 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -60,6 +60,10 @@ MODULE_PARM_DESC(max_user_congthresh,
>   /** Congestion starts at 75% of maximum */
>   #define FUSE_DEFAULT_CONGESTION_THRESHOLD (FUSE_DEFAULT_MAX_BACKGROUND 
> * 3 / 4)
> 
> +static inline bool attr_newer_than_local(struct fuse_attr *attr, struct 
> inode *inode) {
> +    return (attr->mtime > inode->i_mtime.tv_sec)
> +               || ((attr->mtime == inode->i_mtime.tv_sec) && 
> (attr->mtimensec > inode->i_mtime.tv_nsec));
> +}
>   #ifdef CONFIG_BLOCK
>   static struct file_system_type fuseblk_fs_type;
>   #endif
> @@ -241,8 +245,10 @@ void fuse_change_attributes(struct inode *inode, 
> struct fuse_attr *attr,
>           * extend local i_size without keeping userspace server in 
> sync. So,
>           * attr->size coming from server can be stale. We cannot trust it.
>           */
> -       if (!is_wb || !S_ISREG(inode->i_mode))
> +       if (!is_wb || !S_ISREG(inode->i_mode)
> +               || (attr_newer_than_local(attr, inode) && 
> !inode_is_open_for_write(inode))) {
>                  i_size_write(inode, attr->size);
> +       }
>          spin_unlock(&fi->lock);
> 
>          if (!is_wb && S_ISREG(inode->i_mode)) {
> 
> On 2021/6/22 23:19, Miklos Szeredi wrote:
>> On Tue, 22 Jun 2021 at 14:25, Fengnan Chang <changfengnan@vivo.com> 
>> wrote:
>>>
>>> Unh, it seems i_writecount not work.
>>> If we modify file through lowerfs, i_writecount won't change, but the
>>> size already changed.
>>> For example:
>>> echo "111" > /lowerfs/test
>>> ls -l /upper/test
>>> echo "2222" >> /lowerfs/test
>>> ls -l /upper/test
>>>
>>> So, can you describe your test enviroment? including kernel version and
>>> fsx parameters, I will check it.
>>
>> linux-5.13-rc5 + patch
>> mkdir /tmp/test
>> libfuse/example/passthrough_ll -ocache=always,writeback /mnt/fuse/
>> fsx-linux -N 1000000 /mnt/fuse/tmp/test/fsx
>>
>> Thanks,
>> Miklos
>>
