Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2786E4C823F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 05:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiCAEWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 23:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiCAEWl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:22:41 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6A6344DF
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 20:22:01 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so1150886pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 20:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xcD3DLzlSiv5+2xjOLCVbu4Mz1FZrHNfXkP4SfFAO8M=;
        b=AsAcUiT4NrNpzqrWszR0OWWixCi8jN2fDRzW4vxT3O7KAUy5XNJF+N2BSNetl96BSc
         QdVzuxwjw4EaU71YRBhD98Zm2dad2IhB5TYv4hH4eV7aLLJOzMO93WY2Zr0a6NCdp0Vs
         e57PBJ6k1tlcd0oFHqBaZ2i3yc78o0wKxY6JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xcD3DLzlSiv5+2xjOLCVbu4Mz1FZrHNfXkP4SfFAO8M=;
        b=FmKhJk3CI2uBJE+Q/4ZqKpLLYJXCVBKy+GCsbS1I9Hqyf2OXsMdDl+1YEtY/bQnZ48
         PK6AHugdwTZIGj08DFc0EksnIl9GXHdGNpIUdpnGDYN1OM/P+OGpqPMZhoqW+G95D0dE
         Na64YJgNlGL3xVzoweauUfNb4JAoqQm7YHJmNwLuLTMF3uebtVax7zGuND4uiCE3QmGZ
         JWltZjWJ8NwLgwYsbTIZFIpHrR7DKRvgKymLaNIMHjdEng30oPHCgvF0CoJPUGvM+gtb
         84Ck2L/889eMj6vS6Ww+SB9YFs4yEOJwx3dPSgcBS7Sz6r2Y1ibRIr9TJcMQvz54RY/n
         6BwQ==
X-Gm-Message-State: AOAM532rHyBspvLdsOc6Yc+YbBVA3p0er2wvgta/FwDvmcjIUApcIhXG
        BUbOpdWCaN1HLtYg+/Mz3nz3TCnnvdpU2A==
X-Google-Smtp-Source: ABdhPJwwbP2Sa8V8bqQ8Sj5wA8WG+81HwJJqlkxz7EeIf458BpFvq8FByyWaKKp+nvTcdX/dynhLSg==
X-Received: by 2002:a17:902:d504:b0:14d:846f:e7da with SMTP id b4-20020a170902d50400b0014d846fe7damr18148823plg.133.1646108521297;
        Mon, 28 Feb 2022 20:22:01 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:95ec:e94d:ec6b:6068])
        by smtp.gmail.com with ESMTPSA id o7-20020a63f147000000b00373facf1083sm11415554pgk.57.2022.02.28.20.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 20:22:00 -0800 (PST)
Date:   Tue, 1 Mar 2022 13:21:55 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 3/4] ksmbd: increment reference count of parent fp
Message-ID: <Yh2fY6F8n/8KvMEH@google.com>
References: <20220228234833.10434-1-linkinjeon@kernel.org>
 <20220228234833.10434-3-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228234833.10434-3-linkinjeon@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (22/03/01 08:48), Namjae Jeon wrote:
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index 3151ab7d7410..03c3733e54e4 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -5764,8 +5764,10 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
>  	if (parent_fp) {
>  		if (parent_fp->daccess & FILE_DELETE_LE) {
>  			pr_err("parent dir is opened with delete access\n");
> +			ksmbd_fd_put(work, parent_fp);
>  			return -ESHARE;
>  		}
> +		ksmbd_fd_put(work, parent_fp);
>  	}

And also in ksmbd_validate_entry_in_use()?

>  next:
>  	return smb2_rename(work, fp, user_ns, rename_info,
> diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
> index 0974d2e972b9..c4d59d2735f0 100644
> --- a/fs/ksmbd/vfs_cache.c
> +++ b/fs/ksmbd/vfs_cache.c
> @@ -496,6 +496,7 @@ struct ksmbd_file *ksmbd_lookup_fd_inode(struct inode *inode)
>  	list_for_each_entry(lfp, &ci->m_fp_list, node) {
>  		if (inode == file_inode(lfp->filp)) {
>  			atomic_dec(&ci->m_count);
> +			lfp = ksmbd_fp_get(lfp);
>  			read_unlock(&ci->m_lock);
>  			return lfp;
>  		}
> -- 
> 2.25.1
> 
