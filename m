Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B0125AF45
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgIBPfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgIBPfx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:35:53 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D277C061245;
        Wed,  2 Sep 2020 08:35:53 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDUnK-009LqU-QO; Wed, 02 Sep 2020 15:35:30 +0000
Date:   Wed, 2 Sep 2020 16:35:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     maz@kernel.org, alsa-devel@alsa-project.org,
        dan.carpenter@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, o-takashi@sakamocchi.jp,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Subject: Re: general protection fault in snd_ctl_release
Message-ID: <20200902153530.GK1236603@ZenIV.linux.org.uk>
References: <000000000000c15ee205ae4f2531@google.com>
 <s5h36409pbb.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h36409pbb.wl-tiwai@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 02, 2020 at 05:22:00PM +0200, Takashi Iwai wrote:

> Marc, Al, could you guys check this bug?

That's racy; the first one should be get_file_rcu() instead of
file_count()+get_file(), the second is not needed at all (we
have the file pinned down by the caller).  See vfs.git#work.epoll
for fix
