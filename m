Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEE6502BA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 16:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354368AbiDOOWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 10:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiDOOWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:22:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461B4B7C2;
        Fri, 15 Apr 2022 07:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 104B2B82E33;
        Fri, 15 Apr 2022 14:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67E6C385A5;
        Fri, 15 Apr 2022 14:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650032380;
        bh=lB0q6SgBOeaOtr18Ish5vUaCGSkpyRA0FKi6vpJK9SM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tkmduwwl4ubxFcTu71avm1GFBVb1xragubeW8MEpDelTky+0c6rCfikNs4uBcUfif
         IXJmdfE2LD1TQfS8rcfBfLmNF5GO8S2J72FHZBe/AoznZ23jv0li9i7WorKweK5zlq
         UDdVbouPGxVsU0OwUWdfgJ6V7gAXfNDoxr6ZMLHFUHJunhXWDExXAGd434++/Gyji3
         qpooi67kIe2W+SQXG/DbN6qOZYXIEIVroZl0Qp3LXpuSH5hAP85bqNyk4sNT1oUCEj
         iIGXDSC/3QYtca5xJCfjDUFuUOiB6S8rjJD+hKSsVRUYJMC0pRW4HEZ5rVOayknrfR
         QD7vRUMBK3mDg==
Date:   Fri, 15 Apr 2022 16:19:36 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        viro@zeniv.linux.org.uk, jlayton@kernel.org
Subject: Re: [PATCH v3 5/7] fs: Add new helper prepare_mode
Message-ID: <20220415141936.gu4vellwglati7z5@wittgenstein>
References: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650020543-24908-5-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650020543-24908-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 15, 2022 at 07:02:21PM +0800, Yang Xu wrote:
> As Christian Brauner suggested, add a new helper calls inode_sgid_strip()
> and does the umask stripping as well and then call it in all these places.
> 
> This api is introduced to support strip file's S_ISGID mode on vfs instead
> of on underlying filesystem.
> 
> Suggested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

I don't think this needs to be a separate patch especially since the
helper is not in any header file. So just squah patch 5 and 6 imho.

>  include/linux/fs.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 4a617aaab6f6..8c2f4cde974b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3458,6 +3458,15 @@ static inline bool dir_relax_shared(struct inode *inode)
>  	return !IS_DEADDIR(inode);
>  }
>  
> +static inline void prepare_mode(struct user_namespace *mnt_userns,
> +				const struct inode *dir, umode_t *mode)
> +{
> +	inode_sgid_strip(mnt_userns, dir, mode);
> +
> +	if (!IS_POSIXACL(dir))
> +		*mode &= ~current_umask();
> +}
> +
>  extern bool path_noexec(const struct path *path);
>  extern void inode_nohighmem(struct inode *inode);
>  
> -- 
> 2.27.0
> 
