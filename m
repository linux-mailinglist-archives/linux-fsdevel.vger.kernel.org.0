Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C8B30B4D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 02:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBBBso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 20:48:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhBBBsn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:48:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07A6A64E92;
        Tue,  2 Feb 2021 01:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612230483;
        bh=hdTZZ+CrwqEkg3W5j8UkFRDDjf3qMrGRiVjorKoXwAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GR/R8UVlpEEal8KvIiWojfsScHvh7t+SGtXBzlEZ6naDkbWLfcqZf7Fz+CajyZmgU
         EvVwatv/hPXz/BCyjfVZ7tusS6XTNjJVK0ESNfgL+EIv5RcQhExhvB6Tv7HDxVLbyo
         K3dmXhxzgk3Wkf08ivxKvUnVWANGu9ypRCA6ITBHKtLtb7PyAqNX2inAHcjR1smIS3
         X20HQJe69p3hScEHCqjcVN8Ymn5TEcePg9YsT2ja5S0rDVNqCYzWJv20xl++WK5io4
         U15q57Vr7pLVM4svDHZlH7m1oSy5saBaaoQ4EkgvDjzTHu/LV9qUgW+cpNAdw7N+2h
         OGjRCvowHIAEg==
Date:   Mon, 1 Feb 2021 17:48:02 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amy Parker <enbyamy@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Using bit shifts for VXFS file modes
Message-ID: <20210202014802.GB7187@magnolia>
References: <CAE1WUT63RUz0r2LaJZ7hvayzfLadEdsZjymg8UYU481de+6wLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE1WUT63RUz0r2LaJZ7hvayzfLadEdsZjymg8UYU481de+6wLA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 01, 2021 at 03:49:20PM -0800, Amy Parker wrote:
> Hello filesystem developers!
> 
> I was scouting through the FreeVXFS code, when I came across this in
> fs/freevxfs/vxfs.h:
> 
> enum vxfs_mode {
>         VXFS_ISUID = 0x00000800, /* setuid */
>         VXFS_ISGID = 0x00000400, /* setgid */
>         VXFS_ISVTX = 0x00000200, /* sticky bit */
>         VXFS_IREAD = 0x00000100, /* read */
>         VXFS_IWRITE = 0x00000080, /* write */
>         VXFS_IEXEC = 0x00000040, /* exec */
> 
> Especially in an expanded form like this, these are ugly to read, and
> a pain to work with.

I would personally just change those to use the constants in
include/uapi/linux/stat.h.  They're userspace ABI and I don't think
anyone's going to come up with a good reason to change the numbering
after nearly 50 years.

That said, on the general principle of "anything you touch you get to
QA" I would leave it alone.

--D

> 
> An example of potentially a better method, from fs/dax.c:
> 
> #define DAX_SHIFT (4)
> #define DAX_LOCKED (1UL << 0)
> #define DAX_PMD (1UL << 1)
> #define DAX_ZERO_PAGE (1UL << 2)
> #define DAX_EMPTY (1UL << 3)
> 
> Pardon the space condensation - my email client is not functioning properly.
> 
> Anyways, I believe using bit shifts to represent different file modes
> would be a much better idea - no runtime penalty as they get
> calculated into constants at compile time, and significantly easier
> for the average user to read.
> 
> Any thoughts on this?
> 
> Best regards,
> Amy Parker
> (she/her/hers)
