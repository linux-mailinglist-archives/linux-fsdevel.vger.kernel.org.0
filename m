Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987A475205F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjGMLtq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 07:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbjGMLtp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25BAB4;
        Thu, 13 Jul 2023 04:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ECB060E83;
        Thu, 13 Jul 2023 11:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE89C433C7;
        Thu, 13 Jul 2023 11:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689248983;
        bh=vDmj731OCfOfJy54MNOlHg88Er/ll4Hf8rYHXy1IxzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BbX3Vv5jAUmkEx5pFSV7+rhtxAFbzf+NiGBa6ahrgMJVw7ZKVIZWudmHEjViZ4LoU
         IfwQ8Q46FQG6trL5dHBjnEtvP2Plrg0qDW4svp3SiYV0j/LiQfOQm53HXTo78SbAir
         3GzMFeNfiEB1tK69l7sd138RisqrDVxBz2HPO5Q7Ipdf+4uUfzUkm5K22fELX9pa3E
         jyuCpiZ9B4uWi+meeu7xLR5+eH8RFhvLPW7bsVWlGuOI7sX27xf0XKIDJJ9/pk7oP2
         OEG0K9Gce/s+zeipB+ZbhtFsN7O2dmy3BnBjteep0ldFuJO79lARP6L885dDBEUXqs
         v1+gGB3Aft6Ew==
Date:   Thu, 13 Jul 2023 13:49:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] proc: use generic setattr() for /proc/$PID/net
Message-ID: <20230713-abitur-alliierte-93460a210b1b@brauner>
References: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
 <20230624-proc-net-setattr-v1-2-73176812adee@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230624-proc-net-setattr-v1-2-73176812adee@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 24, 2023 at 12:30:47PM +0200, Thomas Weißschuh wrote:
> All other files in /proc/$PID/ use proc_setattr().
> 
> Not using it allows the usage of chmod() on /proc/$PID/net, even on
> other processes owned by the same user.
> The same would probably also be true for other attributes to be changed.
> 
> As this technically represents an ABI change it is not marked for
> stable so any unlikely regressions are caught during a full release cycle.
> 
> Fixes: e9720acd728a ("[NET]: Make /proc/net a symlink on /proc/self/net (v3)")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  fs/proc/proc_net.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
> index a0c0419872e3..78f9e6b469c0 100644
> --- a/fs/proc/proc_net.c
> +++ b/fs/proc/proc_net.c
> @@ -321,6 +321,7 @@ static int proc_tgid_net_getattr(struct mnt_idmap *idmap,
>  const struct inode_operations proc_net_inode_operations = {
>  	.lookup		= proc_tgid_net_lookup,
>  	.getattr	= proc_tgid_net_getattr,
> +	.setattr        = proc_setattr,
>  };
>  
>  static int proc_tgid_net_readdir(struct file *file, struct dir_context *ctx)

So your concern really is specifically about /proc/$pid/net itself as
that's owned by the user and thus the user itself can chmod it and thus
also restrict access for other processess running with the same uid:

chmod 0000 /proc/1234/net
ls -al /proc/self/net
ls: cannot open directory '/proc/self/net/': Permission denied

Yeah, it's not a huge deal but it's arguably a bug especially since the
original commit from 2006 that introduced proc_setattr() was clear that
it should apply to anything beneath /proc/<pid>/ owned by the user.

So I agree and we should probably try and have the same behavior for
/proc/$pid/net as well. We can see if that breaks something.
