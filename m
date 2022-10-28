Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31846611A33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 20:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiJ1Sfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 14:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiJ1Sf3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:35:29 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C9569ECA
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 11:35:25 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id bb5so3995583qtb.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=554KCjWn8qBcAcBVpoouhKeUYG/Iw1xaVWw3M5KddOs=;
        b=DCzroOtVcESn8/j0p2284O1c8+f71f2wa1HhtWbyeBVb5KrtXtesUm1DKY6tLO/CqX
         oBob/TSHMKmFbqkcAbw8pVZOUno4hI+NzeRw7haRuA1X/fp9UYA0EEKK34zd9GG+8Fmn
         h0agPHPClfZ8rFS2LoP6wiZ0asEbvErvPOO6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=554KCjWn8qBcAcBVpoouhKeUYG/Iw1xaVWw3M5KddOs=;
        b=axD6tlf9jV+axoP2xIbnktTa6zC+L3hAg+7YuEGnHl9C+91GipQboUr6DVl3LvMMFH
         TsR2liFNIqY19KfElb7+cI3QTp82R2sZO0yM5azXVGYPQ8su/rgq4sm1DMvLNjZsjZ+6
         n9yOArt92u9uhR69zizn1Jqk1LYHL53qumUrJ9CeL/NnCvzvH3H1qsCwIIUZJfxtnDSV
         bP+30W15ZAtmLzWgOINJSUmYXN7CWOX+fa9IC5/Y+r96TLqBN90i6p5pbvawBOkt/o3s
         QewunhLilwrMmCQ4bxELIIYfjKYtj5WWJFc4EgfZabotIlTXmHuIBSmnIrQRz8gdQLkc
         f6Wg==
X-Gm-Message-State: ACrzQf3Wx+uyoXUmWOtbsqff+2AGmSyKIFy/hzVjniBvdkTTmLMazid3
        0+YmPwiaUAUQyPoE5X2VP67w0fa/dOBtew==
X-Google-Smtp-Source: AMsMyM7imGF8roNZdWk12jbYVpAOlrtD2a6SR4s4KE9OM/vN5R6tOBVvEProcJu9DDb1/HGVMVXJfQ==
X-Received: by 2002:ac8:7d42:0:b0:39c:dd3f:b74d with SMTP id h2-20020ac87d42000000b0039cdd3fb74dmr740975qtb.279.1666982124692;
        Fri, 28 Oct 2022 11:35:24 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id x1-20020a05620a448100b006ec771d8f89sm3550729qkp.112.2022.10.28.11.35.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 11:35:23 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id j7so7059968ybb.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 11:35:22 -0700 (PDT)
X-Received: by 2002:a25:5389:0:b0:6bc:f12c:5d36 with SMTP id
 h131-20020a255389000000b006bcf12c5d36mr619498ybb.184.1666982122579; Fri, 28
 Oct 2022 11:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <Y1btOP0tyPtcYajo@ZenIV> <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
 <20221028023352.3532080-12-viro@zeniv.linux.org.uk> <CAHk-=wibPKfv7mpReMj5PjKBQi4OsAQ8uwW_7=6VCVnaM-p_Dw@mail.gmail.com>
 <Y1wOR7YmqK8iBYa8@ZenIV>
In-Reply-To: <Y1wOR7YmqK8iBYa8@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Oct 2022 11:35:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_iDAugqFZxTiscsRCNbtARMFiugWtBKO=NqgM-vCVAQ@mail.gmail.com>
Message-ID: <CAHk-=wi_iDAugqFZxTiscsRCNbtARMFiugWtBKO=NqgM-vCVAQ@mail.gmail.com>
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

On Fri, Oct 28, 2022 at 10:15 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > I can see the logic: "the destination is the iter, so the source is
> > the bvec".
>
> ???
>
> Wait a sec; bvec is destination - we are going to store data into the page
> hanging off that bvec.

Yeah, no, I'm confused and used confusing language. The bvec is the
only "source" in the sense that it's the original destination.  They
are both the destination for the data itself.

> Umm...  How are you going to e.g. copy from ITER_DISCARD?  I've no problem
> with WARN_ON_ONCE(), but when the operation really can't be done, what
> can we do except returning an error?

Fair enough. But it's the "people got the direction wrong, but the
code worked" case that I would want tyo make sure still works - just
with a warning.

Clearly the ITER_DISCARD didn't work before either, but all the cases
in patches 1-10 were things that _worked_, just with entirely the
wrong ->data_source (aka iov_iter_rw()) value.

So things like copy_to_iter() should warn if it's not a READ (or
ITER_DEST), but it should still copy into the destination described by
the iter, in order to keep broken code working.

That's simply because I worry that your patches 1-10 didn't actually
catch every single case. I'm not actually sure how you found them all
- did you have some automation, or was it with "boot and find warnings
from the first version of patch 11/12"?


> No.  If nothing else, you'll get to split struct msghdr (msg->msg_iter
> different for sendmsg and recvmsg that way) *and* you get to split
> every helper in net/* that doesn't give a damn about the distinction
> (as in "doesn't even look at ->msg_iter", for example).

Gah. Ok. So it's more than just direct_io. Annoying.

              Linus
