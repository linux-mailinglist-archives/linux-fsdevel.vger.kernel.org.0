Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A57166376D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 03:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjAJCiE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 21:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjAJCiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:38:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424F7B7F0;
        Mon,  9 Jan 2023 18:38:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFEE8614BB;
        Tue, 10 Jan 2023 02:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A862CC433EF;
        Tue, 10 Jan 2023 02:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673318281;
        bh=Y64MR4JK48Pzp25aGh8zQ5wqMuidq5kQnWPvb8e5i9I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cEgGQa5zyUoGHgJLglyternN0KDprFlgUCd6BKIvxiD2upcGonWYYLG4H/yh6Ywbg
         mhfo1DGbQOmqUd8qvuzP76ikYLMkESZ1gih+2voSna2iJrFiRvv6jIDGac5HZ6dRo/
         9yjcHwGTRnn5HHiw2V0ZuL50gw2Z3KriC6g3L4ro=
Date:   Mon, 9 Jan 2023 18:37:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v2 10/11] fs/buffer.c: support fsverity in
 block_read_full_folio()
Message-Id: <20230109183759.c1e469f5f2181e9988f10131@linux-foundation.org>
In-Reply-To: <20221223203638.41293-11-ebiggers@kernel.org>
References: <20221223203638.41293-1-ebiggers@kernel.org>
        <20221223203638.41293-11-ebiggers@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 23 Dec 2022 12:36:37 -0800 Eric Biggers <ebiggers@kernel.org> wrote:

> After each filesystem block (as represented by a buffer_head) has been
> read from disk by block_read_full_folio(), verify it if needed.  The
> verification is done on the fsverity_read_workqueue.  Also allow reads
> of verity metadata past i_size, as required by ext4.

Sigh.  Do we reeeeealy need to mess with buffer.c in this fashion?  Did
any other subsystems feel a need to do this?

> This is needed to support fsverity on ext4 filesystems where the
> filesystem block size is less than the page size.

Does any real person actually do this?
