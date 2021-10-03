Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22AA4201C5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Oct 2021 15:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhJCNox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Oct 2021 09:44:53 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:50072 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhJCNow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Oct 2021 09:44:52 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mX1hQ-009dmQ-PD; Sun, 03 Oct 2021 13:38:40 +0000
Date:   Sun, 3 Oct 2021 13:38:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, krisman@collabora.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 1/2] fs: dcache: Handle case-exact lookup in
 d_alloc_parallel
Message-ID: <YVmyYP25kgGq9uEy@zeniv-ca.linux.org.uk>
References: <cover.1632909358.git.shreeya.patel@collabora.com>
 <0b8fd2677b797663bfcb97f6aa108193fedf9767.1632909358.git.shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8fd2677b797663bfcb97f6aa108193fedf9767.1632909358.git.shreeya.patel@collabora.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 04:23:38PM +0530, Shreeya Patel wrote:
> There is a soft hang caused by a deadlock in d_alloc_parallel which
> waits up on lookups to finish for the dentries in the parent directory's
> hash_table.
> In case when d_add_ci is called from the fs layer's lookup functions,
> the dentry being looked up is already in the hash table (created before
> the fs lookup function gets called). We should not be processing the
> same dentry that is being looked up, hence, in case of case-insensitive
> filesystems we are making it a case-exact match to prevent this from
> happening.

NAK.  What you are doing would lead to parallel calls of ->lookup() in the
same directory for names that would compare as equal.  Which violates
all kinds of assumptions in the analysis of dentry tree locking.

d_add_ci() is used to force the "exact" spelling of the name on lookup -
that's the whole point of that thing.  What are you trying to achieve,
and what's the point of mixing that with non-trivial ->d_compare()?

If it's "force to exact spelling on lookup, avoid calling ->lookup() on
aliases", d_add_ci() is simply not a good match.
