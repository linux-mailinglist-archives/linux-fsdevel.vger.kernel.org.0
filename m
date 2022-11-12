Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378B16268C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Nov 2022 11:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiKLKJx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Nov 2022 05:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLKJw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Nov 2022 05:09:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFC55F56
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Nov 2022 02:09:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69C40608C1
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Nov 2022 10:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E83C433C1;
        Sat, 12 Nov 2022 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668247789;
        bh=DjolpFHX/1j4ZdzyQhh5FPOGdHe2I6mLsiKrB9yPb0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SSOPwqpaVcWJPq/pYgkJPQnbhqX3Wg/tpl0ZXR/iUsa4m5tnM4Z95ijfPRGbmfDCx
         CzTrUhUS4Ytr5vfuoho14VDqyQH0Lu/asTn902NE6zxeYpNd3hhVI/YXnOo9ZvwXbG
         v6ig3klDh6cUHeY0rtsjPLPL5I8SHXjofZWYsH3rzCV0GedU4ppJWGb0VKV2ZSzDDT
         +qsfO/P91glU1seSC1Hy8Z+p6uLw4VnxdI3T29sBIxe15RGtmBy+odkQOG+XRP6VuO
         EhWKV+J4sin1Tkj5kalFcRZ61qXiu0GoRQlAT1aS1SMokADm0yyT/488JbLBawPzhL
         yxkfrzl8PZZ3g==
Date:   Sat, 12 Nov 2022 11:09:45 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 01/30] orangefs: rework posix acl handling when
 creating new filesystem objects
Message-ID: <20221112100945.uig2jef74oxbg6gd@wittgenstein>
References: <20221018115700.166010-1-brauner@kernel.org>
 <20221018115700.166010-2-brauner@kernel.org>
 <CAOg9mSSq_yV=q5J6sEh8qHWwLe_wYwwsb1rTEh11k52D2nm11g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOg9mSSq_yV=q5J6sEh8qHWwLe_wYwwsb1rTEh11k52D2nm11g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 11, 2022 at 04:38:26PM -0500, Mike Marshall wrote:
> Hello... I have applied your v5 patch series to 6.1-rc2. I get
> numerous acl related xfstests failures with your patch.
> 
> generic/105 is the first one that fails, so I got started dee-ciphering
> what it does.
> 
> I hoped I could find what it is in the patch that causes the
> regression, but I have not yet, and we're already up to rc4.
> 
> I have a sequence of events that is part of generic/105 where
> I believe "the bad thing" happens, I thought I'd show you, you
> might know right away what is wrong...
> 
> 6.1-rc2 without the patch series:
> root@vm1 ~]# cd /scratch
> [root@vm1 scratch]# mkdir -m 600 subdir
> [root@vm1 scratch]# chown 13 subdir
> [root@vm1 scratch]# echo data > subdir/file
> [root@vm1 scratch]# ls -l subdir/file | awk '{ print $1, $3 }'
> -rw-r--r--. root
> 
> 6.1-rc2 with the patch series:
> [root@vm1 hubcap]# cd /scratch
> [root@vm1 scratch]#  mkdir -m 600 subdir
> [root@vm1 scratch]# chown 13 subdir
> [root@vm1 scratch]# echo data > subdir/file
> [root@vm1 scratch]# ls -l subdir/file | awk '{ print $1, $3 }'
> -rw-rw-rw-. root
> 
> The commit message for the orangefs part of the patch
> says "calculate the correct mode directly before
> actually creating the inode."
> 
> Anywho... I'll keep looking...

Thanks for the report. I'm mostly afk this weekend but I've installed
the orangefs-server on Fedora and will reproduce and fix this early next
week.
