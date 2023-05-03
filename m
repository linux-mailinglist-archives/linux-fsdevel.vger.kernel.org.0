Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EE16F4E03
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 02:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjECAMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 20:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjECAMb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 20:12:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651232D61
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 17:12:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDCBA62929
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 00:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEFFC433D2;
        Wed,  3 May 2023 00:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683072749;
        bh=avUvPtIVtB/TgmXReTnIalPcBkf63SdC57To7FuyNtM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2v4kUGIUxes1my6Kq0/DzY8zVtStIlikdS/ChE9NYuls6DQvpD3WlSm7hjJiKbEpB
         aVcddTO5bq/7GLH1BRcAlPEfPFbQnmdrIOYAcKeqwQRnNQVsXW8DW7IT/m3k5hLMVj
         t44lvhrD6uT97Xm+tP86M3eOG5ISvbDlEhlja8FM=
Date:   Tue, 2 May 2023 17:12:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chuck Lever <cel@kernel.org>
Cc:     hughd@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] shmem: stable directory cookies
Message-Id: <20230502171228.57a906a259172d39542e92fb@linux-foundation.org>
In-Reply-To: <168175931561.2843.16288612382874559384.stgit@manet.1015granger.net>
References: <168175931561.2843.16288612382874559384.stgit@manet.1015granger.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 17 Apr 2023 15:23:10 -0400 Chuck Lever <cel@kernel.org> wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The current cursor-based directory cookie mechanism doesn't work
> when a tmpfs filesystem is exported via NFS. This is because NFS
> clients do not open directories: each READDIR operation has to open
> the directory on the server, read it, then close it. The cursor
> state for that directory, being associated strictly with the opened
> struct file, is then discarded.
> 
> Directory cookies are cached not only by NFS clients, but also by
> user space libraries on those clients. Essentially there is no way
> to invalidate those caches when directory offsets have changed on
> an NFS server after the offset-to-dentry mapping changes.
> 
> The solution we've come up with is to make the directory cookie for
> each file in a tmpfs filesystem stable for the life of the directory
> entry it represents.
> 
> Add a per-directory xarray. shmem_readdir() uses this to map each
> directory offset (an loff_t integer) to the memory address of a
> struct dentry.
> 

How have people survived for this long with this problem?

It's a lot of new code - can we get away with simply disallowing
exports of tmpfs?

How can we maintain this?  Is it possible to come up with a test
harness for inclusion in kernel selftests?

