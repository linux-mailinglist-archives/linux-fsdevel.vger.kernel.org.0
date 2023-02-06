Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6647568C21E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 16:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjBFPrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 10:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjBFPrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A682B09B
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Feb 2023 07:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675698333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ViNvh2IavPltRwIS2u0eTkOgWpB6sQmqMz+8YaqMvr0=;
        b=UebLbuMqTdYh0K+fWiLa7ev6dxvTdVTHnN096Iz8ILyOV8Ouh9bgLev0oYKgw+Y+qJkRgg
        HdtEhK496eVWdjeSmdDLldn2gTKVn6iRiOsFfk2sxWAa5iCYbq6EtsrXxV/Y7E0bUXNEPa
        oGIg7uNG4LI7IP5pTCPJSF46e6IMORE=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-PLHalhMaNWC_-k89Y0xUPg-1; Mon, 06 Feb 2023 10:31:35 -0500
X-MC-Unique: PLHalhMaNWC_-k89Y0xUPg-1
Received: by mail-il1-f199.google.com with SMTP id d2-20020a056e021c4200b00313bdffad9aso2675221ilg.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Feb 2023 07:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViNvh2IavPltRwIS2u0eTkOgWpB6sQmqMz+8YaqMvr0=;
        b=gdgJqUXTJ+PyIHUBgLMwZSaMU6680eH4Wfo5Wdkc9RA0ko+yHj5jO0iPnN8jhyP2AI
         2KLhCO1nwIz0mJNTu1RH31FhVckWLlRJZfaXXrDTBR9vj1BTrvKjkZAr5JNsC8i5rdrl
         T7hr6o45uanWtUd2qwRg3xMPsgd5b9j4H7XmH8XxAsRmaJEMKQ6KKKThus2hSZSRM+zo
         r70gMuhQgrYpYX9rXWlZlIKT/MjTA6AAcHHosjhA62ZpYXld1b0KHlEWWHaabcTHMOv5
         LhMJrckGdDHH7EeKVyeUIXInXd1Rh+uBnz7hCuhSPJqfnsEFNI3TRx2/Xeq5R49j/+ip
         SNGw==
X-Gm-Message-State: AO0yUKXlrMz4vFE+yodXeD6AUaBXvRNkzqX34HNuEmCYsESOsuMbmZWF
        za9//5o1bHfefonBQGrR+FMWo1dt7DTDYVejS5LDIQboeXB5Hwr4QGZl9mB4u7qWNOpS7EphnBs
        lTZOl1WBRuTCuLR9KV+JQJABhc3WqlAxOFYpLUiHZbw==
X-Received: by 2002:a92:2003:0:b0:30f:37f5:8520 with SMTP id j3-20020a922003000000b0030f37f58520mr4264642ile.63.1675697493948;
        Mon, 06 Feb 2023 07:31:33 -0800 (PST)
X-Google-Smtp-Source: AK7set8hCwd+me3+fYn1guoCKfdAzafeoQiTQpA+TBWgprx+HN0/zGbagcHaITaEMm2xP2+TKjAWyE38obGRBKZ4NwA=
X-Received: by 2002:a92:2003:0:b0:30f:37f5:8520 with SMTP id
 j3-20020a922003000000b0030f37f58520mr4264630ile.63.1675697493785; Mon, 06 Feb
 2023 07:31:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
 <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com> <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
 <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com> <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
 <071074ad149b189661681aada453995741f75039.camel@redhat.com>
 <0d2ef9d6-3b0e-364d-ec2f-c61b19d638e2@linux.alibaba.com> <de57aefc-30e8-470d-bf61-a1cca6514988@linux.alibaba.com>
 <CAOQ4uxgS+-MxydqgO8+NQfOs9N881bHNbov28uJYX9XpthPPiw@mail.gmail.com>
 <9c8e76a3-a60a-90a2-f726-46db39bc6558@linux.alibaba.com> <02edb5d6-a232-eed6-0338-26f9a63cfdb6@linux.alibaba.com>
 <3d4b17795413a696b373553147935bf1560bb8c0.camel@redhat.com>
 <CAOQ4uxjNmM81mgKOBJeScnmeR9+jG_aWvDWxAx7w_dGh0XHg3Q@mail.gmail.com>
 <CAL7ro1Hc4npP9DQjzuWXJYPTi9H=arLstAJvsBgVKzd8Cx8_tg@mail.gmail.com> <678002cf-f847-d5c3-a79b-5bebd3c1e518@linux.alibaba.com>
In-Reply-To: <678002cf-f847-d5c3-a79b-5bebd3c1e518@linux.alibaba.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Mon, 6 Feb 2023 16:31:22 +0100
Message-ID: <CAL7ro1G59CGj99YKJYAP=8W+sejE+q=XqXtYjmiXXP9=xVcjwA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jingbo Xu <jefflexu@linux.alibaba.com>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 6, 2023 at 2:27 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> On 2023/2/6 20:43, Alexander Larsson wrote:
> >
> > One problem I ran into is that erofs seems to only support mounting
> > filesystem images that are created with the native page size. This
> > means I can't mount a erofs image created on a 4k page-size machine on
> > an arm64 mac with 64k pages. That doesn't seem great. Maybe this
> > limitation can be lifted from the erofs code though.
>
> Honestly, EROFS 64k support has been in our roadmap for a quite long
> time, and it has been almost done for the uncompressed part apart from
> replacing EROFS_BLKSIZ to erofs_blksiz(sb).

Good, as long as it is on the roadmap.

> Currently it's not urgent just because our Cloud environment always use
> 4k PAGE_SIZE, but it seems Android will consider 16k pagesize as well, so
> yes, we will support !4k page size for the uncompressed part in the near
> future.  But it seems that arm64 RHEL 9 switched back to 4k page size?

Honestly I'm not following it all that closely, but I think Fedora was
at least talking about 64k pages.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

