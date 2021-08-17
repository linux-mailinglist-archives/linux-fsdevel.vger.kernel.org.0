Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D563EF2BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 21:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhHQTnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 15:43:08 -0400
Received: from smtp-31.italiaonline.it ([213.209.10.31]:51650 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229466AbhHQTnI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:08 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Aug 2021 15:43:08 EDT
Received: from venice.bhome ([78.12.137.210])
        by smtp-31.iol.local with ESMTPA
        id G4qrm9LH4zHnRG4qrmlMpj; Tue, 17 Aug 2021 21:34:23 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1629228863; bh=P8Bf7iShNr/xT9K0oV4cNJLSntwJxtiESn39U6hdWdA=;
        h=From;
        b=pSy0oaZUMvxOgoLEUsiXBzEnid6+HuuPoRQ+I46JmLee5b6T0MThN6MWfUoTEHMSd
         UqxziNGQrm39yPgNxlA5U55xweEiY4QUQdwYM8jzPEj/Eq04umFesQc+b+QLEA+uA9
         sTQwhnK2OpSbjUdxPdjloCqprqny3em2DxkiSROBS3MbreMnCF+n5Ge3qWxtDG3Hq3
         nAwIJy14mQnKkUEdG8h0cXBidXhbvBBQ7sms7YJc7yogwD8jMWJ9Z4FNg3Lv21vVbK
         YU/yFPyaqnRULeaX+hU60FoveQbt2zFqhJjNsJUA9zFGFlPGG+G7SIs9vVXe5l+cxQ
         eCjjeVDFU6s9A==
X-CNFS-Analysis: v=2.4 cv=L6DY/8f8 c=1 sm=1 tr=0 ts=611c0f3f cx=a_exe
 a=VHyfYjYfg3XpWvNRQl5wtg==:117 a=VHyfYjYfg3XpWvNRQl5wtg==:17
 a=IkcTkHD0fZMA:10 a=OLL_FvSJAAAA:8 a=VwQbUJbxAAAA:8 a=Uq0mbvy6AAAA:8
 a=zCpshGh_ssoCxRdNTxgA:9 a=QEXdDO2ut3YA:10 a=sB6geW_GkGoA:10
 a=05sTH6Zuzt8A:10 a=oIrB72frpwYPwTMnlWqB:22 a=AjGcO6oz07-iQ99wixmX:22
 a=9nAYT2xhiIK_ZOnRzmc7:22
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for
 btrfs export
To:     NeilBrown <neilb@suse.de>
Cc:     Roman Mamedov <rm@romanrm.net>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>
 <bf49ef31-0c86-62c8-7862-719935764036@libero.it>
 <20210816003505.7b3e9861@natsu>
 <ee167ffe-ad11-ea95-1bd5-c43f273b345a@libero.it>
 <162906443866.1695.6446438554332029261@noble.neil.brown.name>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <d8d67284-8d53-ed97-f387-81b27d17fdde@inwind.it>
Date:   Tue, 17 Aug 2021 21:34:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <162906443866.1695.6446438554332029261@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNHNrf4IYCWcGwhX6Geb+6AwQdOH139eW9m8BTSMYbkNL2hzyyud3j95cc8QctQqtEoi/ukmD4IGnEcQy2Z/HxYE9rD3WVsT58f6+dkFg4B06DvfRWLk
 LVufdmdYw47SkCTDJnxGxuwTnCtKDknFEwFB9dAu9XQhQsnGbLG3ZXEN8gxarJNnLjRJjITKgBuaaFzTa8awyJDy//2PE6P7l3CjglABYVEWu8/LCWzRJBmx
 Sq2DjytlDU6ksnt19HIknBtdhUoOX43AoHI+RfWf6PKEpB4hl0JAJG8zd7aPa7T8jxiK4KlX5PUdlTh2uizg1unUOXnfKgkQpO1kxx14jEl14LDbjKkyWM4r
 8l44/JP9YRHlTEvDXxhXXIGH/6/7YpVasoKS0eID4CM4Pl9rEg8SLmkmIYFiuKprowYifLVjLNjKvbalTEBPJuW0RMlqtx6zlLu4kI3tq2936Zo4UWYVomFB
 ferV6cPR/HmnyiZkKqhhQa2PNZBhBsNkooSJsb8HrFHAtYoPaEQDjTdvfow=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/15/21 11:53 PM, NeilBrown wrote:
> On Mon, 16 Aug 2021, kreijack@inwind.it wrote:
>> On 8/15/21 9:35 PM, Roman Mamedov wrote:
>>> On Sun, 15 Aug 2021 09:39:08 +0200
>>> Goffredo Baroncelli <kreijack@libero.it> wrote:
>>>
>>>> I am sure that it was discussed already but I was unable to find any track
>>>> of this discussion. But if the problem is the collision between the inode
>>>> number of different subvolume in the nfd export, is it simpler if the export
>>>> is truncated to the subvolume boundary ? It would be more coherent with the
>>>> current behavior of vfs+nfsd.
>>>
>>> See this bugreport thread which started it all:
>>> https://www.spinics.net/lists/linux-btrfs/msg111172.html
>>>
>>> In there the reporting user replied that it is strongly not feasible for them
>>> to export each individual snapshot.
>>
>> Thanks for pointing that.
>>
>> However looking at the 'exports' man page, it seems that NFS has already an
>> option to cover these cases: 'crossmnt'.
>>
>> If NFSd detects a "child" filesystem (i.e. a filesystem mounted inside an already
>> exported one) and the "parent" filesystem is marked as 'crossmnt',  the client mount
>> the parent AND the child filesystem with two separate mounts, so there is not problem of inode collision.
> 
> As you acknowledged, you haven't read the whole back-story.  Maybe you
> should.
> 
> https://lore.kernel.org/linux-nfs/20210613115313.BC59.409509F4@e16-tech.com/
> https://lore.kernel.org/linux-nfs/162848123483.25823.15844774651164477866.stgit@noble.brown/
> https://lore.kernel.org/linux-btrfs/162742539595.32498.13687924366155737575.stgit@noble.brown/
> 
> The flow of conversation does sometimes jump between threads.
> 
> I'm very happy to respond you questions after you've absorbed all that.

Hi Neil,

I read the other threads. And I still have the opinion that the nfsd crossmnt behavior should be a good solution for the btrfs subvolumes.
> 
> NeilBrown
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
