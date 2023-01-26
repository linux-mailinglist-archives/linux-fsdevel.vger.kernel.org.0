Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C33867D1ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 17:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjAZQk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 11:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjAZQkz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:40:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E8159B42;
        Thu, 26 Jan 2023 08:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=St7IrS1mX9F0RKDBGEEFoebKrWt9ulX8fBNwRg7efIc=; b=Eg3hNBdDGz6MmWSRYZAiHki/eE
        lqofbPItG5HE7VLsezYljzQ1GYuqfgr/xpQ/G5btMaRZLA1Y9KXs4WlRInUMGu6QuUVLsxPqcszh7
        wkBxk+VAdUw26ftVTdoTBVoM48/XpwfRXNr6x9+1o+vpVQJCz+xENydh9aHYrOg7LGO/Bn+uCk+kZ
        9VP6oYuzy2VNB4n5jugCQ4H3LhlJltty78aGk0qxW71KhXi/ax2RJvjjXI9+VoHsJR2k4KYIwb3hj
        B+FIyRAUbWBFqdShQ7cCSoed4oUCdWJ9MtkfMBoVCRSN8nIyT+TP1u+FCs8pf7fyfchlVGPNxcCbn
        2W3TJ5EA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL5In-006uHI-SO; Thu, 26 Jan 2023 16:40:41 +0000
Date:   Thu, 26 Jan 2023 16:40:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <Y9KtCc+4n5uANB2f@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'd like to do another session on how the struct page dismemberment
is going and what remains to be done.  Given how widely struct page is
used, I think there will be interest from more than just MM, so I'd
suggest a plenary session.

If I were hosting this session today, topics would include:

Splitting out users:

 - slab (done!)
 - netmem (in progress)
 - hugetlb (in akpm)
 - tail pages (in akpm)
 - page tables
 - ZONE_DEVICE

Users that really should have their own types:

 - zsmalloc
 - bootmem
 - percpu
 - buddy
 - vmalloc

Converting filesystems to folios:

 - XFS (done)
 - AFS (done)
 - NFS (in progress)
 - ext4 (in progress)
 - f2fs (in progress)
 - ... others?

Unresolved challenges:

 - mapcount
 - AnonExclusive
 - Splitting anon & file folios apart
 - Removing PG_error & PG_private

This will probably all change before May.

I'd like to nominate Vishal Moola & Sidhartha Kumar as invitees based on
their work to convert various functions from pages to folios.
