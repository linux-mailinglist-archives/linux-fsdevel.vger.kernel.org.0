Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEAB5448B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 12:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbiFIKYL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 06:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242143AbiFIKYH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3851E813FD
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 03:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654770243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6a5SsgsnTuFo9sIZWQwmUlikCgiuGiGF/De3NllGDd0=;
        b=O1xC9fxZOMxaqC6rSRf/wp7oRubAOdtuQF660ZO5XT5/cyF74PDWeE2QN9m27mc+BMztdJ
        4cTCEIEgzKecWwUfZ7+HFqcmlsf3bRPqSVsgzJFiymh+8vAQB/cUacDsI0Qr52taSElHs3
        mqthmRsXI3hdg1HfHwjn9aCD07YEUwY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-Y3DQI-UIMnywIqNaPepqZQ-1; Thu, 09 Jun 2022 06:24:02 -0400
X-MC-Unique: Y3DQI-UIMnywIqNaPepqZQ-1
Received: by mail-wr1-f69.google.com with SMTP id bv8-20020a0560001f0800b002183c5d5c26so3285006wrb.20
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jun 2022 03:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=6a5SsgsnTuFo9sIZWQwmUlikCgiuGiGF/De3NllGDd0=;
        b=uadI/4HYf343pcl5zSAVxKhiL5SHnch8OoHEL4Z0K0iOAReHm780qbm8tiDP60mmwC
         ou6apyS9TLSmFbhHp+sr5A5tInJbmGaYAsG/s0wfywIMggWSUkXVhxFMd0eaC5hGsSVR
         jsBNbWJ+NaX7rAsps8hbeIiKQKyWCcE3+d41EoBhV59TA3upKip32jCRuen6+uMVlpzy
         TH7xpRHLcglhtaOqWN7FjUW7Jd9PUbNX19G3bzTroiJx9ZEzPWI2A3AP/abOski3Ur2L
         oscgUG+d9dfZbjQ7/BxweCyaqlHAPyKjP7gFqV4B2m/KMEX0OcKrbApXO31rOK1EhlOL
         +mqQ==
X-Gm-Message-State: AOAM5309p9/KqlfYaxla/iUEnNJGIHoYELWS4dS4skdjdif5Zb8E7E/E
        Og28DnFZCVrYlOfPIwYdcMiEgnA8GGVtF5/crKXtMUDQAYESnULDy1vgb8iVgq+0oi9DDiyx+QT
        Gu5yex6aZb0nU8RdR22/AXzW5Jw==
X-Received: by 2002:a1c:a301:0:b0:392:9bc5:203c with SMTP id m1-20020a1ca301000000b003929bc5203cmr2594374wme.67.1654770241337;
        Thu, 09 Jun 2022 03:24:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy58rh3fuuccVM2J0IS1QrE1vJ3CH41QyKYHa1IrWm/Rvain2xs2JDw35eE5SOSwtsykjkKLA==
X-Received: by 2002:a1c:a301:0:b0:392:9bc5:203c with SMTP id m1-20020a1ca301000000b003929bc5203cmr2594345wme.67.1654770240948;
        Thu, 09 Jun 2022 03:24:00 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d460a000000b0021552eebde6sm17782568wrq.32.2022.06.09.03.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 03:23:59 -0700 (PDT)
Message-ID: <a079ed41-1978-0551-2b5c-6d61aff7ddf2@redhat.com>
Date:   Thu, 9 Jun 2022 12:23:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 02/19] mm: Convert all PageMovable users to
 movable_operations
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
References: <20220608150249.3033815-1-willy@infradead.org>
 <20220608150249.3033815-3-willy@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220608150249.3033815-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.06.22 17:02, Matthew Wilcox (Oracle) wrote:
> These drivers are rather uncomfortably hammered into the
> address_space_operations hole.  They aren't filesystems and don't behave
> like filesystems.  They just need their own movable_operations structure,
> which we can point to directly from page->mapping.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  arch/powerpc/platforms/pseries/cmm.c |  60 +---------------
>  drivers/misc/vmw_balloon.c           |  61 +---------------
>  drivers/virtio/virtio_balloon.c      |  47 +-----------
>  include/linux/balloon_compaction.h   |   6 +-
>  include/linux/fs.h                   |   2 -
>  include/linux/migrate.h              |  26 +++++--
>  include/linux/page-flags.h           |   2 +-
>  include/uapi/linux/magic.h           |   4 --
>  mm/balloon_compaction.c              |  10 ++-
>  mm/compaction.c                      |  29 ++++----
>  mm/migrate.c                         |  24 +++----
>  mm/util.c                            |   4 +-
>  mm/z3fold.c                          |  82 +++------------------
>  mm/zsmalloc.c                        | 102 ++++++---------------------
>  14 files changed, 94 insertions(+), 365 deletions(-)

You probably should have cc'ed the relevant maintainers (including me :P ).

For everything except z3fold.c and zsmalloc.c,

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

