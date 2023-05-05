Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A206F7E01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 09:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjEEHgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 03:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjEEHgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 03:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719D018158
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 00:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683272163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1CDos4xXpfX0yUzIH2R6tkwubXHkIXYBoy2gEXH5JA=;
        b=Ulu1OIJv+F5PRIiVh/+oSWmT47A8tnohcll3b6MIOvPvGoXJ4oTI/pvuYX0hOoc6eyP/qV
        BoVNt4/dLOGV62nGPxxh/ilaxgUFqzdD5KUovqWrCiJZfK+Ps9hgk86kpDaAB2ySQ69Gr8
        uMDP8vjVXwzRUrwJvwWe2jPii4PfuP4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-6xL18v9TMvGD146HF3mZ6Q-1; Fri, 05 May 2023 03:36:02 -0400
X-MC-Unique: 6xL18v9TMvGD146HF3mZ6Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f1763fac8bso9413595e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 May 2023 00:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683272161; x=1685864161;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1CDos4xXpfX0yUzIH2R6tkwubXHkIXYBoy2gEXH5JA=;
        b=jXn8r4Pl9umf+b+6OP8qalzVXVyMInCyz3qaJ1uVAfOM3PsfWYiIVCwAne315K8I9W
         a42SkVZajUFsjV8Ttbul5E9UZx6e4xXFgBvh6bhpWO/F26bPSQNx314YrIR9UibLK3CV
         Vxnu4mwkRmjS6g5F5Vf2B2Jffwu9LNt+bPiI2NJnXB8y+qXmcMU6hqnTMQTBREndDXY0
         2IIUqAa8Qb498EwPUtttUSYfaf9ARjgqSAonTRyT7os3Pl3wQfoGuFpqt0nbaNsMZlie
         oogYl3T0FBdUsyXlknwEPwFSIPBdgk1oLV0hgQepSxwL8fpEpel98H1Iq1XYjBaOJ6n2
         oOAw==
X-Gm-Message-State: AC+VfDz/5tj03EncxlBv68h7dwbxE/qKxyFfdyUoLIwtWcyCMA9APVQ2
        N3uxHB4AoUsmVwJw6vhiBYhg2lInOvoVinF+l9+o68f+Z8mFF/SFTDjOQsaynoWgJiMJd4IQvyD
        4y/P6XvJtVzXgBKd+MfnMmKvrBA==
X-Received: by 2002:a1c:f60a:0:b0:3f2:5920:e198 with SMTP id w10-20020a1cf60a000000b003f25920e198mr327468wmc.34.1683272161233;
        Fri, 05 May 2023 00:36:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5XUDdNnSt2o2Ebxjr2vrScxpisR6Dhq9Ysweo7VXotuNFB3rkH+IP2VGzq0fyN3ub0us6E+w==
X-Received: by 2002:a1c:f60a:0:b0:3f2:5920:e198 with SMTP id w10-20020a1cf60a000000b003f25920e198mr327446wmc.34.1683272160847;
        Fri, 05 May 2023 00:36:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71f:6900:2b25:fc69:599e:3986? (p200300cbc71f69002b25fc69599e3986.dip0.t-ipconnect.de. [2003:cb:c71f:6900:2b25:fc69:599e:3986])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c021000b003f1940fe278sm7185780wmi.7.2023.05.05.00.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 00:36:00 -0700 (PDT)
Message-ID: <fbf37518-328d-c08c-7140-5d09d7a2674f@redhat.com>
Date:   Fri, 5 May 2023 09:35:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] sysctl: add config to make randomize_va_space RO
To:     Michael McCracken <michael.mccracken@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-hardening@lists.openwall.com, serge@hallyn.com,
        tycho@tycho.pizza, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20230504213002.56803-1-michael.mccracken@gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230504213002.56803-1-michael.mccracken@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04.05.23 23:30, Michael McCracken wrote:
> Add config RO_RANDMAP_SYSCTL to set the mode of the randomize_va_space
> sysctl to 0444 to disallow all runtime changes. This will prevent
> accidental changing of this value by a root service.
> 
> The config is disabled by default to avoid surprises.

Can you elaborate why we care about "accidental changing of this value 
by a root service"?

We cannot really stop root from doing a lot of stupid things (e.g., 
erase the root fs), so why do we particularly care here?

-- 
Thanks,

David / dhildenb

