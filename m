Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDE128D63C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 23:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgJMVc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 17:32:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37801 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgJMVc0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 17:32:26 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kSRuA-00088m-MW; Tue, 13 Oct 2020 21:32:22 +0000
Date:   Tue, 13 Oct 2020 23:32:22 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
Message-ID: <20201013213222.wlnhiocw6zi5eegx@wittgenstein>
References: <20201013140609.2269319-1-gscrivan@redhat.com>
 <20201013140609.2269319-2-gscrivan@redhat.com>
 <20201013210925.GJ3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201013210925.GJ3576660@ZenIV.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 10:09:25PM +0100, Al Viro wrote:
> On Tue, Oct 13, 2020 at 04:06:08PM +0200, Giuseppe Scrivano wrote:
> > +		spin_lock(&cur_fds->file_lock);
> > +		fdt = files_fdtable(cur_fds);
> > +		cur_max = fdt->max_fds - 1;
> > +		max_fd = min(max_fd, cur_max);
> > +		while (fd <= max_fd)
> > +			__set_close_on_exec(fd++, fdt);
> > +		spin_unlock(&cur_fds->file_lock);
> 
> 	First of all, this is an atrocious way to set all bits
> in a range.  What's more, you don't want to set it for *all*

Hm, good point.

Would it make sense to just use the bitmap_set() proposal since the 3 to
~0 case is most common or to actually iterate based on the open fds?


Christian
