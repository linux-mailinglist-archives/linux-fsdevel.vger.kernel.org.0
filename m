Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46754E37E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439851AbfJXQ3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 12:29:05 -0400
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:39174 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405586AbfJXQ3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:29:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 294A88384363;
        Thu, 24 Oct 2019 16:29:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:4321:5007:8957:10004:10400:11026:11232:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:21810:30012:30054:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: slip23_4ee4cce0ad431
X-Filterd-Recvd-Size: 1839
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 24 Oct 2019 16:29:02 +0000 (UTC)
Message-ID: <5c7a7fe972469296d367dba504f0b6c8063a7d55.camel@perches.com>
Subject: Re: [PATCH 15/15] staging: exfat: Clean up return codes -
 FFS_SUCCESS
From:   Joe Perches <joe@perches.com>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Oct 2019 09:29:00 -0700
In-Reply-To: <20191024155327.1095907-16-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
         <20191024155327.1095907-16-Valdis.Kletnieks@vt.edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2019-10-24 at 11:53 -0400, Valdis Kletnieks wrote:
> Just replace FFS_SUCCESS with a literal 0.

[]

> diff --git a/drivers/staging/exfat/exfat_cache.c b/drivers/staging/exfat/exfat_cache.c
[]
> @@ -214,7 +214,7 @@ static u8 *FAT_getblk(struct super_block *sb, sector_t sec)
>  
>  	FAT_cache_insert_hash(sb, bp);
>  
> -	if (sector_read(sb, sec, &bp->buf_bh, 1) != FFS_SUCCESS) {
> +	if (sector_read(sb, sec, &bp->buf_bh, 1) != 0) {

Probably nicer to just drop the != 0

> diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
[]
> @@ -768,13 +768,13 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
>  
>  		if ((offset == 0) && (oneblkread == p_bd->sector_size)) {
>  			if (sector_read(sb, LogSector, &tmp_bh, 1) !=
> -			    FFS_SUCCESS)
> +			    0)

especially for these split line tests


