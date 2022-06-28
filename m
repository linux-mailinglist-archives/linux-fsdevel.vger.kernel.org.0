Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC4155E3EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiF1M5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiF1M5F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:57:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45732FE6F;
        Tue, 28 Jun 2022 05:57:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8097F60F43;
        Tue, 28 Jun 2022 12:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3BCC3411D;
        Tue, 28 Jun 2022 12:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656421023;
        bh=NV1nc+PhAL8+uxW888wxL8Bu7nqpR4cXRNoKsXAqrj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O3Wlfm471hyojpg/8aHEVI1XlA6decDKQZp+bF99F3RVMeGKT8uTbRJLCJtiE+h3l
         uKMNsP25iTuA5ruLdPK46Xd65f5Irakde6nuLk3v03PG9IpvhesSdhiiQJ4DY1ga5R
         uiDQfDNEtl9ciQZb8meWZTa67xG3lu0ml/ZyH4hwCTllkAcPSM1ANOKiujK7VZYvs9
         zIescM5OSt8kkCDjrhJYGk9iTMM5XkaE9BaUnpOZ8n1TMjOGHx2VBBJ0aC/CdWQgK2
         TeJBNjgC/Ri4bmzhoHXPA3PqpLuUtMTNDlqp+NvsvjfQ4dGndj3SedF025e6etE8uF
         6T1gHEkwYHPQw==
Date:   Tue, 28 Jun 2022 14:56:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 5/8] fs: use new capable_any functionality
Message-ID: <20220628125659.l6irgn6ryoseojv3@wittgenstein>
References: <20220502160030.131168-8-cgzones@googlemail.com>
 <20220615152623.311223-1-cgzones@googlemail.com>
 <20220615152623.311223-4-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615152623.311223-4-cgzones@googlemail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 15, 2022 at 05:26:19PM +0200, Christian Göttsche wrote:
> Use the new added capable_any function in appropriate cases, where a
> task is required to have any of two capabilities.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---

Not seeing the whole patch series so it's a bit difficult to judge but
in general we've needed something like this for quite some time.

> v3:
>    rename to capable_any()
> ---
>  fs/pipe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 74ae9fafd25a..18ab3baeec44 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -776,7 +776,7 @@ bool too_many_pipe_buffers_hard(unsigned long user_bufs)
>  
>  bool pipe_is_unprivileged_user(void)
>  {
> -	return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
> +	return !capable_any(CAP_SYS_RESOURCE, CAP_SYS_ADMIN);
>  }
>  
>  struct pipe_inode_info *alloc_pipe_info(void)
> -- 
> 2.36.1
> 
