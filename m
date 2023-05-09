Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CBC6FCE95
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 21:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjEITb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 15:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbjEITb6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 15:31:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BC6E71;
        Tue,  9 May 2023 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AdywwhjxGaN6Y3/mPqh/c2MgjoXsXtnSQ+Kliw53l+c=; b=c2W8uSumZRfddTrbKo2ykCgH54
        +188v8gGxJC+y2pNBcq5OTBhzwJbjENdEsXKTGm/pqr5iWlNxUEm/Cx/rHIeM39FkpQuCIMESBwB8
        dUB3A23nwrwZpkZVIfVj54PWZbxgTteGErtwYkVVree8SgEyRtq1E0CZY6Wojoftyeh9g2d8ZcRuL
        7VqPvD+ErYEBEHftquqIlQvfAEhM848aIO8fNomchCorgWHd4AC8Nvel5XYkAI4qDuI+dTng/fg0A
        sXM8OeB54k+DZX3hMs4uNmwnaXAnYxG31UZsyts8TFPwydNpH2NaQ5lK+m6OQ4727cUkGXcEIbrGg
        WgcN5lew==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pwT3r-00FY08-U2; Tue, 09 May 2023 19:31:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87142300786;
        Tue,  9 May 2023 21:31:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7866221F9F5C4; Tue,  9 May 2023 21:31:47 +0200 (CEST)
Date:   Tue, 9 May 2023 21:31:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 03/32] locking/lockdep: lockdep_set_no_check_recursion()
Message-ID: <20230509193147.GC2148518@hirez.programming.kicks-ass.net>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-4-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509165657.1735798-4-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 12:56:28PM -0400, Kent Overstreet wrote:
> This adds a method to tell lockdep not to check lock ordering within a
> lock class - but to still check lock ordering w.r.t. other lock types.
> 
> This is for bcachefs, where for btree node locks we have our own
> deadlock avoidance strategy w.r.t. other btree node locks (cycle
> detection), but we still want lockdep to check lock ordering w.r.t.
> other lock types.
> 

ISTR you had a much nicer version of this where you gave a custom order
function -- what happend to that?
