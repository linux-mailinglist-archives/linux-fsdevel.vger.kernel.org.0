Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB872D729
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 03:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbjFMBw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 21:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFMBwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:52:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49A013E;
        Mon, 12 Jun 2023 18:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=NjFb2DneMugGIPw5KlK2+oDu3ftr6iDdoaz0Ka2kCgc=; b=uqYivyfZxr4tZ6Ciy1zx0jCDWG
        1MvyOF1wlySoP6i6IRg7beLoPQ28OH7kxTBb4cK+QIPnDeNTNaiq7Bm41S31+5Ncs7i0dfrWIP+2N
        51InwiFpifoThbHx2/UIebWu3F/IDOkAwgSKeZ1NKomXQLYCBd9zMqbuYsf1WHKYz/kThqKTUMwsg
        fg1AlBuxFVJM47s9OkB0wyM1x4syJ/m0RVkMrF2JUC/sQMXKvWnR8hD7i7NDAl+k+Qobazt+uiM2P
        hfu+mWIpj+AQKLdjDXKxPHRAIvXF2i7/ZZJ2l4C033j7eW837bm+tZ4R/FMpF8/clfv2o33abnrnn
        PXleK7hA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8tDB-006cLc-08;
        Tue, 13 Jun 2023 01:52:45 +0000
Message-ID: <004cc6b2-1941-5aed-6e09-3bd01dfbf8e4@infradead.org>
Date:   Mon, 12 Jun 2023 18:52:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 01/11] documentation: Block Device Filtering Mechanism
Content-Language: en-US
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        dlemoal@kernel.org, wsa@kernel.org,
        heikki.krogerus@linux.intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230609115858.4737-1-sergei.shtepa@veeam.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230609115858.4737-1-sergei.shtepa@veeam.com>
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

Hi--

On 6/9/23 04:58, Sergei Shtepa wrote:
> The document contains:
> * Describes the purpose of the mechanism
> * A little historical background on the capabilities of handling I/O
>   units of the Linux kernel
> * Brief description of the design
> * Reference to interface description
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>  Documentation/block/blkfilter.rst | 64 +++++++++++++++++++++++++++++++
>  Documentation/block/index.rst     |  1 +
>  MAINTAINERS                       |  6 +++
>  3 files changed, 71 insertions(+)
>  create mode 100644 Documentation/block/blkfilter.rst
> 
> diff --git a/Documentation/block/blkfilter.rst b/Documentation/block/blkfilter.rst
> new file mode 100644
> index 000000000000..555625789244
> --- /dev/null
> +++ b/Documentation/block/blkfilter.rst
> @@ -0,0 +1,64 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================================
> +Block Device Filtering Mechanism
> +================================
> +
> +The block device filtering mechanism is an API that allows to attach block

                                                  that allows {what or who} to attach

so who/what does the attach? Is it a driver or a user or admin or something else?
and attach them to what?

> +device filters. Block device filters allow perform additional processing

                                        allow performing ...

> +for I/O units.
> +
> +Introduction
> +============
> +
> +The idea of handling I/O units on block devices is not new. Back in the
> +2.6 kernel, there was an undocumented possibility of handling I/O units
> +by substituting the make_request_fn() function, which belonged to the
> +request_queue structure. But none of the in-tree kernel modules used this
> +feature, and it was eliminated in the 5.10 kernel.
> +
> +The block device filtering mechanism returns the ability to handle I/O units.
> +It is possible to safely attach filter to a block device "on the fly" without

                            attach a filter
or
                            attach filters

> +changing the structure of block devices stack.

                          of the block device's stack.

> +
> +It supports attaching one filter to one block device, because there is only
> +one filter implementation in the kernel yet.
> +See Documentation/block/blksnap.rst.
> +
> +Design
> +======
> +
> +The block device filtering mechanism provides registration and unregistration
> +for filter operations. The struct blkfilter_operations contains a pointer to
> +the callback functions for the filter. After registering the filter operations,
> +filter can be managed using block device ioctl BLKFILTER_ATTACH,

   a filter
or
   the filter                               ioctls

> +BLKFILTER_DETACH and BLKFILTER_CTL.
> +
> +When the filter is attached, the callback function is called for each I/O unit
> +for a block device, providing I/O unit filtering. Depending on the result of
> +filtering the I/O unit, it can either be passed for subsequent processing by
> +the block layer, or skipped.
> +
> +The filter can be implemented as a loadable module. In this case, the filter
> +module cannot be unloaded while the filter is attached to at least one of the
> +block devices.
> +
> +Interface description
> +=====================
> +
> +The ioctl BLKFILTER_ATTACH and BLKFILTER_DETACH use structure blkfilter_name.

       ioctls

> +It allows to attach a filter to a block device or detach it.

   It allows a driver to attach a filter ...
?

> +
> +The ioctl BLKFILTER_CTL use structure blkfilter_ctl. It allows to send a

                                                        It allows a driver to send a

> +filter-specific command.
> +
> +.. kernel-doc:: include/uapi/linux/blk-filter.h
> +
> +To register in the system, the filter creates its own account, which contains
> +callback functions, unique filter name and module owner. This filter account is
> +used by the registration functions.

I'm having a problem with this "account" thingy. Can you explain more about it?
Is there an alternate word that might be used here?

> +
> +.. kernel-doc:: include/linux/blk-filter.h
> +
> +.. kernel-doc:: block/blk-filter.c
> +   :export:

Thanks.
-- 
~Randy
