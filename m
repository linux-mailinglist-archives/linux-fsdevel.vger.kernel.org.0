Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A11A5BC534
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 11:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiISJU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 05:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiISJUz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:20:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B7F25DC
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 02:20:54 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b35so40389346edf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 02:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=DvQYH86CwDBf6YKcZRT5htevcFbwWBBKjj8n93NhSBA=;
        b=OSP1SevS0lzcRfK/5qhC/Qm7XdLilBJZvCFYMxNjWM83aWK5AfuY6HGu6Eobpd+DaD
         g1BzJnff8I3uCdelPAL36STXMJ4ztLTaWKpOlMfY2jXEq83fCjjXmZ7X2/IVm0M6JsZ9
         xU4IxmQVqbRCheO+UIqo7ESoBZIqF6PllLzl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DvQYH86CwDBf6YKcZRT5htevcFbwWBBKjj8n93NhSBA=;
        b=OK+42VYf2KNnuA1e8L4z7ah2ls47y0J5xs6/Lnfp/Ay9XBOZSlxcB//58j7DFfP0bG
         yAGFBgG+MUU4hWhnHJR2OaOe8KjE9yCfMCpSqbZS8OWpVnWPUIiZTSMP3muDc1Q0lY6x
         irgTGjTTWnar18cgcyjHzMzUJzL3ZkQOicWAUm2a5cUbODaYvd/t4UiQbApEu0g/ZzIo
         pjuLOMCp27XdogoGcP0tVhJ8am1Af0q7eca9AEDqHc+jSg9Xu2CKLTpHX+5J/KxJSrAr
         qa0g9BJUiExxsNx7qa4O4ac3LWwhN4nEl787/GEHEMaiu5airYmMNNZWGI/wNXFeLJkM
         oALw==
X-Gm-Message-State: ACrzQf0Rs7iCgB+PeH79fR9+Nzx4uS9+9gfT4nMR39QoJf5NdTy2rJ9I
        IDtQM1MFDBfpcR5mGNGlavO3VC8weZSGts4SgLDrLg3H5M0=
X-Google-Smtp-Source: AMsMyM6BNpaQGNGbvgqz0TuEEBa7EZzUUBMVYGqsH6mKwKHlGE/bueq7oxHWB+DAl8d5Q6rkmlViCuOuVqS4VoqGuPc=
X-Received: by 2002:a05:6402:3549:b0:454:414e:a7fd with SMTP id
 f9-20020a056402354900b00454414ea7fdmr1026951edd.69.1663579252632; Mon, 19 Sep
 2022 02:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <87mtaxt05z.fsf@vostro.rath.org>
In-Reply-To: <87mtaxt05z.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 19 Sep 2022 11:20:41 +0200
Message-ID: <CAJfpegv=1UjycheWyANxsoOM5oCf7DGs9OKNzhNw_dSETBDCVQ@mail.gmail.com>
Subject: Re: Should FUSE set IO_FLUSHER for the userspace process?
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 18 Sept 2022 at 13:03, Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> Hi,
>
> Should the FUSE kernel driver perhaps set PR_SET_IO_FLUSHER for the FUSE
> userspace process daemon when a connection is opened?
>
> If I understand correctly, this is necessary to avoid a deadlocks if the
> kernel needs to reclaim memory that has to be written back through FUSE.

The fuse kernel driver is careful to avoid such deadlocks.  When
memory reclaim happens, it copies data to temporary buffers and
immediately finishes the reclaim from the memory management
subsystem's point of view.   The temp buffers are then sent to
userspace and written back without having to worry about deadlocks.
There are lots of details missing from the above description, but this
is the essence of the writeback deadlock avoidance.

Thanks,
Miklos
