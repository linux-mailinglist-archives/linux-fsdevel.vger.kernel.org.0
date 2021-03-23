Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B7D346193
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 15:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhCWOe3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 10:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231843AbhCWOdy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616510033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Jq/F710yph7giIFuOon0hHnQr6Etp9FxSOgX4AsDyE=;
        b=g5lx+tPW+iz+dCoqIa00qbC4Lsyi/PFXu2rNbZpU2jz9qDqHywnSiwc88hYABAy9lOiB3/
        xBZZEmxLF/vG+uVAfLMwj/rX2pWXGxl0sFIM7bhFIR5vUfj68n1AcSsIc7sdKRSrZRFiN3
        XYUw9FGlJlbvoSCinhkxR0RU0p2Zbtc=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-Ug011l2aNTGWMl_isxwRKQ-1; Tue, 23 Mar 2021 10:33:51 -0400
X-MC-Unique: Ug011l2aNTGWMl_isxwRKQ-1
Received: by mail-oo1-f71.google.com with SMTP id m21so1076100ooj.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 07:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Jq/F710yph7giIFuOon0hHnQr6Etp9FxSOgX4AsDyE=;
        b=pVNe1AvkMwPb8E4gKzQmmkRQxsQXaId17MqK0E7n72SGnlP/D0f9K2eCfpU92BCFyH
         ZHMNoVKJZ00luq1vlyZeQXgZdyvqgE2z33IOTyzPiCIYNok6C3FTIoXohDEbvbJFs/Ji
         TvTOkPfiKrsKFM+zouJngp+OShDzsZXHUpkuwsS9EefGCf3ZOOTjGgVftSwXDJVXzfzf
         TT1Dtac3jpLj4SkKFTl5Ey7sSJu/f7fpJUWJlwgDznweGE13srAwSvpJLEEg7jGtkBXD
         qdAVy/MlXhpojzBGYJ5DeNNyJHaFrQRO2c83qwbZd3qHWDqeSSMXJ3gWUTGtLrQgDDl1
         1sWg==
X-Gm-Message-State: AOAM531b1QIXqnn4GWUHbb4W3fIOEHYz5h1RlpdEAC7dmu6hOGpWpbsU
        wKhnbkNjLMbqeuWqu0crxNIKwn7UcfTtey9ABFDEkpjN1jB9W5zRELWs6eRVPqag3Q38HiQqkNm
        biJDFmyn2ACVtKPW1421hvO/cNw==
X-Received: by 2002:aca:4a95:: with SMTP id x143mr3509561oia.59.1616510031184;
        Tue, 23 Mar 2021 07:33:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxok3f6ziJ9zKDi8trmoswuyjnL5pOr/KQa4kLV4auhi+XJnxMJJpMV5++pTTR3OV7D20fw4A==
X-Received: by 2002:aca:4a95:: with SMTP id x143mr3509539oia.59.1616510030878;
        Tue, 23 Mar 2021 07:33:50 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id a13sm3696881ooj.14.2021.03.23.07.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 07:33:50 -0700 (PDT)
Subject: Re: [PATCH] fuse: Fix a potential double free in virtio_fs_get_tree
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>, vgoyal@redhat.com,
        stefanha@redhat.com, miklos@szeredi.hu
Cc:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210323051831.13575-1-lyl2019@mail.ustc.edu.cn>
From:   Connor Kuehl <ckuehl@redhat.com>
Message-ID: <db475406-76d1-dffd-f492-3e5bb955f08e@redhat.com>
Date:   Tue, 23 Mar 2021 09:33:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323051831.13575-1-lyl2019@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/23/21 12:18 AM, Lv Yunlong wrote:
> In virtio_fs_get_tree, fm is allocated by kzalloc() and
> assigned to fsc->s_fs_info by fsc->s_fs_info=fm statement.
> If the kzalloc() failed, it will goto err directly, so that

Right, I follow this so far.

> fsc->s_fs_info must be non-NULL and fm will be freed.

But this I don't follow in the context of the stuff that happens in out_err.

> But later fm is freed again when virtio_fs_fill_super() fialed.
> I think the statement if (fsc->s_fs_info) {kfree(fm);} is
> misplaced.

I'm not sure this can double free, because:

* If fm = kzalloc[..] fails, the function bails early.

* If sget_fc() fails, the function cleans up fm and fc and bails early.

* If sget_fc() succeeds and allocated a new superblock, fc->s_fs_info 
pointer is moved to sb->s_fs_info and fc->s_fs_info is set to NULL, so 
the first free hasn't happened yet.

* If sget_fc() succeeds and somehow returns an existing superblock 
(which I think is tested by checking if fc->s_fs_info is not NULL, since 
otherwise it'd have been moved to the superblock and set to NULL in 
sget_fc), I think sb->s_root would not be NULL, therefore the flow of 
control wouldn't enter the if-block where virtio_fs_fill_super could 
fail which means the code won't reach the double free.

That's just my reading of it though, and I'm wondering if that makes 
sense to others :-)

One last comment inline:

> My patch puts this statement in the correct palce to avoid
> double free.
> 
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>   fs/fuse/virtio_fs.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8868ac31a3c0..727cf436828f 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1437,10 +1437,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>   
>   	fsc->s_fs_info = fm;
>   	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
> -	if (fsc->s_fs_info) {
> -		fuse_conn_put(fc);
> -		kfree(fm);
> -	}
> +
>   	if (IS_ERR(sb))
>   		return PTR_ERR(sb);

By removing the check from here, it now looks like if sget_fc() fails, 
then this early return will leak fm's memory and fc's reference.

Connor

>   
> @@ -1457,6 +1454,11 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>   		sb->s_flags |= SB_ACTIVE;
>   	}
>   
> +	if (fsc->s_fs_info) {
> +		fuse_conn_put(fc);
> +		kfree(fm);
> +	}
> +
>   	WARN_ON(fsc->root);
>   	fsc->root = dget(sb->s_root);
>   	return 0;
> 

