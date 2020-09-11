Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE90F2676A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 01:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIKXzT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 19:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgIKXzR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 19:55:17 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE45C061573;
        Fri, 11 Sep 2020 16:55:16 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGssp-00EZrC-MZ; Fri, 11 Sep 2020 23:55:11 +0000
Date:   Sat, 12 Sep 2020 00:55:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@lca.pw>
Cc:     torvalds@linux-foundation.org, vgoyal@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: slab-out-of-bounds in iov_iter_revert()
Message-ID: <20200911235511.GB3421308@ZenIV.linux.org.uk>
References: <20200911215903.GA16973@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911215903.GA16973@lca.pw>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 11, 2020 at 05:59:04PM -0400, Qian Cai wrote:
> Super easy to reproduce on today's mainline by just fuzzing for a few minutes
> on virtiofs (if it ever matters). Any thoughts?

Usually happens when ->direct_IO() fucks up and reports the wrong amount
of data written/read.  We had several bugs like that in the past - see
e.g. 85128b2be673 (fix nfs O_DIRECT advancing iov_iter too much).

Had there been any recent O_DIRECT-related patches on the filesystems
involved?
