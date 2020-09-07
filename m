Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687C3260573
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 22:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgIGUPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 16:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgIGUPU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:15:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98596C061573;
        Mon,  7 Sep 2020 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HFgEvpW3R88BEO0W4TSH3T3fDAqlzxYsLL7Hu+xZbDk=; b=aiJetSAJfdkq2mh4ZZZDTgDH+/
        Ie8NLiM2SBOSMVrp6U1arwYlqWE/Eo7L1GvO+mumyvIKb3pXf2OvUTMbNtqiec50Yzppr40TT3rLJ
        MacFYA88gNS6w/wSHlUblr5xFGBonsGmLvl1Vugh96YU5HprbUDtJ/Ygg5CiDf13Y8Zg8UrieyKf6
        ishVTLin826hOaiVwCseYjJ+/eQU7mFqgirgNNeWnc04FKYw/RESX96q4gdUbQsxx2n+aST7+snYg
        3ZcVc90rjMvVgWdWPlilljSLcGDkJ8HNSyZRLn23jhhrMnh4DWFsWB2Kn8XQrGpet07mHWrB5/Ril
        DchM4ukA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFNXo-0007o8-OB; Mon, 07 Sep 2020 20:15:17 +0000
Date:   Mon, 7 Sep 2020 21:15:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] fs: align IOCB_* flags with RWF_* flags
Message-ID: <20200907201516.GC27537@casper.infradead.org>
References: <95de7ce4-9254-39f1-304f-4455f66bf0f4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95de7ce4-9254-39f1-304f-4455f66bf0f4@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 12:08:10PM -0600, Jens Axboe wrote:
> We have a set of flags that are shared between the two and inherired
> in kiocb_set_rw_flags(), but we check and set these individually.
> Reorder the IOCB flags so that the bottom part of the space is synced
> with the RWF flag space, and then we can do them all in one mask and
> set operation.
> 
> The only exception is RWF_SYNC, which needs to mark IOCB_SYNC and
> IOCB_DSYNC. Do that one separately.
> 
> This shaves 15 bytes of text from kiocb_set_rw_flags() for me.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
