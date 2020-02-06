Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4E4154E49
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 22:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgBFVpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 16:45:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33278 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFVpU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 16:45:20 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izoxa-008U4X-9h; Thu, 06 Feb 2020 21:45:18 +0000
Date:   Thu, 6 Feb 2020 21:45:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "J . Bruce Fields" <bfields@redhat.com>
Subject: Re: [PATCH] exportfs: fix handling of rename race in reconnect_one()
Message-ID: <20200206214518.GB23230@ZenIV.linux.org.uk>
References: <20200126220800.32397-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126220800.32397-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 27, 2020 at 12:08:00AM +0200, Amir Goldstein wrote:
> If a disconnected dentry gets looked up and renamed between the
> call to exportfs_get_name() and lookup_one_len_unlocked(), and if also
> lookup_one_len_unlocked() returns ERR_PTR(-ENOENT), maybe because old
> parent was deleted, we return an error, although dentry may be connected.
> 
> Commit 909e22e05353 ("exportfs: fix 'passing zero to ERR_PTR()'
> warning") changes this behavior from always returning success,
> regardless if dentry was reconnected by somoe other task, to always
> returning a failure.
> 
> Change the lookup error handling to match that of exportfs_get_name()
> error handling and return success after getting -ENOENT and verifying
> that some other task has connected the dentry for us.

It's not that simple, unfortunately.  For one thing, lookup_one_len_unlocked()
will normally return a negative dentry, not ERR_PTR(-ENOENT).  For another,
it *can* fail for any number of other reasons (-ENOMEM, for example), without
anyone having ever looked it up.

So I agree that the damn thing needs work, but I don't believe that this
is the right fix.
