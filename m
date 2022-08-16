Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B3B596393
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 22:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbiHPUOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 16:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbiHPUOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 16:14:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7952880508
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 13:14:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f14so9016475qkm.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 13:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc;
        bh=tCZS1gSrzfsH3ZNBY6cc5+eBl7G2zR+ip9sLiYFEeP0=;
        b=hqELqfCgwUA0QqtPaP/SG6cfWW9baBp4BuE9YUW8cvO5mlpj5NP10O6zmzUXWJky+C
         PxVv2RORc25WfYqozglT0xU5GG2P/sj38cEEh96d1beKksQvR+E7TLg7E2ZI21W1e9pG
         w5pqsPxWR0XpSj011qRKfREgckruLLrmvIoheTiLEOxsH3tMch+mNE+9iWAgLeA3PqeD
         76AiHV9l2ArlX9IeSwIMvY/27gaoEFIPnCJQUNRaFxm3GkHlsb0upMreCstSXtMSlc4c
         1jqxRs+2iUALYmzkueRcqcOkVxY7yBTOGtW5gpLM5wwXRl2OoUJBBY3J+okIH8r7Bg11
         SdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=tCZS1gSrzfsH3ZNBY6cc5+eBl7G2zR+ip9sLiYFEeP0=;
        b=QrMnG+0Sq/TNIKz+nq6n3s7Vv5DslFpfpqpz8/3vqMB4dfKnatruhDd4uiwJnz3CmI
         muOCT5sAJREPiXmrivZqSzp92ok/4O89npqxMr4W2KRoJ+fsjabgf9ip1du+B6vx5llN
         f1gDt/lz9baXUvo8UGspa4snFlV4/FLfEsVJi4qtyH5dacfjpgQL17UHXmyuTAsZH1DZ
         Txy2ofkE3FhBzjGc052Uutdgy18yCg5X8Unn+Xq9hgq2k2p2798AimfGjy3to+euN5Lx
         RkgX29qq2aC1tVccI1IabbSzX92OzRp7Vv5SuOafaxRG42mgxrJoLOBLtw8DyJAKsC0b
         vLyg==
X-Gm-Message-State: ACgBeo3bkwMK9BcgZdS/HUDP19fiz0HE90mNsuYNgoWJVcoYKwhEfHU8
        UZp2wTLMO0x7sq/nziGGVOsu2g==
X-Google-Smtp-Source: AA6agR4AXidIxbOb8GAVYnk6vENLdsLtAwLAbLVMilD+vFwOAIt8tf4YxcuDsefVP/+g3zcQuALwdQ==
X-Received: by 2002:a05:620a:2844:b0:6b8:8cc3:9387 with SMTP id h4-20020a05620a284400b006b88cc39387mr16102781qkp.615.1660680881483;
        Tue, 16 Aug 2022 13:14:41 -0700 (PDT)
Received: from cs.cmu.edu (tunnel29655-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:582::2])
        by smtp.gmail.com with ESMTPSA id bs30-20020a05620a471e00b006b910e588a4sm12519681qkb.129.2022.08.16.13.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 13:14:40 -0700 (PDT)
Date:   Tue, 16 Aug 2022 16:14:38 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Switching to iterate_shared
Message-ID: <20220816201438.66v4ilot5gvnhdwj@cs.cmu.edu>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
References: <YvvBs+7YUcrzwV1a@ZenIV>
 <CAHk-=wgkNwDikLfEkqLxCWR=pLi1rbPZ5eyE8FbfmXP2=r3qcw@mail.gmail.com>
 <Yvvr447B+mqbZAoe@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvvr447B+mqbZAoe@casper.infradead.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 03:35:46PM -0400, Matthew Wilcox wrote:
> fs/coda/dir.c:  .iterate        = coda_readdir,
> 
> Would anyone notice if we broke CODA?  Maintainers cc'd anyway.

Ha, yes I think I would notice, but probably not until after the changes
got released and trickled down to the distributions ;)

So good to know in advance a change like this is coming. I'll have to
educate myself on this shared vs non-shared filldir.

Jan

