Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84D4532BD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbiEXN7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 09:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiEXN7h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 09:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FCD48CB0D
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653400775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Ff+pshfC1Z6E3EzI0y8JRQ1REVK5W8crSBK2MgvYz0=;
        b=CPY9tM8sOjSxfzwTh7DEsSuHWWLbrhLWX/iqRSn1MdNdt6EJxKhOSCoLqqSSl3gemhEHbK
        t3Dz7DkZWAEtTC7RfPioiOQfvQjjR1vUCQgtIpZoMW7n8QaM6Gmmn7lnqVZDCa0/9PhDhj
        KTzNspw7a0zwd+Armo35R/J0iFl1BhY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-4N72gVKQPaifFXVd2g6sWw-1; Tue, 24 May 2022 09:59:33 -0400
X-MC-Unique: 4N72gVKQPaifFXVd2g6sWw-1
Received: by mail-qk1-f198.google.com with SMTP id g3-20020a05620a108300b006a329bc4da3so12102200qkk.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 06:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Ff+pshfC1Z6E3EzI0y8JRQ1REVK5W8crSBK2MgvYz0=;
        b=dCCXPqjwGauVeXq1IZqv5h+Ujzin8slmeS+rxBdo2cQ8n2QqMYioJx9qbQy0wcIdzi
         LIjo48MnTE6thHefVOgLICjFWfAggyvqe/bRuui+PSaINwfHfQuXlQVP93kc1Ax//06U
         CxNUXWBPrkQ9kTczYMV2bLHAjbWyPUfXn5oiAk9FKIOFTzXNvDmt3dLiH/ganExEQUx6
         W91j7eqilU8+40GXks+RhyGVwqlEtx+G7hcm4bFM4BRlzA4zKFYG9Eoh+wVr6nC4gXBX
         4OgRvAEIt8GkbN6gt2CXi90TV5SSIj30GYCds9nYAY394dQlK2vJEd9Gw89doKI2rtO7
         osNg==
X-Gm-Message-State: AOAM530kpeiFGQhFiIYv9SaVXshtSINSLSr6avpvP8WL829Ukimnrhth
        LFVplkXBVDUGHkMgL2yl1YbqS6qBVemYgIGWAuxdswlnyv7cNiytTc+yH9XpIgvBBFI7jxzo8Ij
        clXlKg6dEc1OK5RVS5phcLHYtUSOfcb/k2iyL+PCEgg==
X-Received: by 2002:a05:620a:1981:b0:507:4a52:f310 with SMTP id bm1-20020a05620a198100b005074a52f310mr17389281qkb.611.1653400773164;
        Tue, 24 May 2022 06:59:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqS+yZK5ZzpIED7qcr754PYpaiBLoHFNyuZBNAopvk3ojwwBfdu204lMoxiDpi9ZmkpuCv+gT3j6X+c8inrO8=
X-Received: by 2002:a05:620a:1981:b0:507:4a52:f310 with SMTP id
 bm1-20020a05620a198100b005074a52f310mr17389243qkb.611.1653400772863; Tue, 24
 May 2022 06:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211029184500.2821444-1-mcgrof@kernel.org> <20211029184500.2821444-2-mcgrof@kernel.org>
 <87h75g0xbm.ffs@tglx>
In-Reply-To: <87h75g0xbm.ffs@tglx>
From:   Richard Fontana <rfontana@redhat.com>
Date:   Tue, 24 May 2022 09:59:22 -0400
Message-ID: <CAC1cPGz3ARW_H9cq6LY0_h3YXomMmSdVR1v1+xEYbshtK8Mvmw@mail.gmail.com>
Subject: Re: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, tj@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, jeyu@kernel.org,
        Shuah Khan <shuah@kernel.org>, bvanassche@acm.org,
        dan.j.williams@intel.com, joe@perches.com, keescook@chromium.org,
        rostedt@goodmis.org, minchan@kernel.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Kuno Woudt <kuno@frob.nl>,
        Richard Fontana <fontana@sharpeleven.org>,
        copyleft-next@lists.fedorahosted.org,
        Ciaran Farrell <Ciaran.Farrell@suse.com>,
        Christopher De Nicolo <Christopher.DeNicolo@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 23, 2022 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, Oct 29 2021 at 11:44, Luis Chamberlain wrote:
> > preferred. A summary of benefits why projects outside of Linux might
> > prefer to use copyleft-next >= 0.3.1 over GPLv2:
> >
> <snip>
> >
> > o copyleft-next has a 'built-in or-later' provision
>
> Not convinced that this is a benefit under all circumstances, but that's
> a philosopical problem. The real problem is this:
>
> > +Valid-License-Identifier: copyleft-next-0.3.1
>
> and
>
> > +11. Later License Versions
> > +
> > +    The Copyleft-Next Project may release new versions of copyleft-next,
> > +    designated by a distinguishing version number ("Later Versions").
> > +    Unless I explicitly remove the option of Distributing Covered Works
> > +    under Later Versions, You may Distribute Covered Works under any Later
> > +    Version.
>
> If I want to remove this option, then how do I express this with a SPDX
> license identifier?

Probably off-topic but: I think as things currently stand in SPDX you
would have to use an ad hoc LicenseRef- identifier to express the
entirety of copyleft-next-0.3.1 coupled with an amendment that sort of
strikes the later versions provision. This issue is also somewhat
relevant: https://github.com/spdx/spdx-spec/issues/153

FWIW, built-in 'or-later' clauses are actually common in copyleft open
source licenses; the GPL family is the oddity here. (Then again, the
whole idea of a downstream license upgradability option is sort of
unusual in the bigger scheme of things, but that's another topic.)

Richard

