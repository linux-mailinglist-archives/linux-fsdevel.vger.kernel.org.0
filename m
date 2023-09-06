Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D93C793348
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 03:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjIFBSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 21:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjIFBSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 21:18:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E4BCEA;
        Tue,  5 Sep 2023 18:18:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCEFC433C8;
        Wed,  6 Sep 2023 01:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693963115;
        bh=eeHDRb7VfosuUqyYtVjvJ/NSWIjvkBytSfOcika1FK4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C5eFJfawMth3UCf6NW1kktZ9SXhIy6WntHswux69S6WFgqvd9zvXOD1KwjeR/czbg
         tTMhxsBbJL+qOoOdeHO0uYKjfks+MFY3wIzX/B16aHnOSXY76S0Q+UlJyYo8t9a5Fh
         XNMG31KtJJZsJKo14ObOrzQC5+Dv6GPD1Y3d8n5k9dyosfdiSL9JKGGBR7YKrP7jqd
         GFH6+pjResjDfIY6OsRpjmJzoiGf7kBcQcb1RxbsKgW3ixHiVVJkB1llRMaovplcc5
         kD/1ohrUQFkibDlpLB4omNnybNnZhvjQ4F30MxOPBUCLyYyv8Lt2+0apx9y8TBVHSb
         1gC6DprOFNQLA==
Message-ID: <c27f7736-33b6-71ea-97aa-81bcbce342e8@kernel.org>
Date:   Wed, 6 Sep 2023 10:18:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] iomap: handle error conditions more gracefully in
 iomap_to_bh
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, djwong@kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
References: <20230905124120.325518-1-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230905124120.325518-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/5/23 21:41, Christoph Hellwig wrote:
> iomap_to_bh currently BUG()s when the passed in block number is not
> in the iomap.  For file systems that have proper synchronization this
> should never happen and so far hasn't in mainline, but for block devices
> size changes aren't fully synchronized against ongoing I/O.  Instead
> of BUG()ing in this case, return -EIO to the caller, which already has
> proper error handling.  While we're at it, also return -EIO for an
> unknown iomap state instead of returning garbage.
> 
> Fixes: 487c607df790 ("block: use iomap for writes to block devices")
> Reported-by: syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

