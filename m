Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7A251691C7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 21:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgBVUlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 15:41:08 -0500
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:51505 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgBVUlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 15:41:08 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6D94A4995F1;
        Sat, 22 Feb 2020 20:41:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:966:968:973:981:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2693:2828:2897:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:4385:5007:6117:6119:7903:7904:8660:10004:10400:10848:11026:11232:11657:11658:11914:12297:12740:12760:12895:13148:13230:13439:14096:14097:14659:14721:21080:21451:21611:21627:21972:21990:30012:30051:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bead20_98bab56d3062
X-Filterd-Recvd-Size: 3025
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat, 22 Feb 2020 20:41:05 +0000 (UTC)
Message-ID: <7c30fd26941948fa1aedd1e73bdc2ebb8efec477.camel@perches.com>
Subject: Re: [PATCH v3] proc: faster open/read/close with "permanent" files
From:   Joe Perches <joe@perches.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Sat, 22 Feb 2020 12:39:39 -0800
In-Reply-To: <20200222201539.GA22576@avx2>
References: <20200222201539.GA22576@avx2>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-02-22 at 23:15 +0300, Alexey Dobriyan wrote:
> Now that "struct proc_ops" exist we can start putting there stuff which
> could not fly with VFS "struct file_operations"...
> 
> Most of fs/proc/inode.c file is dedicated to make open/read/.../close reliable
> in the event of disappearing /proc entries which usually happens if module is
> getting removed. Files like /proc/cpuinfo which never disappear simply do not
> need such protection.
> 
> Save 2 atomic ops, 1 allocation, 1 free per open/read/close sequence for such
> "permanent" files.
> 
> Enable "permanent" flag for
> 
> 	/proc/cpuinfo
> 	/proc/kmsg
> 	/proc/modules
> 	/proc/slabinfo
> 	/proc/stat
> 	/proc/sysvipc/*
> 	/proc/swaps
> 
> More will come once I figure out foolproof way to prevent out module
> authors from marking their stuff "permanent" for performance reasons
> when it is not.
> 
> This should help with scalability: benchmark is "read /proc/cpuinfo R times
> by N threads scattered over the system".

Is this an actual expected use-case?
Is there some additional unnecessary memory consumption
in the unscaled systems?

And trivia:

>  static loff_t proc_reg_llseek(struct file *file, loff_t offset, int whence)
>  {
[]
> +	if (pde_is_permanent(pde)) {
> +		return pde_lseek(pde, file, offset, whence);
> +	} else if (use_pde(pde)) {
> +		rv = pde_lseek(pde, file, offset, whence);
>  		unuse_pde(pde);
>  	}
>  	return rv;
>  }
[]
>  static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  {
>  	struct proc_dir_entry *pde = PDE(file_inode(file));
>  	ssize_t rv = -EIO;
> -	if (use_pde(pde)) {
> -		typeof_member(struct proc_ops, proc_read) read;
>  
> -		read = pde->proc_ops->proc_read;
> -		if (read)
> -			rv = read(file, buf, count, ppos);
> +	if (pde_is_permanent(pde)) {
> +		return pde_read(pde, file, buf, count, ppos);
> +	} else if (use_pde(pde)) {
> +		rv = pde_read(pde, file, buf, count, ppos);
>  		unuse_pde(pde);

Perhaps all the function call duplication could be minimized
by using code without direct returns like:

	rv = pde_read(pde, file, buf, count, pos);
	if (!pde_is_permanent(pde))
		unuse_pde(pde);

	return rv;


