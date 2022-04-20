Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C284650807A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 07:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiDTFVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 01:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiDTFVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:21:42 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9131D340E3;
        Tue, 19 Apr 2022 22:18:57 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id e128so496130qkd.7;
        Tue, 19 Apr 2022 22:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jRBAKSNTX3OPR1ejw6VcnPzpXTqvP8rwf6yGE9zvTRs=;
        b=jnjFR1ymmSrPNyMHCu25MqxYRGsrlYdv1hzv/xd7UCQAvgKJl8vg+15+ee5LJtGZyg
         pK8YJUj+X74FdID5/A3RaMj/3gbQjcxbVX+Cyzv+DSnQHIDnFkQA0YgOOB64kAi6zod0
         8M5PYOlNXB8lAw+AMTavpsQxWmUVSLhqUSnDhx6aTUfPU3v5RPij8KQVJWLhuly50OWU
         Fw+qtDSjP0bzVLiyZ8QJD7WuQG0NgJO0Y0vAYZw4wGHlXbiky0KuwLgs5hMUh0XPuDHA
         zoadeBbrqspxVifgip76C9nhfMVfaXVUwl2H+ut1mt4qv6eYu6dgxli6m18pbS3q6+L7
         WYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jRBAKSNTX3OPR1ejw6VcnPzpXTqvP8rwf6yGE9zvTRs=;
        b=ON9FkEPly8qVua1Yo1McndVtezI1HqXc7vtZGd5q0CJbNvaLZjkblup3iXYLUbROPC
         2GBd82IiS643FM8qLVkgrqYjyHzt+gUUbUkcuwi6HiKkvGgLB359N2FVg//pjRJrza8e
         Qm2Ly0g3u7/+IR9s18evRkgru+/lC4PsxzZyTVCEjvwEozEBtGPtgWDX5ejS9zmCSesz
         E3wA05un2Yo/vGSjwyg5wWplAHWttIBujGFNxcj0hWqve7ZE9i3D7Q7J1/L8HgwFHJzy
         nRkAU4s4DUxwk5pSvZTRMggDgqiivPvJu0bsym2hw/A70zf54ZWrck14Q8axaibYJztZ
         3qxQ==
X-Gm-Message-State: AOAM530bwNsQXDHFMgWTkr9towdMrCp67ogY2kM3wkEx4lSv9cZu8s96
        mRMiR+XTEMVUnHhSCzKZsDpeSoOdDE5M
X-Google-Smtp-Source: ABdhPJy+zsCfxOjoQRrsWeFxSM/HX+HUNvFFWNnnsMNhQTEA8qiEipcsnFZfAdahiNyxdqyBSiWqJQ==
X-Received: by 2002:a05:620a:4706:b0:69e:b913:e592 with SMTP id bs6-20020a05620a470600b0069eb913e592mr5668468qkb.18.1650431936757;
        Tue, 19 Apr 2022 22:18:56 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id d13-20020a37c40d000000b0069ebc29ddc1sm993292qki.136.2022.04.19.22.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 22:18:55 -0700 (PDT)
Date:   Wed, 20 Apr 2022 01:18:54 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org
Subject: Re: [PATCH 1/4] lib/printbuf: New data structure for heap-allocated
 strings
Message-ID: <20220420051854.qioq4nt4dejpnip6@moria.home.lan>
References: <20220419203202.2670193-1-kent.overstreet@gmail.com>
 <20220419203202.2670193-2-kent.overstreet@gmail.com>
 <Yl+T3Mx408HiC6dS@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl+T3Mx408HiC6dS@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:02:20PM -0700, Christoph Hellwig wrote:
> On Tue, Apr 19, 2022 at 04:31:59PM -0400, Kent Overstreet wrote:
> > This adds printbufs: simple heap-allocated strings meant for building up
> > structured messages, for logging/procfs/sysfs and elsewhere. They've
> > been heavily used in bcachefs for writing .to_text() functions/methods -
> > pretty printers, which has in turn greatly improved the overall quality
> > of error messages.
> 
> How does this use case differ from that of lib/seq_buf.c?

I hadn't come across that code before, thanks for pointing it out :)

seq_buf.c looks exactly like an older version of printbufs, from before I added
the auto heap allocating functionality. seq_buf.c could be dropped, I could go
ahead and convert existing users to printbufs.
