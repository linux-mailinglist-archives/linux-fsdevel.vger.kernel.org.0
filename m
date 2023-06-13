Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F98B72E585
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 16:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242447AbjFMOQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 10:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbjFMOQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:16:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733C194;
        Tue, 13 Jun 2023 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=CbGcyfHi9QA1um+JXK92ovTuo4LzjCmAsPSThsU99qE=; b=YHP/QC3m5r8bf93VtZEyxh/INM
        9SOJij2U2Pjj1WYK4iuiA5KnydctxBsfTeeOshHG6I5pU/VVHdwrIhivOjqLXT3nzcB1acCCbiql8
        S2dITLjPcWpzWwA0o1jk3ep/cZh80zjDVXi36DD6YTUnyNSkggJpNz648uDI6nV4UJDjxPt0gaXgQ
        KlMDjs/fCy5DGFXU3tp5QvcaznNwNLq4CDvuFyyxYHbeZ/n7YABL0evJaWOiVE26mwVdnjgCh81Dm
        jEiv3jIzyvmTOQ/V6ntL6I59lSH1Qkl1aEHOGSBr+j/meYKNOgSM8/8LFgCJH8F9FmRj9A3byqfaF
        06OCKDmw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q94oy-008IDS-2l;
        Tue, 13 Jun 2023 14:16:32 +0000
Message-ID: <77171ea8-c8d9-5f8d-caf0-76bd5ca03f0c@infradead.org>
Date:   Tue, 13 Jun 2023 07:16:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 02/11] block: Block Device Filtering Mechanism
Content-Language: en-US
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        dlemoal@kernel.org, wsa@kernel.org,
        heikki.krogerus@linux.intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>
References: <20230609115858.4737-1-sergei.shtepa@veeam.com>
 <20230609115858.4737-2-sergei.shtepa@veeam.com>
 <e2f851d7-6b17-7a36-b5b3-2d60d450989d@infradead.org>
 <f7b67068-62c4-0977-265a-37c84f553eab@veeam.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <f7b67068-62c4-0977-265a-37c84f553eab@veeam.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/13/23 05:34, Sergei Shtepa wrote:
> 
> 
> On 6/13/23 03:51, Randy Dunlap wrote:
>>
>> On 6/9/23 04:58, Sergei Shtepa wrote:
>>> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
>>> index b7b56871029c..7904f157b245 100644
>>> --- a/include/uapi/linux/fs.h
>>> +++ b/include/uapi/linux/fs.h
>>> @@ -189,6 +189,9 @@ struct fsxattr {
>>>   * A jump here: 130-136 are reserved for zoned block devices
>>>   * (see uapi/linux/blkzoned.h)
>>>   */
>>> +#define BLKFILTER_ATTACH	_IOWR(0x12, 140, struct blkfilter_name)
>>> +#define BLKFILTER_DETACH	_IOWR(0x12, 141, struct blkfilter_name)
>>> +#define BLKFILTER_CTL		_IOWR(0x12, 142, struct blkfilter_ctl)
>>
>> Please update Documentation/userspace-api/ioctl/ioctl-number.rst
>> with the blkfilter ioctl number usage.
> 
> It seems to me that there is no need to change anything in the table of
> numbers for 'blkfilter'. I think the existing record is enough:
> 
> 0x10  20-2F  arch/s390/include/uapi/asm/hypfs.h
> 0x12  all    linux/fs.h
>              linux/blkpg.h

Yes, OK.

> Maybe it would probably be correct to specify the file 'uapi/linux/fs.h'?
> And maybe we need to specify the request numbers for blksnap?

Yes.

> add ioctls numbers for blksnap
> 
> Asked-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 176e8fc3f31b..96af64988251 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -202,6 +202,7 @@ Code  Seq#    Include File                                           Comments
>  'V'   C0     linux/ivtvfb.h                                          conflict!
>  'V'   C0     linux/ivtv.h                                            conflict!
>  'V'   C0     media/si4713.h                                          conflict!
> +'V'   00-1F  uapi/linux/blksnap.h                                    conflict!
>  'W'   00-1F  linux/watchdog.h                                        conflict!
>  'W'   00-1F  linux/wanrouter.h                                       conflict! (pre 3.9)
>  'W'   00-3F  sound/asound.h                                          conflict!

-- 
~Randy
