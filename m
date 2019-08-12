Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B580A89584
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 05:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfHLDD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 23:03:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57566 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLDD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 23:03:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hx0ck-0000rI-IY; Mon, 12 Aug 2019 03:03:54 +0000
Date:   Mon, 12 Aug 2019 04:03:54 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>,
        syzbot <syzbot+2c95195d5d433f6ed6cb@syzkaller.appspotmail.com>
Subject: Re: [PATCH] nfsd: fix dentry leak upon mkdir failure.
Message-ID: <20190812030354.GR1131@ZenIV.linux.org.uk>
References: <0000000000001097b6058fe1fb22@google.com>
 <1565576171-6586-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565576171-6586-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 11:16:11AM +0900, Tetsuo Handa wrote:
> syzbot is reporting that nfsd_mkdir() forgot to remove dentry created by
> d_alloc_name() when __nfsd_mkdir() failed (due to memory allocation fault
> injection) [1].

That's not the only problem I see there.
        ret = __nfsd_mkdir(d_inode(parent), dentry, S_IFDIR | 0600);
        if (ret)
                goto out_err;
        if (ncl) {
                d_inode(dentry)->i_private = ncl;
                kref_get(&ncl->cl_ref);
        }
and we are doing that to inode *after* it has become visible via dcache -
__nfsd_mkdir() has already done d_add() (and pinged f-snotify, at that).
Looks fishy...
