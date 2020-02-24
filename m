Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E06169C64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 03:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgBXCuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 21:50:09 -0500
Received: from smtprelay0043.hostedemail.com ([216.40.44.43]:39519 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727156AbgBXCuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:50:09 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2D36A1802926E;
        Mon, 24 Feb 2020 02:50:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:355:379:599:960:966:968:973:981:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1605:1730:1747:1777:1792:1801:2196:2197:2199:2200:2393:2553:2559:2562:2693:2828:2897:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4049:4118:4321:4385:4605:5007:6117:6119:7903:7904:8603:8660:9121:10004:10848:11026:11232:11233:11657:11658:11914:12297:12555:12740:12760:12895:12986:13148:13230:13439:14096:14097:14659:21067:21080:21221:21433:21451:21611:21627:21939:21972:21990:30012:30051:30054:30079:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: rest88_5836b87657e27
X-Filterd-Recvd-Size: 7800
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Feb 2020 02:50:06 +0000 (UTC)
Message-ID: <dc93d5299169a33e00fc35a4c5f29ea72764bce0.camel@perches.com>
Subject: Re: [PATCH v3] proc: faster open/read/close with "permanent" files
From:   Joe Perches <joe@perches.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Sun, 23 Feb 2020 18:48:38 -0800
In-Reply-To: <20200223113024.GA4941@avx2>
References: <20200222201539.GA22576@avx2>
         <7c30fd26941948fa1aedd1e73bdc2ebb8efec477.camel@perches.com>
         <20200223113024.GA4941@avx2>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2020-02-23 at 14:30 +0300, Alexey Dobriyan wrote:
> On Sat, Feb 22, 2020 at 12:39:39PM -0800, Joe Perches wrote:
> > On Sat, 2020-02-22 at 23:15 +0300, Alexey Dobriyan wrote:
> > > Now that "struct proc_ops" exist we can start putting there stuff which
> > > could not fly with VFS "struct file_operations"...
> > > 
> > > Most of fs/proc/inode.c file is dedicated to make open/read/.../close reliable
> > > in the event of disappearing /proc entries which usually happens if module is
> > > getting removed. Files like /proc/cpuinfo which never disappear simply do not
> > > need such protection.
> > > 
> > > Save 2 atomic ops, 1 allocation, 1 free per open/read/close sequence for such
> > > "permanent" files.
> > > 
> > > Enable "permanent" flag for
> > > 
> > > 	/proc/cpuinfo
> > > 	/proc/kmsg
> > > 	/proc/modules
> > > 	/proc/slabinfo
> > > 	/proc/stat
> > > 	/proc/sysvipc/*
> > > 	/proc/swaps
> > > 
> > > More will come once I figure out foolproof way to prevent out module
> > > authors from marking their stuff "permanent" for performance reasons
> > > when it is not.
> > > 
> > > This should help with scalability: benchmark is "read /proc/cpuinfo R times
> > > by N threads scattered over the system".
> > 
> > Is this an actual expected use-case?
> 
> Yes.
> 
> > Is there some additional unnecessary memory consumption
> > in the unscaled systems?
> 
> No, it's the opposite. Less memory usage for everyone and noticeable
> performance improvement for contented case.
> 
> > >  static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> > >  {
> > >  	struct proc_dir_entry *pde = PDE(file_inode(file));
> > >  	ssize_t rv = -EIO;
> > > -	if (use_pde(pde)) {
> > > -		typeof_member(struct proc_ops, proc_read) read;
> > >  
> > > -		read = pde->proc_ops->proc_read;
> > > -		if (read)
> > > -			rv = read(file, buf, count, ppos);
> > > +	if (pde_is_permanent(pde)) {
> > > +		return pde_read(pde, file, buf, count, ppos);
> > > +	} else if (use_pde(pde)) {
> > > +		rv = pde_read(pde, file, buf, count, ppos);
> > >  		unuse_pde(pde);
> > 
> > Perhaps all the function call duplication could be minimized
> > by using code without direct returns like:
> > 
> > 	rv = pde_read(pde, file, buf, count, pos);
> > 	if (!pde_is_permanent(pde))
> > 		unuse_pde(pde);
> > 
> > 	return rv;
> 
> Function call non-duplication is false goal.

Depends, copy/paste errors are common and object code
size generally increases.

> Surprisingly it makes code bigger:

Not so far as I can tell.  Are you sure?

> 	$ ./scripts/bloat-o-meter ../vmlinux-000 ../obj/vmlinux
> 	add/remove: 0/0 grow/shrink: 1/0 up/down: 10/0 (10)
> 	Function                                     old     new   delta
> 	proc_reg_read                                108     118     +10
> 
> and worse too: "rv" is carried on stack through "unuse_pde" call.

With gcc 9.2.1 x86-64 defconfig:

Changing just proc_reg_read to:

static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
{
	struct proc_dir_entry *pde = PDE(file_inode(file));
	ssize_t rv;

	rv = pde_read(pde, file, buf, count, ppos);
	if (use_pde(pde))
		unuse_pde(pde);

	return rv;
}

gives:

$ size fs/proc/inode.o*
   text	   data	    bss	    dec	    hex	filename
   5448	     28	      0	   5476	   1564	fs/proc/inode.o.suggested
   5526	     28	      0	   5554	   15b2	fs/proc/inode.o.alexey

$ objdump -d fs/proc/inode.o.suggested (grep for proc_reg_read)
0000000000000410 <proc_reg_read>:
 410:	41 54                	push   %r12
 412:	55                   	push   %rbp
 413:	48 8b 47 20          	mov    0x20(%rdi),%rax
 417:	48 8b 68 d0          	mov    -0x30(%rax),%rbp
 41b:	48 8b 45 30          	mov    0x30(%rbp),%rax
 41f:	48 8b 40 10          	mov    0x10(%rax),%rax
 423:	48 85 c0             	test   %rax,%rax
 426:	74 28                	je     450 <proc_reg_read+0x40>
 428:	e8 00 00 00 00       	callq  42d <proc_reg_read+0x1d>
 42d:	49 89 c4             	mov    %rax,%r12
 430:	8b 45 00             	mov    0x0(%rbp),%eax
 433:	85 c0                	test   %eax,%eax
 435:	78 12                	js     449 <proc_reg_read+0x39>
 437:	8d 50 01             	lea    0x1(%rax),%edx
 43a:	f0 0f b1 55 00       	lock cmpxchg %edx,0x0(%rbp)
 43f:	75 f2                	jne    433 <proc_reg_read+0x23>
 441:	48 89 ef             	mov    %rbp,%rdi
 444:	e8 e7 fc ff ff       	callq  130 <unuse_pde>
 449:	4c 89 e0             	mov    %r12,%rax
 44c:	5d                   	pop    %rbp
 44d:	41 5c                	pop    %r12
 44f:	c3                   	retq   
 450:	49 c7 c4 fb ff ff ff 	mov    $0xfffffffffffffffb,%r12
 457:	eb d7                	jmp    430 <proc_reg_read+0x20>
 459:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

vs
 
$ objdump -d fs/proc/inode.o.alexey (grep for proc_reg_read)

00000000000006e0 <proc_reg_read>:
 6e0:	41 54                	push   %r12
 6e2:	55                   	push   %rbp
 6e3:	48 8b 47 20          	mov    0x20(%rdi),%rax
 6e7:	48 8b 68 d0          	mov    -0x30(%rax),%rbp
 6eb:	f6 85 aa 00 00 00 01 	testb  $0x1,0xaa(%rbp)
 6f2:	74 15                	je     709 <proc_reg_read+0x29>
 6f4:	48 8b 45 30          	mov    0x30(%rbp),%rax
 6f8:	48 8b 40 10          	mov    0x10(%rax),%rax
 6fc:	48 85 c0             	test   %rax,%rax
 6ff:	74 3f                	je     740 <proc_reg_read+0x60>
 701:	5d                   	pop    %rbp
 702:	41 5c                	pop    %r12
 704:	e9 00 00 00 00       	jmpq   709 <proc_reg_read+0x29>
 709:	8b 45 00             	mov    0x0(%rbp),%eax
 70c:	85 c0                	test   %eax,%eax
 70e:	78 30                	js     740 <proc_reg_read+0x60>
 710:	44 8d 40 01          	lea    0x1(%rax),%r8d
 714:	f0 44 0f b1 45 00    	lock cmpxchg %r8d,0x0(%rbp)
 71a:	75 f0                	jne    70c <proc_reg_read+0x2c>
 71c:	48 8b 45 30          	mov    0x30(%rbp),%rax
 720:	48 8b 40 10          	mov    0x10(%rax),%rax
 724:	48 85 c0             	test   %rax,%rax
 727:	74 20                	je     749 <proc_reg_read+0x69>
 729:	e8 00 00 00 00       	callq  72e <proc_reg_read+0x4e>
 72e:	49 89 c4             	mov    %rax,%r12
 731:	48 89 ef             	mov    %rbp,%rdi
 734:	e8 f7 f9 ff ff       	callq  130 <unuse_pde>
 739:	4c 89 e0             	mov    %r12,%rax
 73c:	5d                   	pop    %rbp
 73d:	41 5c                	pop    %r12
 73f:	c3                   	retq   
 740:	49 c7 c4 fb ff ff ff 	mov    $0xfffffffffffffffb,%r12
 747:	eb f0                	jmp    739 <proc_reg_read+0x59>
 749:	49 c7 c4 fb ff ff ff 	mov    $0xfffffffffffffffb,%r12
 750:	eb df                	jmp    731 <proc_reg_read+0x51>
 752:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
 759:	00 00 00 00 
 75d:	0f 1f 00             	nopl   (%rax)


