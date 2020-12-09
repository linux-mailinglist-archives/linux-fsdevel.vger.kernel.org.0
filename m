Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D212D4AF7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 20:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbgLITuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 14:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732246AbgLITuY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:50:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D9FC0613CF;
        Wed,  9 Dec 2020 11:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=owvt0VPnkLv7CCz/UAulq+0d45ny1JQwNUHbwby6R2I=; b=PkPcG8fMbD4hffflurftNPDruU
        Ezi6gMw61uAhgAvkowNvRTku1Kn/D8l9YogS7ASjyAhoEDMROvP/5rRROgbFsfqXYw8acJvfu6iCE
        ACP6J/oToKc/G6O6cXzOSZ4Jb0ImsyzRJMdg3EJd1uAzPiuiqYPjyR+d/SaOney0KKEQakfOCiBh6
        X1k5H0P6mpwejT/8P/MDXWKhnHcil/7SbXa4ZZbhorPqr05KL8kD58UOtX6gar23IKWwxXG2MWccH
        G+MuaXgo7nhVTkWRb7TzasE5NW2sk7u7TzqGhPTqaYEw1UnOfiqy5crpHyqEBRjOwhp+8801SRCLr
        iJ4zHpfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kn5T0-0005BT-TS; Wed, 09 Dec 2020 19:49:38 +0000
Date:   Wed, 9 Dec 2020 19:49:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
Subject: Re: [PATCH] files: rcu free files_struct
Message-ID: <20201209194938.GS7338@casper.infradead.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
 <20201120231441.29911-15-ebiederm@xmission.com>
 <20201207232900.GD4115853@ZenIV.linux.org.uk>
 <877dprvs8e.fsf@x220.int.ebiederm.org>
 <20201209040731.GK3579531@ZenIV.linux.org.uk>
 <877dprtxly.fsf@x220.int.ebiederm.org>
 <20201209142359.GN3579531@ZenIV.linux.org.uk>
 <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 12:04:38PM -0600, Eric W. Biederman wrote:
> @@ -397,8 +397,9 @@ static struct fdtable *close_files(struct files_struct * files)
>  		set = fdt->open_fds[j++];
>  		while (set) {
>  			if (set & 1) {
> -				struct file * file = xchg(&fdt->fd[i], NULL);
> +				struct file * file = fdt->fd[i];
>  				if (file) {
> +					rcu_assign_pointer(fdt->fd[i], NULL);

Assuming this is safe, you can use RCU_INIT_POINTER() here because you're
storing NULL, so you don't need the wmb() before storing the pointer.

