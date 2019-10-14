Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 748D2D5DCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 10:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfJNIqM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 04:46:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:43116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730439AbfJNIqM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:46:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F19BFADAA;
        Mon, 14 Oct 2019 08:46:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 00D1F1E4A86; Mon, 14 Oct 2019 10:46:09 +0200 (CEST)
Date:   Mon, 14 Oct 2019 10:46:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] fs: avoid softlockups in s_inodes iterators
Message-ID: <20191014084609.GA5939@quack2.suse.cz>
References: <841d0e0f-f04c-9611-2eea-0bcc40e5b084@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <841d0e0f-f04c-9611-2eea-0bcc40e5b084@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 11-10-19 11:49:38, Eric Sandeen wrote:
> One remains: remove_dquot_ref(), because I'm not quite sure how to deal
> with that one w/o taking the i_lock.

Yeah, that will be somewhat tricky. But I think we can modify the standard
iget-iput dance like:

		if (need_resched()) {
			spin_lock(&inode->i_lock);
			if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
				/*
				 * Cannot break on this inode, need to do one
				 * more.
				 */
				spin_unlock(&inode->i_lock);
				continue;
			}
			__iget(inode);
			spin_unlock(&inode->i_lock);
			spin_unlock(&sb->s_inode_list_lock);
			iput(put_inode);
			put_inode = inode;
			cond_resched();
			spin_lock(&sb->s_inode_list_lock);
		}
	...
	iput(put_inode);

Will you transform this into a proper patch in your series or should I do
it?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
