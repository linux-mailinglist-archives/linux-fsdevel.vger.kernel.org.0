Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A0874521C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 22:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjGBUJB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 16:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjGBUIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:08:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE061BFD;
        Sun,  2 Jul 2023 13:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C6D660C75;
        Sun,  2 Jul 2023 20:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712D1C433C8;
        Sun,  2 Jul 2023 20:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688328376;
        bh=ZJnTsXKaN6uYtJh5LC2hJdMySXlUaJO5Zc6GW+BMzyI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L6ait9MxtGovd3rhKKKGdWJ1Lvcd6cT3sEcMdSOOn2dXu8Fg0QtVVOPzWWBu1SjWv
         GsFRQmnrdTZToes1uGZhEAVS5g+MBgbepJVXJHjBt+nnnNJPxuvrSV+sG/UtEasu8H
         O5KHOG9Xj8sy4IBL6h+7zFv+Wa4vCbnGGhIYqSqY=
Date:   Sun, 2 Jul 2023 13:06:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] writeback: Account the number of pages written back
Message-Id: <20230702130615.b72616d7f03b3ab4f6fc8dab@linux-foundation.org>
In-Reply-To: <20230628185548.981888-1-willy@infradead.org>
References: <20230628185548.981888-1-willy@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 28 Jun 2023 19:55:48 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> nr_to_write is a count of pages, so we need to decrease it by the number
> of pages in the folio we just wrote, not by 1.  Most callers specify
> either LONG_MAX or 1, so are unaffected, but writeback_sb_inodes()
> might end up writing 512x as many pages as it asked for.

512 is a big number,  Should we backport this?

> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")

I'm not seeing how a readahead change messed up writeback accounting?


