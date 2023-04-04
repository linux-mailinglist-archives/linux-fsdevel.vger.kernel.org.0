Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E9F6D672F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 17:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjDDPXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 11:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjDDPXm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:23:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A0C3AAA
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 08:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iZJqls/F/HBbyS/UcVy7NLaQZNXwzXH9QLB2HKdU25M=; b=eiJBxwxYSxeH+WygznPUN94kxm
        eDPQBdHfT0p3v5DsAF/sCDuTXXhiSROvZEruxi9Xey/D4ueXpCQEUapLHil7WEbp0pjQLsaleyWwp
        jrGKtAACPSRwTIH3F0y83mfEFtWeD43P8nsxsGtiSE0fUnO7ecsE6XDzfi4Eez8c7hMsi8Zn+tX0N
        Tx3ljAWbj/zc+WMYWLahE/k4mdSK5gcawBQaf13Dx+4lgSp7vCVbGMVCan9X5Z9TT7MiPSaCuYE+j
        Yw2NljvMWNLNedIw1xEC6bEFfMtJ58IdQvfnZlcK4l5W0ZxIhEyOA6eowCvqQtQaId58TKaHQn1v/
        opN0pf7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjiVU-00FTWr-SP; Tue, 04 Apr 2023 15:23:37 +0000
Date:   Tue, 4 Apr 2023 16:23:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: Re: [PATCH 6/6] mm: Run the fault-around code under the VMA lock
Message-ID: <ZCxA+DYkzVWbLAod@casper.infradead.org>
References: <20230404135850.3673404-1-willy@infradead.org>
 <20230404135850.3673404-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404135850.3673404-7-willy@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 04, 2023 at 02:58:50PM +0100, Matthew Wilcox (Oracle) wrote:
> The map_pages fs method should be safe to run under the VMA lock instead
> of the mmap lock.  This should have a measurable reduction in contention
> on the mmap lock.

https://github.com/antonblanchard/will-it-scale/pull/37/files should
be a good microbenchmark to report numbers from.  Obviously real-world
benchmarks will be more compelling.
