Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D004D6C72C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 23:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCWWMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 18:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCWWME (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:12:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7541123120
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 15:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13CBF628CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 22:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A44DC433AA;
        Thu, 23 Mar 2023 22:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679609522;
        bh=NPJ7rJHAWoXvOzSWrNmY2FKPUyh54zh3/+WwtjUeeZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h5KzCfwPb0Phb7owz/hHVi892GYAfI2mUZ43fBiSOl3tFnJfHYr4Oz4hZCnsxtIrp
         /IlUGuq3VA3IaNbqAGwzyydoRiL+oLjNmo1c5jlrnYh8G5PdrIhX/4ub3HRcYDZDVv
         lcYGdsoCJFioAzmJWS03J2Uv9Mag6FFZxYwg+Ipc=
Date:   Thu, 23 Mar 2023 15:12:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>
Subject: Re: [PATCH] fsdax: dedupe should compare the min of two iters'
 length
Message-Id: <20230323151201.98d54f8d85f83c636568eacc@linux-foundation.org>
In-Reply-To: <0d219eb0-0f58-e667-0d86-be158ea2030f@fujitsu.com>
References: <1679469958-2-1-git-send-email-ruansy.fnst@fujitsu.com>
        <20230322161236.f90c21c8f668f551ee19d80b@linux-foundation.org>
        <0d219eb0-0f58-e667-0d86-be158ea2030f@fujitsu.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 23 Mar 2023 14:48:25 +0800 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> 
> 
> 在 2023/3/23 7:12, Andrew Morton 写道:
> > On Wed, 22 Mar 2023 07:25:58 +0000 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
> > 
> >> In an dedupe corporation iter loop, the length of iomap_iter decreases
> >> because it implies the remaining length after each iteration.  The
> >> compare function should use the min length of the current iters, not the
> >> total length.
> > 
> > Please describe the user-visible runtime effects of this flaw, thanks.
> 
> This patch fixes fail of generic/561, with test config:
> 
> export TEST_DEV=/dev/pmem0
> export TEST_DIR=/mnt/test
> export SCRATCH_DEV=/dev/pmem1
> export SCRATCH_MNT=/mnt/scratch
> export MKFS_OPTIONS="-m reflink=1,rmapbt=1"
> export MOUNT_OPTIONS="-o dax"
> export XFS_MOUNT_OPTIONS="-o dax"

Again, how does the bug impact real-world kernel users?

Thanks.
