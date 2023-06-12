Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F8F72D514
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 01:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjFLXnd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 19:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjFLXnc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:43:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9733C10F9;
        Mon, 12 Jun 2023 16:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ZlWLeOXVICCHBRrKKLqL9aWEONQcjjN3Lm4aBMgVQww=; b=afaSMC5RX3j1M7bncFgFM7mWmn
        mrpuVvRDOOxncD9USgGUmd40J82MMdkJFzoygBevKnC4I9Am7YuqcUQFy8xn0+f2pQm4LOMA5rMrh
        g45HyceqwYRuW/3HlSbM9RohnR4Hr+YD2c6EV3EBr9YCf97J2K4OKIlEkhqbJXl/yeDdqCQ9K7gPd
        USWddYyVs0xCuREGfQ9wM30iKR83Pr597FExFJMKMgZaWqB3O+CLIglpG3CTCCVA3rl8OvE5sdCNJ
        Qgw8LdSAsFcHr4aArexARNQ+2pUSnJxUXTQcpnLUIkC2gs9GV8ZFa22OMT+c9UAaVkzZghWmoWG3q
        AGI+tATQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8rBn-006Azs-1T;
        Mon, 12 Jun 2023 23:43:11 +0000
Message-ID: <499ded51-3fb8-f11b-8776-08ab2e9a8812@infradead.org>
Date:   Mon, 12 Jun 2023 16:43:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 11/11] blksnap: Kconfig and Makefile
Content-Language: en-US
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        dlemoal@kernel.org, wsa@kernel.org,
        heikki.krogerus@linux.intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230609115858.4737-1-sergei.shtepa@veeam.com>
 <20230609115858.4737-11-sergei.shtepa@veeam.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230609115858.4737-11-sergei.shtepa@veeam.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/9/23 04:58, Sergei Shtepa wrote:
> diff --git a/drivers/block/blksnap/Kconfig b/drivers/block/blksnap/Kconfig
> new file mode 100644
> index 000000000000..14081359847b
> --- /dev/null
> +++ b/drivers/block/blksnap/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Block device snapshot module configuration
> +#
> +
> +config BLKSNAP
> +	tristate "Block Devices Snapshots Module (blksnap)"
> +	help
> +	  Allow to create snapshots and track block changes for block devices.
> +	  Designed for creating backups for simple block devices. Snapshots are
> +	  temporary and are released then backup is completed. Change block

	                             when backup is completed.

or is the order of operations as listed: release snapshots and then backup
can be completed?

> +	  tracking allows to create incremental or differential backups.

-- 
~Randy
