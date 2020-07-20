Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D730A226E04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 20:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbgGTSLM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 14:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgGTSLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:11:12 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61712C061794;
        Mon, 20 Jul 2020 11:11:12 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxaFn-00GiGn-Lp; Mon, 20 Jul 2020 18:11:07 +0000
Date:   Mon, 20 Jul 2020 19:11:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 05/24] fs: move the putname from filename_lookup to the
 callers
Message-ID: <20200720181107.GQ2786714@ZenIV.linux.org.uk>
References: <20200720155902.181712-1-hch@lst.de>
 <20200720155902.181712-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720155902.181712-6-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 05:58:43PM +0200, Christoph Hellwig wrote:
> This allows reusing the struct filename for retries, and will also allow
> pushing the getname up the stack for a few places to allower for better
> handling of kernel space filenames.

You are complicating the callers for no good reason.  NAK.  The same goes
for the previous patch in the series.

Keep the cleanup rules simple.  Sure, I understand wanting to avoid
special rules for early bootstrap, but that's a corner case; don't
make fs/namei.c harder to follow.
