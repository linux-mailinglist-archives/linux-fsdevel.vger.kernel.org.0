Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C617186AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 17:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjEaPsv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 11:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjEaPsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 11:48:39 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6158E93
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 08:48:35 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-339fca7da2aso2001665ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685548115; x=1688140115;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xh+NM7DUxAEzTOJt7Ae/1UKGsTT1CaBWPKgHIK+Ua4s=;
        b=TeV2nuosxCCQSaB5ZclhgFC3ci1TbhrLaLO7YeIa++CfuP3tLyp3XgFpxvgwElWYJB
         tHOvz9UOWflYz0udLqW8SlXtramYgCn2tvTozp6JaEpMJEnUOIOc9htdjbFb9wvYSRcL
         Q9sgHw0VEfQJl89cB8p6S3BmlVvQ51rl2tUtJAP0ZFYUgvBVXjltJCIrCS2NNtp+8Dxx
         Ctg+EYHhUNQDa0WFaYpG+Dq1/lO8dS++A7XL0PkNnCt87heuEDDhP4nKE2bgY3mhTx8o
         ejL2+csFEJTi2h+Flhy8H6ZBi8Zxqv3ks3EYKU54mH0IQkZju6Ym/N47UBAkeuuRGS/b
         MQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685548115; x=1688140115;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xh+NM7DUxAEzTOJt7Ae/1UKGsTT1CaBWPKgHIK+Ua4s=;
        b=f7V0BQZWsM77LFpF665r5BMQB4lN9QGvkfRD96Nf9wjeiVgrZyK6jJ++hwjV5NM6EL
         wbF4LPGJKzEtfnAYFHHFaRDxVzgc2z7CVu6rbwlk07TvNrCaNkmSlLT3Yn2zOu6ebNVl
         TM7YihnZnzjrm2+p4/w61TgNwCP8budR+Gp5NF4CMmaTcRF+D9OiBhb/wDlEZaK3016D
         E0l633nKS91Mu3rgCUNqGK1Ov9eteicQc8PXWrDxabuE5tsKqLJVcWUIVrdz85RZfstK
         2c9jaNDxxR3BrN7Bzk+lewBETqhrSwWdzqcsp47wnD3vTTXWfnJKyXFTkOoYcTWsWzrm
         PAzg==
X-Gm-Message-State: AC+VfDyXl18mRTmErbJdckzWw8yCW6mXW+PHOa9lzDok2g2OjWs6R/Vh
        fd5jAimigDlRPhuCoxAeeDrREg==
X-Google-Smtp-Source: ACHHUZ7olLMdzgJo49hRI+Brw+8ZbYH7IxOyZnrYIxdhWvtRY4fllkEJYDoAKqWowWyMCg9AG6Kdvg==
X-Received: by 2002:a6b:8d53:0:b0:774:80fc:11a9 with SMTP id p80-20020a6b8d53000000b0077480fc11a9mr1999696iod.1.1685548114657;
        Wed, 31 May 2023 08:48:34 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f16-20020a02a110000000b004091d72f62dsm1552201jag.85.2023.05.31.08.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 08:48:33 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20230526214142.958751-1-dhowells@redhat.com>
References: <20230526214142.958751-1-dhowells@redhat.com>
Subject: Re: [PATCH v4 0/3] block: Make old dio use
 iov_iter_extract_pages() and page pinning
Message-Id: <168554811322.183150.13490236053670818511.b4-ty@kernel.dk>
Date:   Wed, 31 May 2023 09:48:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Fri, 26 May 2023 22:41:39 +0100, David Howells wrote:
> Here are three patches that go on top of the similar patches for bio
> structs now in the block tree that make the old block direct-IO code use
> iov_iter_extract_pages() and page pinning.
> 
> There are three patches:
> 
>  (1) Make page pinning neither add nor remove a pin to/from a ZERO_PAGE,
>      thereby allowing the dio code to insert zero pages in the middle of
>      dealing with pinned pages.  This also mitigates a potential problem
>      whereby userspace could force the overrun the pin counter of a zero
>      page.
> 
> [...]

Applied, thanks!

[1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
      commit: c8070b78751955e59b42457b974bea4a4fe00187
[2/3] mm: Provide a function to get an additional pin on a page
      commit: 1101fb8f89e5fc548c4d0ad66750e98980291815
[3/3] block: Use iov_iter_extract_pages() and page pinning in direct-io.c
      commit: 1ccf164ec866cb8575ab9b2e219fca875089c60e

Best regards,
-- 
Jens Axboe



