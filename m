Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D12A62A98C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 14:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfEZMHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 08:07:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42272 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfEZMHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 08:07:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hUrvr-0008Af-Cx; Sun, 26 May 2019 12:07:19 +0000
Date:   Sun, 26 May 2019 13:07:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "J. R. Okajima" <hooanon05g@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kolyshkin@gmail.com
Subject: Re: [PATCH] concrete /proc/mounts
Message-ID: <20190526120719.GQ17978@ZenIV.linux.org.uk>
References: <17910.1558861894@jrobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17910.1558861894@jrobl>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 06:11:34PM +0900, J. R. Okajima wrote:
> commit 1e83f8634c6efe7dd4e6036ee202ca10bdbca0b3
> Author: J. R. Okajima <hooanon05g@gmail.com>
> Date:   Sat May 25 18:35:13 2019 +0900
> 
>     concrete /proc/mounts
>     
>     When the size of /proc/mounts exceeds PAGE_SIZE, seq_read() has to
>     release namespace_sem via mounts_op.m_stop().  It means if someone else
>     issues mount(2) or umount(2) and the mounts list got changed, then the
>     continuous getmntent(3) calls show the incomplete mounts list and some
>     entries may not appear in it.
>     
>     This patch generates the full mounts list when mounts_op.m_start() is
>     called, and keep it in the seq_file buffer until the file is closed.
>     The size of the buffer increases if necessary.  Other operations m_next,
>     m_stop, m_show become meaningless, but still necessary for the seq_file
>     manner.
>     
>     I don't think the size of the buffer matters because many /proc entries
>     already keep the similar PAGE_SIZE buffer.  Increasing /proc/mounts
>     buffer is to keep the correctness of the mount list.
>     
>     Reported-by: Kirill Kolyshkin <kolyshkin@gmail.com>
>     See-also: https://github.com/kolyshkin/procfs-test
>     Signed-off-by: J. R. Okajima <hooanon05g@gmail.com>

Translation: let's generate the entire contents on the first read() and keep
it until the sucker's closed; that way userland wont' see anything changing
under it.  Oh, wait...

NAK.
