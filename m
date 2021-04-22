Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11509367FE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 13:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhDVL7O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 07:59:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:46420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235957AbhDVL7O (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 07:59:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7300ADD7;
        Thu, 22 Apr 2021 11:58:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B00AC1E37A2; Thu, 22 Apr 2021 13:58:38 +0200 (CEST)
Date:   Thu, 22 Apr 2021 13:58:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Hole punch races in CIFS
Message-ID: <20210422115838.GG26221@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I was looking into what protects CIFS from races between hole punching and
operations like page fault or readahead and AFAICT there's nothing to
prevent a race like:

CPU1						CPU2
smb3_fallocate()
  smb3_punch_hole()
    truncate_pagecache_range()
						filemap_fault()
						  - loads old data into the
						    page cache
    SMB2_ioctl(..., FSCTL_SET_ZERO_DATA, ...)

And now we have stale data in the page cache and if the page gets later
dirtied and written out, even persistent data corruption. Is there anything
I'm missing?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
