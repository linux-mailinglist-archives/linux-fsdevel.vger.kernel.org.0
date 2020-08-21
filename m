Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2340324E0C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 21:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHUTjM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 15:39:12 -0400
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:52098 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725831AbgHUTjL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:39:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 5763C8384365;
        Fri, 21 Aug 2020 19:39:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:2903:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:4419:4605:5007:6117:6119:7875:7903:10004:10128:10400:10848:11026:11232:11473:11658:11914:12043:12048:12295:12296:12297:12740:12760:12895:13161:13229:13439:14181:14659:14721:21080:21433:21627:21990:30012:30029:30054:30070:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: rod43_3d0fd782703b
X-Filterd-Recvd-Size: 3830
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 19:39:08 +0000 (UTC)
Message-ID: <1ad67130d11ae089fbc46fd373e1e019e1de06f8.camel@perches.com>
Subject: Re: [PATCH v2 02/10] fs/ntfs3: Add initialization of super block
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Date:   Fri, 21 Aug 2020 12:39:06 -0700
In-Reply-To: <caddbe41eaef4622aab8bac24934eed1@paragon-software.com>
References: <caddbe41eaef4622aab8bac24934eed1@paragon-software.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-08-21 at 16:25 +0000, Konstantin Komarov wrote:
> Initialization of super block for fs/ntfs3
[]
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
[]
> +
> +/**
> + * ntfs_trace() - print preformated ntfs specific messages.
> + */
> +void __ntfs_trace(const struct super_block *sb, const char *level,
> +		  const char *fmt, ...)

This is a printk mechanism.

I suggest renaming this __ntfs_trace function to ntfs_printk
as there is a naming expectation conflict with the tracing
subsystem.

> +{
> +	struct va_format vaf;
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	vaf.fmt = fmt;
> +	vaf.va = &args;
> +	if (!sb)
> +		printk("%sntfs3: %pV", level, &vaf);
> +	else
> +		printk("%sntfs3: %s: %pV", level, sb->s_id, &vaf);
> +	va_end(args);
> +}

Also it would be rather smaller overall object code to
change the macros and uses to embed the KERN_<LEVEL> into
the format and remove the const char *level argument.

Use printk_get_level to retrieve the level from the format.

see fs/f2fs/super.c for an example.

This could be something like the below with a '\n' addition
to the format string to ensure that messages are properly
terminated and cannot be interleaved by other subsystems
content that might be in another simultaneously running
thread starting with KERN_CONT.

void ntfs_printk(const struct super_block *sb, const char *fmt, ...)
{
	struct va_format vaf;
	va_list args;
	int level;

	va_start(args, fmt);

	level = printk_get_level(fmt);
	vaf.fmt = printk_skip_level(fmt);
	vaf.va = &args;
	if (!sb)
		printk("%c%cntfs3: %pV\n",
		       KERN_SOH_ASCII, level, &vaf);
	else
		printk("%c%cntfs3: %s: %pV\n",
		       KERN_SOH_ASCII, level, sbi->sb->s_id, &vaf);

	va_end(args);
}

> +
> +/* prints info about inode using dentry case if */
> +void __ntfs_inode_trace(struct inode *inode, const char *level, const char *fmt,

ntfs_inode_printk

> +			...)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	ntfs_sb_info *sbi = sb->s_fs_info;
> +	struct dentry *dentry;
> +	const char *name = "?";
> +	char buf[48];
> +	va_list args;
> +	struct va_format vaf;
> +
> +	if (!__ratelimit(&sbi->ratelimit))
> +		return;
> +
> +	dentry = d_find_alias(inode);
> +	if (dentry) {
> +		spin_lock(&dentry->d_lock);
> +		name = (const char *)dentry->d_name.name;
> +	} else {
> +		snprintf(buf, sizeof(buf), "r=%lx", inode->i_ino);
> +		name = buf;
> +	}
> +
> +	va_start(args, fmt);
> +	vaf.fmt = fmt;
> +	vaf.va = &args;
> +	printk("%s%s on %s: %pV", level, name, sb->s_id, &vaf);
> +	va_end(args);
> +
> +	if (dentry) {
> +		spin_unlock(&dentry->d_lock);
> +		dput(dentry);
> +	}
> +}

Remove level and use printk_get_level as above.
Format string should use '\n' termination here too.


