Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7C41C6453
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 01:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgEEXRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 19:17:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:59332 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgEEXRH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 19:17:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CA3E2AC84;
        Tue,  5 May 2020 23:17:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DABA6DA7AD; Wed,  6 May 2020 01:16:17 +0200 (CEST)
Date:   Wed, 6 May 2020 01:16:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 0/2] Add file-system authentication to BTRFS
Message-ID: <20200505231617.GD18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Eric Biggers <ebiggers@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200501060336.GD1003@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501060336.GD1003@sol.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:03:36PM -0700, Eric Biggers wrote:
> On Tue, Apr 28, 2020 at 12:58:57PM +0200, Johannes Thumshirn wrote:
> > There was interest in also using a HMAC version of Blake2b from the community,
> > but as none of the crypto libraries used by user-space BTRFS tools as a
> > backend does currently implement a HMAC version with Blake2b, it is not (yet)
> > included.
> 
> Note that BLAKE2b optionally takes a key, so using HMAC with it is unnecessary.
> 
> And the kernel crypto API's implementation of BLAKE2b already supports this.
> I.e. you can call crypto_shash_setkey() directly on "blake2b-256".

The idea behind using HMAC + checksum and not the built-in blake2b keyed
hash was to make the definitions unified and use the established crypto
primitives without algorithm-specific tweaks.

But you're right that using "blake2b-256" + setkey achieves the same, I
haven't realized that.
