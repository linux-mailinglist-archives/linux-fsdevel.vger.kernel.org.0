Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502A46C651A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 11:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjCWKb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 06:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCWKb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:31:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF6E2B9E1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 03:28:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cn12so38625424edb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 03:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1679567279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n2fLjxVRjO6B2VfFirpAjUWT7nQO1gpnKWEIlrkKV+M=;
        b=ltimdLyz1PEeTmmqgfQPQ6AbkEtFjxjFQKqh1IwFYgPcVbIPM/F7JxmJn8jylsuX3T
         xwMAszyFgoDHfIeSVCrBQInpPQZFvNbMlt8wu8uOEgWialRQdbxdpXki/QHjfqFUcsdH
         yruXVl+EMOtBcffV+8qpcVkKl7vUefg0I/q2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2fLjxVRjO6B2VfFirpAjUWT7nQO1gpnKWEIlrkKV+M=;
        b=k/6QkH8NVesE5XmlyL/iak0NxwN8SszD18EIjWrAVSa3CFopt96nRaKKxMLjRCZE0q
         rp7lGu5cRteqO0viGEOEqswH7HBW1a5lj+jxPhQ521+qJCzqEwx9xtvicswWN1kSKPgU
         tD4zxdD//chB7ks36cJCbBti59D7O7Fui9i3CBiD4RpUEk4a0QdZN66K9wLqTTA1aG5T
         3MKz1tjL3mu8bMylhwc51oVwLjbmN174Co6cKBXLS/2qrgnKECmzzd/D2Lai0qVMgwhW
         fcfhaLAjl+CddPj2JQfm96IjaqB3dBsaI19iT3EcjBJA32d4MwcB55nZ7wB/qADmEVtI
         ZrJQ==
X-Gm-Message-State: AO0yUKWlCYsFiTeVpbe8NzAqBCGG+Voo9r3C5jzCnMVneoDsOQbfKp+p
        5FWdlegpXCTQ3m7uInlIz1NWkRgeomtPvSBuxpbW7w==
X-Google-Smtp-Source: AK7set/k+8JZ/zERTbZ59gyCMisy3coQVJSp0EV4Fq3ykgfOpjdKX+tu5KGO34ljhoycfbTLVVzFf+Tz4HJ9PllTWeo=
X-Received: by 2002:a50:cc9b:0:b0:4fa:d8aa:74ad with SMTP id
 q27-20020a50cc9b000000b004fad8aa74admr4969791edi.8.1679567278991; Thu, 23 Mar
 2023 03:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230321011047.3425786-1-bschubert@ddn.com> <20230321011047.3425786-7-bschubert@ddn.com>
In-Reply-To: <20230321011047.3425786-7-bschubert@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 23 Mar 2023 11:27:47 +0100
Message-ID: <CAJfpegs6z6pvepUx=3zfAYqisumri=2N-_A-nsYHQd62AQRahA@mail.gmail.com>
Subject: Re: [PATCH 06/13] fuse: Add an interval ring stop worker/monitor
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>,
        Amir Goldstein <amir73il@gmail.com>,
        fuse-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 21 Mar 2023 at 02:11, Bernd Schubert <bschubert@ddn.com> wrote:
>
> This adds a delayed work queue that runs in intervals
> to check and to stop the ring if needed. Fuse connection
> abort now waits for this worker to complete.

This seems like a hack.   Can you explain what the problem is?

The first thing I notice is that you store a reference to the task
that initiated the ring creation.  This already looks fishy, as the
ring could well survive the task (thread) that created it, no?

Can you explain why the fuse case is different than regular io-uring?

Thanks,
Miklos
