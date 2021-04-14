Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C441E35EB97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 05:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347055AbhDND5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 23:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbhDND5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 23:57:07 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC326C061574;
        Tue, 13 Apr 2021 20:56:46 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWWdw-005Bid-Gt; Wed, 14 Apr 2021 03:56:44 +0000
Date:   Wed, 14 Apr 2021 03:56:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, matthew.wilcox@oracle.com,
        khlebnikov@yandex-team.ru
Subject: Re: [PATCH RFC 6/6] dcache: prevent flooding with negative dentries
Message-ID: <YHZn/IFvZbMX9QTD@zeniv-ca.linux.org.uk>
References: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
 <1611235185-1685-7-git-send-email-gautham.ananthakrishna@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611235185-1685-7-git-send-email-gautham.ananthakrishna@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 06:49:45PM +0530, Gautham Ananthakrishna wrote:

> +	spin_lock(&victim->d_lock);
> +	parent = lock_parent(victim);
> +
> +	rcu_read_unlock();

Similar story.  As soon as you hit that rcu_read_unlock(), the memory
pointed to by victim might be reused.  If you have hit __lock_parent(),
victim->d_lock had been dropped and regained.  Which means that freeing
might've been already scheduled.  Unlike #1/6, here you won't get
memory corruption in lock_parent() itself, but...

> +
> +	if (d_count(victim) || !d_is_negative(victim) ||
> +	    (victim->d_flags & DCACHE_REFERENCED)) {
> +		if (parent)
> +			spin_unlock(&parent->d_lock);
> +		spin_unlock(&victim->d_lock);

... starting from here you just might.
