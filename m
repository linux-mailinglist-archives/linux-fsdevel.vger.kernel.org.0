Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25FF7710E6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 19:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjHERVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Aug 2023 13:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHERVs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:21:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9578E;
        Sat,  5 Aug 2023 10:21:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 122E560BBB;
        Sat,  5 Aug 2023 17:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19F1C433C7;
        Sat,  5 Aug 2023 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691256106;
        bh=vnKkOBQ6RUHTyaftoNB3Z3SKgzXN8Rn0e0gq3dbItmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZTUYvmls+pvZYWEM9T2IITL8yNf+2wwxbgBaM8Kn2yr8I3uGWv5DctJOL2zuteuB
         3EVFWkHOiXi5vPT4YcBQcw7kG4rwa+Zmwvv0ucc8MRClkrq9KYeQHKdkkk2OSdbWyS
         eorsL75JPTKcglr9A6JLzdLQGudJl7lKe7x5zQdZB0EMrZm8nPr5LKwktgbaOl+mKr
         cIo0s1pFKiy5ZCopohuIm1/Cr82V3GKh3T9IkeczV+tbe4Opcpdz2p8JwSfBJC5wFg
         utNC80SCZFQ6yDoxtR423ZtF4yTX3ImBSP8CTImwjp9lL+yryLIyDSL765+1yp3Tr2
         hChYdvW9S93+Q==
Date:   Sat, 5 Aug 2023 19:21:41 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] open: make RESOLVE_CACHED correctly test for O_TMPFILE
Message-ID: <20230805-hasen-unbefangen-1fa5538eb0fa@brauner>
References: <20230806-resolve_cached-o_tmpfile-v1-1-7ba16308465e@cyphar.com>
 <20230805-ignorant-kahlkopf-9749ac3cd20a@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230805-ignorant-kahlkopf-9749ac3cd20a@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 05, 2023 at 07:17:54PM +0200, Christian Brauner wrote:
> On Sun, 06 Aug 2023 02:11:58 +1000, Aleksa Sarai wrote:
> > O_TMPFILE is actually __O_TMPFILE|O_DIRECTORY. This means that the old
> > fast-path check for RESOLVE_CACHED would reject all users passing
> > O_DIRECTORY with -EAGAIN, when in fact the intended test was to check
> > for __O_TMPFILE.

And afaict, io_uring has the same problem in

static bool io_openat_force_async(struct io_open *open)
{
        /*
         * Don't bother trying for O_TRUNC, O_CREAT, or O_TMPFILE open,
         * it'll always -EAGAIN
         */
        return open->how.flags & (O_TRUNC | O_CREAT | O_TMPFILE);
}

always forcing O_DIRECTORY lookups to go async. So that needs another
fix.
