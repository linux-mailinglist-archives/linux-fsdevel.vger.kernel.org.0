Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EB93624AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 17:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbhDPPzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 11:55:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:39412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238123AbhDPPzY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:55:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6BDBB178;
        Fri, 16 Apr 2021 15:54:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C6E29DA790; Fri, 16 Apr 2021 17:52:41 +0200 (CEST)
Date:   Fri, 16 Apr 2021 17:52:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/3] blkid: add magic and probing for zoned btrfs
Message-ID: <20210416155241.GY7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
 <20210414013339.2936229-3-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414013339.2936229-3-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:33:38AM +0900, Naohiro Aota wrote:
> It also supports temporary magic ("!BHRfS_M") in zone #0. The mkfs.btrfs
> first writes the temporary superblock to the zone during the mkfs process.
> It will survive there until the zones are filled up and reset. So, we also
> need to detect this temporary magic.

> +	  /*
> +	   * For zoned btrfs, we also need to detect a temporary superblock
> +	   * at zone #0. Mkfs.btrfs creates it in the initialize process.
> +	   * It persits until both zones are filled up then reset.
> +	   */
> +	  { .magic = "!BHRfS_M", .len = 8, .sboff = 0x40,
> +	    .is_zoned = 1, .zonenum = 0, .kboff_inzone = 0 },

Should we rather reset the zone twice so the initial superblock does not
have the temporary signature?

For the primary superblock at offset 64K and as a fallback the signature
should be valid for detection purposes (ie. not necessarily to get the
latest superblock).
