Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9431C6404
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 00:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbgEEWhI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 18:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbgEEWhH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 18:37:07 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2528206FA;
        Tue,  5 May 2020 22:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588718227;
        bh=UdZ1HFCFDP6+pG52oE+2tMcVpq+n7qYIuAWKP/UAw+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLLQrHiyI6r0PMHl+ZFLUZAEoPzJUouVkuj6gki9wWdNwifcCIdwPFxii+KxDnIE4
         pbKNiv4zO9kxTZ4u8ROfqZ9s9ntdBf+laCTtT+uyEaxLIOuxPcvCQYylB871xYiiLn
         DASjzcAYFN4HWHVb7c7pCp/BBoL278fHTHCVnsas=
Date:   Tue, 5 May 2020 15:37:05 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Message-ID: <20200505223705.GD128280@sol.localdomain>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <20200501053908.GC1003@sol.localdomain>
 <SN4PR0401MB3598198E5FB728B68B39A1589BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200504205935.GA51650@gmail.com>
 <SN4PR0401MB359843476634082E8329168A9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB359843476634082E8329168A9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 08:11:56AM +0000, Johannes Thumshirn wrote:
> On 04/05/2020 22:59, Eric Biggers wrote:
> [...]
> 
> > But your proposed design doesn't do this completely, since some times of offline
> > modifications are still possible.
> > 
> > So that's why I'm asking *exactly* what security properties it will provide.
> 
> [...]
> 
> > Does this mean that a parent node's checksum doesn't cover the checksum of its
> > child nodes, but rather only their locations?  Doesn't that allow subtrees to be
> > swapped around without being detected?
> 
> I was about to say "no you can't swap the subtrees as the header also 
> stores the address of the block", but please give me some more time to 
> think about it. I don't want to give a wrong answer.
> 
> [...]
> 
> > Actually, nothing in the current design prevents the whole filesystem from being
> > rolled back to an earlier state.  So, an attacker can actually both "change the
> > structure of the filesystem" and "roll back to an earlier state".
> 
> Can you give an example how an attacker could do a rollback of the whole 
> filesystem without the key? What am I missing?
> 

They replace the current content of the block device with the content at an
earlier time.

- Eric
