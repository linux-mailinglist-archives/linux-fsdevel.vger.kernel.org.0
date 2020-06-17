Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EAA1FD4C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 20:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgFQSpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 14:45:08 -0400
Received: from fieldses.org ([173.255.197.46]:44790 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgFQSpI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:45:08 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C505A315; Wed, 17 Jun 2020 14:45:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C505A315
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1592419507;
        bh=v7GIMCnhAtmRXr/LhTtCzIl7ouboiD5siEZjRRy7r60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABM8uEu0xVvYNEfxkv7T40RLBhEW4zhpfRCV/K5uZ72tSaKLYl4fnXY1/sGukWeqj
         tSHc5l/2SAWseozJXONI3md4Thnxw2yekdb/hytSXc5MTl1+NyoVERWSLczbxxIYfU
         rsAQLmK6w7X3+USPYq3w96GSvIddi0Cj0j1FSwjM=
Date:   Wed, 17 Jun 2020 14:45:07 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200617184507.GB18315@fieldses.org>
References: <20200616202123.12656-1-msys.mizuma@gmail.com>
 <20200617080314.GA7147@infradead.org>
 <20200617155836.GD13815@fieldses.org>
 <24692989-2ee0-3dcc-16d8-aa436114f5fb@sandeen.net>
 <20200617172456.GP11245@magnolia>
 <8f0df756-4f71-9d96-7a52-45bf51482556@sandeen.net>
 <20200617181816.GA18315@fieldses.org>
 <4cbb5cbe-feb4-2166-0634-29041a41a8dc@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cbb5cbe-feb4-2166-0634-29041a41a8dc@sandeen.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 01:28:11PM -0500, Eric Sandeen wrote:
> but mount(8) has already exposed this interface:
> 
>        iversion
>               Every time the inode is modified, the i_version field will be incremented.
> 
>        noiversion
>               Do not increment the i_version inode field.
> 
> so now what?

It's not like anyone's actually depending on i_version *not* being
incremented.  (Can you even observe it from userspace other than over
NFS?)

So, just silently turn on the "iversion" behavior and ignore noiversion,
and I doubt you're going to break any real application.

--b.
