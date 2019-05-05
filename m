Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE2613FD3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2019 15:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfEENrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 May 2019 09:47:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43092 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfEENrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 May 2019 09:47:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hNHTu-0007OY-DB; Sun, 05 May 2019 13:47:06 +0000
Date:   Sun, 5 May 2019 14:47:06 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKP <lkp@01.org>
Subject: Re: [PATCH] fsnotify: fix unlink performance regression
Message-ID: <20190505134706.GB23075@ZenIV.linux.org.uk>
References: <20190505091549.1934-1-amir73il@gmail.com>
 <20190505130528.GA23075@ZenIV.linux.org.uk>
 <CAOQ4uxhEWLXQ+cb4UQcworPQoJpXvf59HJYi2dv5pumvbxpA9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhEWLXQ+cb4UQcworPQoJpXvf59HJYi2dv5pumvbxpA9w@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 05, 2019 at 04:19:02PM +0300, Amir Goldstein wrote:

> I have made an analysis of callers to d_delete() and found that all callers
> either hold parent inode lock or name is stable for another reason:
> https://lore.kernel.org/linux-fsdevel/20190104090357.GD22409@quack2.suse.cz/
> 
> But Jan preferred to keep take_dentry_name_snapshot() to be safe.
> I think the right thing to do is assert that parent inode is locked or
> no rename op in d_delete() and take the lock in ceph/ocfs2 to conform
> to the standard.

Any messing with the locking in ceph_fill_trace() would have to come
with very detailed proof of correctness, convincingly stable wrt
future changes in ceph...
