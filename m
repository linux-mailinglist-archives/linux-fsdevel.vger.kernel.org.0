Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E163B0449
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhFVM1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:27:35 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:47640 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhFVM1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:27:32 -0400
DKIM-Signature: a=rsa-sha256;
        b=cvAf4iVjM2lX58rufT0Ljkzs53iairvQFR5fR3PrSoVbG+MxK5bBYHw8BRYAGfhAl5FdhhUkitL1OXAa73VHPPMqzyN0mR4EDyCupbZRQlyjCcxj/jKG5QtB3yCzgL3SE8Smez6NilrvjQGt+wvZ/5SKPZMuH+qahH0XYZv/vuc=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=EU5S1WPiblJSADqUm9fIJBjK6VEkY0WtsaZ1+glDnQM=;
        h=date:mime-version:subject:message-id:from;
Received: from [172.25.44.145] (unknown [58.251.74.232])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 598B9AC020C;
        Tue, 22 Jun 2021 20:25:12 +0800 (CST)
Subject: Re: [PATCH v2] fuse: use newer inode info when writeback cache is
 enabled
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
References: <20210130085003.1392-1-changfengnan@vivo.com>
 <CAJfpegutK2HGYUtJOjvceULf2H=hoekNxUbcg=6Su6uteVmDLg@mail.gmail.com>
From:   Fengnan Chang <changfengnan@vivo.com>
Message-ID: <3e740389-9734-a959-a88a-3b1d54b59e22@vivo.com>
Date:   Tue, 22 Jun 2021 20:25:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegutK2HGYUtJOjvceULf2H=hoekNxUbcg=6Su6uteVmDLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQkJITFZMHUgfTh0aTx4ZGE9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBw6Dyo5Lz8CTT4vPQ8tTzYx
        IzVPChNVSlVKTUlPSE1PTEpJTEhDVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WU5DVUlOSlVMT1VJSElZV1kIAVlBSU1MSjcG
X-HM-Tid: 0a7a33ae81feb039kuuu598b9ac020c
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unh, it seems i_writecount not work.
If we modify file through lowerfs, i_writecount won't change, but the 
size already changed.
For example:
echo "111" > /lowerfs/test
ls -l /upper/test
echo "2222" >> /lowerfs/test
ls -l /upper/test

So, can you describe your test enviroment? including kernel version and 
fsx parameters, I will check it.

Thanks.

On 2021/6/22 15:59, Miklos Szeredi wrote:
> On Sat, 30 Jan 2021 at 09:50, Fengnan Chang <changfengnan@vivo.com> wrote:
>>
>> When writeback cache is enabled, the inode information in cached is
>> considered new by default, and the inode information of lowerfs is
>> stale.
>> When a lower fs is mount in a different directory through different
>> connection, for example PATHA and PATHB, since writeback cache is
>> enabled by default, when the file is modified through PATHA, viewing the
>> same file from the PATHB, PATHB will think that cached inode is newer
>> than lowerfs, resulting in file size and time from under PATHA and PATHB
>> is inconsistent.
>> Add a judgment condition to check whether to use the info in the cache
>> according to mtime.
> 
> This seems to break the fsx-linux stress test.
> 
> I suspect a better direction would be looking at whether the inode has
> any files open for write (i_writecount > 0)...
> 
> Thanks,
> Miklos
> 
