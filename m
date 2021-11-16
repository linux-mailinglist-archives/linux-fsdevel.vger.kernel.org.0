Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAD8452E69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 10:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhKPJyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 04:54:35 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44068 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhKPJyA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:54:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7B9662177B;
        Tue, 16 Nov 2021 09:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637056262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mDFTTIiszcWpxAylcu0QzEP9/NecXrKSzvnEd4lCTY0=;
        b=GB3lAEhBjkXXAHEs1lirJeNVPqy3z2zGaeeafIHzWzkuIbOBGG4OX3oHnXgOr9R0pmI0q0
        ppTDCllU68nWvHY5+YoX3fZ5R9V36CN35yD7p+q97lmf7YHaw+olPwwAwNbaPFzq1wkkR/
        sJu2VJwgGzDfmUbWjT3btCFh7DDIvww=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F1DC9A3B90;
        Tue, 16 Nov 2021 09:51:00 +0000 (UTC)
Date:   Tue, 16 Nov 2021 10:51:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, Alexey Alexandrov <aalexand@google.com>,
        ccross@google.com, sumit.semwal@linaro.org, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com,
        rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, gorcunov@gmail.com, pavel@ucw.cz,
        songmuchun@bytedance.com, viresh.kumar@linaro.org,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Subject: Re: [PATCH v11 2/3] mm: add a field to store names for private
 anonymous memory
Message-ID: <YZN/BMImQqrK4MWm@dhcp22.suse.cz>
References: <20211019215511.3771969-1-surenb@google.com>
 <20211019215511.3771969-2-surenb@google.com>
 <89664270-4B9F-45E0-AC0B-8A185ED1F531@google.com>
 <CAJuCfpE-fR+M_funJ4Kd+gMK9q0QHyOUD7YK0ES6En4y7E1tjg@mail.gmail.com>
 <CAJuCfpHfnG8b4_RkkGhu+HveF-K_7o9UVGdToVuUCf-qD05Q4Q@mail.gmail.com>
 <CAJuCfpEJuVyRfjEE-NTsVkdCZyd6P09gHu7c+tbZcipk+73rLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEJuVyRfjEE-NTsVkdCZyd6P09gHu7c+tbZcipk+73rLA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 15-11-21 10:59:20, Suren Baghdasaryan wrote:
[...]
> Hi Andrew,
> I haven't seen any feedback on my patchset for some time now. I think
> I addressed all the questions and comments (please correct me if I
> missed anything).

I believe the strings vs. ids have been mostly hand waved away. The
biggest argument for the former was convenience for developers to have
something human readable. There was no actual proposal about the naming
convention so we are relying on some unwritten rules or knowledge of the
code to be debugged to make human readable string human understandable
ones. I believe this has never been properly resolved except for - this
has been used in Android and working just fine. I am not convinced TBH.

So in the end we are adding a user interface that brings a runtime and
resource overhead that will be hard to change in the future. Reference
counting handles a part of that and that is nice but ids simply do not
have any of that.

> Can it be accepted as is or is there something I should address
> further?

Is the above reason to nack it? No, I do not think so. I just do not
feel like I want to ack it either. Concerns have been expressed and I
have to say that I would like a minimalistic approach much more. Also
extending ids into string is always possible. The other way around is
not possible.

-- 
Michal Hocko
SUSE Labs
