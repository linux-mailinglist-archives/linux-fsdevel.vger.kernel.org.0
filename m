Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4755AA7D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiFYN3S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 09:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiFYN3P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:29:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED92111C0E;
        Sat, 25 Jun 2022 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VMebA8yQeVZMRzdvMUNABTQuSHPkN19xCjkasWh2T7k=; b=qt2Yb1342EoIxvnP4N/gNFPjwM
        OtBV4RKU8ehY9J0ju8f2CPM9ijg6TaJJxlVBSs6mAnx+SJ5uHavxkDLA0Fm0WmU0BrV9W8tg9e3kk
        WTT5DxC4zR1PUfzXXnENYo9IPaQQAEh5KvuD/gB2R1edFEeN+VbmQIcfhRCbWV3QGIkYZHS9Zbav1
        BXQDpEikupoaKMNlKDBvc7b8hPR3x3EZSjjGNclHgI03YGbR20haDmDrzlYXXlYPzj9qfm0GkUBWg
        EYjy1ef6Q6vwvYzQ26EpXKxt5OhUWI9YNINbOXQFwp7f8EGotCTNSUXMvXXNVEF9YiCumSQfj6AIA
        HqrEtv8w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o55qX-004Kaw-Mg;
        Sat, 25 Jun 2022 13:29:09 +0000
Date:   Sat, 25 Jun 2022 14:29:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] fs: clear or set FMODE_LSEEK based on llseek
 function
Message-ID: <YrcNpdJmyFU+Up1n@ZenIV>
References: <20220625110115.39956-1-Jason@zx2c4.com>
 <20220625110115.39956-4-Jason@zx2c4.com>
 <YrcIoaluGx+2TzfM@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrcIoaluGx+2TzfM@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 25, 2022 at 06:07:45AM -0700, Christoph Hellwig wrote:
> On Sat, Jun 25, 2022 at 01:01:10PM +0200, Jason A. Donenfeld wrote:
> > This helps unify a longstanding wart where FMODE_LSEEK hasn't been
> > uniformly unset when it should be.
> 
> I think we could just remove FMODE_LSEEK after the previous patch
> as we can just check for the presence of a ->llseek method instead.

I wouldn't bet on that - as it is, an ->open() instance can decide
in some cases to clear FMODE_LSEEK, despite having file_operations
with non-NULL ->llseek.
