Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF4D69213E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 15:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjBJO4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 09:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjBJO4l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:56:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA2A70CE2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 06:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676040954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J+rg85xYSll7eP3Sf5GHRKpU1GokGp9XDi0j91yLtiE=;
        b=Jh7L7FRt0YJAHhb2drPnf3UkyDvo/EmxtuQoxEdMc+85aJS8g5IocuBzJnb++qupoDOsAY
        QvIzhJYuNozGLKx7Dt7Mgk159jUCeuKZhPELU0eNO//gZ5B3v+plaHdM6dm0fbHSnf9NvF
        vx+gfv1G8o44Xn2id8/8F1Z9S1yE9b0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-vojPdnQuPc2mjDgudaSNUw-1; Fri, 10 Feb 2023 09:55:53 -0500
X-MC-Unique: vojPdnQuPc2mjDgudaSNUw-1
Received: by mail-qk1-f199.google.com with SMTP id bp30-20020a05620a459e00b00738e1fe2470so3426611qkb.23
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 06:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J+rg85xYSll7eP3Sf5GHRKpU1GokGp9XDi0j91yLtiE=;
        b=30xumBUh5lkbOi+TqlIAE11qutO39WZTJBwNNCh7Ph3ydjkYnlQanRW3O3s6f2VvQI
         Z1zNGVJTizj83/r44GSb8xO/inekG0YVeNotQgMqJ0M3UpMGqJ0lW0kN0N19cZ/hw/Qy
         WSG9qanyJYyi16LLU3eAIMXRGnTI+bNCj6+OESYckgbItdLMjgPDmZx/oScUahO5UNG7
         tGEn4lnQg0WiYXyKBrvWxQsQEP/i4Rvjp/0yTbFIzyrE37cuF98xHP/xiEY35EI7M4Ql
         pfeb8zLR4b60lqz2M+IsNn45n1yyzc92im+05ZEm+xrYvicwXPzOkPGEGNHPxxnSfx5C
         zxWQ==
X-Gm-Message-State: AO0yUKW6Np7tWpCuQNOoItwChHQm6fkzr9fbt0jhy+g1eSw8ReH9dbvT
        KgYRAB2rddXAg2n0utVC5JdV8cE5Gn/G1CqucVsK3KYQ8/nl2cJ5WMKy0jliUNNDTcSQHcStdI5
        V99RoV36fEMGFo98/BhpyGLpksQ==
X-Received: by 2002:ac8:5955:0:b0:3b3:7d5:a752 with SMTP id 21-20020ac85955000000b003b307d5a752mr26834082qtz.50.1676040952534;
        Fri, 10 Feb 2023 06:55:52 -0800 (PST)
X-Google-Smtp-Source: AK7set/IAOXvCvxAJe1QVvAocUsN8WugW1iNym2GUKlBrMHZnHFLP+SYPzzktfBcL8E2KyHQV7ULTw==
X-Received: by 2002:ac8:5955:0:b0:3b3:7d5:a752 with SMTP id 21-20020ac85955000000b003b307d5a752mr26834042qtz.50.1676040952267;
        Fri, 10 Feb 2023 06:55:52 -0800 (PST)
Received: from [192.168.0.2] (ip-109-43-178-85.web.vodafone.de. [109.43.178.85])
        by smtp.gmail.com with ESMTPSA id z12-20020ac87cac000000b003b9bc00c2f1sm3370579qtv.94.2023.02.10.06.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 06:55:51 -0800 (PST)
Message-ID: <2344ac16-781e-8bfa-ec75-e71df0f3ed28@redhat.com>
Date:   Fri, 10 Feb 2023 15:55:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 03/14] Move COMPAT_ATM_ADDPARTY to net/atm/svc.c
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     viro@zeniv.linux.org.uk, aishchuk@linux.vnet.ibm.com,
        aarcange@redhat.com, akpm@linux-foundation.org, luto@kernel.org,
        acme@kernel.org, bhe@redhat.com, 3chas3@gmail.com,
        chris@zankel.net, dave@sr71.net, dyoung@redhat.com,
        drysdale@google.com, ebiederm@xmission.com, geoff@infradead.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, mingo@kernel.org,
        iulia.manda21@gmail.com, plagnioj@jcrosoft.com, jikos@kernel.org,
        josh@joshtriplett.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        jcmvbkbc@gmail.com, paulmck@linux.vnet.ibm.com,
        a.p.zijlstra@chello.nl, tglx@linutronix.de, vgoyal@redhat.com,
        x86@kernel.org, arnd@arndb.de, dhowells@redhat.com,
        peterz@infradead.org, netdev@vger.kernel.org
References: <1446579994-9937-1-git-send-email-palmer@dabbelt.com>
 <1447119071-19392-1-git-send-email-palmer@dabbelt.com>
 <1447119071-19392-4-git-send-email-palmer@dabbelt.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <1447119071-19392-4-git-send-email-palmer@dabbelt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/11/2015 02.31, Palmer Dabbelt wrote:
> This used to be behind an #ifdef COMPAT_COMPAT, so most of userspace
> wouldn't have seen the definition before.  Unfortunately this header
> file became visible to userspace, so the definition has instead been
> moved to net/atm/svc.c (the only user).
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
> Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
> ---
>   include/uapi/linux/atmdev.h | 4 ----
>   net/atm/svc.c               | 5 +++++
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/atmdev.h b/include/uapi/linux/atmdev.h
> index 93e0ec0..3dcec70 100644
> --- a/include/uapi/linux/atmdev.h
> +++ b/include/uapi/linux/atmdev.h
> @@ -100,10 +100,6 @@ struct atm_dev_stats {
>   					/* use backend to make new if */
>   #define ATM_ADDPARTY  	_IOW('a', ATMIOC_SPECIAL+4,struct atm_iobuf)
>    					/* add party to p2mp call */
> -#ifdef CONFIG_COMPAT
> -/* It actually takes struct sockaddr_atmsvc, not struct atm_iobuf */
> -#define COMPAT_ATM_ADDPARTY  	_IOW('a', ATMIOC_SPECIAL+4,struct compat_atm_iobuf)
> -#endif
>   #define ATM_DROPPARTY 	_IOW('a', ATMIOC_SPECIAL+5,int)
>   					/* drop party from p2mp call */
>   
> diff --git a/net/atm/svc.c b/net/atm/svc.c
> index 3fa0a9e..9e2e6ef 100644
> --- a/net/atm/svc.c
> +++ b/net/atm/svc.c
> @@ -27,6 +27,11 @@
>   #include "signaling.h"
>   #include "addr.h"
>   
> +#ifdef CONFIG_COMPAT
> +/* It actually takes struct sockaddr_atmsvc, not struct atm_iobuf */
> +#define COMPAT_ATM_ADDPARTY _IOW('a', ATMIOC_SPECIAL+4, struct compat_atm_iobuf)
> +#endif
> +
>   static int svc_create(struct net *net, struct socket *sock, int protocol,
>   		      int kern);
>   

  Hi!

The CONFIG_* switch is still there in the atmdev.h uapi header ... could 
somebody please pick this patch up to fix it?

  Thanks,
   Thomas

