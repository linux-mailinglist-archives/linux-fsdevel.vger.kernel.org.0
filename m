Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4435A0A0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 09:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbiHYHW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 03:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiHYHW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:22:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF83A1D31;
        Thu, 25 Aug 2022 00:22:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E641561901;
        Thu, 25 Aug 2022 07:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3630C433C1;
        Thu, 25 Aug 2022 07:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661412176;
        bh=FZL6dNpPI/YKsRnZLNyMo4D7gdJtSXb/mNkH8Nlircs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ha5zOtk0AvY7x3EA510ExFs2Re0tF/qCrDWbj8ScuZmL1dRJ/pCwzPTJ1HofG6kaL
         LwrifvXSDr2EJZFsFOq5BYmD3ZPtJhQA9mz12KYgxwET8INYKABD3MDe3a9iWm1oNG
         U0gz1uULE3YJPQ679T93gSvpNaY1U4yRiXxd6ONs=
Date:   Thu, 25 Aug 2022 09:22:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v2 2/4] fs/proc/task_mmu: Implement IOCTL to get and
 clear soft dirty PTE bit
Message-ID: <YwcjTOgKD22TXwYk@kroah.com>
References: <20220825070926.2922471-1-usama.anjum@collabora.com>
 <20220825070926.2922471-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825070926.2922471-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 25, 2022 at 12:09:24PM +0500, Muhammad Usama Anjum wrote:
> - The flags can be specified in the flags field. Currently only one
>   PAGEMAP_SD_NO_REUSED_REGIONS is supported which can be specified to
>   ignore the VMA dirty flags.

You forgot to check that all other bits in that flag are set to 0
properly, otherwise you can never add a new bit to the field ever as you
can't expect userspace got it right and did not accidentaly set it
already.

There is kernel documentation on how to add a new ioctl, you might want
to read up on that first before resending this.

thanks,

greg k-h
