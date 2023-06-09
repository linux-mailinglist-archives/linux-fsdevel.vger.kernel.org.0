Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F67F72A340
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 21:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjFIThx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 15:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFIThw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:37:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27386E0;
        Fri,  9 Jun 2023 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lusZ+n63tKGbL0NLAwyLdzJ9q5GPTx8lfmxKN/LB0PY=; b=CNfhC6+WyPlV8tbFcjbN0TEnbz
        dLYLnJhghcLMBiB+AgpZ+6tvYAU+jvfv/ohGWsHslgWuDKY0TQHqBY76FBp+4BukmWSGPC3pmxIsG
        m7XyIZHxWmmF4+rQdH0MclhhopxKtiWggD5WFChzDKTULUh35ze6FQKnWjYPAEeJLNNjXZ8sdErHA
        8MIVtuOjD2fnDUYqjiiWnaLLJcpa4G4rgV8ajNQVt/y/JiYjoMrslA4llfYW00daPRVQaU8FMh4zK
        GD3x+k4C3yQdikVVx2Z0k3ylJa1Eh0PBj+FZTTfqbE/sZoIR/a2XcysQ32fJkX5x2MY9E5+4KehvZ
        x4pWS85Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7hun-00GxfZ-V3; Fri, 09 Jun 2023 19:36:53 +0000
Date:   Fri, 9 Jun 2023 20:36:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 5/6] mm: implement folio wait under VMA lock
Message-ID: <ZIN/VSepGu9HAi42@casper.infradead.org>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-6-surenb@google.com>
 <ZIM/O54Q0waFq/tx@casper.infradead.org>
 <CAJuCfpE4VYz-Z4_aS3d9-8FGtQ-F4f7adYcJqRk3P3Ks7WPgQA@mail.gmail.com>
 <CAJuCfpG9JeHBKF0fzqR7xpDufpm7HVwgfbQVDeKYW24TWkpckw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG9JeHBKF0fzqR7xpDufpm7HVwgfbQVDeKYW24TWkpckw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 11:55:29AM -0700, Suren Baghdasaryan wrote:
> Oh, after rereading I think you are suggesting to replace
> folio_lock_or_retry()/__folio_lock_or_retry() with
> folio_lock_fault()/__folio_lock_fault(), not to add them. Is that
> right?

Right.  It only has two callers.  And I'd do that before adding the
FAULT_VMA_LOCK handling to it.
