Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFC25977DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241883AbiHQU1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbiHQU1k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:27:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7A0A924A
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:27:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g18so4515776pju.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=e8AurnYaw5w6q42X379tvVxdUwxeEA/mYjtAY47a6po=;
        b=aLY/bwswAmyWGmv+4JEwglL+yZmZSkY5uTI10+jNpMXObxnDHYBy1/NFE6oNgiy8gm
         8M7QxAggsLjoXwN0tKrViIKk34FBRU2jjAG7OmyyvJlon3HbSz6RYHrCeWoKD7s7v+ey
         WBXTu2wjGczVnm7NC9ChqKPe87n8jYbCFqs3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=e8AurnYaw5w6q42X379tvVxdUwxeEA/mYjtAY47a6po=;
        b=aeMZTGKG1ZVUxjn2cVJQsy/L4DgsPxEExWlEYjLimVU6et2S+bGYv68uOKAVvU0ZFp
         AXJ5O6jmzB8J8Vv67T+Acovxr9jr9OLAqsGT+4IVxbI4HCg5lJLHe4Cd3yxZDqfaHcyL
         vS7L2aRwuND1sIxZmEjb5+H4arpOpXLaIHK+QGoWYM7Xj+cWMkOFrsOuUGE5vxcW61Z/
         fEWf2VbhLlW9DCxYWYhNpb0E3CJOcpc0gt3I2cqWHsR/6ebao0kFHTWcI7YIf+OtfuZ9
         S1ZN2ow+KXz/vJ7e3M498bRndU/9cbiRIbdlOJOYsmAT2CpYm0HlM6Jbw5Q2ZITmgp43
         iuSQ==
X-Gm-Message-State: ACgBeo3+8vdtXLD2oqABYqkinGDlCoRGEdLRpVMCGDkLTW0oip4Au3IB
        VnBmCRuLnBYe1JjAavooNYzP9g==
X-Google-Smtp-Source: AA6agR5S9YLS9hTLBjiPpJ4Ms8k04xxDQPAV7b2x3cjD+0b+HLPqSTmwLa6D1Y6x82x152TjEZlwVw==
X-Received: by 2002:a17:902:cccb:b0:172:60b7:4590 with SMTP id z11-20020a170902cccb00b0017260b74590mr20507691ple.152.1660768058582;
        Wed, 17 Aug 2022 13:27:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709027e4800b0016efa52d428sm320362pln.218.2022.08.17.13.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:27:37 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:27:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        David Gow <davidgow@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 25/27] x86: enable initial Rust support
Message-ID: <202208171327.EFF61F0E@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-26-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-26-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:42:10PM +0200, Miguel Ojeda wrote:
> Note that only x86_64 is covered and not all features nor mitigations
> are handled, but it is enough as a starting point and showcases
> the basics needed to add Rust support for a new architecture.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
