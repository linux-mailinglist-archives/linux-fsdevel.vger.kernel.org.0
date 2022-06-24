Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE418559AC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 15:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiFXN5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 09:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiFXN5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:57:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192314D620;
        Fri, 24 Jun 2022 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656079022;
        bh=r0MaBQlHinmqnGDGTmFiEj78Fo8p+iOCL6h0Z28ZnnI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EYIr21HMcbAdYkvFQSql3bP+Wf6SIFuLQagUDNEQzzvPL+BqwC75tArpz4L/wjrM8
         Xmk+33ZXgpmEm5WSd/1No2HvzafcEA5S0cHIbbu1lRYB8y4VyC7fY/TwNPHQliY+6V
         w5mw261ZgJV6M4I/1akf5ynTquTYRHVDhzTUTIYE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNbp3-1oKMsf0TBz-00P9q3; Fri, 24
 Jun 2022 15:57:02 +0200
Message-ID: <568f1582-3ff2-aae5-cd98-cf76172d89cb@gmx.com>
Date:   Fri, 24 Jun 2022 21:56:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220624122334.80603-1-hch@lst.de>
 <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com> <20220624125118.GA789@lst.de>
 <20220624130750.cu26nnm6hjrru4zd@quack3.lan>
 <1b37cfc6-7369-69c1-bd90-5851cc79960d@gmx.com>
 <20220624134041.ktqj3af7lysaszrc@quack3.lan>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220624134041.ktqj3af7lysaszrc@quack3.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mYkgCA3IY86Q6jbvGgswMOOV/5XIWBNhBDspBM4bZKcUIPfUCch
 AsgIjXMndkDc+9NUlGu749XIkqGRtMCHv+2Qc5WBk/tq71WNI5f16tkaZhIDn1E//5AAZcl
 GWYR3Ef93myRz8uOWxZyLsjcnAcCg13Du4mGIYsGbmKcePvU1FyirUDqhfGxfUPNWlotUyE
 5cxkrebvd5fsvQ5mFPa3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AsOwb6571Dk=:rzf2d7alKj49kbsz0Y09+E
 HaJHkInMD5LjXBAkaCf9rPrSfveOqxNwQFe91pmwTZNeiMKd16Mf2qVXkC1rm89XcpHSr5V3r
 LgIoBKOqFDYekIEG2jaI/iOGPQKgZ/tD1CeOWEazhq76nUk8hVInbUY7+/G+vQ8Ghn6mGMhIQ
 2raIEvMzHv2VzAkv9r9IhMsWYEB1UyZlv3GcLBYNGNsIYdeTBH9jRt3k6wyJDKcCx+0HOzblu
 +VcnxQjtxGppKk7pQlhpd+si+WHKvlP9SBnBoViUkpMl+GSMILIttEzxcuuO9xZcVtPYjTVo0
 SwXPcyEkc61fk/p+xoNYcd8dRw518R+X9jbeI6Sc0aHFRbaJ069Eiae3sZ8mmCLDd3uDY5k8a
 IWM8PqNxxH21MVjbOwVlveBhHP/OpK30XWRzm6VHciSByuVa8JmBxXM8ibCm3A8vx08h8cokn
 KSKINKopxxCOV2KjYQk1yuDIAgFQOVDGFiPJSZaEKEzWTJFMInbeeD+rJ9XltLqIvXibjoPGD
 aG9scVt3ow8LNcHxHW8SrHXjPXIuEt2hsUu6RfRaVN6DEMAFP6+o3H9quKyGRbTY74qdTpqSe
 iWdP3CmCWTnYeiHl4ewprabxzvPMfvPnTOGPwsErqAsrLbRpHmoYuLItqvRC2Ys3AkYY+WpTx
 YM6j+jNY3bMASNhXwFX3CcTCG7xM9EXhuDV1jXcx1HsLDw8O/TS9CUiLPdJ7q33B2tmCRG2SZ
 13u0nf94S/SP+4E0A5LyplyDZHepwTy1lL3yE2xpE12f0ZttQQGVT3w9XM98ecxb2hW+oBl/U
 95sRnGyCj0lMyglDIWNMAMVHidVJfAO8KEO3BQ+v20MpVCd3HGml97bosl2Nc7HPqm6hw5i8i
 k0lapiMdMgFVe5v7UXCGFWAlAOv1/t9PhmVBpbvzp5sNP0G2zY+ItcqTvL6T4lRo2Rcho+Gd+
 mc2HFvCBXX4P3Ic1EXWikPcycGz3UbGM3d7oV5ERza0WmAQCDo0nLfvRKhSS6MD0z4GLpskUs
 1tdO85EIBTTSqKB2yjlqcZjEUkt3dGWHegMzo4mc4rqwpBA5QbbqwoEwouruJl6r8JiN/8Q9s
 EFiP5KxR6Oryc6FcytaN8IGFeX2T4iMzUZ2KrowG9fJD1eMk20xRG5FnQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/6/24 21:40, Jan Kara wrote:
