Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EDE28D626
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 23:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgJMVJ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 17:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgJMVJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 17:09:28 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4BBC061755;
        Tue, 13 Oct 2020 14:09:28 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSRXx-00HB9t-Ag; Tue, 13 Oct 2020 21:09:25 +0000
Date:   Tue, 13 Oct 2020 22:09:25 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        christian.brauner@ubuntu.com, containers@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
Message-ID: <20201013210925.GJ3576660@ZenIV.linux.org.uk>
References: <20201013140609.2269319-1-gscrivan@redhat.com>
 <20201013140609.2269319-2-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013140609.2269319-2-gscrivan@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 04:06:08PM +0200, Giuseppe Scrivano wrote:
> +		spin_lock(&cur_fds->file_lock);
> +		fdt = files_fdtable(cur_fds);
> +		cur_max = fdt->max_fds - 1;
> +		max_fd = min(max_fd, cur_max);
> +		while (fd <= max_fd)
> +			__set_close_on_exec(fd++, fdt);
> +		spin_unlock(&cur_fds->file_lock);

	First of all, this is an atrocious way to set all bits
in a range.  What's more, you don't want to set it for *all*
bits - only for the ones present in open bitmap.  It's probably
harmless at the moment, but let's not create interesting surprises
for the future.
