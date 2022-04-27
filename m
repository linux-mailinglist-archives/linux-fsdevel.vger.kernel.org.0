Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0990B5123FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 22:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbiD0Uho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 16:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236676AbiD0Uhg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:37:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16954EF5A;
        Wed, 27 Apr 2022 13:34:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39076B82AA7;
        Wed, 27 Apr 2022 20:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2B9C385A7;
        Wed, 27 Apr 2022 20:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651091661;
        bh=QhjW6sqbQQAgxviJKBe4aWpl0/FEQUpaXuQ5s4h6qWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q7Ns2THonpI64rhc55ciDClC+/tZwbo74ep5sf07OFCb26oZ1kUe9z79CZSpHNgzN
         VGMMisHTfPF3UFsfvxZ0AEUddllyF0mAQ72EsVMFRXrTjUdgq9z58WzHBUfQPEqp0O
         W6dNwKJCwvp4aKEyZx9Z3zIMHTeQ0j/etEQ7Dh8M=
Date:   Wed, 27 Apr 2022 13:34:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Daniel Colascione <dancol@google.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/smaps_rollup: return empty file for kthreads instead
 of ESRCH
Message-Id: <20220427133420.2847e62203b9e10a106c86b2@linux-foundation.org>
In-Reply-To: <83f49beb-52f7-15f6-3b53-97cac0030ca4@suse.cz>
References: <20220413211357.26938-1-alex_y_xu.ref@yahoo.ca>
        <20220413211357.26938-1-alex_y_xu@yahoo.ca>
        <20220413142748.a5796e31e567a6205c850ae7@linux-foundation.org>
        <1649886492.rqei1nn3vm.none@localhost>
        <20220413160613.385269bf45a9ebb2f7223ca8@linux-foundation.org>
        <YleToQbgeRalHTwO@casper.infradead.org>
        <YlfFaPhNFWNP+1Z7@localhost.localdomain>
        <83f49beb-52f7-15f6-3b53-97cac0030ca4@suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 14 Apr 2022 09:38:14 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> > Returning ESRCH is better so that programs don't waste time reading and
> > closing empty files and instantiating useless inodes.
> 
> Hm, unfortunately I don't remember why I put return -ESRCH for this case in
> addition to get_proc_task() failing. I doubt it was a conscious decision to
> treat kthreads differently - I think I would have preferred consistency with
> maps/smaps.
> 
> Can the awk use case be fixed with some flag to make it ignore the errors?

This is all too hard.  I think I'll drop the patch for now.
