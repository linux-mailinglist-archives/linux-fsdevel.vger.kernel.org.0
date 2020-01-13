Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3243313905E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 12:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgAMLsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 06:48:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:46948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgAMLsm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:48:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A0BA9AEE9;
        Mon, 13 Jan 2020 11:48:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 973E11E0D0E; Mon, 13 Jan 2020 12:48:38 +0100 (CET)
Date:   Mon, 13 Jan 2020 12:48:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Steven J. Magnani" <steve.magnani@digidescorp.com>
Subject: Re: udf: Commit b085fbe2ef7fa (udf: Fix crash during mount) broke
 CD-RW support
Message-ID: <20200113114838.GD23642@quack2.suse.cz>
References: <20200112144735.hj2emsoy4uwsouxz@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200112144735.hj2emsoy4uwsouxz@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Sun 12-01-20 15:47:35, Pali Rohár wrote:
> Commit b085fbe2ef7fa (udf: Fix crash during mount) introduced check that
> UDF disk with PD_ACCESS_TYPE_REWRITABLE access type would not be able to
> mount in R/W mode. This commit was added in Linux 4.20.
> 
> But most tools which generate UDF filesystem for CD-RW set access type
> to rewritable, so above change basically disallow usage of CD-RW discs
> formatted to UDF in R/W mode.
> 
> Linux's cdrwtool and mkudffs (in all released versions), Windows Nero 6,
> NetBSD's newfs_udf -- all these tools uses rewritable access type for
> CD-RW media.
> 
> In UDF 1.50, 2.00 and 2.01 specification there is no information which
> UDF access type should be used for CD-RW medias.
> 
> In UDF 2.60, section 2.2.14.2 is written:
> 
>     A partition with Access Type 3 (rewritable) shall define a Freed
>     Space Bitmap or a Freed Space Table, see 2.3.3. All other partitions
>     shall not define a Freed Space Bitmap or a Freed Space Table.
> 
>     Rewritable partitions are used on media that require some form of
>     preprocessing before re-writing data (for example legacy MO). Such
>     partitions shall use Access Type 3.
> 
>     Overwritable partitions are used on media that do not require
>     preprocessing before overwriting data (for example: CD-RW, DVD-RW,
>     DVD+RW, DVD-RAM, BD-RE, HD DVD-Rewritable). Such partitions shall
>     use Access Type 4.
> 
> And in 6.14.1 (Properties of CD-MRW and DVD+MRW media and drives) is:
> 
>     The Media Type is Overwritable (partition Access Type 4,
>     overwritable)
> 
> Similar info is in UDF 2.50.

Thanks for detailed info. Yes, UDF 2.60 spec is why I've added the check
you mentioned. I was not aware that the phrasing was not there in earlier
versions and frankly even the UDF 2.60 spec is already 15 years old... But
the fact that there are tools creating non-compliant disks certainly
changes the picture :)

> So I think that UDF 2.60 is clear that for CD-RW medias (formatted in
> normal or MRW mode) should be used Overwritable access type. But all
> mentioned tools were probably written prior to existence of UDF 2.60
> specifications, probably targeting only UDF 1.50 versions at that time.
> 
> I checked that they use Unallocated Space Bitmap (and not Freed Space
> Bitmap), so writing to these filesystems should not be a problem.
> 
> How to handle this situation? UDF 2.01 nor 1.50 does not say anything
> for access type on CD-RW and there are already tools which generates UDF
> 1.50 images which does not matches UDF 2.60 requirements.
> 
> I think that the best would be to relax restrictions added in commit
> b085fbe2ef7fa to allow mounting mounting udf fs with rewritable access
> type in R/W mode if Freed Space Bitmap/Table is not used.
> 
> I'm really not sure if existing udf implementations take CD-RW media
> with overwritable media type. E.g. prehistoric wrudf tool refuse to work
> with optical discs which have overwritable access type. I supports only
> UDF 1.50.

Yeah, we should maintain compatibility with older tools where sanely
possible. So I agree with what you propose. Allow writing to
PD_ACCESS_TYPE_REWRITABLE disks if they don't use 'Freed Space
Bitmap/Table'. Will you send a patch or should I do the update?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
