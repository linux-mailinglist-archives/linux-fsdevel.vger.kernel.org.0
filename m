Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB5055CAA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242583AbiF1AYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 20:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242526AbiF1AY0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:24:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273E41C113;
        Mon, 27 Jun 2022 17:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656375853;
        bh=eg0Ld1dIzdoptyJh2iXj5oMIQgq7oAxqfrx2L8T1HJQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gX4rzrbSog0rNGFR+T9YRkAS5tw0fhxLMCB0Z2NAUAGXZBPErJslacP9LPvfisb4A
         PQ9BJO71cgTLl/krDi2W9do9WE6c9kxc9nD9w1+DpvHOum0+UPTy/eF5naHpzhh2LQ
         4C3p/gciOYsP00tdDdCPhhq/xVXpgKXyUilOEohE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6Udt-1nzfV726Cf-006yib; Tue, 28
 Jun 2022 02:24:13 +0200
Message-ID: <e73be42e-fce5-733a-310d-db9dc5011796@gmx.com>
Date:   Tue, 28 Jun 2022 08:24:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220624122334.80603-1-hch@lst.de>
 <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com> <20220624125118.GA789@lst.de>
 <20220624130750.cu26nnm6hjrru4zd@quack3.lan> <20220625091143.GA23118@lst.de>
 <20220627101914.gpoz7f6riezkolad@quack3.lan>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220627101914.gpoz7f6riezkolad@quack3.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TUDXYOguBdFc8szg6s33DZegG88/C2dSpWWfTYkLuX+c99FdYCK
 Vy6e4moT6QGELL2/V/Rh3pbIlPHrkDi6kLA7hF+FaQ0hdYLQr1gA1zAVrJvpXgloxXsojmD
 Gd0zRuoa6JX7rKcEqfERap8OuNS9yLsdji02zGTl1hUBGXCiuQA+DW1+H+aIZFojs8ozOdp
 8sZzJckpycFxb/gbYSBDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XN8zdhvGw94=:1+LQDVtrC4prmgl7Bx6lP8
 kIYj7ADpVy9l8Nbz9aoCdM/gBPAyB0dZwYJU3oxVgmRQH75Q6ligndn1Xq+cHkgf2Iqhqepfw
 wb0fVnRx5FBQ44oMyRZlkU/lkP815YpLATlPSqF+hi3o+GbMYot1yxtlsFsHmHuilSyzTyWqQ
 HQaZrh29DmAqWtJfS4okjy1omELzQC7hgCNVOXodtDnrXUOWR4/Fs2q3YqXSa7pO+4Utsa1yX
 Gx26ymmDqGGlRDzAqm2JACe8TpRMivou62hbdd34Pe8CyZ8XuvnAQRtlpamPcZMOg4/XS04VO
 WeDA0QCe3Y+lfAwHeWCOWC1c/73fjjZcz+7zvh18Z01UsMqSUcAz18nBt11CGo4YrX5GEKkX2
 2eKHSAS/IrBqUOMCxypkRbpS7Eua37HhkCqBA/e2MuLgPhXFCMkVv+4n1PHadQPJnIkifm5XA
 +XQt7oPzbSzhXOrOT/FJdVjJt40nZ3Q9Gzt0iZlm2MQgiJ6/f39ktroCIBd8OXR5mjhjil/mp
 Mf1Klifea/PPF2z4bzfWuSZUJ0gOCwrXWMljHx4W376xwgmVeAw8nth3bkqHF9H5PFfiVDTa2
 HvgnTSZylVz+yzCSRCvh1NU70JEb3MPrn9zlSmdpyI5H0UVceC4J7hX8UfGppNFsROXF8eVI2
 bTpXmiEs16wQWBex+5Rs269kB4cA74DY4K/Ya/zkLPcWMQJxa6eAex48zWC/w0jN2XkxBWApN
 1zCM0BDVee2OPemKN/FK6gQlMIwSnob6aNhf3lok7lqOJZ6+Ig+XHdo7M8lXm2mUGP2xN4QqZ
 fh6WfCxVcYeW4kIrgczDuMDTtrN+Vdg4SOLGbqIx2nOkgiD2sRUuagQz2SRwdEJhFfVN6hRZb
 Fab480NxssJwh/uyRiac3ehz2ltJ/z8OBp5C5tXouum+Mrk72zGCKAuULUuZmniUElIP0D/hI
 ER/LnHqO5knB4rLXYMy3ZeJN7YWHuEOdF0fP4dB8VoGXXl/2vCJD/SjG7bRuSrtuCSjWhxj4i
 mPAWkzJ89mo9d/Km37GbQTk9qwtvUdc0S/ZtRUp9vwg1lV2rULPcaFl4ZICLQPIte/iafP35r
 4McGk+d1wcyjYdV1FBqnRs3Y36U9qp8uSIv6+ZhR2eoOHNdZ5Ww8/5FjA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/6/27 18:19, Jan Kara wrote:
> On Sat 25-06-22 11:11:43, Christoph Hellwig wrote:
>> On Fri, Jun 24, 2022 at 03:07:50PM +0200, Jan Kara wrote:
>>> I'm not sure I get the context 100% right but pages getting randomly d=
irty
>>> behind filesystem's back can still happen - most commonly with RDMA an=
d
>>> similar stuff which calls set_page_dirty() on pages it has got from
>>> pin_user_pages() once the transfer is done. page_maybe_dma_pinned() sh=
ould
>>> be usable within filesystems to detect such cases and protect the
>>> filesystem but so far neither me nor John Hubbart has got to implement=
 this
>>> in the generic writeback infrastructure + some filesystem as a sample =
case
>>> others could copy...
>>
>> Well, so far the strategy elsewhere seems to be to just ignore pages
>> only dirtied through get_user_pages.  E.g. iomap skips over pages
>> reported as holes, and ext4_writepage complains about pages without
>> buffers and then clears the dirty bit and continues.
>>
>> I'm kinda surprised that btrfs wants to treat this so special
>> especially as more of the btrfs page and sub-page status will be out
>> of date as well.
>
> I agree btrfs probably needs a different solution than what it is curren=
tly
> doing if they want to get things right. I just wanted to make it clear t=
hat
> the code you are ripping out may be a wrong solution but to a real probl=
em.

IHMO I believe btrfs should also ignore such dirty but not managed by fs
pages.

But I still have a small concern here.

Is it ensured that, after RDMA dirtying the pages, would we finally got
a proper notification to fs that those pages are marked written?

If not, I would guess those pages would never got a chance to be written
back.

If yes, then I'm totally fine to go the ignoring path.

Thanks,
Qu
>
> 								Honza
