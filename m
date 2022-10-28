Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA11611B90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 22:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJ1Ue0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 16:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJ1UeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:34:25 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB1222C457
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 13:34:24 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id l28so4227929qtv.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 13:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5JcJ09bBdlBVf21xZKuOSzNCt5BJDxCAWw6Qi6m3gKQ=;
        b=hU743kZXYxAVHQ1EsSBvl3ayRYEjnGCLfaHZ8Jv5OOMADfUvRRqwIase4PKYUcaJ3E
         INbfDZi9n0Q5pnuXHtRhyGvyX40BjYI+eGMAw+5rMraVeCJayNAIOiRRhBR82dlGAo05
         /mVa5vBjROjk9lw+ojylUbMmMrQmNGOeXMwBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JcJ09bBdlBVf21xZKuOSzNCt5BJDxCAWw6Qi6m3gKQ=;
        b=M5oF22RRfAvJY+Nb/9ajnHYgtrtnVRNZHuat2754uflIUFeG+TroYEl14upqivjA/y
         Tq+zy0DkN1sXkOWB1bezLMO1zZpcWxPV70kI4jFXbAC8ZvrhosVUgl0mhGUDye9eVXiV
         lXC2CLgvor6OJ9+al3trxoRL7tIqB5w00hDVL0lPm3nRHosNEiSwMXf1lYuqiuQugXgw
         DP7j/5CdOhMOQRBGi93PbqRsTKmgIZSr9RNeiK1Ia7Tw2m3UyS2DSikbU4mpbRs5w56y
         7XZsw05DlT9tV/1+PPgEqdIB2FZ+8dC3GlUSZZuscYYwZ1/kl/Kba0nWu+JQh2JoD2Qa
         4QsQ==
X-Gm-Message-State: ACrzQf2wQUH9h0QoJOhjjxFBuDV2fqW3vER9zG0f4oc2qw9jX/vy/fOG
        4ajg/e/OcZtZGjcsBN0VNP9FfLQcjYWXhw==
X-Google-Smtp-Source: AMsMyM4N/sAHrTCgvcCxlrNUHZXzxF36i5Mg+yRrwq73ZY7GPm9kmgMewkqmMELUh9FVO2k/Pe8f5g==
X-Received: by 2002:ac8:5ac7:0:b0:39c:c198:e6fd with SMTP id d7-20020ac85ac7000000b0039cc198e6fdmr1210777qtd.220.1666989263327;
        Fri, 28 Oct 2022 13:34:23 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05620a179300b006cf9084f7d0sm3692140qkb.4.2022.10.28.13.34.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 13:34:21 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id j7so7385675ybb.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 13:34:21 -0700 (PDT)
X-Received: by 2002:a5b:984:0:b0:6ca:9345:b2ee with SMTP id
 c4-20020a5b0984000000b006ca9345b2eemr931629ybq.362.1666989261347; Fri, 28 Oct
 2022 13:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <Y1btOP0tyPtcYajo@ZenIV> <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
 <20221028023352.3532080-12-viro@zeniv.linux.org.uk> <CAHk-=wibPKfv7mpReMj5PjKBQi4OsAQ8uwW_7=6VCVnaM-p_Dw@mail.gmail.com>
 <Y1wOR7YmqK8iBYa8@ZenIV> <CAHk-=wi_iDAugqFZxTiscsRCNbtARMFiugWtBKO=NqgM-vCVAQ@mail.gmail.com>
 <Y1wt7uzL7vkBQ6Vm@ZenIV>
In-Reply-To: <Y1wt7uzL7vkBQ6Vm@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Oct 2022 13:34:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4ndvhOFFsnNXRmwetwL9ZxE2QzcrLFTeJ7Yfh+pJ7Mw@mail.gmail.com>
Message-ID: <CAHk-=wj4ndvhOFFsnNXRmwetwL9ZxE2QzcrLFTeJ7Yfh+pJ7Mw@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] use less confusing names for iov_iter direction initializers
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 12:30 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Went through the callers, replaced each with the right ITER_... (there's
> not that many of them and they are fairly easy to review), then went
> through mismatches and split their fixups into the beginning of the
> series (READ -> ITER_SOURCE becoming READ -> WRITE -> ITER_SOURCE, that
> is).

Oh, ok. So if you've actually reviewed each and every one of them,
then I'm ok with the "abort".

I still want it to be a WARN_ON_ONCE(), because of any future addition
that gets things wrong.

Rationale: either the WARN_ON() can happen, or it cannot. If it
cannot, it shouldn't exist in the first place. If it can, warning
multiple times will just make things harder to read and possibly cause
endless streams of scrolling errors.

So either the WARN_ON() shouldn't exist, or it should be a WARN_ON_ONCE().

Generally the only valid use of WARN_ON() (and BUG_ON()) is for things
like errors in the boot/setup code, where the operation basically is
only done once anyway.

                 Linus
