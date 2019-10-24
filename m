Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5094E37C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 18:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439819AbfJXQXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 12:23:37 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:49034 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733261AbfJXQXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:23:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id AD6DC182CF665;
        Thu, 24 Oct 2019 16:23:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3867:3868:4321:5007:8957:10004:10400:11232:11658:11914:12043:12296:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:14721:21080:21433:21627:21810:21939:30012:30054:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: shade65_1f39141a68414
X-Filterd-Recvd-Size: 1838
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 24 Oct 2019 16:23:34 +0000 (UTC)
Message-ID: <915cd2a3ee58222b63c14f9f1819a0aa0b379a4f.camel@perches.com>
Subject: Re: [PATCH 04/15] staging: exfat: Clean up return codes -
 FFS_PERMISSIONERR
From:   Joe Perches <joe@perches.com>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Oct 2019 09:23:33 -0700
In-Reply-To: <20191024155327.1095907-5-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
         <20191024155327.1095907-5-Valdis.Kletnieks@vt.edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2019-10-24 at 11:53 -0400, Valdis Kletnieks wrote:
> Convert FFS_PERMISSIONERR to -EPERM
[]
> diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
[]
> @@ -2526,7 +2526,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
>  
>  	err = ffsRemoveFile(dir, &(EXFAT_I(inode)->fid));
>  	if (err) {
> -		if (err == FFS_PERMISSIONERR)
> +		if (err == -EPERM)
>  			err = -EPERM;
>  		else
>  			err = -EIO;
[]
> @@ -2746,7 +2746,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	err = ffsMoveFile(old_dir, &(EXFAT_I(old_inode)->fid), new_dir,
>  			  new_dentry);
>  	if (err) {
> -		if (err == FFS_PERMISSIONERR)
> +		if (err == -EPERM)
>  			err = -EPERM;
>  		else if (err == FFS_INVALIDPATH)
>  			err = -EINVAL;

These test and assign to same value blocks look kinda silly.


