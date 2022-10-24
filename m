Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D25609787
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 02:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJXAi0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 20:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJXAiY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 20:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26CB61710
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 17:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666571901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/UdhZqMRJmQvgYCScCECdvRWph3XGwvAToTHziUz2vk=;
        b=g/l1H6wiSXQZ6nln7zhFBp8GwsYOu7llemSXyYxQlv9q1XDYHODD1+84kjCqvyWYcUz9nP
        VNjDvPtpB85NEomov+vtrzttOjFwMZ+HxGaZ2pCXXVPqR0GdKLK+bOU8kqtslWcFwTDwLv
        AHEBcfumdIDK9sgzNF2RRYqDXCQSc9c=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-490-DZAMP7HEMmWGwSYK88C-Ig-1; Sun, 23 Oct 2022 20:38:20 -0400
X-MC-Unique: DZAMP7HEMmWGwSYK88C-Ig-1
Received: by mail-pj1-f71.google.com with SMTP id p1-20020a17090a2c4100b00212733d7aaaso3107360pjm.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 17:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UdhZqMRJmQvgYCScCECdvRWph3XGwvAToTHziUz2vk=;
        b=imawHger21TXE2I5cKk7uTPGhbZWKnfy8EmjJ3SkulEmej5nYmD5Mqtvz+ishTiARj
         c/JlgFFPEMdj48nRb03ADHX9BJqYCE5bhWN+y5sNNlV/kuEYyDjSy6+Hn3vWEVZqztpg
         8zxUZNBXOVTBHG9Swqd9EXMXWgQI40qeZXjc8RWstGT42GFZJl44559415N7TyQveJzq
         qJo4OlXsr3N1dxaRJUiXaB/pcwrUfpQ02OEo1SBAVlGDkUiwY7ruWXrp3462X29kDpNM
         VnWsyVBksPGQ5wGoJt/WzKx623PfayDAlfKJra5BoRAD+Texhrd4qk06qfv2ePJ2HDKR
         jStg==
X-Gm-Message-State: ACrzQf1PueUVil32zbiAG6bwiKiLSYYTuKAl5huYTxqDZR1BJkQkSrx2
        DJmRB3qKOKi7aB3gKFFKO0+yfirTJzA2l6kqfLmSFfltL+csN6BCr+ssI+OVH97k6QdYFt2et15
        F9gF2ZMg64DhZAkWvLQASOukCbg==
X-Received: by 2002:a17:90a:6909:b0:212:f535:a34b with SMTP id r9-20020a17090a690900b00212f535a34bmr7713921pjj.6.1666571899185;
        Sun, 23 Oct 2022 17:38:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6wHbLCC9ZTvDwwS9U1pcyvx0QqS9dwipUoB06/Zkbk5O1zlmqw7Xz8kmlbrjSJwqQcU6lJ+g==
X-Received: by 2002:a17:90a:6909:b0:212:f535:a34b with SMTP id r9-20020a17090a690900b00212f535a34bmr7713905pjj.6.1666571898964;
        Sun, 23 Oct 2022 17:38:18 -0700 (PDT)
Received: from [10.72.12.79] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b00172f4835f60sm18700537plg.189.2022.10.23.17.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 17:38:18 -0700 (PDT)
Subject: Re: [PATCH -next 3/5] ceph: fix possible null-ptr-deref when parsing
 param
To:     Hawkins Jiawei <yin31149@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     18801353760@163.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
References: <20221023163945.39920-1-yin31149@gmail.com>
 <20221023163945.39920-4-yin31149@gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <a587d14f-8bdd-ba61-d750-594359f9e5f2@redhat.com>
Date:   Mon, 24 Oct 2022 08:38:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221023163945.39920-4-yin31149@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 24/10/2022 00:39, Hawkins Jiawei wrote:
> According to commit "vfs: parse: deal with zero length string value",
> kernel will set the param->string to null pointer in vfs_parse_fs_string()
> if fs string has zero length.
>
> Yet the problem is that, ceph_parse_mount_param() will dereferences the
> param->string, without checking whether it is a null pointer, which may
> trigger a null-ptr-deref bug.
>
> This patch solves it by adding sanity check on param->string
> in ceph_parse_mount_param().
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>   fs/ceph/super.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 3fc48b43cab0..341e23fe29eb 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -417,6 +417,9 @@ static int ceph_parse_mount_param(struct fs_context *fc,
>   		param->string = NULL;
>   		break;
>   	case Opt_mds_namespace:
> +		if (!param->string)
> +			return invalfc(fc, "Bad value '%s' for mount option '%s'\n",
> +				       param->string, param->key);
>   		if (!namespace_equals(fsopt, param->string, strlen(param->string)))
>   			return invalfc(fc, "Mismatching mds_namespace");
>   		kfree(fsopt->mds_namespace);

Good catch!

Will merge it to testing branch.

Thanks!

- Xiubo

