Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83584DA399
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 20:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbiCOT7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 15:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351561AbiCOT5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:57:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A2E580D5
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 12:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=c0sTAmq3W1jrsXGgq1g3SYAlZlT3nYN+7v5mMEKTke0=; b=mhSzvLJOzZt635pLCLpf1P4qhh
        iypHn5061CTisjIQNMtnYUbLCSfT3Mj5F6qT9pqJ/a2krJEcLxna0srEgtuJ1Ctiy1OoifmGJ+Tk4
        cEZ2qwijboouvM+7xvb3iCt5Re9dOwxuR96FhoKMUzPf9prv3+n4cJJCvYymxNyJAhYgK4/LrF7tU
        e5iP0ZwuWpgJwlnzJp+y+ffcqgpzyEaqDAeCG45JCuyV+CIattoSRiq/tn8OBiMD+8M8o1dOauUMN
        RpHsusoOxz2jWdzv68+Ba9s7VA0e2EAXFfFL0ucUcpAQ/RfZi0ABD2avkdlvAn23VWeSSrJcF4WGm
        m67CsTnw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUDGn-005KqP-0A; Tue, 15 Mar 2022 19:55:49 +0000
Date:   Tue, 15 Mar 2022 19:55:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Subject: [LSF/MM TOPIC] Better handling of negative dentries
Message-ID: <YjDvRPuxPN0GsxLB@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The number of negative dentries is effectively constrained only by memory
size.  Systems which do not experience significant memory pressure for
an extended period can build up millions of negative dentries which
clog the dcache.  That can have different symptoms, such as inotify
taking a long time [1], high memory usage [2] and even just poor lookup
performance [3].  We've also seen problems with cgroups being pinned
by negative dentries, though I think we now reparent those dentries to
their parent cgroup instead.

We don't have a really good solution yet, and maybe some focused
brainstorming on the problem would lead to something that actually works.

(Apologies to Stephen; I should have thought to send this before the
invitations to LSFMM went out).

[1] https://lore.kernel.org/linux-fsdevel/20220209231406.187668-1-stephen.s.brennan@oracle.com/
[2] https://lore.kernel.org/linux-fsdevel/1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com/
[3] https://lore.kernel.org/linux-fsdevel/158893941613.200862.4094521350329937435.stgit@buzz/

