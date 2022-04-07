Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989644F7FA1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 14:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245556AbiDGM5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 08:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245571AbiDGM5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:57:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E7149911;
        Thu,  7 Apr 2022 05:55:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA4BF6162C;
        Thu,  7 Apr 2022 12:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DACC385A4;
        Thu,  7 Apr 2022 12:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649336113;
        bh=KSvYjYXkyEYjYiuQ8olYJeBAk2b7OH8Gu6YSEawgljQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aBR1o6MvPi5VZcr/NOLXLhr5l/+x2OLxnxDQkEReVqlwVLtp52Sw+Xg1N7mlW1cYP
         bjeE+4uSDI2/jcB45Qq5zahARq4PnHgZcRr6F/cCUY9GJO0gfQDomNZx5TD2vYHReB
         6pJILacM/t2L7xi5G/cw+dC1LJaAZOvWWjMsA4mBuYmF02aliPC1Z6ifHkIc7yT84G
         eGJgkZbv2u2Vwp4YHVN8rV6mJK1T72Kdtp5f+QucV52mSS8j7hauPqIhHWUmX2Kdrz
         f3LcHXmwVhal0qYb2LaIEb27BjiTabcg+O2xsRKP2NjATnczgSVAHwgF+z/L328pia
         BPWkIzcMbTCcw==
Date:   Thu, 7 Apr 2022 14:55:09 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/6] idmapped-mount: split setgid test from test-core
Message-ID: <20220407125509.ammsotnbrimbqjbo@wittgenstein>
References: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 07, 2022 at 08:09:30PM +0800, Yang Xu wrote:
> Since we plan to increase setgid test covertage, it will find new bug
> , so add a new test group test-setgid is better.
> 
> Also add a new test case to test test-setgid instead of miss it.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  src/idmapped-mounts/idmapped-mounts.c | 19 +++++++++++++++----
>  tests/generic/999                     | 26 ++++++++++++++++++++++++++
>  tests/generic/999.out                 |  2 ++

I actually didn't mean to split out the existing setgid tests. I mean
adding new ones for the test-cases you're adding. But how you did it
works for me too and is a bit nicer. I don't have a strong opinion so as
long as Dave and Darrick are fine with it then this seems good to me.

One note about the test name/numbering though. It seems you haven't
added the test using the provided xfstest infrastructure to do that.
Instead of manually adding the test you should run the "new" script.

You should run:

        ~/src/git/xfstests$ ./new generic

        Next test id is 678
        Append a name to the ID? Test name will be 678-$name. y,[n]:
        Creating test file '678'
        Add to group(s) [auto] (separate by space, ? for list): auto quick attr idmapped mount perms
        Creating skeletal script for you to edit ...

that'll automatically figure out the correct test number etc.
