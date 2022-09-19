Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D395BD651
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 23:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiISVYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 17:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiISVYg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 17:24:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6679EF0D;
        Mon, 19 Sep 2022 14:24:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE49B61EBF;
        Mon, 19 Sep 2022 21:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC1EC433D6;
        Mon, 19 Sep 2022 21:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663622671;
        bh=1cpRM5tko1UyvK/nVYxUegMJmu9VP3/Cg/QFSqlvimo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ciCRVrcSeMfuR6qISsRAC4H1iyJ3Y4cq4cQNWZ9Ru2HqJZTRLKOYDcB811D7qI5ld
         CsKPWr03/vXKCFGxR3K0KpxTHvj8zlAgz4u+o5vvJzPtiJBwOkPV4jjh0VFU8DXtVt
         JgLvfjVc/FDrDoIOyvmN13J9Zw9NxsCAofv0KvIU=
Date:   Mon, 19 Sep 2022 14:24:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eliav Farber <farbere@amazon.com>
Cc:     <viro@zeniv.linux.org.uk>, <yangyicong@hisilicon.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@intel.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] libfs: fix negative value support in
 simple_attr_write()
Message-Id: <20220919142413.c294de0777dcac8abe2d2f71@linux-foundation.org>
In-Reply-To: <20220918135036.33595-1-farbere@amazon.com>
References: <20220918135036.33595-1-farbere@amazon.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 18 Sep 2022 13:50:36 +0000 Eliav Farber <farbere@amazon.com> wrote:

> After commit 488dac0c9237 ("libfs: fix error cast of negative value in
> simple_attr_write()"), a user trying set a negative value will get a
> '-EINVAL' error, because simple_attr_write() was modified to use
> kstrtoull() which can handle only unsigned values, instead of
> simple_strtoll().
> 
> This breaks all the places using DEFINE_DEBUGFS_ATTRIBUTE() with format
> of a signed integer.
> 
> The u64 value which attr->set() receives is not an issue for negative
> numbers.
> The %lld and %llu in any case are for 64-bit value. Representing it as
> unsigned simplifies the generic code, but it doesn't mean we can't keep
> their signed value if we know that.
> 
> This change basically reverts the mentioned commit, but uses kstrtoll()
> instead of simple_strtoll() which is obsolete.
> 

https://lkml.kernel.org/r/20220919172418.45257-1-akinobu.mita@gmail.com
addresses the same thing.

Should the final version of this fix be backported into -stable trees?
