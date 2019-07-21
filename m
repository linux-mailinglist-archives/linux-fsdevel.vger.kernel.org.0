Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD436F16B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jul 2019 06:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbfGUEHB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jul 2019 00:07:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58104 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfGUEHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jul 2019 00:07:01 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hp36f-000820-UA; Sun, 21 Jul 2019 04:06:06 +0000
Date:   Sun, 21 Jul 2019 05:05:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, devel@driverdev.osuosl.org,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 03/24] erofs: add super block operations
Message-ID: <20190721040547.GF17978@ZenIV.linux.org.uk>
References: <20190711145755.33908-1-gaoxiang25@huawei.com>
 <20190711145755.33908-4-gaoxiang25@huawei.com>
 <20190720224955.GD17978@ZenIV.linux.org.uk>
 <161cffc4-1d61-5dc6-45df-f1779ef03b0f@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161cffc4-1d61-5dc6-45df-f1779ef03b0f@aol.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 21, 2019 at 11:08:42AM +0800, Gao Xiang wrote:

> It is for debugging use as you said below, mainly for our internal
> testers whose jobs are
> to read kmsg logs and catch kernel problems. sb->s_id (device number)
> maybe not
> straight-forward for them compared with dev_name...

Huh? ->s_id is something like "sdb7" - it's bdev_name(), not a device
number...

> The initial purpose of erofs_mount_private was to passing multi private
> data from erofs_mount
> to erofs_read_super, which was written before fs_contest was introduced.

That has nothing to do with fs_context (well, other than fs_context conversions
affecting the code very close to that).

> I agree with you, it seems better to just use s_id in community and
> delete erofs_mount_private stuffs...
> Yet I don't look into how to use new fs_context, could I keep using
> legacy mount interface and fix them all?

Sure.

> I guess if I don't misunderstand, that is another suggestion -- in
> short, leave all destructors to .kill_sb() and
> cleanup fill_super().

Just be careful with that iput() there - AFAICS, if fs went live (i.e.
if ->s_root is non-NULL), you really need it done only from put_super();
OTOH, for the case of NULL ->s_root ->put_super() won't be called at all,
so in that case you need it directly in ->kill_sb().
