Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F2E628837
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 19:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbiKNSUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 13:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiKNSUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:20:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE33A461;
        Mon, 14 Nov 2022 10:20:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB321B80E9A;
        Mon, 14 Nov 2022 18:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF45C433D7;
        Mon, 14 Nov 2022 18:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668450039;
        bh=6rrV9le5kLOXSW9wg4wECadYOt8F4Fow9dl9fDjmFpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fwWVc+qDMP/qhateNdVfHhROUCFKrHjgWeIylTD8/2rsblM+v65ZGj/0SMeusqsT1
         ojNEBSeo6PWtqM9Rghx2QxNfBOQZGY6WtHTFuF9e7ZZECebOOeB+qqfnUr0CerSETZ
         HvdaHtKB7BCHd9SRTG2qw0OSwv76NP36ohGfLIEpUGlABTZxH0tSuXSN3NEYGNoE39
         0OY3/GBQjuIObhEsgiD5WcrZ62jM0+ezTIXlQSIiwWkb0JTsX/ZIKk+1BUnkc+Ppz6
         Wsl6f9hoI0DLzouQqcSqtykxbEb3RyWH7JRR1GPCrzoOciWfNP9ZbjgF2YBkctrwcu
         XJ6uKckB+2Vww==
Date:   Mon, 14 Nov 2022 18:20:37 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs: ext4: initialize fsdata in pagecache_write()
Message-ID: <Y3KG9bAo11t84SIg@gmail.com>
References: <20221114082935.3007497-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114082935.3007497-1-glider@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 14, 2022 at 09:29:35AM +0100, Alexander Potapenko wrote:
> [PATCH] fs: ext4: initialize fsdata in pagecache_write()
>
> When aops->write_begin() does not initialize fsdata, KMSAN reports
> an error passing the latter to aops->write_end().
> 
> Fix this by unconditionally initializing fsdata.
> 
> Also speculatively fix similar issues in affs, f2fs, hfs, hfsplus,
> as suggested by Eric Biggers.

You might have better luck with separate patches for each filesystem, as it
might be hard to get someone to apply this patch otherwise.

If you do go with a single patch, then the subject prefix should be "fs:", not
"fs: ext4:".

- Eric
