Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D423FDED2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343743AbhIAPki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 11:40:38 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:39610 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244612AbhIAPkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:40:37 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLSGg-000H8s-IX; Wed, 01 Sep 2021 15:35:14 +0000
Date:   Wed, 1 Sep 2021 15:35:14 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] namei: get rid of unused filename_parentat()
Message-ID: <YS+dstZ3xfcLxhoB@zeniv-ca.linux.org.uk>
References: <20210901150040.3875227-1-dkadashev@gmail.com>
 <YS+csMTV2tTXKg3s@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS+csMTV2tTXKg3s@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 01, 2021 at 03:30:56PM +0000, Al Viro wrote:
> On Wed, Sep 01, 2021 at 10:00:40PM +0700, Dmitry Kadashev wrote:
> > After the switch of kern_path_locked() to __filename_parentat() (to
> > address use after free bug) nothing is using filename_parentat(). Also,
> > filename_parentat() is inherently buggy: the "last" output arg
> > always point to freed memory.
> > 
> > Drop filename_parentat() and rename __filename_parentat() to
> > filename_parentat().
> 
> I'd rather fold that into previous patch.
> 
> And it might be better to fold filename_create() into its 2 callers
> and rename __filename_create() as well.
> 
> Let me poke around a bit...

BTW, if you look at the only caller of filename_lookup() outside of
fs/namei.c, you'll see this:
        f->refcnt++; /* filename_lookup() drops our ref. */
	ret = filename_lookup(param->dirfd, f, flags, _path, NULL);
IOW, that thing would be better off with calling the current
__filename_lookup().

Might be better to rename filename_lookup to something different,
turn __filename_lookup() into filename_lookup() and use _that_ in
fs/fs_parser.c...
