Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994F27A5DB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 11:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjISJZK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 05:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjISJZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:25:09 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9F2100;
        Tue, 19 Sep 2023 02:25:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27499bb759cso2747513a91.3;
        Tue, 19 Sep 2023 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695115500; x=1695720300; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S2Aq5Ukk7Fnm/UrgZLz/+HdEj7r6s/6zcK8vNUOpQoE=;
        b=PgmYbccRGhmM86uh6ub2E+5HDW/7mYEdxVmMCEdRjhojORYFXvv3BUa+1NV0H+KhVl
         /dgz7hzKSDKMZmsYQ/lWwYiW9MYIeLMjOqEgA/dwZJECQVCukMKnPgvMjZKPD+q9df3k
         b/xvXzpdWfKNhgkO9nNfnv/N4tJoPgjn78FbnfxpOMB95648m6Jg8MC/UTcWHoI4q3HQ
         65/IQUGn3yMtgEuMGDEP6FmniPs8l7eyv0pt0JoIlJZ6a9wYtkl1GCfx1ZdjGSi1n2Ns
         Es+NpFJmulZ2n/UZrRYBOqV5iJdqojy4Bk4o2q4tjnq8MIs+5cDXUiNDmWDFz4LAqC0F
         plYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695115500; x=1695720300;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2Aq5Ukk7Fnm/UrgZLz/+HdEj7r6s/6zcK8vNUOpQoE=;
        b=qIGT3tLx/P9vid7+iFca9Bix02JyePXAnQBfDGkxt25w88Vvp+vSxsaj+mJ3G4s1PY
         7lGp100kDi/cOCJytxfZb7rRCQQmf4VIZLueNEK11k9n6asW1fDedCLFwxAD3iXmbZKz
         7+pYtv3AcBNUC/1PfXjQ2F5UXAsNcPzHezcTFNGpOmVCTUOBxa2coF+E9D+dloWEhNnF
         v4QuLUpC+LdcFlOA8s+i9Ah+XyakJPJGm9XYtgOgyjr57aYQuwPq6BSby8K/u2Qp824j
         ilfFhpePRKK7VEgtIEowNctfrVL8chnaR+/3NAb+tXjnpuXXrK3FVKfzwVu3+qbkB4/K
         egqA==
X-Gm-Message-State: AOJu0YyDsONskBW/4r95SxlLRp1SM2cvlgsE9mIfgtqoHCmOWv8EIJ++
        YiRM5woeO+4Xhok7eXCfHxM=
X-Google-Smtp-Source: AGHT+IG/GWNXzoBweCHxh0HzDSXeYTA6HP4U3FPJ26/OsolQHvDiIDLHXMaiAOQ9Jg8l62uzHx2VOQ==
X-Received: by 2002:a17:90b:3583:b0:268:7be6:29a5 with SMTP id mm3-20020a17090b358300b002687be629a5mr8760270pjb.9.1695115500538;
        Tue, 19 Sep 2023 02:25:00 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902b60300b001bbb8d5166bsm9627003pls.123.2023.09.19.02.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 02:24:59 -0700 (PDT)
Date:   Tue, 19 Sep 2023 14:54:56 +0530
Message-Id: <87cyye7bx3.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>, djwong@kernel.org
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 1/2] iomap: don't skip reading in !uptodate folios when unsharing a range
In-Reply-To: <87sf7a7p04.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> "Darrick J. Wong" <djwong@kernel.org> writes:
>
>> From: Darrick J. Wong <djwong@kernel.org>
>>
>> Prior to commit a01b8f225248e, we would always read in the contents of a
>> !uptodate folio prior to writing userspace data into the folio,
>> allocated a folio state object, etc.  Ritesh introduced an optimization
>> that skips all of that if the write would cover the entire folio.
>>
>> Unfortunately, the optimization misses the unshare case, where we always
>> have to read in the folio contents since there isn't a data buffer
>> supplied by userspace.  This can result in stale kernel memory exposure
>> if userspace issues a FALLOC_FL_UNSHARE_RANGE call on part of a shared
>> file that isn't already cached.
>>
>> This was caught by observing fstests regressions in the "unshare around"
>> mechanism that is used for unaligned writes to a reflinked realtime
>> volume when the realtime extent size is larger than 1FSB, though I think
>> it applies to any shared file.
>>
>> Cc: ritesh.list@gmail.com, willy@infradead.org
>> Fixes: a01b8f225248e ("iomap: Allocate ifs in ->write_begin() early")
>> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
>> ---
>>  fs/iomap/buffered-io.c |    6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Thanks for catching this case. Fix for this looks good to me. 
> I have verified on my setup. w/o this patch it indeed can cause
> corruption in the unshare case, since we don't read the disk contents
> and we might end up writing garbage from the page cache.

To add more info to my above review. iomap_write_begin() is used by 
1. iomap_write_iter()
2. iomap_zero_iter()
3. iomap_unshare_iter()

And looks like out of the 3, iomap_unshare_iter() is the only one which
will not write anything to the folio in the foliocache, & we
definitely need to read the extent in folio cache in iomap_write_begin()
for unsharing.

Hence I believe iomap_unshare_iter() should be the only path to be
fixed, which this patch does by checking IOMAP_UNSHARE flag in
__iomap_write_begin().

>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
>

-ritesh
