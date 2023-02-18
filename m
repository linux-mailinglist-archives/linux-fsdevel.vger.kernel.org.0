Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF3969BBE0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 21:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBRUgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 15:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBRUgK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 15:36:10 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CCE144B3;
        Sat, 18 Feb 2023 12:36:09 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id BAC1EC009; Sat, 18 Feb 2023 21:36:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676752591; bh=/pFwTlz4AiDVvxjY6gJ7Ns3KKC9mALcI1mGQLAJfu0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCr+rnIlmqlEC+mbn65lqO+j/k6eE256kccNfwENTqhC5ZvRSBDrhRtsRVm7pm5I0
         ZyIOFV8PtwmBzCEgkAC771iNgrotw8vFMlOiXgYbDSjiuIzic7jziilDYcAwnbgHUI
         77W1L6GR5FGjxj3dK70BkV0ROn0xXAvYgLhXupQJdGak/fWhcPe+J+VJKlIpDOxFZm
         1Vjgvp/0UP8HAxk5cbXLXWJhOSIA3K3fyWraM21DR2vz1ElgEY8bfI/0h7jrsll4C/
         eT/G4FJSHV3o8ImK/gGhy7r4OuH2ZpnkyZhAPpQHrARfgCQH5CVuwvSHexCHZIOKHC
         H1aGYaFD8Nrgg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id A4471C009;
        Sat, 18 Feb 2023 21:36:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676752591; bh=/pFwTlz4AiDVvxjY6gJ7Ns3KKC9mALcI1mGQLAJfu0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCr+rnIlmqlEC+mbn65lqO+j/k6eE256kccNfwENTqhC5ZvRSBDrhRtsRVm7pm5I0
         ZyIOFV8PtwmBzCEgkAC771iNgrotw8vFMlOiXgYbDSjiuIzic7jziilDYcAwnbgHUI
         77W1L6GR5FGjxj3dK70BkV0ROn0xXAvYgLhXupQJdGak/fWhcPe+J+VJKlIpDOxFZm
         1Vjgvp/0UP8HAxk5cbXLXWJhOSIA3K3fyWraM21DR2vz1ElgEY8bfI/0h7jrsll4C/
         eT/G4FJSHV3o8ImK/gGhy7r4OuH2ZpnkyZhAPpQHrARfgCQH5CVuwvSHexCHZIOKHC
         H1aGYaFD8Nrgg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 2df64c9a;
        Sat, 18 Feb 2023 20:36:02 +0000 (UTC)
Date:   Sun, 19 Feb 2023 05:35:47 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <ericvh@gmail.com>
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH v4 03/11] fs/9p: Consolidate file operations and add
 readahead and writeback
Message-ID: <Y/E2o2/NmfTyfiM5@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-4-ericvh@kernel.org>
 <Y/CZVEQPFFo0zMjo@codewreck.org>
 <CAFkjPTm909jFaEnpmSMBu-6uZnPBVyU_KqMFzWCwbDopT4jCAA@mail.gmail.com>
 <CAFkjPTmZB273pMkQiX1mcBb4XgM5oo8dHZqV-MSPuTKFrFPkSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFkjPTmZB273pMkQiX1mcBb4XgM5oo8dHZqV-MSPuTKFrFPkSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 10:19:47AM -0600:
> ...of course, relooking at the functions in mm/filemap.c it seems like
> I can probably just use filemap_fdatawrite
> instead of having my own flush function since it basically sets up wbc
> the same way....

hmm, I was basing myself off file_write_and_wait_range that also calls
file_check_and_advance_wb_err before returning, but the wait actually
comes from fdatawrite in there...

So, right:
 - WB_SYNC is probably ok, but if we go that way let's use
filemap_fdatawrite -- less things to think about :)
 - if we want any sort of error reporting
file_check_and_advance_wb_err() is probably useful, at which point
keeping the old function is just as good. That doesn't do any wait, just
checks f_wb_err ... in a really complicated way... I don't want to have
to think about.

--
Dominique
