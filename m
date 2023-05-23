Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B3C70E13E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 17:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbjEWP7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 11:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbjEWP7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 11:59:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F671185;
        Tue, 23 May 2023 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZWd/pPhxGYih7w2ZJsyn/LHablyBWgmEMR2FTtunxyQ=; b=dMNRGE0HQuZY6O0r+N+ENrLWay
        n7nokiwnS/oUKJvNX7JVbSajwuvWpHr9fa2KZdqrX9TSfUdLC4yjSbvfEdTMjVBBb1oI4+s1ewQ3D
        GOb/UKlkv4jESUfrYba+f2nPpDGCwb/A/CkqxrZXyqrcGz2BswvOX0ALFjnfixLqktG4ys7A8DxW5
        EHMb+aaQ+8Hi8oqJUk9fL7fGdMfiQAxeC408dwNmmUR6Lm214AV5bZmpX6NCrLm+7FtCyNkw6Rx8A
        1SyVSOC7nzTxq/+mn0XD4b3r/J4XtA0Yg8JH/Sym6ASe5cRtoWsupPXQT5GenXJNXXz8JDd5GIVrc
        /IymAzdg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q1UPd-00AMKR-Tc; Tue, 23 May 2023 15:59:01 +0000
Date:   Tue, 23 May 2023 16:59:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv5 5/5] iomap: Add per-block dirty state tracking to improve
 performance
Message-ID: <ZGzixaCEwGyNfPJR@casper.infradead.org>
References: <ZGzRX9YVkAYJGLqV@bfoster>
 <87fs7nozu5.fsf@doe.com>
 <ZGzaOSvpCAUsluhr@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGzaOSvpCAUsluhr@bfoster>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 11:22:33AM -0400, Brian Foster wrote:
> That is a prepatory patch before iop dirty tracking is enabled in patch
> 5, right? I was mainly just suggesting to make the overwrite checking
> part of this patch come after dirty tracking is enabled (as a small
> optimization patch) rather than before.
> 
> I don't want to harp on it if that's difficult or still doesn't make
> sense for some reason. I'll take a closer look the next go around when I
> have a bit more time and just send a diff if it seems it can be done
> cleanly..

Honestly, I think the way the patchset is structured now is fine.
There are always multiple ways to structure a set of patches, and I don't
think we need be too concerned about what order the things are done in,
as long as they get done.
