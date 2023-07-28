Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4BE766325
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 06:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjG1EZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 00:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjG1EZS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:25:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEA119B;
        Thu, 27 Jul 2023 21:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Ao7GNVwTNlA+08NsEP9KZa7poSWv2gw93VRCPXPtkIo=; b=38+weY92+ZIyidQnYhi8kc+JP/
        szcZrxQEne0HTl1iQsM6mY36YAgtWl6RMTi9sS3DHyFIBOn0YC3/08+0L/Zv4lwb/wo68qR5dC9GK
        CihBfhf/c1vmio6iXOLkf6+96C8LwAzkIYrMxj9IukfT6/uTd2MaJ4mh+thby9/Ugm2XuBho+cnGX
        Y4XC7L87mowW4ZLrfjDQMLR8ptTm4S4yEiC/lH9KGXXKu1yIIFIb9xygfEmQpmbBQd+jU/epsA5q8
        tN26FPumsd06dJzLMPQt7IUsZj9mBb6r7z/j82XJ2QZDc8CwwiiI/mDCfhp9SzpMt9M9SdIhcPdKM
        pbSnNOqA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qPF2J-001aDr-28;
        Fri, 28 Jul 2023 04:25:07 +0000
Message-ID: <cc9ba6e9-1154-ad84-0fef-d67834169110@infradead.org>
Date:   Thu, 27 Jul 2023 21:25:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC bootconfig 0/2] Distinguish bootloader and embedded
 kernel parameters
Content-Language: en-US
To:     paulmck@kernel.org, akpm@linux-foundation.org, adobriyan@gmail.com,
        mhiramat@kernel.org
Cc:     arnd@kernel.org, ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
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



On 7/27/23 20:35, Paul E. McKenney wrote:
> Hello!
> 
> This series provides /proc interfaces parallel to /proc/cmdline that
> provide only those kernel boot parameters that were provided by the
> bootloader (/proc/cmdline_load) and only those parameters that were
> embedded in the kernel image (/proc/cmdline_image, in boot-config format).
> This is especially important when these parameters are presented to the
> boot loader by automation that might gather them from diverse sources,
> and also when a kexec-based reboot process pulls the kernel boot
> parameters from /proc.  If such a reboot process uses /proc/cmdline,
> the kernel parameters from the image are replicated on every reboot,
> which can be frustrating when the new kernel has different embedded
> kernel boot parameters.
> 
> Why put these in /proc?  Because they is quite similar to /proc/cmdline,
> so it makes sense to put it in the same place that /proc/cmdline is
> located.
> 
> 1.	fs/proc: Add /proc/cmdline_load for boot loader arguments.
> 
> 2.	fs/proc: Add /proc/cmdline_image for embedded arguments.
> 
> 						Thanx, Paul
> 

Hi Paul,

This series seems to be missing updates to
Documentation/filesystems/proc.rst.

Please add them.
Thanks.

> ------------------------------------------------------------------------
> 
>  b/fs/proc/cmdline.c    |   13 +++++++++++++
>  b/include/linux/init.h |    3 ++-
>  b/init/main.c          |    2 +-
>  fs/proc/cmdline.c      |   12 ++++++++++++
>  include/linux/init.h   |   11 ++++++-----
>  init/main.c            |    9 +++++++++
>  6 files changed, 43 insertions(+), 7 deletions(-)

-- 
~Randy
