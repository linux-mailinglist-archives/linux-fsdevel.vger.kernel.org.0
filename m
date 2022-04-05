Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BE34F34B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 15:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbiDEJPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 05:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244982AbiDEIw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C226E0EB;
        Tue,  5 Apr 2022 01:48:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i6-20020a1c3b06000000b0038e710da2dcso1111817wma.1;
        Tue, 05 Apr 2022 01:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JysfUtBbV1yB6ulPL8qCt0+AynaBy1ohgfTXNgk6MB0=;
        b=G6Gn4S/T+/2xjEfH19TC3Z2WEyythPt+0uqXFPhKHukxVYYb4iNuQdeun/cviMQ3Uq
         EiiNVUDSSNsfAJepmOCBBRtqew8aO2h3+LnbBKIrUZnMJRK3TzB7lGyM6Yonn/DXA7pN
         kOdKdDeXuB6IIstu7sMOUYYmikssPl/qgE43wIdGNL/AiuKNsGIs563HziGseiId3Omo
         JN8yfCDrs1cajyuqcj22v00NX8NCvZ8VkUvh3c3eeeAZxyMp2MyYji4OFIvj4aFpRK7L
         YepEkla7ezaypzMy+col8vnP/uoKWrCs/ZImUdH7UD39gfk/iyVaqnrBPcw2sa8cdr2k
         OytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JysfUtBbV1yB6ulPL8qCt0+AynaBy1ohgfTXNgk6MB0=;
        b=67GsNwOIw3vh8as3NFcrywYlnvrSpfPXEVCvJqH/h7SLvR199+7EN4Rg8g6w0Ofzr3
         1JafX5mI8jBaSvCyJ25VfCIhZXQOvB4JDcvzvmyxgN9F+bluuH41WV+SmmRNqHhxM+Pm
         Uqaxb5aOJwfasw3jTDp/BRsirK+uDujHapxE5iRVeFWxR8t+XLJ1QXuR2NB1w/zsw7Nb
         Ee0l5rbwaM0vNlqnYgP7jA1+NiP8RpHMU2mMab8rqJUw7CEd1XiRxP0kVqKyPfLEc5YZ
         MGnoiHGZL9V8LKBt3hrCO3ySh5Hp13Vr6NdbU2IevVBa4J15w/vOc8zy3za8CoSRVdBa
         j/dA==
X-Gm-Message-State: AOAM530Dj9F2cB8VUBM4oOXFlaAUh5F2dJX6IZZXAZwFmMLSEKD4oiHV
        ZTVmoulKLjcCViP6/zzWnvE=
X-Google-Smtp-Source: ABdhPJxTH9suN+qXTycbX3htbU0fTO28wuXG11xRAdNHXf7BB5No6ds07TokaCnxj2VFjdyc0ttNPQ==
X-Received: by 2002:a7b:c844:0:b0:37b:b986:7726 with SMTP id c4-20020a7bc844000000b0037bb9867726mr2170955wml.160.1649148511840;
        Tue, 05 Apr 2022 01:48:31 -0700 (PDT)
Received: from smtpclient.apple ([95.128.147.62])
        by smtp.gmail.com with ESMTPSA id bg8-20020a05600c3c8800b0038e4c5967besm1594651wmb.3.2022.04.05.01.48.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Apr 2022 01:48:31 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] fs/proc/kcore.c: remove check of list iterator against
 head past the loop body
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <20220404155516.a5fb4c23ee017a7212e4b22c@linux-foundation.org>
Date:   Tue, 5 Apr 2022 10:48:30 +0200
Cc:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <32C4FBEE-D56B-46AA-AB95-1A17B5CC0A87@gmail.com>
References: <20220331223700.902556-1-jakobkoschel@gmail.com>
 <20220331164843.b531fbf00d6e7afd6cdfe113@linux-foundation.org>
 <A23914B0-BFD7-48D6-ADCF-42062E1D9887@gmail.com>
 <20220404155516.a5fb4c23ee017a7212e4b22c@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On 5. Apr 2022, at 00:55, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Fri, 1 Apr 2022 09:19:57 +0200 Jakob Koschel =
<jakobkoschel@gmail.com> wrote:
>=20
>>> Speaking of limiting scope...
>>=20
>> Fair point :-)
>>=20
>> I see you have applied this already to the -mm tree. Shall I still =
move the iterator?
>> The hope is to remove the 'iter' variable altogether when there are =
no uses after
>> the loop anymore.
>=20
> I don't really understand the question.

Basically I was asking if I should send a v2 with the change you =
suggested.
>=20
> My plan is to merge your patch with my fixlet immediately prior to
> sending upstream.

ok, great. Even better, so ignore my question.

Thanks,
Jakob=
