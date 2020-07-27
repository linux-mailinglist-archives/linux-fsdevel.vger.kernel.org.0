Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D81722F5C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgG0QuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbgG0QuC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:50:02 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF3072075A;
        Mon, 27 Jul 2020 16:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595868602;
        bh=22XFLIm9G+RbCnMxSWD699xCqAJWa1TDuzMcG089LAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jhtp3RJWFY+48yj4sM2R/8F9nVBtUNZeL6wdQkMMwq6Qn9msZ1jhhJldtc/KzwB3r
         oL4hDwrm9HsYibBd2P9mYuo9CUsVJqsx18KaqVYviEWqF5wYXahBpNvyUuS36Wb3Ec
         KcW844ZuH3X238JwAk/fFR+WhlSsK+I24mqDsZEs=
Date:   Mon, 27 Jul 2020 09:50:00 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-nilfs@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nilfs2: only call unlock_new_inode() if I_NEW
Message-ID: <20200727165000.GH1138@sol.localdomain>
References: <20200628070152.820311-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628070152.820311-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 28, 2020 at 12:01:52AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> unlock_new_inode() is only meant to be called after a new inode has
> already been inserted into the hash table.  But nilfs_new_inode() can
> call it even before it has inserted the inode, triggering the WARNING in
> unlock_new_inode().  Fix this by only calling unlock_new_inode() if the
> inode has the I_NEW flag set, indicating that it's in the table.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Ping.  Ryusuke, any interest in taking this patch?

- Eric
