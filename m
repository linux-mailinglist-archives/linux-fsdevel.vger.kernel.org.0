Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855007BC5C3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 09:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343711AbjJGHvi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 03:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343613AbjJGHvh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:51:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B024CA6
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Oct 2023 00:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696665046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IL6H5VoBRpOqVzPYQ3RJbppwYGMKi8FhTxtOJkmxhus=;
        b=EIfBovor6h9v4sc5H6ep5maH8JVbRH4BkMeai5JZNmBgzzsJ/3eFKu/kCPijPgt8wvASt7
        j1aqq11wIP8LLEY0Csbar6O8SdK9D1mUx1FW4DrmQUSl7/GNV1Bo8koobd7dw7SQFmJ4FL
        iUKbROsvP1s2AU8prlGRt2r4mCa89DQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-J1IeMs9LOoWEWlOTBjrngg-1; Sat, 07 Oct 2023 03:50:45 -0400
X-MC-Unique: J1IeMs9LOoWEWlOTBjrngg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5701dbeaf9fso2292321a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Oct 2023 00:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696665044; x=1697269844;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IL6H5VoBRpOqVzPYQ3RJbppwYGMKi8FhTxtOJkmxhus=;
        b=XufsWDE5IQkjZj4jdbXyOS5GvUv0jjuNFB0vC7yKp4+rfSQ7n7nA6+dkFRJV0xTtdL
         hPFjBn6pjA+8b1lYt43fTYMPfSA/wlG66IlpfQlDRzu3EaHucf9bsWF5efAqVImHQacd
         tDgyVPoAdkxJ49HaMFVF0gpbF9Jfsbk9+BNktNah6dOrq/SCufywkN/l95372vE43z30
         S/r+CxCSvKqWBkQT4bLMaT2NIkVyYe3knF4CXjDpW2Kr5/tF/pscejGIew8/FGUYmOEH
         rHanBczTa/AFxFTQP0HnFRTLesmHrq9YFDyvEH7KWFRQ5fE5GXJZXQo6JA3f8hO6/Rj3
         F2yA==
X-Gm-Message-State: AOJu0Yy4IOneNItRCUaAI+XJmvf0TfgK9TCyWHlUfjK//xEBDfbfK4/U
        EAQGLzMhwTBmyESYDb5h5wR5Ftgs8EjipvcVTcO+roLwKh2xgOa8eTWQ/096Yq9wGne5qDjQpqq
        nz6g4Ydcm8kdB0AS7OAc29aF6vg==
X-Received: by 2002:a05:6a20:144c:b0:13c:ca8b:7e29 with SMTP id a12-20020a056a20144c00b0013cca8b7e29mr11909255pzi.12.1696665044399;
        Sat, 07 Oct 2023 00:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV+YP75IsHGoH7CRYi4h1SL1w6jeOp8lNxOmS7z+zGawVvDwyAwksYVpWVsM61n+0klP893A==
X-Received: by 2002:a05:6a20:144c:b0:13c:ca8b:7e29 with SMTP id a12-20020a056a20144c00b0013cca8b7e29mr11909245pzi.12.1696665044053;
        Sat, 07 Oct 2023 00:50:44 -0700 (PDT)
Received: from [10.72.112.33] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7844b000000b0069b772c4325sm2613613pfn.87.2023.10.07.00.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 00:50:43 -0700 (PDT)
Message-ID: <507202a9-b71d-e52b-0306-dd89044ff442@redhat.com>
Date:   Sat, 7 Oct 2023 15:50:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fuse: pass ATTR_KILL_SUID/ATTR_KILL_SGID mode bits to
 user space
Content-Language: en-US
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230921022436.1191166-1-xiubli@redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230921022436.1191166-1-xiubli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping...

On 9/21/23 10:24, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>
> Such as for the xfstest-dev's generic/684 test case it will clear
> suid and sgid if the fallocate request is commit by an unprivileged
> user.
>
> We need to pass the ATTR_KILL_SUID/ATTR_KILL_SGID flags to userspace.
>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>   fs/fuse/dir.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index f67bef9d83c4..73dcf54efbff 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1938,11 +1938,11 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
>   
>   			attr->ia_mode = inode->i_mode;
>   			if (inode->i_mode & S_ISUID) {
> -				attr->ia_valid |= ATTR_MODE;
> +				attr->ia_valid |= ATTR_KILL_SUID | ATTR_MODE;
>   				attr->ia_mode &= ~S_ISUID;
>   			}
>   			if ((inode->i_mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
> -				attr->ia_valid |= ATTR_MODE;
> +				attr->ia_valid |= ATTR_KILL_SGID | ATTR_MODE;
>   				attr->ia_mode &= ~S_ISGID;
>   			}
>   		}

