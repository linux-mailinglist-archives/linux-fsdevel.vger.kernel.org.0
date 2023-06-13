Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4535172D721
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 03:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbjFMBvk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 21:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjFMBvj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:51:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F7913E;
        Mon, 12 Jun 2023 18:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=6263zB6Myj1CWGl+WNtIFb/c8mPPuyucfWhf/Mxh6Os=; b=FgGTxNTocVD82y328AxSc9giuK
        kvOKzRsKOEEDHTFLP4luTJYpYvvwwbdBW8EHLXUDEMZs+cwYXZSv00cbWkA+XN8jP55wCcFPIHdST
        bcEkMrZ343ZhJfwC85lvv2XrES2QugFHx0xr/CCo4iyimhibUJd2N887vZ7l4EfRMDVxsKjza9dy2
        59f7t1ElvJBSyIQm8qUjKpNDGTTY2fHIhMkocI1RqmSkEQdEyvwEe1gWVxbd59r6ElmgReR9Ye9en
        YKlfYCJXzk6VzwQU9V1Enk2b0+vxWVmKsqDLzHeYHhk/lsYfkh82hEy/euWVELmCMvvF/miOuHfeI
        spf1DjcQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8tBm-006cAY-2V;
        Tue, 13 Jun 2023 01:51:18 +0000
Message-ID: <e2f851d7-6b17-7a36-b5b3-2d60d450989d@infradead.org>
Date:   Mon, 12 Jun 2023 18:51:17 -0700
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
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230609115858.4737-2-sergei.shtepa@veeam.com>
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



On 6/9/23 04:58, Sergei Shtepa wrote:
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index b7b56871029c..7904f157b245 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -189,6 +189,9 @@ struct fsxattr {
>   * A jump here: 130-136 are reserved for zoned block devices
>   * (see uapi/linux/blkzoned.h)
>   */
> +#define BLKFILTER_ATTACH	_IOWR(0x12, 140, struct blkfilter_name)
> +#define BLKFILTER_DETACH	_IOWR(0x12, 141, struct blkfilter_name)
> +#define BLKFILTER_CTL		_IOWR(0x12, 142, struct blkfilter_ctl)


Please update Documentation/userspace-api/ioctl/ioctl-number.rst
with the blkfilter ioctl number usage.

thanks.
-- 
~Randy
