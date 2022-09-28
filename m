Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643CF5EDF67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbiI1O7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiI1O7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:59:31 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4479E9C7C6;
        Wed, 28 Sep 2022 07:59:25 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id bq9so20246306wrb.4;
        Wed, 28 Sep 2022 07:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AX/XCxhpdbVVHbhyunySUg3dFfYwUm6jVR02ydVl864=;
        b=DCkWlFMgdjoXRNQpbMsB0xfn7wA3UnRdh0a6yFwxR29tUOe8xAZPzoi+uLvJbct+uj
         EPjHawDkgaI2hdUCt+zRdasz7ZT/o+iBIMO/pb8PCwzntTP/uHco9/VStXULw2x0H2Qn
         V8MnP4LquLb6sWscLxLPJpC0SwbO+xPsNnpTE3WDwbCxOoiQ3YOdogvqS1SDDwdqrz6V
         IOvkMI5aA9a1+FkuiBwzfTej5YlT54ICf2t19n7nDMccFSaN9eXjhNVVb46WQgnUBfWj
         ytzSTzQhI/UHK0oSCJk3o65ORi300SeVGzixkMbvSOQl6NQdNjVlzOo8KDs0YfVhMKrW
         ycVQ==
X-Gm-Message-State: ACrzQf13+M3Oo+jTNVe8n3wVBKH2Z5UId/3/Yh/5d6TsS0X7EAd+7Oy8
        HuUHVylb6bZYCtvC7mmlLRk=
X-Google-Smtp-Source: AMsMyM650KPDXUhvVyBLF0kqvjrxyaYRuq5nqe51aXlk0h3C0AQ/x0l1j5SwC8jkwKaQOnXhBILMaw==
X-Received: by 2002:a5d:5b0a:0:b0:22a:f83a:2b6f with SMTP id bx10-20020a5d5b0a000000b0022af83a2b6fmr21403721wrb.176.1664377163416;
        Wed, 28 Sep 2022 07:59:23 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4203000000b0022acb7195aesm4458839wrq.33.2022.09.28.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:59:22 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:59:21 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Kees Cook <keescook@chromium.org>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v10 02/27] kallsyms: avoid hardcoding buffer size
Message-ID: <YzRhSaJph/wo0OqY@liuwe-devbox-debian-v2>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-3-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-3-ojeda@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:33PM +0200, Miguel Ojeda wrote:
> From: Boqun Feng <boqun.feng@gmail.com>
> 
> This introduces `KSYM_NAME_LEN_BUFFER` in place of the previously
> hardcoded size of the input buffer.
> 
> It will also make it easier to update the size in a single place
> in a later patch.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
