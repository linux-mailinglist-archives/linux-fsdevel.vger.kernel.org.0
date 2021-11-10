Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A410144C673
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 18:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhKJRxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 12:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhKJRxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:53:14 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E3EC061764
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 09:50:26 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id m9so3862186iop.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 09:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0S9sZv9rv1MLrkq7aAvaZJLfChB0QbHa6Bap7OCVON4=;
        b=Mpj3q9y8P8tXTskEXoJ+jEkJNmYg08YiZzsMCwx006007UkWib0VzvWz+XRgkwol5g
         Cq2E/j2ydmsTRrr6KctSBpI480yI3FutqwVcqwb2VlKHUwJWTSsJTCzxJGnIs6kVN/3O
         DGBhPSDpOxGfegmMhpOX5LX4qoDI1mjiVhMW60IwBCuqrEqdpCvWOXNc2veK2u35aN08
         9ckXcJZs87m5QlP77fFFqpf/4jYJaI9QF6U+YIzxX/8Yk9uT+ZKlfuBEgd4y9TQUghkw
         qaMwa1ayBoLvEKFMLOFsRyir02bszFEdJx/Mmy+VsMnvsU7c1SxsVicijg0LX8EzhIH2
         MSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0S9sZv9rv1MLrkq7aAvaZJLfChB0QbHa6Bap7OCVON4=;
        b=IgNrVHpaVJ6X5azfAWDFH61Itw4t+O8yZofh8ZsXdVKbye6bDpOLmVCtTYgV2cfYtY
         8sy/Yo7P7xkU4jxSlPQP6Jr9PiZjPQrrbQbplIwOmn3RSR2oxYWErrbue75HGgW49jFI
         16PC2r1PsVBDPgrouNZJGfL1E+NJ3tHt1SpCaW05KQYb718ZtqZm6XO0oSbeEV+bfRsL
         JeZzR8oqcwlQx8aPdkJBE1o+kNunKh3B7kuDxaDmDA9WJvrQ5tPEXtXwIrH2xrn/9QZv
         PEtKWksKTAeo5VNUobgpBFfI5BRgZeeDMvPYZfbxYWvprYkG1IeVXEAKXgYqXg5+s+Uk
         I6lQ==
X-Gm-Message-State: AOAM531bREB1bjgjlvsbXyyju7KORYhiTEoUWs8GzuxI3r3om9lluPYz
        f+Q9Iw/p3plth3JORhZN1+tsdwuZtVL2FHCRH4P/FMbTdSg=
X-Google-Smtp-Source: ABdhPJx8SVMZqY/M+G/wfHByt0Gdg7mcZQx8twUBaM2wGi8juiZIcAzzBUsezhqV/JnXuzMhcKYRZ7I6PzZJKf5g7kI=
X-Received: by 2002:a02:c559:: with SMTP id g25mr489184jaj.123.1636566625557;
 Wed, 10 Nov 2021 09:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20211107235754.1395488-1-almasrymina@google.com> <YYtuqsnOSxA44AUX@t490s>
In-Reply-To: <YYtuqsnOSxA44AUX@t490s>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 10 Nov 2021 09:50:13 -0800
Message-ID: <CAHS8izP9zJYfqmDouA1otnD-CsQtWJSta0KhOQq81qLSTOHB4Q@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 9, 2021 at 11:03 PM Peter Xu <peterx@redhat.com> wrote:
>
> The ending "_MAPPING" seems redundant to me, how about just call it "PM_THP" or
> "PM_HUGE" (as THP also means HUGE already)?
>

So I want to make it clear that the flag is set only when the page is
PMD mappend and is a THP (not hugetlbfs or some other PMD device
mapping). PM_THP would imply the flag is set only if the underlying
page is THP without regard to whether it's actually PMD mapped or not.
