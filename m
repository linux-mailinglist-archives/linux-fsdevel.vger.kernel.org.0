Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929A44F7FB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 14:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245649AbiDGNBx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 09:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245647AbiDGNBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:01:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240F719950C;
        Thu,  7 Apr 2022 05:59:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE24AB8276C;
        Thu,  7 Apr 2022 12:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F080C385A0;
        Thu,  7 Apr 2022 12:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649336385;
        bh=YJlPFEX+O6/wI6+2H4H++FVq+8HZ7V4/0FOYSYgOUdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TViDNzr61d/robSU6BYyE16ygDP2zABG9uUReRGzD3rpDk4CzARXJit2Cy8PN5DA7
         Yn3tr0W2LAHwBW/63Lr+fyiDY0FZq6gjaQeuKpJaej5pU67InhDip+why/fvtirjcN
         fY4cF3XyRXRyHHL/lMtppjkSeKeliJfRWGPwG8YGM3qAJpO1pudES4VeyWzBSlVDfs
         J0greJuuuVghqnXd8f47UVFGXg3spTJwGHFSiSDyUPUhqcwCX2Sa94c9s8pquScCe3
         m9noGPCKG+gu0kWUqyi9Mjgi1pg0WjNQl+LaaJbJzGyYiu5rhHqji5kijgAph4CYeT
         154PGVXFUQW3Q==
Date:   Thu, 7 Apr 2022 14:59:36 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2 3/6] idmapped-mounts: Reset errno to zero after detect
 fs_allow_idmap
Message-ID: <20220407125936.hxp5oqddxpbtb27w@wittgenstein>
References: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649333375-2599-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649333375-2599-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 07, 2022 at 08:09:32PM +0800, Yang Xu wrote:
> If we run case on old kernel that doesn't support mount_setattr and
> then fail on our own function before call is_setgid/is_setuid function
> to reset errno, run_test will print "Function not implement" error.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  src/idmapped-mounts/idmapped-mounts.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> index e8a856de..d2638c64 100644
> --- a/src/idmapped-mounts/idmapped-mounts.c
> +++ b/src/idmapped-mounts/idmapped-mounts.c
> @@ -14254,6 +14254,8 @@ int main(int argc, char *argv[])
>  		die("failed to open %s", t_mountpoint_scratch);
>  
>  	t_fs_allow_idmap = fs_allow_idmap();
> +	/*Don't copy ENOSYS errno to child proecss on older kernel*/

nit: s/proecess/process/
