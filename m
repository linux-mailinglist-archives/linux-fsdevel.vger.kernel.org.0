Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27705962D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 21:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiHPTI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 15:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbiHPTIv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:08:51 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6583158DDE
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 12:08:47 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bh13so10059213pgb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=nssVLWGkSozCP2prxT0MLzeStZK7aNTTPyXYDkMAmNY=;
        b=dTA84z7jwhcwlnw4Kaod43Raw7zJOjVO3Y2P5TI4q6HuZXPkle236cvUxikwrR1IK/
         U4j4cn24hVd4sl7B/K0bF4vF9rnk1HwMZa3QyrC5mdRETd5IaEDZDcD+pWZOqBpNGeHo
         59sY34hNBZUfCkaobNGgsdWVMmj10MO0HtGzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=nssVLWGkSozCP2prxT0MLzeStZK7aNTTPyXYDkMAmNY=;
        b=UI9p3PxyACvok5v/Uynh4nACFH+WJBgb459GWPVgWnq7qj4ytHkZaLpMh8LLFpXSZX
         OVwqKoTN4qeSeVaIa6O9rb/VAd3WAp38JigybcGQh6uLUFkMm/tcQSIiwwd7jT0Ej26a
         LGSgJAEgApnxFpMQ/xB9ZHajWPDMrfQ08UPW89QhO4lwSefUUQeFBeqQ5CgzQ7PWnggy
         H7qejZn5KkWRlYyquePDaK4JpQxSuvl90RDhBjvgCqEtyYzRgcIWFpXHBZNYhEsqrvZq
         V0wyFsN8DCcYd4iEGXlKm+kTWn0sNx06Sra3wsNNn7hJcXmSAjMYO2MvRl2EXk5fpFFR
         fbbA==
X-Gm-Message-State: ACgBeo0e/N2ApArcc7Kc+tZZLWDiuu102lR2TNxyNNvFBh6RfXGIUjJz
        qfHjh49RuC/KB3VircLLvns9MQ==
X-Google-Smtp-Source: AA6agR4YtXTGF4jQT4B50vbSzKctSMj1hbrPKLGlAvMXXD20DDT7x4n08bEJKh2CHXm2IxfCt+g0tQ==
X-Received: by 2002:a05:6a00:2192:b0:52f:6541:6819 with SMTP id h18-20020a056a00219200b0052f65416819mr22396569pfi.83.1660676926841;
        Tue, 16 Aug 2022 12:08:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b0016c454598b5sm9360527pln.167.2022.08.16.12.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 12:08:45 -0700 (PDT)
Date:   Tue, 16 Aug 2022 12:08:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] fs: Replace kmap{,_atomic}() with kmap_local_page()
Message-ID: <202208161208.705E007@keescook>
References: <20220803182856.28246-1-fmdefrancesco@gmail.com>
 <8143586.NyiUUSuA9g@opensuse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8143586.NyiUUSuA9g@opensuse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 13, 2022 at 03:36:53PM +0200, Fabio M. De Francesco wrote:
> On mercoledì 3 agosto 2022 20:28:56 CEST Fabio M. De Francesco wrote:
> > The use of kmap() and kmap_atomic() are being deprecated in favor of
> > kmap_local_page().
> > 
> > There are two main problems with kmap(): (1) It comes with an overhead as
> > mapping space is restricted and protected by a global lock for
> > synchronization and (2) it also requires global TLB invalidation when the
> > kmap’s pool wraps and it might block when the mapping space is fully
> > utilized until a slot becomes available.
> > 
> > With kmap_local_page() the mappings are per thread, CPU local, can take
> > page faults, and can be called from any context (including interrupts).
> > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> > the tasks can be preempted and, when they are scheduled to run again, the
> > kernel virtual addresses are restored and are still valid.
> > 
> > Since the use of kmap_local_page() in exec.c is safe, it should be
> > preferred everywhere in exec.c.
> > 
> > As said, since kmap_local_page() can be also called from atomic context,
> > and since remove_arg_zero() doesn't (and shouldn't ever) rely on an
> > implicit preempt_disable(), this function can also safely replace
> > kmap_atomic().
> > 
> > Therefore, replace kmap() and kmap_atomic() with kmap_local_page() in
> > fs/exec.c.
> > 
> > Tested with xfstests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel
> > with HIGHMEM64GB enabled.
> > 
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > v1->v2: Added more information to the commit log to address some
> > objections expressed by Eric W. Biederman[1] in reply to v1. No changes
> > have been made to the code. Forwarded a tag from Ira Weiny (thanks!).
> > 
> > [1]
> > https://lore.kernel.org/lkml/8735fmqcfz.fsf@email.froward.int.ebiederm.org/
> >
> >  fs/exec.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> 
> Hi Kees,
> 
> After that thread about the report from Syzbot, and the subsequent discussion, 
> I noticed that you didn't yet take this other patch for exec.c.
> 
> I suppose that the two patches would better go out together. So I'm writing 
> for sending a gentle ping.
> 
> As I said, no changes have been made to the code with respect to v1 (which I 
> submitted in June). However, later I thought that adding more information 
> might have helped reviewers and maintainers to better understand the why of 
> this patch.

Oops, thanks for the ping. I'll pull this now.

-- 
Kees Cook
