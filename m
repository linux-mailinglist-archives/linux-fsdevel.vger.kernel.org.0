Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6161F4D8DBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 21:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244885AbiCNUGC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 16:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiCNUGB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:06:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1825B5FC6
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 13:04:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w12so29172457lfr.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 13:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorado.edu; s=google;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to;
        bh=aynLaUVEjzEy+VW1kNGPuStqU4F8ZQ1yLDOvxABr84Y=;
        b=BRCR7efkFdRBaAfjJHueI5bQNw5bxH1LSRJbEOu90tA1cD29Q5Cqs/XS0WqpacI+NK
         k7nmSL4a8SZRY2GA8abR3fdwk7LNAktwYfdh4nNOwem2+f9yW1C154E7hpSNSBARhvwu
         6Wcfn7IfjpGwBbpDV+IarsGlFz7f04WtZYt7W+DQpD8pMsnOc35YvDevESD/pV78oEeY
         Gan2a1+OYA9xmBM+eoQyLQ2Ctg89UcOOb99vSsenlcIBPavderYqnhIGy7AsaRNfIZC+
         YE6ml54yqoCHTVSb6RcPnNUH0ueILc2JDUZ7rfx9NPW9jwDi5eAPKmRbR9jpDYXfW+mX
         VmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to;
        bh=aynLaUVEjzEy+VW1kNGPuStqU4F8ZQ1yLDOvxABr84Y=;
        b=LtqOmEd4GWK7x/mpj5Hfks0gx/27XS3y1fE/3DHRPvHxoAxdRqmHfm0rpGo7TNckTY
         gJcDAqLfrVFwGS5mBpASzICXre3WY+BW3AsP0qj4/sLG6iHl+t3m4Lgfl6mnM3yjr+ve
         FtYXv2FvBBJQL4/hexNZwiNTlN0vOpMJSroDeO5IoVsh7tcM0yVV6zao/a4dvIoK+Anm
         YYpyAEh+IjErroHDsjfVS9360fV+sX1uaHEoh0aes0EIv0OzSmTgr4soEXGtqVBcytaQ
         easzZzUAAPBKFumiTz7Ry8fWwW6b4+fXnLShp73HSww+x4zISCqwAw7B2WqHj4gJ/6x3
         XHtQ==
X-Gm-Message-State: AOAM5303vQvqP4kuvOvRdCFer+FkHreK2fHG1Q6KL4/4TFFRiV1vjnku
        u2mpM2xFooIpFRUWC/TU5lduCORr5H6V8g4GsV26uhAOkj8=
X-Google-Smtp-Source: ABdhPJykHym1Ja1kocanouxVRCG7GXLGk41EABiyz1f8AIlYFPmerMiWLGeb4NEX+cIVsWd1N5hBsw/1PpUFknPVq4M=
X-Received: by 2002:a05:6512:6d3:b0:445:fa38:b7ab with SMTP id
 u19-20020a05651206d300b00445fa38b7abmr14212259lff.17.1647288285975; Mon, 14
 Mar 2022 13:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAGd_VJzZArEHHR5HUoUDjkN70aJ7CVsfBjro0mtS3eTPeTy1nw@mail.gmail.com>
In-Reply-To: <CAGd_VJzZArEHHR5HUoUDjkN70aJ7CVsfBjro0mtS3eTPeTy1nw@mail.gmail.com>
Reply-To: George.Hodgkins@colorado.edu
From:   Christopher Hodgkins <George.Hodgkins@colorado.edu>
Date:   Mon, 14 Mar 2022 14:04:35 -0600
Message-ID: <CAGd_VJxRooTgJdkQw+2m_-r3NFhQ5EaY61Kw+b1GNh=sDvwVDQ@mail.gmail.com>
Subject: Fwd: Spurious SIGBUS when threads race to insert a DAX page
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NOTE: This question is about kernel 4.15. All line numbers and symbol
names correspond to the Git source at tag v4.15.

Hi all,
I've been running some benchmarks using ext4 files on PMEM (first-gen
Intel Optane) as "anonymous" memory, and I've run into a weird error.
For reference, the way this works is that we have a runtime that at
startup `fallocate`s a large PMEM-backed file and maps the whole thing
R/W with MAP_SYNC, and then it interposes on calls to `mmap` in
userspace to return page-sized chunks of PMEM when anonymous memory is
requested.

The error I have encountered is the nondeterministic delivery of
SIGBUS on the first access to an untouched page of the mapped region
(which since the file is passed to the application sequentially, is
also typically the first uninitialized extent in the file at time of
crash). The accesses are aligned and within a mapped region according
to smaps, which eliminates the only documented reasons for delivery of
SIGBUS that I'm aware of.

I did a bit of digging with FTrace, and the course of events at a
crash seems to be as follows. Multiple (>2) threads start faulting in
the page, and go through the "synchronous page fault" path. They all
return error-free from the fdatasync() call at dax.c:1588 and call
dax_insert_pfn_mkwrite. The first thread to exit that function returns
NOPAGE (success) and the others all return SIGBUS, and each raises the
userspace signal on the return path.

My best guess for why this occurs is that the unsuccessful calls all
bounce with EBUSY (because of the successful one?) in insert_pfn
(which tails into the call to vm_insert_mixed_mkwrite at dax.c:1548),
and then dax_fault_return maps that to SIGBUS. The signal is
definitely spurious -- as mentioned, one of the threads returns
success, and if I catch the signal with GDB, the faulting access can
be successfully performed after the signal is caught. Also, as
mentioned above, the error is nondeterministic -- it happens maybe one
out of every five runs. To clarify some other things that could make a
difference, the pages are normal-sized (not huge) and the SIGBUS isn't
due to PMEM failure (ie HWPOISON).

I'm on an old kernel (4.15) so if this is really an error in the
kernel code it may be fixed on the current series. If that's the case,
just point me to a patch or release number where it was fixed and I'll
be happy. It may also be an error in my code -- I will be less happy
in that case, but please still point it out or ask questions for
clarification if you think I'm doing something wrong to cause this.

Thanks,
George Hodgkins
