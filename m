Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C3F740A0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 09:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjF1H4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 03:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjF1Hyo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F3819B1;
        Wed, 28 Jun 2023 00:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=RQamssdUQ9C2xGj3PvgqarBFIoJwegp4eTAMgCLct08=; b=sm051owQ1fp4U3wCrUuUPGG9l5
        wo+Jrhvcjn9ctLPQBfidZmKJXvyM246rNQePKQ9sWKMOPgij5Q+yHvwY04b1ROPQZ8cbm18nvIA5m
        esEhiGz0J9GOCrpD6KPZWvLOvIXvzGEHu3FXJkbj4b8TchH/L7HPZKZ15s4ahDIiLbJ2tSn+KOZWe
        FNulJrFgADqpM04VhrNi1VuvqRSqtMbc4ud7+0vCFrMplq1497qcVvPpCApkVz8MAvZdeEHKs1312
        oMPOV0ypGYkVtX5vBYHdey4cSpuIXoltL+GczqYbpRsJGrim/9YYTZWbZvqX1KX2S9RI4cdDtZPRZ
        9Tf/gaxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEN8z-00Eory-0s;
        Wed, 28 Jun 2023 04:51:05 +0000
Date:   Tue, 27 Jun 2023 21:51:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@vger.kernel.org
Subject: Re: [PATCH v3 0/3+1] fanotify accounting for fs/splice.c
Message-ID: <ZJu8OUwWgz1zDVf5@infradead.org>
References: <CAOQ4uxh7i_s4R9pFJPENALdWGG5-dDhqPLEUXuJqSoHraktFiA@mail.gmail.com>
 <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can you please resend this outside this thread?  I really cant't see
what's new or old here if you have a reply-to in the old thread.

On Tue, Jun 27, 2023 at 06:55:22PM +0200, Ahelenia Ziemiańska wrote:
> In 1/3 I've applied if/else if/else tree like you said,
> and expounded a bit in the message.
> 
> This is less pretty now, however, since it turns out that
> iter_file_splice_write() already marks the out fd as written because it
> writes to it via vfs_iter_write(), and that sent a double notification.

It seems like vfs_iter_write is the wrong level to implement
->splice_write given that the the ->splice_write caller has already
checked f_mode, done the equivalent of rw_verify_area and
should do the fsnotify_modify.  I'd suggest to just open code the
relevant parts of vfs_iocb_iter_write in iter_file_splice_write.
