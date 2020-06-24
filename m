Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6CC206BD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 07:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbgFXFhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 01:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388470AbgFXFhb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:37:31 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC0C82072E;
        Wed, 24 Jun 2020 05:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592977051;
        bh=wb4QukjekILuiNOvt3WtAggRANvs3/DPlF6kk/OZN9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ME2/ILyRl01EO6yDPEjuIw5z41jE6WT0YL/dZxeFp1FPcCqTGoXmWlZASWXMdQg+d
         Gg6ZXHBJaopVsT69BCF292QvgQpMxHWYMvgoHHUbOyO2xDDrO8HZyvDEPplfoZjCZF
         oVsC9NaAewstXOI+yLeiPyQ9MDInXF4S2T12EQBY=
Date:   Tue, 23 Jun 2020 22:37:29 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v9 1/4] unicode: Add utf8_casefold_hash
Message-ID: <20200624053729.GE844@sol.localdomain>
References: <20200624043341.33364-1-drosen@google.com>
 <20200624043341.33364-2-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624043341.33364-2-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:33:38PM -0700, Daniel Rosenberg wrote:
> This adds a case insensitive hash function to allow taking the hash
> without needing to allocate a casefolded copy of the string.

It would be helpful to add a few more details in this commit message.
Somewhat along the lines of: ->d_hash() for casefolding currently allocates
memory, it needs to use GFP_ATOMIC due to ->d_hash() being called in rcu-walk
mode, this is unreliable and inefficient, and this patch allows solving that
problem by removing the need to allocate memory.

- Eric
