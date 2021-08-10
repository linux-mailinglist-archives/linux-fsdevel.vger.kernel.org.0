Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70D23E50C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 03:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbhHJBv7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 21:51:59 -0400
Received: from mail-m17654.qiye.163.com ([59.111.176.54]:23616 "EHLO
        mail-m17654.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbhHJBv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 21:51:57 -0400
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Aug 2021 21:51:57 EDT
Received: from [172.25.44.145] (unknown [58.251.74.232])
        by mail-m17654.qiye.163.com (Hmail) with ESMTPA id A603E200D6;
        Tue, 10 Aug 2021 09:41:40 +0800 (CST)
Subject: Re: [PATCH v2] fuse: use newer inode info when writeback cache is
 enabled
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
References: <20210130085003.1392-1-changfengnan@vivo.com>
 <CAJfpegutK2HGYUtJOjvceULf2H=hoekNxUbcg=6Su6uteVmDLg@mail.gmail.com>
 <3e740389-9734-a959-a88a-3b1d54b59e22@vivo.com>
 <CAJfpegtes4CGM68Vj2GxmvK2S8D5sn4Pv_RKyXb33ye=pC+=cg@mail.gmail.com>
 <29a3623f-fb4d-2a2b-af28-26f9ef0b0764@vivo.com>
 <CAJfpeguErrcKc7CKjnp-uM9VMyUjrtjipv7KGSu5xeY9joOQxQ@mail.gmail.com>
From:   Fengnan Chang <changfengnan@vivo.com>
Message-ID: <c5982115-e62c-908c-8aac-011ca682f193@vivo.com>
Date:   Tue, 10 Aug 2021 09:41:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAJfpeguErrcKc7CKjnp-uM9VMyUjrtjipv7KGSu5xeY9joOQxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUMfHh1WQk1MTUxKHUkfSE
        4YVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6KRw6FT9CFy4KMkMjMANM
        OiwaCgtVSlVKTUlDTk5CTEtKSk9PVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WU5DVUlOSlVMT1VJSElZV1kIAVlBSElDTTcG
X-HM-Tid: 0a7b2db8f310d9fdkuwsa603e200d6
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove cache=always still have this problem, this problem is related 
about FUSE_CAP_WRITEBACK_CACHE.

On 2021/8/6 20:20, Miklos Szeredi wrote:
> On Thu, 24 Jun 2021 at 09:42, Fengnan Chang <changfengnan@vivo.com> wrote:
>>
>> Hi Miklos:
>>
>> Thank you for the information, I have been able to reproduce the problem.
>>
>> The new version of the patch as below. Previous fsx test is pass now.
>> Need do more test, Can you help to test new patch? or send me your test
>> case, I will test this.
>>
>> Here is my test case, and is the problem this patch is trying to solve.
>> Case A:
>> mkdir /tmp/test
>> passthrough_ll -ocache=always,writeback /mnt/test/
>> echo "11111" > /tmp/test/fsx
>> ls -l /mnt/test/tmp/test/
>> echo "2222" >> /tmp/test/fsx
>> ls -l /mnt/test/tmp/test/
>>
>> Case B:
>> mkdir /tmp/test
>> passthrough_ll -ocache=always,writeback /mnt/test/
>> passthrough_ll -ocache=always,writeback /mnt/test2/
>> echo "11111" > /tmp/test/fsx
>> ls -l /mnt/test/tmp/test/
>> ls -l /mnt/test2/tmp/test/
>> echo "222" >> /mnt/test/tmp/test/fsx
>> ls -l /mnt/test/tmp/test/
>> ls -l /mnt/test2/tmp/test/
> 
> Both these testcases have the "cache=always" option, which means:
> cached values (both data and metadata) are always valid; i.e. changes
> will be made only through this client and not through some other
> channel (like the backing filesystem or another instance).
> 
> Why is "cache=always" used?
> 
> Thanks,
> Miklos
> 
