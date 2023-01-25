Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F60867B50C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 15:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbjAYOpw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 09:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbjAYOpv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:45:51 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4AC44A4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 06:45:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l40-20020a25ad68000000b0080b821fbb0fso4191597ybe.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 06:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGfGUjaGLH+8XJ9armKqzpt89zfr+otVnTMhjbMCoI4=;
        b=rOOvRup5i80rTrCdededOy5eOHDXSOWC4JOHuwbako4X/IP6tSOe4t0Uq6NT9zncrt
         6pMzQAKz0XS6hSLJ1vnCRioRsOfbndERsOdxfrWcgy1EQgQ2YQyO9+l+nDLm7MiwNV+2
         O00Pyo/suVmmHuA0IXW65H2rKJ0/CUU0nw7aChk2qLJNlSvnqjwBNmaYg3ib2tVZd39X
         3q8s8bSmCLgiuetJPB0SxvCvejHEcyEiSNil7W3RYZMXY/jKURm5eZW6aTUFQhs3lcZe
         1o2/S95mBqBEzagirjGXsYc3TmmxrlkPcfLwgXs/8VPAPwaB0bzNvZfCS06Lbep9Gqta
         xysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGfGUjaGLH+8XJ9armKqzpt89zfr+otVnTMhjbMCoI4=;
        b=J0EqtzkZQYQvVI2ZUCgZENrrSue80W/nZDL5NPMf6yvbAu/PfYo+5efeHddPWNvsey
         24K9RCeofULnJ7SDQH3/zdwabby+N57IxyYf+MjpaLfYMIzvzO0kukUtOwh8aC4AtJoo
         Do+v5cR2m2+flAp8WbK11p1F7lD1L8F+nMiy9gm787k2hxL09H85nxlghwqgCwX+2etA
         JZb+R9o5KWuKgvBBnD1xWMuMXaTy0zh3A/SPgupan+Wbxi7N0T0obw1mk7hN1F/AP7s9
         XiAXMA1K5MmyZpT3wEE7OfV21hLefjhDyPkYf0ZOsQElSEsZKFTUSe2TeaddkG8IifCR
         Ni7w==
X-Gm-Message-State: AO0yUKXT15X2KB/lUU7OlFNtMHddV6G70xfDaknySu9ABGB1T04dRNYi
        Wjd2v+RVNnJUrGhmWuGDgJSO4J59QuG7
X-Google-Smtp-Source: AK7set/tmTwyZYMl/jIoH2jKvSplFAhH7z4Cf9+VFwkQOG+1wRywqg63gkehHrmk61wsnNB67mOZRJgPfpy9
X-Received: from mdanylo.waw.corp.google.com ([2a00:79e0:9b:0:1ad0:76d7:3d4b:21e1])
 (user=mdanylo job=sendgmr) by 2002:a81:ac61:0:b0:506:596a:586c with SMTP id
 z33-20020a81ac61000000b00506596a586cmr567812ywj.237.1674657932535; Wed, 25
 Jan 2023 06:45:32 -0800 (PST)
Date:   Wed, 25 Jan 2023 15:45:29 +0100
In-Reply-To: <Y9A2PsCS7gfKWfaM@x1n>
Mime-Version: 1.0
References: <Y9A2PsCS7gfKWfaM@x1n>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230125144529.1630917-1-mdanylo@google.com>
Subject: Re: [PATCH v7 0/4] Implement IOCTL to get and/or the clear info about PTEs
From:   Danylo Mocherniuk <mdanylo@google.com>
To:     peterx@redhat.com
Cc:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        alex.sierra@amd.com, avagin@gmail.com, axelrasmussen@google.com,
        brauner@kernel.org, dan.j.williams@intel.com, david@redhat.com,
        emmir@google.com, gorcunov@gmail.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, kernel@collabora.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mdanylo@google.com, namit@vmware.com, pasha.tatashin@soleen.com,
        pgofman@codeweavers.com, rppt@kernel.org, shuah@kernel.org,
        shy828301@gmail.com, surenb@google.com, usama.anjum@collabora.com,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, willy@infradead.org,
        yun.zhou@windriver.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 8:49 PM Peter Xu <peterx@redhat.com> wrote:
> On Mon, Jan 23, 2023 at 06:15:00PM +0500, Muhammad Usama Anjum wrote:
> > > Firstly, doc update is more than welcomed to explain the new interface
> > first (before throwing the code..).  That can be done in pagemap.rst on
> > > pagemap changes, or userfaultfd.rst on userfaultfd.
> > Okay. I'll add the documentation in next version or after the series has
> > been accepted. Initially I'd added the documentation. But the code kept on
> > changing so much that I had to spend considerable time on updating the
> > documentation. I know it is better to add documentation with the patches.
> > I'll try to add it.
>
> Yes, logically it should be the thing people start looking with.  It'll
> help reviewers to understand how does it work in general if relevant
> description is not in the cover letter, so it can matter even before the
> series is merged.
> > > There're four kinds of masks (required/anyof/excluded/return).  Are they
> > > all needed?  Why this is a good interface design?
> > Then, CRIU developers Andrea [1] and Danylo [2], asked to include all these
> > different kinds of masks. I'd thought of these masks as fancy filter inside
> > the kernel. But there wasn't anyone else to review. So I'd included them to
> > move forward. Please let me know your thoughts after reading emails from [1].
> The idea makes sense to me, thanks.  I just hope "moving it forward" is not
> the only reason that you included it.
> Please also consider to attach relevant links to your next cover letter so
> new reviewers can be aware of why the interface is proposed like that.
> IMHO it would be also great if the CRIU people can acknowledge the
> interface at some point to make sure it satisfies the needs.

I acknowledge that this interface looks good for my use case to get interesting
pages from a big sparse mapping. For Andrei's use case to iteratively dump memory
it also looks good IMO. 

> An POC would be even better on CRIU, but maybe that's asking too much.

Can't promise now, but happy to do this when there'll be a clear signal that this
patchset is about to be merged. Meanwhile, I'll make some smaller tests with this
patchset rebased and will get back if there are some problems with that. 

> -- 
> Peter Xu
