Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91504A3C98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 03:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357385AbiAaCxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jan 2022 21:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbiAaCw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jan 2022 21:52:58 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9395C061714;
        Sun, 30 Jan 2022 18:52:57 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEMoH-005z7n-8s; Mon, 31 Jan 2022 02:52:53 +0000
Date:   Mon, 31 Jan 2022 02:52:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mount: warn only once about timestamp range
 expiration
Message-ID: <YfdPBUYno5f0bTVk@zeniv-ca.linux.org.uk>
References: <20220119202934.26495-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119202934.26495-1-ailiop@suse.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 09:29:34PM +0100, Anthony Iliopoulos wrote:
> Commit f8b92ba67c5d ("mount: Add mount warning for impending timestamp
> expiry") introduced a mount warning regarding filesystem timestamp
> limits, that is printed upon each writable mount or remount.
> 
> This can result in a lot of unnecessary messages in the kernel log in
> setups where filesystems are being frequently remounted (or mounted
> multiple times).
> 
> Avoid this by setting a superblock flag which indicates that the warning
> has been emitted at least once for any particular mount, as suggested in
> [1].

Looks sane, except for the locking rules for ->s_iflags stores...
