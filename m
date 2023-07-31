Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF3E76A10C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 21:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjGaTVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 15:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjGaTVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:21:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E6DE5F;
        Mon, 31 Jul 2023 12:21:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31297125334so3334330f8f.0;
        Mon, 31 Jul 2023 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690831294; x=1691436094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1On/KiRyE9vftggERFLzh8PS8Zt/RkJXfV5TSxkZ7ec=;
        b=F+W8OGdxSzu8BC0xALV8+qGARtWLmhFnrSS/3SIIB3afnud+usI+Ab1CiSRhjo2HM0
         xqwymACj2ixZvQtvimKzVzexF+ETcZLMXlqRc3HZXRpxb8/Io+TRv3tjO8C3/hOi7vds
         exZiQucHo15paHqoBpJKbI3hbPubHLECK9VF3TNUbFSfmTKwsUVjC3rnuyBmodDnoTBl
         TONTeRasQmEgfoseekDndPcaUzy5tXMb5ul+FlKCr5w3rxF1lLbg/axacBWvhFPhpVoC
         fsZRVKcMxvrDH4C6J3wTx92rsSICtVy6c11F3ANAQkBNuq8/rqM1sKfHFbB0bqGX5dyW
         8Nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690831294; x=1691436094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1On/KiRyE9vftggERFLzh8PS8Zt/RkJXfV5TSxkZ7ec=;
        b=Jlv8lF4QBr0Qg0pp4atIbTN6n84DXymi5z3u9f9qoloTugKt3+Mv5iTVEsIM6TUbV6
         +SUSvNgA7wEyxtXE27iJr/sN3QWpZ06+7J6KlLTLjEHz0hSMiNeznsYjtHIj9dp2KCPz
         G6bDQ3MiCkuruQbnNVHFY87KkXnwqtfkqgkKebEO+C5iQNphUvuuENNZ3tSsMzik/LDT
         mYxLO4EmzEc/JyZh9rrAI9epTBeWq+32sxfRcBqlueXYRNTrFf14HF1G1KamwrIWJnDM
         QUxg9JQnUTOsJjOSeSoW29N5/l7V+AHr6RcupZ8l+41emkOG+3aOgSWdumQc8xy5hDqO
         x0VQ==
X-Gm-Message-State: ABy/qLbUlQEfE7OyR08CHuuotNsLu73fVPHR/irXyJR5Z5rdv3TgvoSj
        fu91AapKlBOQAW5+EOG7xXY=
X-Google-Smtp-Source: APBJJlHOaPMTFdzeZ1MhBed2PMj/5baagWzIaktNXum9X1zi+9to9ASFG6lc0F9cJ7+UGb7I4Paq4A==
X-Received: by 2002:adf:d84f:0:b0:317:5cfb:44c7 with SMTP id k15-20020adfd84f000000b003175cfb44c7mr491514wrl.30.1690831293771;
        Mon, 31 Jul 2023 12:21:33 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id e5-20020a5d5005000000b00311d8c2561bsm13808194wrt.60.2023.07.31.12.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 12:21:33 -0700 (PDT)
Date:   Mon, 31 Jul 2023 20:21:32 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Jiri Olsa <olsajiri@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v8 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Message-ID: <f10f06d4-9c82-41d3-a62a-09c62f254cfc@lucifer.local>
References: <cover.1679566220.git.lstoakes@gmail.com>
 <fd39b0bfa7edc76d360def7d034baaee71d90158.1679566220.git.lstoakes@gmail.com>
 <ZHc2fm+9daF6cgCE@krava>
 <ZLqMtcPXAA8g/4JI@MiWiFi-R3L-srv>
 <86fd0ccb-f460-651f-8048-1026d905a2d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86fd0ccb-f460-651f-8048-1026d905a2d6@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 08:23:55AM +0200, David Hildenbrand wrote:
> Hi,
>
> >
> > I met this too when I executed below command to trigger a kcore reading.
> > I wanted to do a simple testing during system running and got this.
> >
> >    makedumpfile --mem-usage /proc/kcore
> >
> > Later I tried your above objdump testing, it corrupted system too.
> >
>
> What do you mean with "corrupted system too" --  did it not only fail to
> dump the system, but also actually harmed the system?
>
> @Lorenzo do you plan on reproduce + fix, or should we consider reverting
> that change?
>
> --
> Cheers,
>
> David / dhildenb
>

Apologies I mised this, I have been very busy lately not least with book :)

Concerning, I will take a look as I get a chance. I think the whole series
would have to be reverted which would be... depressing... as other patches
in series eliminates the bounce buffer altogether.
