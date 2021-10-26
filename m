Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E040743B607
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbhJZPvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 11:51:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237075AbhJZPvA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:51:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D543160EFE;
        Tue, 26 Oct 2021 15:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635263314;
        bh=2+3VUKf/vfToAgnI/bI7hDWfTWfhxBk06YKhqrMekpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9UJUjU3qrxIBg7uUkGgiJRyM3tIoImsPaBaU6CfqzHnz3obYg8pskuAiI4ZbWWw5
         AGjBRThWSeawlqQGAUz8cCLjcmgYEIWmO/92w30NUKt60GaQNsQh0JpFN9YPnSh6Y2
         1RyZLpKaNQAE3ZcCDA5+bYN6an2K2GPqd7BoE3qWP6bHrLfenLrHEkHNjlXqzT28PU
         4aACq+U34GVdjaSs0RATNUSnRiOEY4omYbHhgd61XFofH6ZYekvgJzaOmf5z8NCpZC
         46kLmaJP6FA79KfizeMEuICrTY2QThx5w3nNLuyeQkllsrjNtNVsK+wvkfCehuDtDX
         TJiRI+xW1EMyw==
Date:   Tue, 26 Oct 2021 08:48:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        ira.weiny@intel.com, linux-xfs@vger.kernel.org,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        Vivek Goyal <vgoyal@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [Question] ext4/xfs: Default behavior changed after per-file DAX
Message-ID: <20211026154834.GB24307@magnolia>
References: <26ddaf6d-fea7-ed20-cafb-decd63b2652a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ddaf6d-fea7-ed20-cafb-decd63b2652a@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 10:12:17PM +0800, JeffleXu wrote:
> Hi,
> 
> Recently I'm working on supporting per-file DAX for virtiofs [1]. Vivek
> Goyal and I are interested [2] why the default behavior has changed
> since introduction of per-file DAX on ext4 and xfs [3][4].
> 
> That is, before the introduction of per-file DAX, when user doesn't
> specify '-o dax', DAX is disabled for all files. After supporting
> per-file DAX, when neither '-o dax' nor '-o dax=always|inode|never' is
> specified, it actually works in a '-o dax=inode' way if the underlying
> blkdev is DAX capable, i.e. depending on the persistent inode flag. That
> is, the default behavior has changed from user's perspective.
> 
> We are not sure if this is intentional or not. Appreciate if anyone
> could offer some hint.

Yes, that was an intentional change to all three filesystems to make the
steps we expose to sysadmins/users consistent and documented officially:

https://lore.kernel.org/linux-fsdevel/20200429043328.411431-1-ira.weiny@intel.com/

(This was the first step; ext* were converted as separate series around
the same time.)

--D

> 
> 
> [1] https://lore.kernel.org/all/YW2Oj4FrIB8do3zX@redhat.com/T/
> [2]
> https://lore.kernel.org/all/YW2Oj4FrIB8do3zX@redhat.com/T/#mf067498887ca2023c64c8b8f6aec879557eb28f8
> [3] 9cb20f94afcd2964944f9468e38da736ee855b19 ("fs/ext4: Make DAX mount
> option a tri-state")
> [4] 02beb2686ff964884756c581d513e103542dcc6a ("fs/xfs: Make DAX mount
> option a tri-state")
> 
> 
> -- 
> Thanks,
> Jeffle
