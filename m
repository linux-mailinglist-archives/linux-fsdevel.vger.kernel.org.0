Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935996E9C8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 21:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjDTTib (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 15:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjDTTi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:38:29 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AF730D4
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 12:38:28 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3ef34c49cb9so903421cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682019507; x=1684611507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbkXWBpwVxhf9T5z1cj4mwmJl7+Xdft765BvQGmNJoc=;
        b=Ciz/t1cEtCUCOm5soArFZ936T3/SUb8VLB6c5P8LGdbu6vVDAjL9VlEeJbi2ziuhxy
         C3vmNugZAc+x8atgpej6AYWTbg/CH71jBJ0GUVSsktziCLpabOw7/zqEc+skmTFrOO+i
         ZotbQR6QLIGThfZYmTQOsHIcM4IBzEj1DPNrJDhEruo8QA3xEDRWU0solT/rU2BAY/yV
         85SiFvDILk1jQ3JOtF5iesWxvT/b7C3s8OyqovZ33BteZR/RTUJDUejNm5BY5J1b+QCh
         LqVHQd2X9sSBfcuCGaWZZ5VX5RmRRr6etLFaH8HToHo6sDWVSQ8xu7PDiyXLRdFEokvw
         TciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682019507; x=1684611507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbkXWBpwVxhf9T5z1cj4mwmJl7+Xdft765BvQGmNJoc=;
        b=Vg4wI8QXqAYZIuUzpJXNsMRIUOVj6NeNuW/GsCDP0RgW/PlHjJHWuVL5NbtWHClqKY
         xMIvtjgXQkluZLHOdQRvJ1xpaKS8E0kCPVIO+eWm0CfhePT0xmPSKDl6+hwnAubsTTsm
         SSI1gnt6uI2tzf5vpoiL5dwSl46vrzQBMRQhBcFrNTcA/R+MdplpR9JDmf5Y5MpMG8Gk
         f9VND0k91S+sQE90sgp4LgrM2f0++I3ANHoAY8IPj6BCkeidGBpZku/Gr75TClRTI+hl
         3yy+qXlk6QoZ053VEFNRx5b3gs0R3rvaOtc7wogBzdUZ404CEhQj20lh3wO8jG+vGXjD
         02Gg==
X-Gm-Message-State: AAQBX9f2PjrBj6jr6DJquUAA7ssku9Ae0ioq2k5MPXfPaUoAROqUK8cB
        NwryAV94xhWvyyjGarBVJ+D2H7mAQwttIvW7G8N29w==
X-Google-Smtp-Source: AKy350abRG/tf4z4pattUwmk/F2Ixto8fxjoWPcUpuCUwzt1ET28kNEYXAvB43l6rGnhhp3YHPvNlcprP6JiHQXpUXM=
X-Received: by 2002:a05:622a:1102:b0:3bf:e4e0:26a0 with SMTP id
 e2-20020a05622a110200b003bfe4e026a0mr56484qty.14.1682019507455; Thu, 20 Apr
 2023 12:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com> <20230403220337.443510-5-yosryahmed@google.com>
In-Reply-To: <20230403220337.443510-5-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Apr 2023 12:38:16 -0700
Message-ID: <CALvZod6wiCzpbCOtR06vGXy+gb6adC8RCkXfsRjC-N8yJorGWg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable RFC 4/5] memcg: remove mem_cgroup_flush_stats_atomic()
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 3, 2023 at 3:03=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> Previous patches removed all callers of mem_cgroup_flush_stats_atomic().
> Remove the function and simplify the code.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
