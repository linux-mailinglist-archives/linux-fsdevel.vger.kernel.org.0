Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADFD2223E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 15:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGPN3o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 09:29:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:33566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbgGPN3n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:29:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E0699B952;
        Thu, 16 Jul 2020 13:29:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DCCC31E12C9; Thu, 16 Jul 2020 15:29:41 +0200 (CEST)
Date:   Thu, 16 Jul 2020 15:29:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 16/22] fsnotify: remove check that source dentry is
 positive
Message-ID: <20200716132941.GD5022@quack2.suse.cz>
References: <20200716084230.30611-1-amir73il@gmail.com>
 <20200716084230.30611-17-amir73il@gmail.com>
 <20200716131311.GC5022@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716131311.GC5022@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-07-20 15:13:11, Jan Kara wrote:
> On Thu 16-07-20 11:42:24, Amir Goldstein wrote:
> > Remove the unneeded check for positive source dentry in
> > fsnotify_move().
> > 
> > fsnotify_move() hook is mostly called from vfs_rename() under
> > lock_rename() and vfs_rename() starts with may_delete() test that
> > verifies positive source dentry.  The only other caller of
> > fsnotify_move() - debugfs_rename() also verifies positive source.
> > 
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> 
> But in vfs_rename() if RENAME_EXCHANGE is set and target is NULL,
> new_dentry can be negative when calling fsnotify_move() AFAICT, cannot it?

FWIW, renameat2() doesn't allow RENAME_EXCHANGE with non-existent target
and I didn't find any other place that could call vfs_rename() with
RENAME_EXCHANGE and negative target but still vfs_rename() seems to support
that and so fsnotify should likely handle that as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
