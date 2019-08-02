Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D137F503
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 12:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389480AbfHBK2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 06:28:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:56750 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730941AbfHBK2a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:28:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55B5CAE03;
        Fri,  2 Aug 2019 10:28:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 460861E3F4D; Fri,  2 Aug 2019 12:28:27 +0200 (CEST)
Date:   Fri, 2 Aug 2019 12:28:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Roald Strauss <mr_lou@dewfall.dk>,
        "Steven J. Magnani" <steve.magnani@digidescorp.com>,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: UDF filesystem image with Write-Once UDF Access Type
Message-ID: <20190802102827.GI25064@quack2.suse.cz>
References: <20190712100224.s2chparxszlbnill@pali>
 <20190801073530.GA25064@quack2.suse.cz>
 <20190801083800.GC25064@quack2.suse.cz>
 <20190801085755.amohgsxdcmzf2nzc@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190801085755.amohgsxdcmzf2nzc@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-08-19 10:57:55, Pali Rohár wrote:
> On Thursday 01 August 2019 10:38:00 Jan Kara wrote:
> > Hum, looks like a problem with mkudffs. Relevant debug messages look like:
> > 
> > UDF-fs: fs/udf/super.c:671:udf_check_vsd: Starting at sector 16 (2048 byte sectors)
> > UDF-fs: fs/udf/super.c:824:udf_load_pvoldesc: recording time 2019/08/01 09:47 (1078)
> > UDF-fs: fs/udf/super.c:836:udf_load_pvoldesc: volIdent[] = 'LinuxUDF'
> > UDF-fs: fs/udf/super.c:844:udf_load_pvoldesc: volSetIdent[] = '1564645645200563LinuxUDF'
> > UDF-fs: fs/udf/super.c:1462:udf_load_logicalvol: Partition (0:0) type 1 on volume 1
> > UDF-fs: fs/udf/super.c:1462:udf_load_logicalvol: Partition (1:0) type 2 on volume 1
> > UDF-fs: fs/udf/super.c:1471:udf_load_logicalvol: FileSet found in LogicalVolDesc at block=0, partition=1
> > UDF-fs: fs/udf/super.c:1218:udf_load_partdesc: Searching map: (0 == 0)
> > UDF-fs: fs/udf/super.c:1060:udf_fill_partdesc_info: Partition (0 type 1511) starts at physical 288, block length 524000
> > UDF-fs: fs/udf/super.c:1060:udf_fill_partdesc_info: Partition (1 type 2012) starts at physical 288, block length 524000
> > UDF-fs: fs/udf/misc.c:223:udf_read_tagged: location mismatch block 524287, tag 0 != 523999
> > UDF-fs: error (device ubdb): udf_read_inode: (ino 524287) failed !bh
> > 
> > So the fact that location tag was 0 in block 524287 (which should contain
> > VAT inode) suggests there's something fishy with how / where mkudffs
> > creates the VAT inode. Can you have a look?
> > 
> > BTW, mkudffs messages look like:
> > filename=/tmp/image
> > label=LinuxUDF
> > uuid=1564645645200563
> > blocksize=2048
> > blocks=524288
> > udfrev=2.01
> > vatblock=319
> > start=0, blocks=16, type=RESERVED 
> > start=16, blocks=4, type=VRS 
> > start=20, blocks=76, type=USPACE 
> > start=96, blocks=16, type=MVDS 
> > start=112, blocks=16, type=USPACE 
> > start=128, blocks=1, type=LVID 
> > start=129, blocks=95, type=USPACE 
> > start=224, blocks=16, type=RVDS 
> > start=240, blocks=16, type=USPACE 
> > start=256, blocks=1, type=ANCHOR 
> > start=257, blocks=31, type=USPACE 
> > start=288, blocks=524000, type=PSPACE 
> > 
> > which suggests that VAT was indeed allocated somewhere in the beginning of
> > the partition.
> 
> For write-once media you are not able to modify size of UDF partition.
> So if you are creating image for CD-R disc, you need to specify size of
> UDF filesystem to match size of CD-R disc. VAT is always burned to the
> last block of current track on CD-R.
> 
> Therefore if you had pre-allocated big image file for CD-R and then you
> run mkudffs for cdr on it, you lost information what is the last used
> block on that cdr image. Normally for optical drivers kernel use mmc
> commands to retrieve last block of current session and based on it find
> VAT. But image files loaded via /dev/loop are not optical drivers and
> therefore do not have ability "hardware" ability to ask where is the
> last used block. IIRC in this case kernel just fallback to the last
> block of block device for VAT, which in this case is not correct.
> 
> What should help is to truncate image file to "correct" size after
> running mkudffs with --media-type=cdr. Maybe mkudffs itself should do it
> when was asked to create UDF filesystem for CD-R on existing image file.

Ah, right. Thanks for explanation. I somehow assumed that mkudffs will be
considering the last block of the "device file" the last block that it has
to record but you're right that on second though that doesn't really make
sense.
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
