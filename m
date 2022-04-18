Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284E7504B22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 05:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiDRDHF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Apr 2022 23:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiDRDHE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Apr 2022 23:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08A6B186FB
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Apr 2022 20:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650251063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqhFZT5SobYTnPgdFY0kzfO4S6KCKic7s1jHUjYq5VQ=;
        b=SmNkwCKQncUqIQt48tj2oeef7p7xuFcclSuJ7GvYDXLPNfmoXBxIMBZhP8f5IGohbjCi87
        U5z8LDRAfYC+9fRm97bENQnR77XtBqF+mOY5lT36yRNOMrAeIG5Jp+Sqc+v76ENe6lLR1k
        WFyU1+2Mm+1UXffi8yJ+7Vkmjes3F8g=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-ORFJ6fNoMrys_kRuyUwdug-1; Sun, 17 Apr 2022 23:04:22 -0400
X-MC-Unique: ORFJ6fNoMrys_kRuyUwdug-1
Received: by mail-pg1-f197.google.com with SMTP id h14-20020a63530e000000b0039daafb0a84so8008183pgb.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Apr 2022 20:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kqhFZT5SobYTnPgdFY0kzfO4S6KCKic7s1jHUjYq5VQ=;
        b=4eSE67b2NDMABCa9ImY5YygPeJ3ezb6QK7SMRafnlXXgGs+4yugrrL9ZPHF/woM7gX
         aFSKqHL3/5hyc1BhMzV+d7JOBkXFVQzE7O3GkMP7V28xBfGhG6u+6sajjNSc3zTII8nb
         DIlj4JPMrOnre+UNvxkaZCUIQmDbZsynHnVYF8WTWWOnwaOnY1uUqgSlFGKaTcgTVFgL
         zzezoAHSA/7/J3/9STLqipcUMGAsDJe0tg9p+3cr+bQy0bT4dEDaOOs/frh8BYMX8ET9
         3xZdzP6uvSM8eUzgvoKNdH/AYlO/LRsrXRLuEu/CDkVB//4Hf1Okih+n1QIZtXOdztqv
         s3rg==
X-Gm-Message-State: AOAM532/3Sr4/l/D8+wx0caPxWtt9pg8vrh9ElFzBJn/q7YdAdbzTf0K
        5qzEnTCKg2sTxls921wrPXYNA9iRj7PHVU6sxtPOLMcizys9mUNywZYakPFa0Scsz4SmwMGIEeQ
        faYlj9I3V7g8y1Fh32+NYQAuepw==
X-Received: by 2002:a17:902:854c:b0:158:35ce:9739 with SMTP id d12-20020a170902854c00b0015835ce9739mr8880067plo.150.1650251061596;
        Sun, 17 Apr 2022 20:04:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFmGkrLS7i0nLz7OIAzvk++53AKMXfM0Mx8XUkioDfWxX6+VSI8xm58OPKZutB5XT3pPdu4w==
X-Received: by 2002:a17:902:854c:b0:158:35ce:9739 with SMTP id d12-20020a170902854c00b0015835ce9739mr8880057plo.150.1650251061397;
        Sun, 17 Apr 2022 20:04:21 -0700 (PDT)
Received: from [10.72.12.77] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m10-20020a17090a414a00b001cb776494a5sm15419779pjg.0.2022.04.17.20.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 20:04:20 -0700 (PDT)
Subject: Re: [PATCH v3 7/7] ceph: Remove S_ISGID clear code in
 ceph_finish_async_create
To:     Yang Xu <xuyang2018.jy@fujitsu.com>, david@fromorbit.com,
        djwong@kernel.org, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        viro@zeniv.linux.org.uk, jlayton@kernel.org
References: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650020543-24908-7-git-send-email-xuyang2018.jy@fujitsu.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <c26f5638-b97e-babf-3177-99fbcd4bbec2@redhat.com>
Date:   Mon, 18 Apr 2022 11:04:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1650020543-24908-7-git-send-email-xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/15/22 7:02 PM, Yang Xu wrote:
> Since vfs has stripped S_ISGID, we don't need this code any more.
>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   fs/ceph/file.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 6c9e837aa1d3..8e3b99853333 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -651,10 +651,6 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
>   		/* Directories always inherit the setgid bit. */
>   		if (S_ISDIR(mode))
>   			mode |= S_ISGID;
> -		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
> -			 !in_group_p(dir->i_gid) &&
> -			 !capable_wrt_inode_uidgid(&init_user_ns, dir, CAP_FSETID))
> -			mode &= ~S_ISGID;

Could you point me where has done this for ceph ?

-- Xiubo


>   	} else {
>   		in.gid = cpu_to_le32(from_kgid(&init_user_ns, current_fsgid()));
>   	}

