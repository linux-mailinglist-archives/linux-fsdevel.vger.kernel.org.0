Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E45B1E4007
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 13:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgE0L2Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 07:28:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:52592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728568AbgE0L2Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 07:28:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 78A6EAE17;
        Wed, 27 May 2020 11:28:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D5E36DA72D; Wed, 27 May 2020 13:27:25 +0200 (CEST)
Date:   Wed, 27 May 2020 13:27:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 0/3] Add file-system authentication to BTRFS
Message-ID: <20200527112725.GA18421@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <jth@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200514092415.5389-1-jth@kernel.org>
 <5663c6ca-87d4-8a98-3338-e9a077f4c82f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5663c6ca-87d4-8a98-3338-e9a077f4c82f@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 27, 2020 at 10:08:06AM +0800, Qu Wenruo wrote:
> > Changes since v2:
> > - Select CONFIG_CRYPTO_HMAC and CONFIG_KEYS (kbuild robot)
> > - Fix double free in error path
> > - Fix memory leak in error path
> > - Disallow nodatasum and nodatacow when authetication is use (Eric)
> 
> Since we're disabling NODATACOW usages, can we also disable the
> following features?
> - v1 space cache
>   V1 space cache uses NODATACOW file to store space cache, althouhg it
>   has inline csum, but it's fixed to crc32c. So attacker can easily
>   utilize this hole to mess space cache, and do some DoS attack.

That's a good point.

The v1 space cache will be phased out but it won't be in a timeframe
we'll get in the authentication. At this point we don't even have a way
to select v2 at mkfs time (it's work in progress though), so it would be
required to switch to v2 on the first mount.

> - fallocate
>   I'm not 100% sure about this, but since nodatacow is already a second
>   class citizen in btrfs, maybe not supporting fallocate is not a
>   strange move.

Fallocate is a standard file operation, not supporting would be quite
strange. What's the problem with fallocate and authentication?
