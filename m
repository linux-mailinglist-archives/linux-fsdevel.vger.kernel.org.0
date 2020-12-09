Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E646C2D4E69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 00:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgLIW7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 17:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgLIW7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 17:59:22 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2C8C0613CF;
        Wed,  9 Dec 2020 14:58:40 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kn8Pl-000AsE-02; Wed, 09 Dec 2020 22:58:29 +0000
Date:   Wed, 9 Dec 2020 22:58:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
Subject: Re: [PATCH] files: rcu free files_struct
Message-ID: <20201209225828.GR3579531@ZenIV.linux.org.uk>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
 <20201120231441.29911-15-ebiederm@xmission.com>
 <20201207232900.GD4115853@ZenIV.linux.org.uk>
 <877dprvs8e.fsf@x220.int.ebiederm.org>
 <20201209040731.GK3579531@ZenIV.linux.org.uk>
 <877dprtxly.fsf@x220.int.ebiederm.org>
 <20201209142359.GN3579531@ZenIV.linux.org.uk>
 <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
 <20201209194938.GS7338@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209194938.GS7338@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 07:49:38PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 09, 2020 at 12:04:38PM -0600, Eric W. Biederman wrote:
> > @@ -397,8 +397,9 @@ static struct fdtable *close_files(struct files_struct * files)
> >  		set = fdt->open_fds[j++];
> >  		while (set) {
> >  			if (set & 1) {
> > -				struct file * file = xchg(&fdt->fd[i], NULL);
> > +				struct file * file = fdt->fd[i];
> >  				if (file) {
> > +					rcu_assign_pointer(fdt->fd[i], NULL);
> 
> Assuming this is safe, you can use RCU_INIT_POINTER() here because you're
> storing NULL, so you don't need the wmb() before storing the pointer.

fs/file.c:pick_file() would make more interesting target for the same treatment...
