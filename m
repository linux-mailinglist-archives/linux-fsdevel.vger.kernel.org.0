Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F877BB142
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 07:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjJFFmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 01:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjJFFmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 01:42:22 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30360B6
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 22:42:21 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a2379a8b69so20658277b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Oct 2023 22:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696570940; x=1697175740; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iMNU/NcReGRTQoFhUIKFEhWrRToHaZS/r6S0IyfUYQA=;
        b=SA+o1acD+FtLsYNEUhzawIOUUFxuMD4SCozuTCTQtEIf8xsGjfnehkKT3gPXtqEXyM
         iZompe2XYlOamDl5cMHVTLMroUFR1xlXUvBNnasTZV1/UAO33aCIpNhN1hHqJKdr9JJ/
         Dl8DF13lYIPkB7uTTmhWBcsQ0y8Pv07xSlorbFnXkzApo1q1huULdlZYF/Ykuo4N40fo
         /7KjrlIqLTXIQaCR+NmSpqgIR4QP2QcD0TIYEhWm1O1ILY0nxnuf0IdTeFgJ5WJGQj9v
         Px2hWNqHqcc/sGZ4aiUVGS1l7Y5YdijhE9831ZyqvJ66+jXw8PtmmOWk9bQak3QdhBQ/
         WmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696570940; x=1697175740;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMNU/NcReGRTQoFhUIKFEhWrRToHaZS/r6S0IyfUYQA=;
        b=bZJbVQ0ouHRm9/JaNwUQ1FyJYP6tzyuP0kZ5u1jDT5EuT3cSXqUcPMEE41eAnoAR+b
         0HNnTms3cuJZabP29SLouno35q/jKpIqYNy3K7LQfB7vWuAqlhTRa3gZ40duxuZp4te/
         VYx9Us8GZmXF/DT76rrHU6rNJpx8f3jFjWVm+Q3tZQko6ypAhifn9IUTlbMVrOu8QLB3
         xbZWvJ6XaDZJcASz7VsHw23FIyOd9LsdCMXDjFCWJcNVACUUlSu3Ars2Gg9rCKv6HOjA
         qm7IZas6zDAdQStoxPNSa512voXk8M9JFwk9yoUVYWWkFdnIqElwUs7t6n9CP+cWRZNX
         WaZA==
X-Gm-Message-State: AOJu0Yz+Wvjl+K7SE3kdnYulPMFwUX5qtVzdOYcyQNzCF10iLNFx97qT
        gSsxRmo1FESZZqvF2ExZPW5RiQ==
X-Google-Smtp-Source: AGHT+IGEuUVUDHmEfgU2ZUeoXgbdvGNBLmcG/5Ng06kfo9sfd8SOCeQ0ooBNx3Jipoe0YW6Lkbx0lA==
X-Received: by 2002:a81:4810:0:b0:5a1:d0fe:e44b with SMTP id v16-20020a814810000000b005a1d0fee44bmr7584991ywa.11.1696570940293;
        Thu, 05 Oct 2023 22:42:20 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w1-20020a81a201000000b005837633d9cbsm1033602ywg.64.2023.10.05.22.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 22:42:19 -0700 (PDT)
Date:   Thu, 5 Oct 2023 22:42:17 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Chen, Tim C" <tim.c.chen@intel.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 8/8] shmem,percpu_counter: add _limited_add(fbc, limit,
 amount)
In-Reply-To: <DM6PR11MB4107F132CC1203486A91A4DEDCCAA@DM6PR11MB4107.namprd11.prod.outlook.com>
Message-ID: <17877ef1-8aac-378b-94-af5afa2793ae@google.com>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com> <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com> <DM6PR11MB4107F132CC1203486A91A4DEDCCAA@DM6PR11MB4107.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 5 Oct 2023, Chen, Tim C wrote:

> >--- a/lib/percpu_counter.c
> >+++ b/lib/percpu_counter.c
> >@@ -278,6 +278,59 @@ int __percpu_counter_compare(struct
> >percpu_counter *fbc, s64 rhs, s32 batch)  }
> >EXPORT_SYMBOL(__percpu_counter_compare);
> >
> >+/*
> >+ * Compare counter, and add amount if the total is within limit.
> >+ * Return true if amount was added, false if it would exceed limit.
> >+ */
> >+bool __percpu_counter_limited_add(struct percpu_counter *fbc,
> >+				  s64 limit, s64 amount, s32 batch) {
> >+	s64 count;
> >+	s64 unknown;
> >+	unsigned long flags;
> >+	bool good;
> >+
> >+	if (amount > limit)
> >+		return false;
> >+
> >+	local_irq_save(flags);
> >+	unknown = batch * num_online_cpus();
> >+	count = __this_cpu_read(*fbc->counters);
> >+
> >+	/* Skip taking the lock when safe */
> >+	if (abs(count + amount) <= batch &&
> >+	    fbc->count + unknown <= limit) {
> >+		this_cpu_add(*fbc->counters, amount);
> >+		local_irq_restore(flags);
> >+		return true;
> >+	}
> >+
> >+	raw_spin_lock(&fbc->lock);
> >+	count = fbc->count + amount;
> >+
> 
> Perhaps we can fast path the case where for sure
> we will exceed limit? 
> 
> if (fbc->count + amount - unknown > limit)
> 	return false;

Thanks, that sounds reasonable: I'll try to add something like that -
but haven't thought about it carefully enough yet (too easy for me
to overlook some negative case which messes everything up).

Hugh
