Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905601C63D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 00:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgEEWUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 18:20:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:47106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgEEWUQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 18:20:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 24BDEAEC8;
        Tue,  5 May 2020 22:20:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 70BCDDA7AD; Wed,  6 May 2020 00:19:27 +0200 (CEST)
Date:   Wed, 6 May 2020 00:19:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Message-ID: <20200505221927.GX18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
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
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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

Note that block addresses are of two types, the physical and logical.
The metadata blocks use the logical one, so the block can be moved to
another location still maintaining the authenticated checksum, but then
the physical address will not match. And the physical<->logical mapping
is stored as metadata item, thus in the metadata blocks protected by the
authenticated checksum.