> On Fri 24-06-22 21:19:04, Qu Wenruo wrote:
>>
>>
>> On 2022/6/24 21:07, Jan Kara wrote:
>>> On Fri 24-06-22 14:51:18, Christoph Hellwig wrote:
>>>> On Fri, Jun 24, 2022 at 08:30:00PM +0800, Qu Wenruo wrote:
>>>>> But from my previous feedback on subpage code, it looks like it's so=
me
>>>>> hardware archs (S390?) that can not do page flags update atomically.
>>>>>
>>>>> I have tested similar thing, with extra ASSERT() to make sure the co=
w
>>>>> fixup code never get triggered.
>>>>>
>>>>> At least for x86_64 and aarch64 it's OK here.
>>>>>
>>>>> So I hope this time we can get a concrete reason on why we need the
>>>>> extra page Private2 bit in the first place.
>>>>
>>>> I don't think atomic page flags are a thing here.  I remember Jan
>>>> had chased a bug where we'd get into trouble into this area in
>>>> ext4 due to the way pages are locked down for direct I/O, but I
>>>> don't even remember seeing that on XFS.  Either way the PageOrdered
>>>> check prevents a crash in that case and we really can't expect
>>>> data to properly be written back in that case.
>>>
>>> I'm not sure I get the context 100% right but pages getting randomly d=
irty
>>> behind filesystem's back can still happen - most commonly with RDMA an=
d
>>> similar stuff which calls set_page_dirty() on pages it has got from
>>> pin_user_pages() once the transfer is done.
>>
>> Just curious, things like RMDA can mark those pages dirty even without
>> letting kernel know, but how could those pages be from page cache? By
>> mmap()?
>
> Yes, you pass virtual address to RDMA ioctl and it uses memory at that
> address as a target buffer for RDMA. If the target address happens to be
> mmapped file, filesystem has problems...

Oh my god, this is going to be disaster.

RDMA is really almost a blackbox which can do anything to the pages.

If some RDMA drivers choose to screw up with Private2, the btrfs
workaround is also screwed up.

Another problem is related to subpage.

Btrfs (and iomap) all uses page->private to store extra bitmaps for
subpage usage.
If RDMA is changing page flags, it can easily lead to de-sync between
subpage bitmaps with real page flags.

I can no longer sleep well knowing this...

Thanks,
Qu
>
>>> page_maybe_dma_pinned() should
>>> be usable within filesystems to detect such cases and protect the
>>> filesystem but so far neither me nor John Hubbart has got to implement=
 this
>>> in the generic writeback infrastructure + some filesystem as a sample =
case
>>> others could copy...
>>
>> So the generic idea is just to detect if the page is marked dirty by
>> traditional means, and if not, skip the writeback for them, and wait fo=
r
>> proper notification to fs?
>
> Kind of. The idea is to treat page_maybe_dma_pinned() pages as permanent=
ly
> dirty (because we have no control over when the hardware decides to modi=
fy
> the page contents by DMA). So skip the writeback if we can (e.g. memory
> cleaning type of writeback) and use bounce pages to do data integrity
> writeback (which cannot be skipped).
>
> 								Honza
