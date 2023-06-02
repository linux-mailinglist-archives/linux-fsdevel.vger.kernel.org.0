Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A6271F7A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 03:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjFBBSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 21:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFBBSH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:18:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3574B19F
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 18:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685668630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z89lfLkyR3wUxURBnMByyXkAk3prI/BY4d5M95naVOE=;
        b=bSZQ64ZN9nqjUYcnkE+3wYJemsBe9v9w2JlIZxnjBjCuHe4JRcjYLredO1P8dIobDPZTCS
        zHBC2dYYcrJ/MfHD6Z4WcG3/7sWlh5+4N2PI8WRZoBEojaA0NIj4FWDiaCIV0EB4sV8eEv
        kukbaw2FvWPK8mkEfrda44LgYrJ1+Ho=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-OK_2X14hNj6tCEEeISLRkA-1; Thu, 01 Jun 2023 21:17:00 -0400
X-MC-Unique: OK_2X14hNj6tCEEeISLRkA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2563e180afbso1256535a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jun 2023 18:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685668619; x=1688260619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z89lfLkyR3wUxURBnMByyXkAk3prI/BY4d5M95naVOE=;
        b=DTkiHt85BiK1B/An46jvy+2wUwjNjjlPtJ/0/WLKWAEjKUnpXh5QBoDsSvbd+h9cFb
         krVzzKnIvkoFphheHaFwvVPAq7g7LEaOvB06qDtNtTKOaQ3RketPGhPGvzA50t+5bhh8
         VZvbTUhZCwNPQ0x6nRrI8EGvUyDCE+dAoXIqIc5v+3SsWWaysaJ/GFF+XcDTJxDpHQSM
         jEgA8Uy4CYtFRdHMMpqvWCvUOeSlTboFVd7CDNVacuJho+58HigdX++UIUo/rkBa3/HB
         k/T2ibFdMXu5WBExZhFAhqbC1mW7zGUQk1cSLX3J/0NHaiFgetJCpw8Xn81Tvnx6pkhA
         VwVw==
X-Gm-Message-State: AC+VfDyJIPGL88BQDwhYvz7NmRJ+x4I+R5ntF6j8WajdGMRHbEAQIzuc
        EsSdnaUv66+qT00M/1N3C1yXfpQ9sSvl0ZidXoRIafV61crg9QiNzc4piB5dqzQ/dysz/nGM/oy
        43fKUXo6B9EqvCPeuy4mtzOVHnQ==
X-Received: by 2002:a17:90a:5d8d:b0:256:5a91:5b8 with SMTP id t13-20020a17090a5d8d00b002565a9105b8mr1047628pji.5.1685668619469;
        Thu, 01 Jun 2023 18:16:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ajRv1nh/jKzQg5/3b1FDWRmomE2x/ax2Cvq0KplmScDD//eAEvsLC8Xbst2GzTtf2IRzIUQ==
X-Received: by 2002:a17:90a:5d8d:b0:256:5a91:5b8 with SMTP id t13-20020a17090a5d8d00b002565a9105b8mr1047611pji.5.1685668619201;
        Thu, 01 Jun 2023 18:16:59 -0700 (PDT)
Received: from [10.72.12.188] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b001ac896ff65fsm22571pln.129.2023.06.01.18.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 18:16:58 -0700 (PDT)
Message-ID: <64672c51-498a-2a0c-4d4e-caca145fa744@redhat.com>
Date:   Fri, 2 Jun 2023 09:16:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 01/13] fs: export mnt_idmap_get/mnt_idmap_put
Content-Language: en-US
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
 <20230524153316.476973-2-aleksandr.mikhalitsyn@canonical.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230524153316.476973-2-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/24/23 23:33, Alexander Mikhalitsyn wrote:
> These helpers are required to support idmapped mounts in the Cephfs.
>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>   fs/mnt_idmapping.c            | 2 ++
>   include/linux/mnt_idmapping.h | 3 +++
>   2 files changed, 5 insertions(+)
>
> diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> index 4905665c47d0..5a579e809bcf 100644
> --- a/fs/mnt_idmapping.c
> +++ b/fs/mnt_idmapping.c
> @@ -256,6 +256,7 @@ struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap)
>   
>   	return idmap;
>   }
> +EXPORT_SYMBOL(mnt_idmap_get);
>   
>   /**
>    * mnt_idmap_put - put a reference to an idmapping
> @@ -271,3 +272,4 @@ void mnt_idmap_put(struct mnt_idmap *idmap)
>   		kfree(idmap);
>   	}
>   }
> +EXPORT_SYMBOL(mnt_idmap_put);
> diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
> index 057c89867aa2..b8da2db4ecd2 100644
> --- a/include/linux/mnt_idmapping.h
> +++ b/include/linux/mnt_idmapping.h
> @@ -115,6 +115,9 @@ static inline bool vfsgid_eq_kgid(vfsgid_t vfsgid, kgid_t kgid)
>   
>   int vfsgid_in_group_p(vfsgid_t vfsgid);
>   
> +struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
> +void mnt_idmap_put(struct mnt_idmap *idmap);
> +
>   vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
>   		     struct user_namespace *fs_userns, kuid_t kuid);
>   

Hi Alexander,

This needs the "fs/mnt_idmapping.c" maintainer's ack.

Thanks

- Xiubo

