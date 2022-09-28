Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05005EE05B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 17:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiI1P2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 11:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiI1P2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:28:09 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B55C88B5;
        Wed, 28 Sep 2022 08:27:52 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id bk15so12606035wrb.13;
        Wed, 28 Sep 2022 08:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Z5021MP1akYx7neUqLr5qMs7h+HvHIkKeCKcPGSgbhc=;
        b=r0HzMbJP7JoTurQw8kPB+v/mi3d4sqAlXmwD2lZ/uZ2CWi8Novbk5wGu6c+EMSI0Iw
         uHGwXUPe40qgloD5JOAEAKhMq7vlLYMWHU7/XcXjrLIcXuZOlwrBdtpgMrew05ZbDaUb
         Z2Wp0eDfIJiorcRcy0t+H4OFa7DHk47m+ofW4holLRCQPNdBBfE3r09FoH/FGFlFgkYy
         Kw8QEUvWRA993oqP5be8clsqd6UnLnytnNmcpUX7c4kAs2HKziU45qhScCCVMkbo9oQ9
         ENWcB4xuFcX61a5RrBDoQwDsqoyDNj3GwRzbxWNR4BmSF2lIKEmAp2e5MxYoFIjXleMq
         Y8QQ==
X-Gm-Message-State: ACrzQf2Ictbli9SMJ92k++HF6yU1Ig2v9FiYtyLsqo4ziq7Yj+iC9jJ9
        DZedG1xIoz190fyDQHAIJQqu31NOo48=
X-Google-Smtp-Source: AMsMyM7AzWYKcmC4LtKzfTFeG5/T3mR7Bm6xtkkNpTyXzUEoOHjDeCH+Q5PIuxElD9rilPNBuhn+kg==
X-Received: by 2002:a5d:4741:0:b0:22c:c1a2:812d with SMTP id o1-20020a5d4741000000b0022cc1a2812dmr5779270wrs.220.1664378871204;
        Wed, 28 Sep 2022 08:27:51 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m67-20020a1c2646000000b003a342933727sm2030782wmm.3.2022.09.28.08.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:27:50 -0700 (PDT)
Date:   Wed, 28 Sep 2022 15:27:48 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Wei Liu <wei.liu@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Matthew Bakhtiari <dev@mtbk.me>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v10 08/27] rust: adapt `alloc` crate to the kernel
Message-ID: <YzRn9J9S84nj7IFr@liuwe-devbox-debian-v2>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-9-ojeda@kernel.org>
 <YzRj+47LIz2G9omo@liuwe-devbox-debian-v2>
 <CANiq72=qZPdcdPJzD0FMN13A34C9mXoMb18+uKaA7rdEGuZ0TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=qZPdcdPJzD0FMN13A34C9mXoMb18+uKaA7rdEGuZ0TA@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 28, 2022 at 05:25:55PM +0200, Miguel Ojeda wrote:
> On Wed, Sep 28, 2022 at 5:10 PM Wei Liu <wei.liu@kernel.org> wrote:
> >
> > Missing safety comment here?
> 
> The standard library does not provide safety comments for all blocks,
> and these are essentially copies of the infallible variations in the
> library, which I kept as close as possible to the original.
> 

Okay, that's fine then. Feel free to keep the RB tag.
