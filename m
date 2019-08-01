Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 248D37D665
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 09:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfHAHfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 03:35:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:58244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbfHAHfd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:35:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF555AF0D;
        Thu,  1 Aug 2019 07:35:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DFF791E3F4D; Thu,  1 Aug 2019 09:35:30 +0200 (CEST)
Date:   Thu, 1 Aug 2019 09:35:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Roald Strauss <mr_lou@dewfall.dk>,
        "Steven J. Magnani" <steve.magnani@digidescorp.com>,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: UDF filesystem image with Write-Once UDF Access Type
Message-ID: <20190801073530.GA25064@quack2.suse.cz>
References: <20190712100224.s2chparxszlbnill@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190712100224.s2chparxszlbnill@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Fri 12-07-19 12:02:24, Pali Rohár  wrote:
> I had discussion with Roald and based on his tests, Linux kernel udf.ko
> driver mounts UDF filesystem image with Write-Once UDF Access Type as
> normal read/write filesystem.
>
> I think this is a bug as Write-Once Access Type is defined that existing
> blocks on filesystem cannot be rewritten. Only new blocks can be
> appended after end of device. Basically it means special HW support from
> underlying media, e.g. for optical medias packet-writing technique (or
> ability to burn new session) and CDROM_LAST_WRITTEN ioctl to locate
> "current" end of device.
> 
> In my opinion without support for additional layer, kernel should treat
> UDF Write-Once Access Type as read-only mount for userspace. And not
> classic read/write mount.
> 
> If you want to play with Write-Once Access Type, use recent version of
> mkudffs and choose --media-type=cdr option, which generates UDF
> filesystem suitable for CD-R (Write-Once Access Type with VAT and other
> UDF options according to UDF specification).

Reasonably recent kernels should have this bug fixed and mount such fs read
only. That being said I've tested current upstream kernel with a media
created with --media-type=cdr and mounting failed with:

UDF-fs: error (device ubdb): udf_read_inode: (ino 524287) failed !bh
UDF-fs: error (device ubdb): udf_read_inode: (ino 524286) failed !bh
UDF-fs: error (device ubdb): udf_read_inode: (ino 524285) failed !bh
UDF-fs: error (device ubdb): udf_read_inode: (ino 524284) failed !bh
UDF-fs: Scanning with blocksize 2048 failed

So there's something fishy either in the created image or the kernel...
Didn't debug this further yet.

> Also in git master of udftools has mkduffs now new option --read-only
> which creates UDF image with Read-Only Access Type.

I've tested this and the kernel properly mounts the image read-only.

> It seems that udf.ko does not support updating VAT table, so probably it
> should treat also filesystem with VAT as read-only too.

This is definitely handled properly and we mount such fs read-only as well.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
