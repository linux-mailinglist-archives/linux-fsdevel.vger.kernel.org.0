Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279ED7A2D5F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 04:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbjIPCPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 22:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237881AbjIPCPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:15:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7991FD2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 19:15:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a9cd066db5so357398966b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 19:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694830510; x=1695435310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FbufmgnpA0aesZB//HGaq/RO2Y/ticw2RyjyAED+2xY=;
        b=NanDQtzLSn56DbN41fh7mYp+Cdf7CmrHSQHG1DhofFoaQ9727yFGL0Qxo6F7P8BvJK
         5EGwqZn3/fUukro+ACcvUx1MMOAGJaJ9ZUfkS/VaAhLbXvBtUGoEk8MjlD3C+gJ68gUj
         FvQ0uFfbULzhZ5g/syv9gwlwjNIOxVN5i6GWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694830510; x=1695435310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbufmgnpA0aesZB//HGaq/RO2Y/ticw2RyjyAED+2xY=;
        b=fGOdwEJy3nxIveTJ9hfVoFo2r2eVqs1gSmWrrizxFlqrJnVTtdTh78ckDLwrbYl6ds
         of3v25u9j9KE0FHXBZM+LsXUHM4ld+Edt+qfNxJFVdokTEkNHM5UM1H0fpswNNTwR8R5
         pXYVX7QJeS8SISKM0sW5rXuwCVKcHGv+CqwEWq2rbGoYnVbyKOazNeBLk7mOiisn931i
         6IEZH1sb+HY0dqGaoMuLnaDPqzigNwR/psBGWk3X/2ilaUQ0E8iwojZ6sEvJM4xbPAmg
         ntbHkYlriFaGLWOU1BdQbjnccTbkYgRsKf4c08V6x6j1cw7/piUuC6F11B6MjXRwL0cb
         X+EQ==
X-Gm-Message-State: AOJu0YxOqB7zEvleuMC2S4yeBrEI7CCBQWiw04ugOMv4DjB1PtULVOVM
        OVeXUFAse24ho7HkKIvhvMEwgfyhSrRn2rpwz4j3wZMA
X-Google-Smtp-Source: AGHT+IEPHa4EE8fxDj/LNeGzkKbveUY1pwjXGy/8p5/BCaS09J0L0w4G9Lo7iO5VKLHQ1zETHhBLew==
X-Received: by 2002:a17:906:c4b:b0:9aa:e07:d421 with SMTP id t11-20020a1709060c4b00b009aa0e07d421mr2787616ejf.43.1694830510589;
        Fri, 15 Sep 2023 19:15:10 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id kg28-20020a17090776fc00b00992d122af63sm3110366ejc.89.2023.09.15.19.15.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 19:15:09 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso353999366b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 19:15:09 -0700 (PDT)
X-Received: by 2002:a17:906:cc9:b0:977:ecff:3367 with SMTP id
 l9-20020a1709060cc900b00977ecff3367mr2903210ejh.40.1694830509066; Fri, 15 Sep
 2023 19:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org> <20230915183707.2707298-9-willy@infradead.org>
 <CAHk-=wgBUvM7tc70AAvUw+HHOo6Q=jD4FVheFGDCjNaK3OCEGA@mail.gmail.com>
 <ZQT4/gA4vIa/7H6q@casper.infradead.org> <CAHk-=whbj+pVGhJTcQCLhY8KZJNomWOKM=s-GZSpK_G=G4fXEA@mail.gmail.com>
In-Reply-To: <CAHk-=whbj+pVGhJTcQCLhY8KZJNomWOKM=s-GZSpK_G=G4fXEA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 19:14:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+QEzoiUjeUkYqkJe4mcTQCshaAje51PiAuJu+REYxSA@mail.gmail.com>
Message-ID: <CAHk-=wj+QEzoiUjeUkYqkJe4mcTQCshaAje51PiAuJu+REYxSA@mail.gmail.com>
Subject: Re: [PATCH 08/17] alpha: Implement xor_unlock_is_negative_byte
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 15 Sept 2023 at 19:01, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> No, I think "mov src,dst" is just a pseudo-op for "or src,src,dst",
> there's no actual "mov" instruction, iirc.

Bah. I looked it up. It's actually supposed to be "BIS r31,src,dst".

Where "BIS" is indeed what most sane people call just "or". I think
it's "BIt Set", but the assembler will accept the normal "or" mnemonic
too.

There's BIC ("BIt Clear") too. Also known as "and with complement".

I assume it comes from some VAX background. Or maybe it's just a NIH
thing and alpha wanted to be "special".

              Linus
