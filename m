Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B53B7362C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 06:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjFTEsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 00:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFTEsU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 00:48:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8220C10F2;
        Mon, 19 Jun 2023 21:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IJtc0dSmvrdtDpxoBDdBZLPgMK+CrBpfQaCUFRKuZTE=; b=xysdKIXlVYrGJm8AdxF81CHfTL
        R53hTcAtaIK4/Wdz2V7GPaDDAbVjZWeX2sAImKPCWK4xbFGJJvUSc3GxJp3S/LOYjldEPyH8TnG6b
        OSmMAZMj1hL5tJsg5vmjXv6o95zaE88JIzozG5KoYd/Q0Vf8v6ql+TGdo3fmkGWitY+tXP5yMElce
        8FT7VE+/j2D8PpL4YVgaQTdKSoDhXcUKhdlleUL7ioMqtNANohbBA5ikhfqHQl7IjkDmhXjBAILEy
        BWPRN7lY2pgW0mLNsUKH5nECS9M/a/v9XfPP4vSISPnRbAEU770rSiUuKC7s9QPoZ2qVkMacR0We4
        FyxEX4gQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qBTHn-00A8vD-0V;
        Tue, 20 Jun 2023 04:48:11 +0000
Date:   Mon, 19 Jun 2023 21:48:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: Re: [PATCH v2 2/5] ext4: No need to check return value of
 block_commit_write()
Message-ID: <ZJEvi8CJddmpeluC@infradead.org>
References: <20230619211827.707054-1-beanhuo@iokpp.de>
 <20230619211827.707054-3-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619211827.707054-3-beanhuo@iokpp.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 19, 2023 at 11:18:24PM +0200, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> Remove unnecessary check on the return value of block_commit_write(),
> because it always returns 0.

Dropping the error check before the function signature is changes is
really odd.  I'd suggest to merge this and the following patches into
a single one.
