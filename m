Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5088B3A6FD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 22:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhFNUL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 16:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbhFNUL5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:11:57 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870DDC061574;
        Mon, 14 Jun 2021 13:09:54 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsstm-008Cvo-57; Mon, 14 Jun 2021 20:09:30 +0000
Date:   Mon, 14 Jun 2021 20:09:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>, axboe@kernel.dk,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pstore/blk: Use the normal block device I/O path
Message-ID: <YMe3eoodEyT+r1oI@zeniv-ca.linux.org.uk>
References: <20210614200421.2702002-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614200421.2702002-1-keescook@chromium.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 01:04:21PM -0700, Kees Cook wrote:
  
>  static ssize_t psblk_generic_blk_write(const char *buf, size_t bytes,
>  		loff_t pos)
>  {

>  	/* Console/Ftrace backend may handle buffer until flush dirty zones */
>  	if (in_interrupt() || irqs_disabled())
>  		return -EBUSY;

> +	return kernel_write(psblk_file, buf, bytes, &pos);

In which locking environments could that be called?  The checks above
look like that thing could be called from just about any context;
could that happen when the caller is holding a page locked?

IOW, what are those checks really trying to do?
