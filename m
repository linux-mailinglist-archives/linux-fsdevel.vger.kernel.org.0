Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B2571C4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 16:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbiGLOWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 10:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiGLOWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8781C3340A
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657635749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JRth/JuCuClo783o03abQL28yzBSESS3ebbCWk69Wso=;
        b=aUGC4iEi7QxlYE52Uju6mSISoYD7JG4GfC/mzCFFUzP16udCboRQWh3yZNxuQoitoqqyCG
        Ix+0KvqsRF8FkwiTxxqKKf7O9WULmfU3jC+SyjPMN6cQBMQsK2P0QQOBskemme/N+R/Bad
        sCpQG/fCZ8JNYNj+iDBVyzuQC7ey7xA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-wGvGCSvRNxeDr0M0uyVlBQ-1; Tue, 12 Jul 2022 10:22:28 -0400
X-MC-Unique: wGvGCSvRNxeDr0M0uyVlBQ-1
Received: by mail-qt1-f200.google.com with SMTP id gd27-20020a05622a5c1b00b0031eae6afe5aso6719351qtb.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 07:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JRth/JuCuClo783o03abQL28yzBSESS3ebbCWk69Wso=;
        b=nJQJwyAPM0mJ4Z6OCMJOjwzPKTSASB55ng/eMfhK9s497fiF5R4kzzXnTmQfcpmdxW
         dEe8JjHq6JGubCAIKTwXmpeE8uGVVpEn48j08WdPJ7X+MVAQetCKVQDn5YNEUYVfzYUn
         QMNfnjyPb9lZZKW/5lLHt/eoayWMkjBgTu9mC0SmPR3CBM+v8WOiA3Vgp2gMfqn+9HhT
         2l6+T3bnr2qeE0Wonyw1UlA1WOmv9zd8aW/bPh8AIrX8hqx465XBZJwZjfsj4u9qv6on
         3hwFF1WimlrVhGOhyOMlQnU0i8eRrDLRngCXNXa9KBd9Yt66+zCFPL6vuTzM2HU60mLL
         aMcA==
X-Gm-Message-State: AJIora98tORkw3ZnVrWOwjkxJCy8CF9TSHO0dMt7Lw1TGRtsn9QY1WD0
        /Dt50mTS1US5LBSiToF8yjbcfJkgwus7x4G7TX+En/Yo66exY/w43+2gNrFxIbaxM/yo7TS7IOs
        wrDRPWw+jf4hDp1YAK10saWnX2w==
X-Received: by 2002:a05:622a:186:b0:319:1d49:2db7 with SMTP id s6-20020a05622a018600b003191d492db7mr17712533qtw.444.1657635748132;
        Tue, 12 Jul 2022 07:22:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tv78XEVFTMuhWhQKwfrYHtCI9m9VH1riCwijD5DC+NNMp6Ay9I1CfvMy+cndUw9mqJUB3Uxg==
X-Received: by 2002:a05:622a:186:b0:319:1d49:2db7 with SMTP id s6-20020a05622a018600b003191d492db7mr17712507qtw.444.1657635747901;
        Tue, 12 Jul 2022 07:22:27 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id t20-20020a37ea14000000b006a6d7c3a82esm9106182qkj.15.2022.07.12.07.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:22:27 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:22:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert O'Callahan <roc@ocallahan.org>
Subject: Re: [RFC PATCH RESEND] userfaultfd: open userfaultfds with O_RDONLY
Message-ID: <Ys2DobolHlrXP4/M@xz-m1.local>
References: <20220708093451.472870-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220708093451.472870-1-omosnace@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 08, 2022 at 11:34:51AM +0200, Ondrej Mosnacek wrote:
> Since userfaultfd doesn't implement a write operation, it is more
> appropriate to open it read-only.
> 
> When userfaultfds are opened read-write like it is now, and such fd is
> passed from one process to another, SELinux will check both read and
> write permissions for the target process, even though it can't actually
> do any write operation on the fd later.
> 
> Inspired by the following bug report, which has hit the SELinux scenario
> described above:
> https://bugzilla.redhat.com/show_bug.cgi?id=1974559
> 
> Reported-by: Robert O'Callahan <roc@ocallahan.org>
> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

