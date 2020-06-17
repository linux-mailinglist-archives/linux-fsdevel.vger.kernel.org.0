Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D011FD169
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 17:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgFQP6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 11:58:36 -0400
Received: from fieldses.org ([173.255.197.46]:44248 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgFQP6g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:58:36 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 18455C5E; Wed, 17 Jun 2020 11:58:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 18455C5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1592409516;
        bh=qjrP9toWLVUQfIxqLnuogJfwKThqElLy0VbPctF2g9Q=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=SR1bZ108Nc66+qyxzfC/2i4yCutwv45fJBmN6WKaZfy/0XsvNtEplh5Djr8IoIBf9
         uJqqvrE8uabyX/2Faj5IH/Zlqgj56mNkIeHedGMI8YbaJH8/31g2tC9ACjdY84RhCd
         YnPDMKBV3NtijXuhF/sDt4z8wIG60uSPZaq4pqPA=
Date:   Wed, 17 Jun 2020 11:58:36 -0400
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200617155836.GD13815@fieldses.org>
References: <20200616202123.12656-1-msys.mizuma@gmail.com>
 <20200617080314.GA7147@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617080314.GA7147@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 01:03:14AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 16, 2020 at 04:21:23PM -0400, Masayoshi Mizuma wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > /proc/mounts doesn't show 'i_version' even if iversion
> > mount option is set to XFS.
> > 
> > iversion mount option is a VFS option, not ext4 specific option.
> > Move the handler to show_sb_opts() so that /proc/mounts can show
> > 'i_version' on not only ext4 but also the other filesystem.
> 
> SB_I_VERSION is a kernel internal flag.  XFS doesn't have an i_version
> mount option.

It probably *should* be a kernel internal flag, but it seems to work as
a mount option too.

By coincidence I've just been looking at a bug report showing that
i_version support is getting accidentally turned off on XFS whenever
userspace does a read-write remount.

Is there someplace in the xfs mount code where it should be throwing out
SB_I_VERSION?

Ideally there'd be entirely different fields for mount options and
internal feature flags.  But I don't know, maybe SB_I_VERSION is the
only flag we have like this.

--b.
