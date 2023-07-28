Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218DC766DD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 15:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbjG1NFO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 09:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjG1NFO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:05:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F68BE7E;
        Fri, 28 Jul 2023 06:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4C4062130;
        Fri, 28 Jul 2023 13:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F74C433C7;
        Fri, 28 Jul 2023 13:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690549512;
        bh=6f0YxR6kJIKpcQJtnAgNJNr+3crZNPdK8dIk7kOicWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lEr3Q0MAiH9sUs9dXYzAkRC5IC/a1DGr+64RYhurzZop+lP3bFl3DfVhO14999JpP
         59hwXPpFB/t+TGy9ZXVGDhzm9ejGScs+l5nFQ9Lv6dvcUkA390gNpgk3lnfzulJs3B
         UFPcQJNuNdHpezD9T0xAe9080HXkmpJ1SuoQHWdnzaMEMq9lMSYdoYinneN/2PtONS
         gRrTsjkzECJoQ9MF/BPDtvlEU/YafTDeMJbbtFvdjQiRz1xI03fIM6SiP5LzpFThmF
         VVEOxx/Gq5A40DRLPRSjtU+s04krvAk8kRQjRts6A7/rsuCqfu100XuikbXcwwv1tP
         WaERgDcHFdNww==
Date:   Fri, 28 Jul 2023 15:05:06 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] fchmodat2: add support for AT_EMPTY_PATH
Message-ID: <ZMO9AgYcfsR2MIa3@example.org>
References: <20230728-fchmodat2-at_empty_path-v1-1-f3add31d3516@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728-fchmodat2-at_empty_path-v1-1-f3add31d3516@cyphar.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 28, 2023 at 09:58:26PM +1000, Aleksa Sarai wrote:
> This allows userspace to avoid going through /proc/self/fd when dealing
> with all types of file descriptors for chmod(), and makes fchmodat2() a
> proper superset of all other chmod syscalls.
> 
> The primary difference between fchmodat2(AT_EMPTY_PATH) and fchmod() is
> that fchmod() doesn't operate on O_PATH file descriptors by design. To
> quote open(2):
> 
> > O_PATH (since Linux 2.6.39)
> > [...]
> > The file itself is not opened, and other file operations (e.g.,
> > read(2), write(2), fchmod(2), fchown(2), fgetxattr(2), ioctl(2),
> > mmap(2)) fail with the error EBADF.
> 
> However, procfs has allowed userspace to do this operation ever since
> the introduction of O_PATH through magic-links, so adding this feature
> is only an improvement for programs that have to mess around with
> /proc/self/fd/$n today to get this behaviour. In addition,
> fchownat(AT_EMPTY_PATH) has existed since the introduction of O_PATH and
> allows chown() operations directly on O_PATH descriptors.
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

It seems to me that this makes sense for fchmodat2.

Acked-by: Alexey Gladkov <legion@kernel.org>

> ---
>  fs/open.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index e52d78e5a333..b8883ec286f5 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -678,10 +678,12 @@ static int do_fchmodat(int dfd, const char __user *filename, umode_t mode,
>  	int error;
>  	unsigned int lookup_flags;
>  
> -	if (unlikely(flags & ~AT_SYMLINK_NOFOLLOW))
> +	if (unlikely(flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)))
>  		return -EINVAL;
>  
>  	lookup_flags = (flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
> +	if (flags & AT_EMPTY_PATH)
> +		lookup_flags |= LOOKUP_EMPTY;
>  
>  retry:
>  	error = user_path_at(dfd, filename, lookup_flags, &path);
> 
> ---
> base-commit: 4859c257d295949c23f4074850a8c2ec31357abb
> change-id: 20230728-fchmodat2-at_empty_path-310cf40c921f
> 
> Best regards,
> -- 
> Aleksa Sarai <cyphar@cyphar.com>
> 

-- 
Rgrds, legion

