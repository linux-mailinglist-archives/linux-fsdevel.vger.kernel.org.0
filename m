Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F06062B329
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 07:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiKPGOV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 01:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiKPGOU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:14:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA40CE5;
        Tue, 15 Nov 2022 22:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SmNP44zsSjM7fVG0O0ldLj1BYrmirKj9bO7NDkK1/aw=; b=jZxZpnlybPsUgdIVevKQfRR0/r
        nV80Hx7q1OF7A+fBkNJhM8mptUO9qbtZY4rDLSQMIDnaZgj1xazkd+weOZNDpunxKZsMHlX2ggTe4
        i92eQMcqFAUmAgcuC6MAF0UaSxJuX2hwslaf2GxMvVOGsKhsFvpIKoEl2jo/W1NvDTOsYd9ZNM80I
        ge0OjowViCuj6MqObwHU3k7ToYgvIm/l1XL9DKkHFRFI33f/+2ksBtz53hNtCcTxVfK9/d2+qsXdF
        R/xd5zez5DYMKU128+k0v8Nh+ahKSIm7QP/4Ri/hwv5hfI4bK84tuakGs+/Ag6WpSbzdlTsOAlP/f
        PWQWbDRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovBga-000DC6-PE; Wed, 16 Nov 2022 06:14:12 +0000
Date:   Tue, 15 Nov 2022 22:14:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linkinjeon@kernel.org,
        sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] ksmbd: use F_SETLK when unlocking a file
Message-ID: <Y3R/tKzP7QBt0SO/@infradead.org>
References: <20221111131153.27075-1-jlayton@kernel.org>
 <Y3NVZ6e7Hnddsdl6@infradead.org>
 <81a329d44cb2def622ddfcde88984caf51b4a017.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81a329d44cb2def622ddfcde88984caf51b4a017.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:22:42AM -0500, Jeff Layton wrote:
> Maybe, though the current scheme basically of mirrors the userland API,
> as do the ->lock and ->flock file_operations.

Yes.  But the userland API is pretty horrible and the file_operations
should go along with any locks API change.

> FWIW, the filelocking API is pretty rife with warts. Several other
> things that I wouldn't mind doing, just off the top of my head:
> 
> - move the file locking API into a separate header. No need for it to be
> in fs.h, which is already too bloated.
> 
> - define a new struct for leases, and drop lease-specific fields from
> file_lock
> 
> - remove more separate filp and inode arguments
> 
> - maybe rename locks.c to filelock.c? "locks.c" is too ambiguous

These all sounds pretty reasonable to me.
