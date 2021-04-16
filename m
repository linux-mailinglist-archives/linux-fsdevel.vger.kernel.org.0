Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259E0361841
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 05:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbhDPDih (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 23:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbhDPDig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 23:38:36 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8CBC061574;
        Thu, 15 Apr 2021 20:38:13 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXFJ3-005fLg-Lp; Fri, 16 Apr 2021 03:38:09 +0000
Date:   Fri, 16 Apr 2021 03:38:09 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH] fs: split receive_fd_replace from __receive_fd
Message-ID: <YHkGodVOpc/kg3V8@zeniv-ca.linux.org.uk>
References: <20210325082209.1067987-1-hch@lst.de>
 <20210325082209.1067987-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325082209.1067987-2-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 09:22:09AM +0100, Christoph Hellwig wrote:
> receive_fd_replace shares almost no code with the general case, so split
> it out.  Also remove the "Bump the sock usage counts" comment from
> both copies, as that is now what __receive_sock actually does.

Nice, except that you've misread that, er, lovely API.  This

> -static inline int receive_fd_replace(int fd, struct file *file, unsigned int o_flags)
> -{
> -	return __receive_fd(fd, file, NULL, o_flags);
> +	return __receive_fd(file, NULL, o_flags);
>  }

can get called with negative fd (in which case it turns into an alias for
receive_fd(), of course).  As the result, that ioctl got broken in case
when SECCOMP_ADDFD_FLAG_SETFD is not set.  Trivially fixed by having the
only caller check the damn condition and call either receive_fd_replace()
or receive_fd().
