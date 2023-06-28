Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58217407D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 03:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjF1By1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 21:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjF1By0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:54:26 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A763C2111;
        Tue, 27 Jun 2023 18:54:25 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7659924cd9bso346533485a.1;
        Tue, 27 Jun 2023 18:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687917264; x=1690509264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0MVrDy8BC1VnZ5USZJqaLNtQbygF6zhnK+O+s/tz1M=;
        b=beLe2IAe4ALEHVCEEp7ti+HifRhB8JISUuJR9mQdDKWrXu5q3NdZp/3y8FFgQ6OJ5S
         9zw4gEyWvSBxuHFa/Y1NWrl5X7jNGm26hGrFPd/CIhHAyPbQ4ez+yCftSlcgeSb3u6WF
         ad1Fke/gZaSQMKlPp0aF94UkmQQ46pNryDbJHp9j65OhZABBYya/irPIaXZLKypIz7u+
         jEfYUvOKj9Z4+Xc9WHXvPjOqnyi548hx7+xtZOwt6zI2gu15Co3LWtf6+JaiSB/sihYv
         6OlP2q4YXv7QceFk8f34cqIV/0Alxx3wGXIoO8v6tuT+rEjXx47++djXJdixE91aMI3K
         /gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917264; x=1690509264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0MVrDy8BC1VnZ5USZJqaLNtQbygF6zhnK+O+s/tz1M=;
        b=hhVZulAy2y7TqK2S35jYJcwz1LbOXLvQrcHXElmH/35PNWLFm0q9dnVUZYxDebTVzJ
         T5ySzOZnYHTN1uz2+xyoThigtQpk5fxuyxnGr/ZOGF22Gdke19KBK0Xq6aJgcU/ayqej
         MC5jqcukTmqTDbs/3QuXUx0j7ErC+HXmoJsUkLqDIIGTz1L15oN+h5FRtAq+0dgf9q0q
         dstm80iwBAcemTU5G7TdvRnUvu19fFxt7+f+oCJT3Il/OGLQH9ltifBEANP+q4rik2+b
         TJHMCyFt62kSWSjv23MY4EZrJ1LPN4DtZ07Zdam49dWBOiqqxI9lfUfBuZPnmKbAC4cA
         Erlw==
X-Gm-Message-State: AC+VfDx7nVQEt0oeWWDM6xQAtp0dTatMUGypdkU/Jsxcts1u39eEfraA
        kXHUIdXl4/9kxkW1SjmjA6M=
X-Google-Smtp-Source: ACHHUZ79PaTAOc3M6mEP9l5t4Nqqa/QEhBY2ElF3wMjvkTp9RnxeVB4wcdrrl4Ro+sP/Ix7FUX4zdw==
X-Received: by 2002:a05:620a:4549:b0:763:b4d7:51c1 with SMTP id u9-20020a05620a454900b00763b4d751c1mr35357500qkp.50.1687917264455;
        Tue, 27 Jun 2023 18:54:24 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:311b])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a004800b00262af345953sm8490764pjb.4.2023.06.27.18.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 18:54:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 27 Jun 2023 15:54:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Christian Brauner <brauner@kernel.org>, gregkh@linuxfoundation.org,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
Message-ID: <ZJuSzlHfbLj3OjvM@slm.duckdns.org>
References: <20230626201713.1204982-1-surenb@google.com>
 <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
 <20230627-kanon-hievt-bfdb583ddaa6@brauner>
 <CAJuCfpECKqYiekDK6Zw58w10n1T4Q3R+2nymfHX2ZGfQVDC3VQ@mail.gmail.com>
 <20230627-ausgaben-brauhaus-a33e292558d8@brauner>
 <ZJstlHU4Y3ZtiWJe@slm.duckdns.org>
 <CAJuCfpFUrPGVSnZ9+CmMz31GjRNN+tNf6nUmiCgx0Cs5ygD64A@mail.gmail.com>
 <CAJuCfpFe2OdBjZkwHW5UCFUbnQh7hbNeqs7B99PXMXdFNjKb5Q@mail.gmail.com>
 <CAJuCfpG2_trH2DuudX_E0CWfMxyTKfPWqJU14zjVxpTk6kPiWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG2_trH2DuudX_E0CWfMxyTKfPWqJU14zjVxpTk6kPiWQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Tue, Jun 27, 2023 at 02:58:08PM -0700, Suren Baghdasaryan wrote:
> Ok in kernfs_generic_poll() we are using kernfs_open_node.poll
> waitqueue head for polling and kernfs_open_node is freed from inside
> kernfs_unlink_open_file() which is called from kernfs_fop_release().
> So, it is destroyed only when the last fput() is done, unlike the
> ops->release() operation which we are using for destroying PSI
> trigger's waitqueue. So, it seems we still need an operation which
> would indicate that the file is truly going away.

If we want to stay consistent with how kernfs behaves w.r.t. severing, the
right thing to do would be preventing any future polling at severing and
waking up everyone currently waiting, which sounds fine from cgroup behavior
POV too.

Now, the challenge is designing an interface which is difficult to make
mistake with. IOW, it'd be great if kernfs wraps poll call so that severing
is implemented without kernfs users doing anything, or at least make it
pretty obvious what the correct usage pattern is.

> Christian's suggestion to rename current ops->release() operation into
> ops->drain() (or ops->flush() per Matthew's request) and introduce a
> "new" ops->release() which is called only when the last fput() is done
> seems sane to me. Would everyone be happy with that approach?

I'm not sure I'd go there. The contract is that once ->release() is called,
the code backing that file can go away (e.g. rmmod'd). It really should
behave just like the last put from kernfs users' POV. For this specific fix,
it's safe because we know the ops is always built into the kernel and won't
go away but it'd be really bad if the interface says "this is a normal thing
to do". We'd be calling into rmmod'd text pages in no time.

So, I mean, even for temporary fix, we have to make it abundantly clear that
this is not for usual usage and can only be used if the code backing the ops
is built into the kernel and so on.

Thanks.

-- 
tejun
