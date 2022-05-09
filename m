Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF2351FE56
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 15:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiEINez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 09:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiEINey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 09:34:54 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D899E65F8
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 06:30:58 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 249DUqF5004324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 May 2022 09:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652103053; bh=CMKomXJmgNZpr8gZetcfluhrdPkkg5vqQyMSBGU+zRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VJE0CWTdlTyk73PLk0spYhZ59DxBmmxTss5KPKMNm/eYzucfgbrhPWwevALTwGbKA
         VPDY8YHbqeT8r/FxUZ8pw8DDDTCpPydChyu5mwMBrgn5VFdsdr9MgJfLnFCAmrVViR
         YfHDdssK1BSgzEpBki8D37XE/JisBJKU6TPeogEz+ZCByt5k6jTi21Bqov+R1VTrZW
         g8904fG6xWKubnr05yhoyiJGrIaCvt7cBEGAYBvdTDz07vpsu5A3wjsX+JazWRqQc4
         mYpGycXEZx3y7YENk5ZB975VLd2zY+sReFO7e8R3pTO/bre31dN7qxrdFFOOF/8o2z
         IVsk3mMyQ1Btw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 478BF15C3F0A; Mon,  9 May 2022 09:30:52 -0400 (EDT)
Date:   Mon, 9 May 2022 09:30:52 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/37] ext4: Convert ext4 to read_folio
Message-ID: <YnkXjPZMSC+yYGOe@mit.edu>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
 <20220508203131.667959-19-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508203131.667959-19-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 08, 2022 at 09:31:12PM +0100, Matthew Wilcox (Oracle) wrote:
> This is a "weak" conversion which converts straight back to using pages.
> A full conversion should be performed at some point, hopefully by
> someone familiar with the filesystem.

What worries me about the "weak" conversion is that ext4_read_folio()
(formerly ext4_read_page()) is going to completely the wrong thing if
the folio contains more than a single page.  This seems to
be... scary.  How are callers of aops->read_folio() supposed to know
whether the right thing or the wrong thing will happen if a random
folio is passed to aops->read_folio()?

						- Ted
