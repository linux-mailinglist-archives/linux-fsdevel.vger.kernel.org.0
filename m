Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BA6226E26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 20:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgGTSRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 14:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbgGTSRM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:17:12 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D670C061794;
        Mon, 20 Jul 2020 11:17:12 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxaLa-00GiPf-MH; Mon, 20 Jul 2020 18:17:06 +0000
Date:   Mon, 20 Jul 2020 19:17:06 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 06/24] fs: add a kern_chdir helper
Message-ID: <20200720181706.GR2786714@ZenIV.linux.org.uk>
References: <20200720155902.181712-1-hch@lst.de>
 <20200720155902.181712-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720155902.181712-7-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 05:58:44PM +0200, Christoph Hellwig wrote:
> Add a simple helper for a chdir with a kernelspace name and use it in the
> early init code instead of relying on the implicit set_fs(KERNEL_DS)
> there.  Remove the now unused ksys_chdir.

FWIW, my problem with that is that you are making it first-class primitive.
And I don't see any valid use for it - existing one is really "we have
a userland process that would be making syscalls if we only could have it
done right; the only reason we can't is that the infrastructure to build
the binary would be hell to maintain in the tree".  It's *NOT* "kernel
code that has a valid reason to get the syscall functionality".
