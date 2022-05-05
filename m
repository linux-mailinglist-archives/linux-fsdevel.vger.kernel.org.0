Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEE851B72C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 06:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242695AbiEEEc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 00:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiEEEc1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 00:32:27 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C966F205E8
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 21:28:47 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id j6so6421515ejc.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 May 2022 21:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=k0OXywMaqAzIHj124hAaFgQkPrXxVAlSHIpylEhLXeo=;
        b=PJMiftXnfEJgt6y5R5aIahDGslHXTIGJpaTn60xrGDvQlvYbQ9a66qI4L+Q7VAKUpb
         NkqXhPKB9SRBXBu9WyEUFlPnPvsevofW8Uu1M76bpo/NFL+bzizbkJPm7jrphRczIBvA
         GhuEzARBgxy5TuTpMkdOkhFPcXaaOz9I54SfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=k0OXywMaqAzIHj124hAaFgQkPrXxVAlSHIpylEhLXeo=;
        b=M/CLByCg7dQ6jwcXyAvlhohsmh3OGs9LDjg+8yJ+5OP1Kgcpogb/gyS0nXaabo2QXG
         929tnXBWrzG2bvrVpBMSIyTQJyC42MeqjG3f2XTcE9g2kImjTSQ46VwiI49Y6TXJiiew
         qUc5stkywEEB3ZyoZ6v+97/Xu8/LEPGu5IB1QSkvX5ciJDr36q6kHSnUMGGqRxxO/WQR
         aZ3E0qEvY+XVMGVARc3b5hICYs1Rok14Rva1Ud3toWiMSgBTDYBTQvaEfeAhRJNT3OPN
         fGmFNF+4Ny1sJSi7kVbWiYk7DwYGxqwNYQfo/CpcQx9jbC0vj7KXND+FGEcOHeLB4VL3
         XcCw==
X-Gm-Message-State: AOAM530FtsWvRrBsNZteTIHkAhpiiiJfDCm3EZD7Ej54cOP8jt36sQrA
        f5Z+LgcLxWiO9jfHY0cLL0QTJF8WkKS+IKvRt4o5os/Ni0grn3Bo
X-Google-Smtp-Source: ABdhPJx/FVTQdBd6ozyUmZksbuLxr9jT7wDvHtz6pS9xsL7No9EdkuJKPGoLCEtmKmpnEDTEBHqAy1YJMCRss+Jdzmw=
X-Received: by 2002:a17:907:62aa:b0:6e0:f208:b869 with SMTP id
 nd42-20020a17090762aa00b006e0f208b869mr23880567ejc.270.1651724926433; Wed, 04
 May 2022 21:28:46 -0700 (PDT)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 5 May 2022 06:28:34 +0200
Message-ID: <CAJfpegvq2yNtuFWOYWJ-QNGCXFni_SfunQLEQzrErNpjZ0Tk-w@mail.gmail.com>
Subject: adding mount notification to fanotify?
To:     linux-fsdevel@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's David's patch, which introduces new infrastructure for this purpose:

https://lore.kernel.org/all/158204559631.3299825.5358385352169781990.stgit@warthog.procyon.org.uk/

I'm wondering if this could be added to fsnotify/fanotify instead?

After all, the events are very similar, except it's changes to the
mount tree, not the dentry tree that need to be reported.

Thanks,
Miklos
