Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8741E264E62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 21:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIJTMu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 15:12:50 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:52426 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbgIJQAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:00:51 -0400
Date:   Thu, 10 Sep 2020 11:45:17 -0400
From:   Rich Felker <dalias@libc.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: add fchmodat2 syscall
Message-ID: <20200910154516.GH3265@brightrain.aerifal.cx>
References: <20200910142335.GG3265@brightrain.aerifal.cx>
 <20200910151828.GD1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910151828.GD1236603@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 04:18:28PM +0100, Al Viro wrote:
> On Thu, Sep 10, 2020 at 10:23:37AM -0400, Rich Felker wrote:
> 
> > It was determined (see glibc issue #14578 and commit a492b1e5ef) that,
> > on some filesystems, performing chmod on the link itself produces a
> > change in the inode's access mode, but returns an EOPNOTSUPP error.
> 
> Which filesystem types are those?

It's been a long time and I don't know if the details were recorded.
It was reported for xfs but I believe we later found it happening for
others. See:

https://sourceware.org/bugzilla/show_bug.cgi?id=14578#c17
https://sourceware.org/legacy-ml/libc-alpha/2020-02/msg00467.html

and especially:

https://sourceware.org/legacy-ml/libc-alpha/2020-02/msg00518.html

where Christoph seems to have endorsed the approach in my patch. I'm
fine with doing it differently if you'd prefer, though.

Rich
