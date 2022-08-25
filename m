Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589E55A07D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 06:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiHYEWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 00:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHYEWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 00:22:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DB76C13B
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Aug 2022 21:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E27DB81B80
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Aug 2022 04:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC66BC433D6;
        Thu, 25 Aug 2022 04:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661401370;
        bh=0tghq81Ez+xH950H6LvfzcdsXzfldHVIqiG0QoK1dr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QXFOqNhQOG1Z392fLkx3vtIDNhSKBmZESVXmgRBEjEUagPJ6N4tnazBiItiBmXwgV
         P6XNFhJ5NVzomqk510JdwwJWWfWltFNyp9OxgVLHv+HgHsK/PBjflUeuNnKmNbwacB
         sI+aJvyx9lNqwqVWYgWzZWw9KfZPX2I5/tqnR4ucTxMDy/f4P6GSiYl3xTd/42DlCi
         4snJy6Ik8W7ew0gYNOaRgCkX5oU+QVChM2fEBvtE22wsHONlarLybOp5ZStAHyn3e1
         zMy9OpPK/NA7wcreaHHLtVAfnWJnFpbT2B1kuMura8ATPbOQaqfsBYwcqbFEJdSxjY
         Clq3ry5iNqYKQ==
Date:   Thu, 25 Aug 2022 07:22:43 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/8] sgx: use ->f_mapping...
Message-ID: <Ywb5E94yMS/r+LXT@kernel.org>
References: <YwFANLruaQpqmPKv@ZenIV>
 <YwFBAdENeoM+CSTT@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwFBAdENeoM+CSTT@ZenIV>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 20, 2022 at 09:16:01PM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/x86/kernel/cpu/sgx/encl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 24c1bb8eb196..6de17468ca16 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -906,8 +906,7 @@ const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl)
>  static struct page *sgx_encl_get_backing_page(struct sgx_encl *encl,
>  					      pgoff_t index)
>  {
> -	struct inode *inode = encl->backing->f_path.dentry->d_inode;
> -	struct address_space *mapping = inode->i_mapping;
> +	struct address_space *mapping = encl->backing->f_mapping;
>  	gfp_t gfpmask = mapping_gfp_mask(mapping);
>  
>  	return shmem_read_mapping_page_gfp(mapping, index, gfpmask);
> -- 
> 2.30.2
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
