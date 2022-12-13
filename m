Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6633064BF49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 23:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbiLMWWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 17:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiLMWWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:22:38 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9291FF9C;
        Tue, 13 Dec 2022 14:22:35 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id c1so7374777lfi.7;
        Tue, 13 Dec 2022 14:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grg0bvt97ijbsfmyQgu+5+MNtO6B9tZuIIZrlfXrE7g=;
        b=G9cs68AGm0bDo2dxa3H+gWo/J6MyRHIeXJ20mm/LQuWgWQUgQehvq+ynwR+urC9gwZ
         BLHGiQ/auh2nYN2KleCpgDML8YKeuit5PfaNAzQPpdNIvABNP/SeHVlmiylqr/8p0AAZ
         6MC9RaeQKHJHAvVuHGbVYwTiGxYH2VQ2c+M7r6hBH/ic6J4JoG12hOrHLivluU+F3lEN
         trBhSbjWvENewcIbEfgZ2RwvoN1xGZuwGedaopx0YnwEu65SoWgJpM8Wsxj9bePxt2kI
         +NZInILggNT3DlntTw27WrASJa22vkPuwtTEE/2FBNHuIO1YFQ8KlQwwh6+qm660raC/
         GCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grg0bvt97ijbsfmyQgu+5+MNtO6B9tZuIIZrlfXrE7g=;
        b=PWA0LKtAhIGuvc2CKP/K2/a6TnSeinhv21spuw1CgWL41fL8goooWaB6TCbNjlf8f9
         ZHlZw6ejO0kHma21wWZWBburpTLAKbl8TZgZDhy3xARQle+0KW15lfJD6XvCkU7Qb9f5
         mHnaKRr2JRpUWYAIMPvvoRedb10WFHHaL175piqOy6qyykO1YKu5kfVp+JLOuV/RY2DC
         p5/v2AcHSlnjzBbeWaKpmEUxzNDMyyym9spfbiSyh6HhEOvE1i579m2BN3BiZpE4s+O5
         hs0Mx7ZaUV7ZoiF0S0Rj+Qgq95Jdg6Wc5eCfVy61btke1FLrz671v0JenT3fLx+qkqvd
         JiWg==
X-Gm-Message-State: ANoB5pm30xpSlPvDYFBYXWkYKRhLYCEwq5faBl38INeIX+6WEQXVAu3f
        IWhAqyxs3x7jlympkuWwd7o=
X-Google-Smtp-Source: AA0mqf7apQ6SPd44a4c4jCfkeueA+Hwx6ga2toN4O+BsyaHnVrSk6bw5HptAKGAyvZiPDSlnd5V11g==
X-Received: by 2002:a05:6512:3d0e:b0:4b5:9043:2530 with SMTP id d14-20020a0565123d0e00b004b590432530mr7831770lfv.68.1670970153809;
        Tue, 13 Dec 2022 14:22:33 -0800 (PST)
Received: from grain.localdomain ([5.18.253.97])
        by smtp.gmail.com with ESMTPSA id o5-20020ac25e25000000b004acd6e441cesm530270lfg.205.2022.12.13.14.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 14:22:32 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 820EB5A0020; Wed, 14 Dec 2022 01:22:31 +0300 (MSK)
Date:   Wed, 14 Dec 2022 01:22:31 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zach O'Keefe <zokeefe@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list : PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Paul Gofman <pgofman@codeweavers.com>
Subject: Re: [PATCH v6 2/3] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <Y5j7J3hI7Div/WH8@grain>
References: <20221109102303.851281-1-usama.anjum@collabora.com>
 <20221109102303.851281-3-usama.anjum@collabora.com>
 <Y5eSKBJ9hTtw9cbK@grain>
 <d7185563-3a7a-d69e-d3d1-1a2b071aa85d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7185563-3a7a-d69e-d3d1-1a2b071aa85d@collabora.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 06:04:04PM +0500, Muhammad Usama Anjum wrote:
> > Hi Muhammad! I'm really sorry for diving in such late (unfortunatelly too busy to
> > step in yet). Anyway, while in general such interface looks reasonable here are
> > few moments which really bothers me: as far as I undertstand you don't need
> > vzalloc here, plain vmalloc should works as well since you copy only filled
> > results back to userspace.
>
> Thank you for reviewing. Correct, I'll update to use vmalloc.
> 
> > Next -- there is no restriction on vec_len parameter,
> > is not here a door for DoS from userspace? Say I could start a number of ioctl
> > on same pagemap and try to allocate very big amount of vec_len in summay causing
> > big pressure on kernel's memory. Or I miss something obvious here?
>
> Yes, there is a chance that a large chunk of kernel memory can get
> allocated here as vec_len can be very large. We need to think of limiting
> this buffer in the current implementation. Any reasonable limit should
> work. I'm not sure what would be the reasonable limit. Maybe couple of
> hundred MBs? I'll think about it. Or I should update the implementation
> such that less amount of intermediate buffer can be used like mincore does.
> But this can complicate the implementation further as we are already using
> page ranges instead of keeping just the flags. I'll see what can be done.

You know, I'm not yet convinced about overall design. This is new uapi which
should be reviewed very very carefully, once merged in we can't step back and
will have to live with it forever. As to buffer size: look how pagemap_read
is implemented, it allocates PAGEMAP_WALK_SIZE buffer array to gather results
then copies it back to userspace. If the main idea to be able to walk over
memory of a process with mm context locked it still doesn't bring much benefit
because once ioctl is complete the state of mm can be changed so precise results
are only possible if target process is not running.

Maybe all of these aspects are been discussed already I probably need to read
all previous converstaions first :)
