Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E631D5BDEBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 09:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiITHsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 03:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiITHrC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:47:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB0D11169;
        Tue, 20 Sep 2022 00:46:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79C95B80927;
        Tue, 20 Sep 2022 07:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C477C433C1;
        Tue, 20 Sep 2022 07:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663660016;
        bh=31LwDD6/RD3aunahOMD2sHT+ewdy1AuM7USPdp3uXHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTqyeUFod7XeG7uJJHYdHXiuP62G+G/F1DTcdjdKysdwt9RAOgW5ll7YWf/scejs6
         zEpCIB2Dax0KLjpoTMMUb0FUXx+xv+eBdOGN6j/70jM3i3rO8mNhKcf97g9FU9GuPb
         J2dTXXopZbyl8SN4Y3nm4E4u5v8Vtu32qpOsLZMg=
Date:   Tue, 20 Sep 2022 09:47:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, corbet@lwn.net, david@redhat.com,
        osalvador@suse.de, shuah@kernel.org,
        Zhao Gongyi <zhaogongyi@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        akpm@linux-foundation.org
Subject: Re: [PATCH 0/3] fix error when writing negative value to simple
 attribute files
Message-ID: <YylwDJCQ/xdCU3Nd@kroah.com>
References: <20220919172418.45257-1-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919172418.45257-1-akinobu.mita@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 02:24:15AM +0900, Akinobu Mita wrote:
> The simple attribute files do not accept a negative value since the
> commit 488dac0c9237 ("libfs: fix error cast of negative value in
> simple_attr_write()"), but some attribute files want to accept
> a negative value.
> 
> Akinobu Mita (3):
>   libfs: add DEFINE_SIMPLE_ATTRIBUTE_SIGNED for signed value
>   lib/notifier-error-inject: fix error when writing -errno to debugfs
>     file
>   debugfs: fix error when writing negative value to atomic_t debugfs
>     file
> 
>  .../fault-injection/fault-injection.rst       | 10 +++----
>  fs/debugfs/file.c                             | 28 +++++++++++++++----
>  fs/libfs.c                                    | 22 +++++++++++++--
>  include/linux/debugfs.h                       | 19 +++++++++++--
>  include/linux/fs.h                            | 12 ++++++--
>  lib/notifier-error-inject.c                   |  2 +-
>  6 files changed, 73 insertions(+), 20 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
