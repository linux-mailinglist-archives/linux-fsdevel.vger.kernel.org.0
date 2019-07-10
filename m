Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2C964B66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 19:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfGJRWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 13:22:41 -0400
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:33968 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726229AbfGJRWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:22:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 16DFE18224D67;
        Wed, 10 Jul 2019 17:22:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:599:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6120:7901:7903:8957:8985:9025:9038:10004:10234:10400:10848:11026:11232:11658:11914:12043:12048:12297:12438:12740:12760:12895:13069:13141:13230:13255:13311:13357:13439:14096:14097:14181:14659:14721:21080:21212:21627:21660:21788:30029:30054:30070:30091,0,RBL:172.56.44.31:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: bite23_338f1fa13e539
X-Filterd-Recvd-Size: 2392
Received: from XPS-9350 (unknown [172.56.44.31])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jul 2019 17:22:33 +0000 (UTC)
Message-ID: <079745c94c232591453dcb01c9d9406b721bb6bf.camel@perches.com>
Subject: Re: [RFC PATCH] fanotify, inotify, dnotify, security: add security
 hook for fs notifications
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, jmorris@namei.org, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org
Date:   Wed, 10 Jul 2019 10:22:03 -0700
In-Reply-To: <6ce2ce60b2435940bc8dfa07fa2553c4524d2db5.camel@perches.com>
References: <20190710133403.855-1-acgoide@tycho.nsa.gov>
         <4fd98c88-61a6-a155-5028-db22a778d3c1@schaufler-ca.com>
         <cb754dda-fbce-8169-4cd7-eef66e8d809e@infradead.org>
         <6ce2ce60b2435940bc8dfa07fa2553c4524d2db5.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-07-10 at 10:18 -0700, Joe Perches wrote:
> On Wed, 2019-07-10 at 09:49 -0700, Randy Dunlap wrote:
> > On 7/10/19 9:38 AM, Casey Schaufler wrote:
> > > On 7/10/2019 6:34 AM, Aaron Goidel wrote:
> > > > @@ -3261,6 +3262,26 @@ static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
> > > >  	return -EACCES;
> > > >  }
> > > >  
> > > > +static int selinux_inode_notify(struct inode *inode, u64 mask)
> > > > +{
> > > > +	u32 perm = FILE__WATCH; // basic permission, can a watch be set?
> > > 
> > > We don't use // comments in the Linux kernel.
> > > 
> > 
> > I thought that we had recently moved into the 21st century on that issue,
> > but I don't see it mentioned in coding-style.rst.  Maybe we need a Doc update.
> > 
> > checkpatch allows C99 comments by default.
> > Joe, do you recall about this?
> 
> My recollection is it was something I thought was
> just simple and useful so I added it to checkpatch
> without going through the negative of the nominal
> approvals required by modifying CodingStyle.

https://lkml.org/lkml/2016/7/8/625


