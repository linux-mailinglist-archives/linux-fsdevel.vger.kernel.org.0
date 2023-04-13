Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD54D6E1630
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 23:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDMVBC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 17:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDMVBB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 17:01:01 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06F18697
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 14:00:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-634b28df952so1368762b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1681419655; x=1684011655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Po7kMV6PWfvJ0JdTbzWxvRcPOaOmD0dTKySmuNSlDE8=;
        b=5SO+s+WzALNpDN1F2r4RktSFMbeXUOZ5ZZ4imLVAQoXA9/lC9hm3pg4FQZHjcgDFRr
         1W6P7WWYojNsiIJnPi5nuXNn2irghWpItwRXONlnThqo2JXE5P7eGdXskbXOeHw4pfWs
         e4/5GvOocPYZ3hDXjojyciRevZvF858Azln1xhdoJbybRGFGIr/n4fs/v2L8hdzg9s+o
         8ZlfxWTij0X1M7Oqj0eJgBUQGLAU22t8D3AGl9hVEvZT5GMRqEz+FbjOT15elBmGEZRc
         Ug46SqyE6nfY3hF8oRes80r0DASMIbliHC9taLr+InAecO1VhkSBXbyNobEJYqH1kvC8
         qBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681419655; x=1684011655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Po7kMV6PWfvJ0JdTbzWxvRcPOaOmD0dTKySmuNSlDE8=;
        b=RfTf2N9kA5cLe5QiI/HPJ6o/J7ceIGRI9kxGAauNkY0K8j6IoEivruNH1eMN55P0uD
         cMgYeOlzzpfP4JmSAoqPTorBGMnwB0A/rE2YrvGJ5Gn9uUwaBE72Yb8dHDzZcJdD91Ai
         HyUtIWawTSbBkgyIfyY0JdDkFaVvo9WMuVf0U36mVeyfpNSRTUyIXBTfdEIgIno2rNQS
         z5xomspKStq237e5VjWlCiX4hN4zbH6y4QyFg7O73WlJ9dV4rBy8ezS3bwJScqvlBd+n
         PBcX/joZfSMcm7yGpSRVcOrd4p14F/yqLIpmg4aYkyDNKcpnMLtNmmzcNQWOU9EWcBXN
         80ug==
X-Gm-Message-State: AAQBX9fp6D+1ZeCM4+DX6f2T923xY/O9Els4FB2ofKR4isN8tXjTSAYM
        cotfBKo6EllS3MKnD9mCjUAFBw==
X-Google-Smtp-Source: AKy350ZeUgwDYY5eMW7ZOlxK2igrJRw/XaGk5mqSdFs2oVNX3KK71uxfEiOe9qiJLyAHAqLgA8MlqA==
X-Received: by 2002:a05:6a00:2e9c:b0:636:d5be:982f with SMTP id fd28-20020a056a002e9c00b00636d5be982fmr6073105pfb.6.1681419655345;
        Thu, 13 Apr 2023 14:00:55 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-41-174.pa.nsw.optusnet.com.au. [49.180.41.174])
        by smtp.gmail.com with ESMTPSA id w5-20020aa78585000000b0063824fef27asm1871769pfn.13.2023.04.13.14.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 14:00:54 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pn43n-00322H-2A; Fri, 14 Apr 2023 07:00:51 +1000
Date:   Fri, 14 Apr 2023 07:00:51 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 3/3] mm: vmscan: refactor updating
 current->reclaim_state
Message-ID: <20230413210051.GO3223426@dread.disaster.area>
References: <20230413104034.1086717-1-yosryahmed@google.com>
 <20230413104034.1086717-4-yosryahmed@google.com>
 <b7fe839d-d914-80f7-6b96-f5f3a9d0c9b0@redhat.com>
 <CAJD7tkae0uDuRG77nQEtzkV1abGstjF-1jfsCguR3jLNW=Cg5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkae0uDuRG77nQEtzkV1abGstjF-1jfsCguR3jLNW=Cg5w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 13, 2023 at 04:29:43AM -0700, Yosry Ahmed wrote:
> On Thu, Apr 13, 2023 at 4:21 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 13.04.23 12:40, Yosry Ahmed wrote:
> > > During reclaim, we keep track of pages reclaimed from other means than
> > > LRU-based reclaim through scan_control->reclaim_state->reclaimed_slab,
> > > which we stash a pointer to in current task_struct.
> > >
> > > However, we keep track of more than just reclaimed slab pages through
> > > this. We also use it for clean file pages dropped through pruned inodes,
> > > and xfs buffer pages freed. Rename reclaimed_slab to reclaimed, and add
> >
> > Would "reclaimed_non_lru" be more expressive? Then,
> >
> > mm_account_reclaimed_pages() -> mm_account_non_lru_reclaimed_pages()
> >
> >
> > Apart from that LGTM.
> 
> Thanks!
> 
> I suck at naming things. If you think "reclaimed_non_lru" is better,
> then we can do that. FWIW mm_account_reclaimed_pages() was taken from
> a suggestion from Dave Chinner. My initial version had a terrible
> name: report_freed_pages(), so I am happy with whatever you see fit.
> 
> Should I re-spin for this or can we change it in place?

I don't care for the noise all the bikeshed painting has generated
for a simple change like this.  If it's a fix for a bug, and the
naming is good enough, just merge it already, ok?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
