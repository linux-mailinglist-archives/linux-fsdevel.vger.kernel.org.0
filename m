Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCA2597E7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 08:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243392AbiHRGTi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 02:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbiHRGTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:19:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2686367477;
        Wed, 17 Aug 2022 23:19:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 68AA1CE1FC4;
        Thu, 18 Aug 2022 06:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D59C433D7;
        Thu, 18 Aug 2022 06:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660803572;
        bh=hM1mBVLqbFsDP5tgvV4YmWcCLqFBhCnzo6UTUeNmQDo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=mEv6NfFYVoSdIwb8atzrvqGLvmWgbcRIWv7lJ6KpRzgn5bPzSEKKBr4xBo0xmf3Y2
         IzdkDdFlgwjQNpRWm4imudEgu4D2HioJisnLN9vGJwd8BAJAfyurlS1LvTGd7xeyjy
         qMeyGc/+/hClxttZww39er6UFJX1g7OwdRhj+v2ZpL+TBNJhIMrNQo5mIUyovEmsop
         uNP7QhXQaufrRx+toXjG7Gvn5Tyju1YNhsBRsy/G5xBsZpEda0Tey54V4/b4vV3Fn+
         6jQV47Gv0nEVEcJVct+J6X3IkMmFRIAg3HtFfG1XneyrvWvt0K0vsjKQXYw+rXeLEg
         9ERQGh6kyJ+zA==
Received: by mail-oi1-f176.google.com with SMTP id c185so611311oia.7;
        Wed, 17 Aug 2022 23:19:32 -0700 (PDT)
X-Gm-Message-State: ACgBeo15IHyIRFcLjH/y+8h6E3btK6TS462yAM2VXQ2J8gyeUteQ+Bls
        4yjabm/+qL95Klydtqq00lUHhrjPtWpcs3FI1Bs=
X-Google-Smtp-Source: AA6agR4A7YMR8rdH+T3to9r6ulvjKEH1r7K5iASABwfYd4uwUNu0EtoocSVHyFy50wklDI4ktWK10Yw5TNuM64q+dhg=
X-Received: by 2002:a05:6808:14d5:b0:344:8f50:1f0f with SMTP id
 f21-20020a05680814d500b003448f501f0fmr700783oiw.257.1660803571711; Wed, 17
 Aug 2022 23:19:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:27c7:0:0:0:0 with HTTP; Wed, 17 Aug 2022 23:19:31
 -0700 (PDT)
In-Reply-To: <Yv2qyayq+Jo/+Uvs@ZenIV>
References: <Yv2qoNQg48rtymGE@ZenIV> <Yv2qyayq+Jo/+Uvs@ZenIV>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 18 Aug 2022 15:19:31 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-8v8KGofNjCwMeH9Sq-WGK0roRdiTLZ42eUdkpkPnOHw@mail.gmail.com>
Message-ID: <CAKYAXd-8v8KGofNjCwMeH9Sq-WGK0roRdiTLZ42eUdkpkPnOHw@mail.gmail.com>
Subject: Re: [PATCH 2/5] ksmbd: don't open-code file_path()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-08-18 11:58 GMT+09:00, Al Viro <viro@zeniv.linux.org.uk>:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
> ---
>  fs/ksmbd/smb2pdu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index 9751cc92c111..0e1924a6476d 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -5416,7 +5416,7 @@ static int smb2_rename(struct ksmbd_work *work,
>  	if (!pathname)
>  		return -ENOMEM;
>
> -	abs_oldname = d_path(&fp->filp->f_path, pathname, PATH_MAX);
> +	abs_oldname = file_path(fp->filp, pathname, PATH_MAX);
>  	if (IS_ERR(abs_oldname)) {
>  		rc = -EINVAL;
>  		goto out;
> @@ -5551,7 +5551,7 @@ static int smb2_create_link(struct ksmbd_work *work,
>  	}
>
>  	ksmbd_debug(SMB, "link name is %s\n", link_name);
> -	target_name = d_path(&filp->f_path, pathname, PATH_MAX);
> +	target_name = file_path(filp, pathname, PATH_MAX);
>  	if (IS_ERR(target_name)) {
>  		rc = -EINVAL;
>  		goto out;
> --
> 2.30.2
>
>
