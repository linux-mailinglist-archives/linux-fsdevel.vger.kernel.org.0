Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3084201CD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Oct 2021 15:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhJCNyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Oct 2021 09:54:20 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:51004 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhJCNyU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Oct 2021 09:54:20 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mX1um-009e19-Ft; Sun, 03 Oct 2021 13:52:28 +0000
Date:   Sun, 3 Oct 2021 13:52:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 1/2] fs: dcache: Handle case-exact lookup in
 d_alloc_parallel
Message-ID: <YVm1nEDgaI7pl1Jz@zeniv-ca.linux.org.uk>
References: <cover.1632909358.git.shreeya.patel@collabora.com>
 <0b8fd2677b797663bfcb97f6aa108193fedf9767.1632909358.git.shreeya.patel@collabora.com>
 <87a6js61aj.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6js61aj.fsf@collabora.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 01, 2021 at 02:35:32PM -0400, Gabriel Krisman Bertazi wrote:

> I don't like the idea of having a flavor of a dentry comparison function
> that doesn't invoke d_compare.  In particular because d_compare might be
> used for all sorts of things, and this fix is really specific to the
> case-insensitive case.
> 
> Would it be possible to fold this change into generic_ci_d_compare?  If
> we could flag the dentry as part of a parallel lookup under the relevant
> condition, generic_ci_d_compare could simply return immediately in
> such case.

Not really - if anything, that's a property of d_alloc_parallel() call
done by d_add_ci(), not that of any of the dentries involved...
