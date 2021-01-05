Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3A42EB1C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 18:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbhAERq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 12:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbhAERq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 12:46:27 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76FCC061574;
        Tue,  5 Jan 2021 09:45:46 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwqOh-0077dB-4T; Tue, 05 Jan 2021 17:45:31 +0000
Date:   Tue, 5 Jan 2021 17:45:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4] proc: Allow pid_revalidate() during LOOKUP_RCU
Message-ID: <20210105174531.GW3579531@ZenIV.linux.org.uk>
References: <20210104232123.31378-1-stephen.s.brennan@oracle.com>
 <20210105055935.GT3579531@ZenIV.linux.org.uk>
 <20210105165005.GV3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105165005.GV3579531@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 05, 2021 at 04:50:05PM +0000, Al Viro wrote:

> struct dentry *d_find_alias_rcu(struct inode *inode)
> {
> 	struct hlist_head *l = &inode->i_dentry;
>         struct dentry *de = NULL;
> 
> 	spin_lock(&inode->i_lock);
> 	// ->i_dentry and ->i_rcu are colocated, but the latter won't be
> 	// used without having I_FREEING set, which means no aliases left
> 	if (inode->i_state & I_FREEING) {
> 		spin_unlock(&inode->i_lock);
> 		return NULL;
> 	}
> 	// we can safely access inode->i_dentry
>         if (hlist_empty(p)) {

	if (hlist_empty(l)) {

obviously...
