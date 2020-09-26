Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A998279A37
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 16:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgIZOtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 10:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZOtE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 10:49:04 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407F6C0613CE
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 07:49:04 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMBVW-006gc6-U6; Sat, 26 Sep 2020 14:49:03 +0000
Date:   Sat, 26 Sep 2020 15:49:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] fs: pass a nameidata into filename_lookup
Message-ID: <20200926144902.GZ3421308@ZenIV.linux.org.uk>
References: <20200926092051.115577-1-hch@lst.de>
 <20200926092051.115577-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926092051.115577-4-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 26, 2020 at 11:20:50AM +0200, Christoph Hellwig wrote:
> This allows keeping the LOOKUP_ROOT case for vfs_path_lookup entirely
> out of the normal fast path.

... saving you all of a if (unlikely(root)) {....} on it.  Not worth
it, and
> +	struct nameidata nd;
> +
> +	return filename_lookup(AT_FDCWD, getname_kernel(name), flags, path,
> +			       &nd);

is something I would rather avoid on the general principles - better have
set_nameidata()/restore_nameidata() done always to a local variable.  Makes
for somewhat easier analysis.

IOW, NAK
