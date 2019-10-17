Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D2DDA43D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 05:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389117AbfJQDPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 23:15:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60134 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387811AbfJQDPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 23:15:48 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKwGQ-0002Uj-91; Thu, 17 Oct 2019 03:15:46 +0000
Date:   Thu, 17 Oct 2019 04:15:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2] fs/namespace.c: fix use-after-free of mount in
 mnt_warn_timestamp_expiry()
Message-ID: <20191017031546.GT26530@ZenIV.linux.org.uk>
References: <20191017024814.61980-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017024814.61980-1-ebiggers@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 07:48:14PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> After do_add_mount() returns success, the caller doesn't hold a
> reference to the 'struct mount' anymore.  So it's invalid to access it
> in mnt_warn_timestamp_expiry().
> 
> Fix it by calling mnt_warn_timestamp_expiry() before do_add_mount()
> rather than after, and adjusting the warning message accordingly.
> 
> Reported-by: syzbot+da4f525235510683d855@syzkaller.appspotmail.com
> Fixes: f8b92ba67c5d ("mount: Add mount warning for impending timestamp expiry")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied to #fixes and pushed
