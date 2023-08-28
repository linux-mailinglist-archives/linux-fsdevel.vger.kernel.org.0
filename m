Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11AE78A4B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 05:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjH1DAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 23:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjH1DA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 23:00:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD98114;
        Sun, 27 Aug 2023 20:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D80256116C;
        Mon, 28 Aug 2023 03:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA2BC433CC;
        Mon, 28 Aug 2023 03:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693191626;
        bh=otjFS/8nOzqMsBwSJ/OzkjYo/maytY8GZwVsaXFlmug=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=WX9rFIsMNS+yrTdGRuXMvADbB9RFUf1yjAQdLR7zTPLJEvcmaT5EErDfdas1WiFdT
         76i8sX+jykpTO542mqalzMpiANQm10VyLsC/iz9oIw2mADukDoDawsQWuzdPJbejHp
         qOglqbh7kV4ZWYg8Bm65OtSsdINsXwvG7muhZerelCe7Hf/qHMbeWK0p2rE0Vzf7EF
         d9G7jr+MULe2tcthn2OlS4PGjYM0/4+MPq5NBXPtNxVn0evao9YWNSITmDbwtkGKxr
         oV6G0RAKRUtQ66CpcjCHixM7vZ1cbZ3VfghQw4bRpdTLBg/BBye+nJsc5LUyetiKGO
         VXf048NQqXp5w==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5738cb00eebso343939eaf.2;
        Sun, 27 Aug 2023 20:00:26 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx6X8qNG8HQ7Y8MIbTmxl3gCYAGSKemRTrfsBwf7KqrM8cgf/7c
        anzIJa+BrH4eQpCW98QiCeosKfs03cTsCXVHOyk=
X-Google-Smtp-Source: AGHT+IHn+IZlq/F9TsDGUwaduR4k2lI9GSIkPRkjCukEQ4C/QzXTk6ZbBy3ti0e0YyvS2NHc2QQ+pkCPQO4kBE+KG40=
X-Received: by 2002:a4a:281a:0:b0:573:3711:51c4 with SMTP id
 h26-20020a4a281a000000b00573371151c4mr8363886ooa.8.1693191625380; Sun, 27 Aug
 2023 20:00:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6802:1090:b0:4f6:2c4a:5156 with HTTP; Sun, 27 Aug 2023
 20:00:24 -0700 (PDT)
In-Reply-To: <54a8ae10-71f4-9e91-d2b7-bd4a30a8ac2a@gmail.com>
References: <20230813055948.12513-1-ghandatmanas@gmail.com>
 <2023081621-mosaic-untwist-a786@gregkh> <54a8ae10-71f4-9e91-d2b7-bd4a30a8ac2a@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 28 Aug 2023 12:00:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9-NjSjt-TrJ6fYcPDHcaUm-L=-h5OU98DTw97J2qwmXA@mail.gmail.com>
Message-ID: <CAKYAXd9-NjSjt-TrJ6fYcPDHcaUm-L=-h5OU98DTw97J2qwmXA@mail.gmail.com>
Subject: Re: [PATCH v4] ntfs : fix shift-out-of-bounds in ntfs_iget
To:     Manas Ghandat <ghandatmanas@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux-kernel-mentees@lists.linuxfoundation.org, anton@tuxera.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-08-18 15:34 GMT+09:00, Manas Ghandat <ghandatmanas@gmail.com>:
> Sorry for the last reply Greg. The last tag specifies the commit id.
> Also, I have sent the v5 of the patch in which I have made some critical
> changes. Please take a look at that.
Have you checked build error report from kernel test robot ?

>
> On 17/08/23 00:45, Greg KH wrote:
>> On Sun, Aug 13, 2023 at 11:29:49AM +0530, Manas Ghandat wrote:
>>> Currently there is not check for ni->itype.compressed.block_size when
>>> a->data.non_resident.compression_unit is present and NInoSparse(ni) is
>>> true. Added the required check to calculation of block size.
>>>
>>> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
>>> Reported-by: syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=4768a8f039aa677897d0
>>> Fix-commit-ID: upstream f40ddce88593482919761f74910f42f4b84c004b
>> What is this last tag for?  That's a kernel release version, what can be
>> done with that?
>>
>> confused,
>>
>> greg k-h
>
