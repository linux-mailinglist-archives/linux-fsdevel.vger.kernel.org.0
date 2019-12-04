Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935D31130B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 18:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfLDRWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 12:22:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:47756 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727033AbfLDRWl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:22:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88BF6B11A;
        Wed,  4 Dec 2019 17:22:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 40FE5DA786; Wed,  4 Dec 2019 18:22:34 +0100 (CET)
Date:   Wed, 4 Dec 2019 18:22:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 02/28] btrfs: Get zone information of zoned block
 devices
Message-ID: <20191204172234.GI2734@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>, Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
 <20191204081735.852438-3-naohiro.aota@wdc.com>
 <20191204153732.GA2083@Johanness-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204153732.GA2083@Johanness-MacBook-Pro.local>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 04:37:32PM +0100, Johannes Thumshirn wrote:
> On Wed, Dec 04, 2019 at 05:17:09PM +0900, Naohiro Aota wrote:
> [..]
> 
> > +#define LEN (sizeof(device->fs_info->sb->s_id) + sizeof("(device )") - 1)
> > +	char devstr[LEN];
> > +	const int len = LEN;
> > +#undef LEN
> 
> Why not:
> 	const int len = sizeof(device->fs_info->sb->s_id)
> 					+ sizeof("(device )") - 1;
> 	char devstr[len];

len is used only once for snprintf to devstr, so there it can be
replaced by sizeof(devstr) and the sizeof()+sizeof() can be used for
devstr declaration.

The size of devstr seems to be one byte shorter than needed:

> > +		snprintf(devstr, len, " (device %s)",
> > +			 device->fs_info->sb->s_id);

There's a leading " " at the begining that I don't see accounted for.
