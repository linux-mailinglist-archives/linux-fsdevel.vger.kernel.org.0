Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013FE57ADFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 04:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbiGTCcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 22:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237481AbiGTCck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:32:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50173481ED
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jul 2022 19:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658284356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uZbjgFMHeKFjmyd0QEm1xCO2NChsIABolYNiKdJ7Gg=;
        b=Lz3rNC3gm2RxiSMnzRywtItuGcEy7lBka8MLsVW9d2c7D7eXvO/cjcMVdJVdjtKwpr6xyS
        ioXinnEcA7gZ4oZfYW8xA0DAxo7vfr14QcTXV0Jt3B5HYyPQjRIrEEsX9ZTLXElRH6n7gu
        xOZDfXKHaBjTtawbw9ZRL9zflFLnsTg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-HHCHVresOpivh1m_Jsd1Rw-1; Tue, 19 Jul 2022 22:32:35 -0400
X-MC-Unique: HHCHVresOpivh1m_Jsd1Rw-1
Received: by mail-qk1-f199.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso13175015qkb.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jul 2022 19:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3uZbjgFMHeKFjmyd0QEm1xCO2NChsIABolYNiKdJ7Gg=;
        b=Rq1PARWFwqLCt6zDsQc4/crSsML5sVh0xsGe0Z8D38S9Z094SsHvKKNdoyKrdZJtCJ
         b36MPAGYjrn4zH1kxT+KSZPjoWzEqGAwEwj81g937q2O3EU+oA1YFOXEY/kHdoQX1DSf
         np40n+YQ42Yn+Rgb0vHpPfxIgAWWKmmQQEnSYKMN2A9vMWY6vvFY8SOauZA8tMY/8UQV
         vSQVOCFdLUHCdbcSGJjPU9VhZnL/sixeUeH3AEBAg1ohwQmc/SJT+EZpUTVSLgpUqmLJ
         Xal7du4txikYb2szsATAdoaCPQ9+4raO6bNXnhf+s/T9p6QGbSIlFPtgYVTlfNcxnCyE
         43MA==
X-Gm-Message-State: AJIora/ABgQLPyBske14gsQv5UA+/7K+4Nnwvt1prklSJLAs2ZQVhMJB
        Add7cB2nI1c2z17Lp6q2F9KaDn818ZO8KIQQqNVylniXZykG2lFgkhjlsX9s0moo6lMO3qU1b5W
        ZbWc5OK3bqwK5H6baw2ZsEK6NOw==
X-Received: by 2002:a05:6214:e41:b0:473:915c:3efe with SMTP id o1-20020a0562140e4100b00473915c3efemr27335395qvc.10.1658284355252;
        Tue, 19 Jul 2022 19:32:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sqsBhXFhvJemKV/jwgAt84OQwS2X59Z2eXZUwYSIfKumUaM4t252ZCPnvZ1VuTZhBaV0SNdQ==
X-Received: by 2002:a05:6214:e41:b0:473:915c:3efe with SMTP id o1-20020a0562140e4100b00473915c3efemr27335384qvc.10.1658284354992;
        Tue, 19 Jul 2022 19:32:34 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b006b5c5987ff2sm14701779qki.96.2022.07.19.19.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 19:32:34 -0700 (PDT)
Date:   Tue, 19 Jul 2022 22:32:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Message-ID: <YtdpQBrAGJwMnssj@xz-m1.local>
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <20220719195628.3415852-3-axelrasmussen@google.com>
 <D43534E1-7982-45EE-8B16-2C4687F49E77@vmware.com>
 <CAJHvVcigVqAibm0JODkiR=Pcd3E14xp0NB6acw2q2enwnrnLSA@mail.gmail.com>
 <D8D7C973-1480-4166-86AF-AD179873B2A4@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D8D7C973-1480-4166-86AF-AD179873B2A4@vmware.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 11:55:21PM +0000, Nadav Amit wrote:
> Anyhow, I do want to clarify a bit about the “cross-process support”
> userfaultfd situation. Basically, you can already get cross-process support
> today, by using calling userfaultfd() on the controlled process and calling
> pidfd_open() from another process. It does work and I do not remember any
> issues that it introduced (in contrast, for instance, to io-uring, that
> would break if you use userfaultfd+iouring+fork today).

Do you mean to base it on pidof_getfd()?

Just want to mention that this will still need collaboration of the target
process as userfaultfd needs to be created explicitly there.  From that POV
it's still more similar to general SCM_RIGHTS trick to pass over the fd but
just to pass it in a different way.

IMHO the core change about having /proc/pid/userfaultfd is skipping that
only last step to create the handle.

-- 
Peter Xu

