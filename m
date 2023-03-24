Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C846C86DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 21:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjCXUeU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 16:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjCXUeT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:34:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED561499C
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 13:34:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22FC4B825F3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 20:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986E1C433D2;
        Fri, 24 Mar 2023 20:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679690055;
        bh=0XrfIjT1HzllGbUgpFppNSNIjorIYRmjLQ/b09+uonc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eax47RYlRW8awJxRcfVbThj3YrvrJpWoIOPvs/SovFqsP4ofR97yB+UnemOVMLk5D
         i+FEE2sBpwJIkEIReTSySu27giahCZ66EEveHK7vU21V46eCbxZlm04qdEiIGoG4vh
         DzBH8t2P3Qf2wIqr+0qQkf9efus8xEipDOz9MoRs=
Date:   Fri, 24 Mar 2023 13:34:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>
Subject: Re: [PATCH] fsdax: dedupe should compare the min of two iters'
 length
Message-Id: <20230324133414.c0fa29239383e8f5930c3ceb@linux-foundation.org>
In-Reply-To: <a34449ea-4571-2528-9047-f02079e47818@fujitsu.com>
References: <1679469958-2-1-git-send-email-ruansy.fnst@fujitsu.com>
        <20230322161236.f90c21c8f668f551ee19d80b@linux-foundation.org>
        <0d219eb0-0f58-e667-0d86-be158ea2030f@fujitsu.com>
        <20230323151201.98d54f8d85f83c636568eacc@linux-foundation.org>
        <a34449ea-4571-2528-9047-f02079e47818@fujitsu.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 24 Mar 2023 12:19:46 +0800 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> > Again, how does the bug impact real-world kernel users?
> 
> The dedupe command will fail with -EIO if the range is larger than one 
> page size and not aligned to the page size.  Also report warning in dmesg:
> 
> [ 4338.498374] ------------[ cut here ]------------
> [ 4338.498689] WARNING: CPU: 3 PID: 1415645 at fs/iomap/iter.c:16 

OK, thanks.  I added the above to the changelog and added cc:stable.
