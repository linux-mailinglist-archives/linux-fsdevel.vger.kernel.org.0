Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D7F3E9002
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 14:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbhHKMDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 08:03:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36354 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhHKMDE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:03:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4D76F221D4;
        Wed, 11 Aug 2021 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628683360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TXbbn2MuDmKMUW0fB5u0FZ3pkPaYYpBN4JyaK63uXPo=;
        b=bULRAiq9Q+VMNqJWbyXVxI8E4MzZcvND1MQlR21mNqiIvfvkvAgZzmOa4PyAFtJBqb3qw+
        qxVn1STRJWHITBadmJtZ0a7LWWYhWImb1BpxQfIwk3ijlB+jRDJ76Tf9IVkXmH8noeYYJb
        SzgSaU7mcpuENyT1S2+SQU6pPb93hhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628683360;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TXbbn2MuDmKMUW0fB5u0FZ3pkPaYYpBN4JyaK63uXPo=;
        b=B512qLf2CZuGQambTVz9f5lgj3JTlHn5NiI18STt6p+aMD4OpM6mY96nCZweIedKex/TG4
        SMYPwhncw64MSKBQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 0816BA3C3C;
        Wed, 11 Aug 2021 12:02:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D51EA1E6204; Wed, 11 Aug 2021 14:02:39 +0200 (CEST)
Date:   Wed, 11 Aug 2021 14:02:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Performance optimization for no fsnotify marks
Message-ID: <20210811120239.GE14725@quack2.suse.cz>
References: <20210810151220.285179-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810151220.285179-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 10-08-21 18:12:16, Amir Goldstein wrote:
> Hi Jan,
> 
> Following v2 addresses review comments from v1 [1]
> 
> [1] https://lore.kernel.org/linux-fsdevel/20210803180344.2398374-1-amir73il@gmail.com/

Thanks for the patches and for the review to Matthew. I've picked up the
patches to my tree.

								Honza

> 
> Changes since v1:
> - Rebase on 5.14-rc5 + pidfd patches
> - Added RVB
> - Helper to get connector's sb (Matthew)
> - Fix deadlock bug on umount (Jan)
> 
> Amir Goldstein (4):
>   fsnotify: replace igrab() with ihold() on attach connector
>   fsnotify: count s_fsnotify_inode_refs for attached connectors
>   fsnotify: count all objects with attached connectors
>   fsnotify: optimize the case of no marks of any type
> 
>  fs/notify/fsnotify.c     |  6 ++---
>  fs/notify/fsnotify.h     | 15 ++++++++++++
>  fs/notify/mark.c         | 52 ++++++++++++++++++++++++++++++----------
>  include/linux/fs.h       |  4 ++--
>  include/linux/fsnotify.h |  9 +++++++
>  5 files changed, 69 insertions(+), 17 deletions(-)
> 
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
