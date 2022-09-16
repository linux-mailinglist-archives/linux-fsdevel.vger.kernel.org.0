Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0045BA381
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 02:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiIPAah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 20:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIPAag (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 20:30:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB75796B9
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 17:30:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so24037929pjm.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 17:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LkVlhoT05YAjjPwcAfjmZDP9UsS+FFKRNB8ZXWgizNo=;
        b=DjoMxV+z0+9E0zrKxLFmNhIwQWaK2UP963SC6a4w/xWf4GEdfwBjjnhsPM6p8ipdU/
         33DYPhphTHRc03WwY8oxvYA+6XCmuCkA2UGoogMhYr9oUIb7nCMsAsqRtk9T1oGXHoFQ
         uM0+EOdmgpgbLOJJfIHFGMSzdKzpW0r2VGFqPyMcUAlgdtFoqeRzDN+6x8KUrc8kzFoP
         RGVfiwN8pgCNK3ObPSA2YGJBuubZUpUdrUqAfQcJJO1iakP0RImflEM/YMgjFD2n+8ik
         1XapeGaPVtB7FDhdhvpVBxe6Ae/Kw9hjSVLQncm4g39UORjWNCCowuNVY8V/Y+0eBdWO
         Jzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LkVlhoT05YAjjPwcAfjmZDP9UsS+FFKRNB8ZXWgizNo=;
        b=AbjTfrVnUlnVq/8gWZCKZkNtsf9xHjsmaPGFezTRm5AYeICfrOlTQ31NDPr055hGja
         Tj3YkZQEtEBIOak5/tSzYBAu6LTP8H/IUidNVI8eMZ6aMedz3IuCTxuPstOXoNEVu5vn
         YPrA1zU1R2RHdzls/VYpHzedMd7tPVWy3lsFM+gTBw4af+9otzVv582q45DNwDaF2EPN
         FAngNDmp05qth+QiqPvPmzCtMd7wQtYZVVBSUjxUffGDOWn3wCh4FPPrG3zS1vRvaHwM
         JCK5f9yI2xoZsyCPYBsdXrNRb+aPT8xwzwLnqgH+hFIeI2Wvlw3iRegZQSgb7nkjLfIv
         5a1w==
X-Gm-Message-State: ACrzQf0rnttPUnA7rKgEaKfbeGCVUHQ7LFqvYnMMNiKLbvb6ZBvDuQUg
        e861To661/5B+0Ck7N2VoIKkNOaPwqv9bZf8wTw=
X-Google-Smtp-Source: AMsMyM4ZvGf4Boqd4PSzHhcRoMmJ8Amrcs8wuuFae2xRcVLms8MQYbsp4efTubS/3R0nAalOwzcL6qOW3udCM+JToow=
X-Received: by 2002:a17:903:32c1:b0:176:d67b:cf70 with SMTP id
 i1-20020a17090332c100b00176d67bcf70mr2217900plr.117.1663288232822; Thu, 15
 Sep 2022 17:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <44fe39d7-ac92-0abc-220b-5f5875faf3a9@oracle.com>
 <SJ1PR11MB6083C1EC4FB338F25315B723FC499@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <cec5cd9a-a1de-fbfa-65f9-07336755b6b4@oracle.com>
In-Reply-To: <cec5cd9a-a1de-fbfa-65f9-07336755b6b4@oracle.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 15 Sep 2022 17:30:20 -0700
Message-ID: <CAHbLzkrNnp5SsMUJykK5M_sy+C1+smm1CgYvaboO86FfLbZOnA@mail.gmail.com>
Subject: Re: Is it possible to corrupt disk when writeback page with
 undetected UE?
To:     Jane Chu <jane.chu@oracle.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 15, 2022 at 5:27 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> On 9/15/2022 3:50 PM, Luck, Tony wrote:
> >> Suppose there is a UE in a DRAM page that is backed by a disk file.
> >> The UE hasn't been reported to the kernel, but low level firmware
> >> initiated scrubbing has already logged the UE.
> >>
> >> The page is then dirtied by a write, although the write clearly failed,
> >> it didn't trigger an MCE.
> >>
> >> And without a subsequent read from the page, at some point, the page is
> >> written back to the disk, leaving a PAGE_SIZE of zeros in the targeted
> >> disk blocks.
> >>
> >> Is this mode of disk corruption possible?
> >
> > I didn't look at what was written to disk, but I have seen this. My test sequence
> > was to compile and then immediately run an error injection test program that
> > injected a memory UC error to an instruction.
> >
> > Because the program was freshly compiled, the executable file was in the
> > page cache with all pages marked as modified. Later a sync (or memory
> > pressure) wrote the dirty page with poison to filesystem.
> >
> > I did see an error reported by the disk controller.
>
> Thanks a lot for this information!
>
> Were you using madvise to inject an error to a mmap'ed address?
> or a different tool?  Do you still have the test documented
> somewhere?
>
> And, aside from verifying every write with a read prior to sync,
> any suggestion to minimize the window of such corruption?

We discussed the topic at this year's LSFMM summit. Please refer to
https://lwn.net/Articles/893565/

>
> thanks!
> -jane
>
> >
> > -Tony
>
