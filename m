Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415574C002B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 18:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiBVR2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 12:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiBVR2w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:28:52 -0500
Received: from slate.cs.rochester.edu (slate.cs.rochester.edu [128.151.167.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F40616FDF4;
        Tue, 22 Feb 2022 09:28:26 -0800 (PST)
Received: from node1x10a.cs.rochester.edu (node1x10a.cs.rochester.edu [192.5.53.74])
        by slate.cs.rochester.edu (8.14.7/8.14.7) with ESMTP id 21MHRmEg019803
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 22 Feb 2022 12:27:48 -0500
Received: from node1x10a.cs.rochester.edu (localhost [127.0.0.1])
        by node1x10a.cs.rochester.edu (8.15.2/8.15.1) with ESMTP id 21MHRmOW031989;
        Tue, 22 Feb 2022 12:27:48 -0500
Received: (from szhai2@localhost)
        by node1x10a.cs.rochester.edu (8.15.2/8.15.1/Submit) id 21MHRjNN031988;
        Tue, 22 Feb 2022 12:27:45 -0500
From:   Shuang Zhai <szhai2@cs.rochester.edu>
To:     mgorman@techsingularity.net
Cc:     akpm@linux-foundation.org, djwong@kernel.org, efault@gmx.de,
        hakavlad@inbox.lv, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        regressions@lists.linux.dev, riel@surriel.com,
        szhai2@cs.rochester.edu, vbabka@suse.cz
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to make progress'
Date:   Tue, 22 Feb 2022 12:27:31 -0500
Message-Id: <20220222172731.31949-1-szhai2@cs.rochester.edu>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220215144924.GS3366@techsingularity.net>
References: <20220215144924.GS3366@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mel Gorman wrote:
> On Mon, Feb 14, 2022 at 04:10:50PM -0500, Shuang Zhai wrote:
> > Hi Mel,
> > 
> > Mel Gorman wrote:
> > >
> > > Mike Galbraith, Alexey Avramov and Darrick Wong all reported similar
> > > problems due to reclaim throttling for excessive lengths of time.
> > > In Alexey's case, a memory hog that should go OOM quickly stalls for
> > > several minutes before stalling. In Mike and Darrick's cases, a small
> > > memcg environment stalled excessively even though the system had enough
> > > memory overall.
> > >
> > 
> > I recently found a regression when I tested MGLRU with fio on Linux
> > 5.16-rc6 [1]. After this patch was applied, I re-ran the test with Linux
> > 5.16, but the regression has not been fixed yet. 
> > 
> 
> Am I correct in thinging that this only happens with MGLRU?

Sorry about the confusion and let me clarify on this. The regression happens
on upstream Linux with the default page replacement mechanism.
