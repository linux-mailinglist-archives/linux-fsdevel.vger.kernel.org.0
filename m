Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDA131E715
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 08:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhBRHrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 02:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhBRHo5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 02:44:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A0FC061786;
        Wed, 17 Feb 2021 23:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x/KF+DF1pYoW9EgF5c6O1WsHFfGsng3na0X3aUUo6kI=; b=t2dYxkyqC2yN1twmdBB9+kkB9d
        fmKnH0oOks7QGRGWLRRBR62uPZkHvqo9FNkU934CuOVlaoEUD8Mo8rU1qNpv9FlFWMvzVmDIdACU9
        +NUhDfEuslH5OSuaenz3NuIrjhDo8bbaE0QqKpI1Cbi4tRIKYu9vroSEPJWk2w2HL8cUiNj2u4esN
        gNV/+iTZZd2weGDgWeSXwEfI8v6+FjLjbdvwdG1hFqu+ySLzwe//64EG02TEZ7mTvBu3f4IzolTe7
        kldFSx1OB0BVAGY6JWX8O6wj9GLH+t8gnDDaGsLP42abmiI4IbrTTVOL8p7iS/b3XDHXsOstjoHoV
        yMn932ng==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCdyX-001Nra-QE; Thu, 18 Feb 2021 07:43:50 +0000
Date:   Thu, 18 Feb 2021 07:43:49 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3] vfs: fix copy_file_range regression in cross-fs copies
Message-ID: <20210218074349.GB329605@infradead.org>
References: <CAOQ4uxii=7KUKv1w32VbjkwS+Z1a0ge0gezNzpn_BiY6MFWkpA@mail.gmail.com>
 <20210217172654.22519-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217172654.22519-1-lhenriques@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 05:26:54PM +0000, Luis Henriques wrote:
> A regression has been reported by Nicolas Boichat, found while using the
> copy_file_range syscall to copy a tracefs file.  Before commit
> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> kernel would return -EXDEV to userspace when trying to copy a file across
> different filesystems.  After this commit, the syscall doesn't fail anymore
> and instead returns zero (zero bytes copied), as this file's content is
> generated on-the-fly and thus reports a size of zero.
> 
> This patch restores some cross-filesystems copy restrictions that existed
> prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> devices").  It also introduces a flag (COPY_FILE_SPLICE) that can be used
> by filesystems calling directly into the vfs copy_file_range to override
> these restrictions.  Right now, only NFS needs to set this flag.

No need for the flag.  Jyst fall back to splicing in the only caller
that wants it.
