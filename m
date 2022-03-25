Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C849D4E7CD5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 01:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiCYUfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 16:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiCYUfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:35:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B4A95A36
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 13:33:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78223B82824
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 20:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ADAC2BBE4;
        Fri, 25 Mar 2022 20:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648240435;
        bh=23DjXXiTUJsJnJ7kMRRs7+jvXYwVWTNyVfEl1FLt0YQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkGOr/CgAiUZjajLBP9ykQxq70VQNlHdnh3yefCNVAlx/Dz59nJsBPTXBAIqM01VM
         uNzD0VHf8AeB14uvN6KFpHqdK/A0YqrjwIK1Nu5SKKWwoQbypMGKfxBzcZa92/qyUc
         npUPr4hm7F1vkAUYAHzmKNDxtrdmaKww/D1wPkLXTUKM79ckHUpY4KAgzIHzOqy0IG
         BLNEtfTnFMfsrAQRUTNnjJDDrsOTOFDUVt0KjShdE/3Xiz/rQRWF1T5WIdvLYZSx01
         BXjF8b39KN7vL0H/hilI4q/HRwIHG7fPWuP4Rn/i4laq/6XVFlXaXyw3DMug4nx2+T
         K6F0aNvmqtjlw==
Date:   Fri, 25 Mar 2022 20:33:53 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     jianchunfu <jianchunfu@cmss.chinamobile.com>
Cc:     krisman@collabora.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] fs:unicode:mkutf8data.c: Fix the potential stack overflow
 risk
Message-ID: <Yj4nMZ33/Rrh5qhc@gmail.com>
References: <20220325091443.59677-1-jianchunfu@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325091443.59677-1-jianchunfu@cmss.chinamobile.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 25, 2022 at 05:14:43PM +0800, jianchunfu wrote:
> I'm not sure why there are so many missing checks of the malloc function,
> is it because the memory allocated is only a few bytes
> so no checks are needed?
> 
> Signed-off-by: jianchunfu <jianchunfu@cmss.chinamobile.com>
> ---
>  fs/unicode/mkutf8data.c | 54 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 

mkutf8data is a host tool used during the build, not kernel code, so it doesn't
really matter.  If malloc returns NULL, the tool will crash, which will be
treated as a build error, just like if it cleanly reported a failure.  It's
definitely poor practice, though.

How about just adding and using a helper function "xmalloc()" that has a NULL
check built in?  That would be much simpler than your patch.

- Eric
