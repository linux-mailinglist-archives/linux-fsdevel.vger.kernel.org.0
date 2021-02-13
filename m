Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1581731A8DC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Feb 2021 01:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhBMAkL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 19:40:11 -0500
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:36816 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229650AbhBMAkK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 19:40:10 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 261F4181802B2;
        Sat, 13 Feb 2021 00:39:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2560:2563:2682:2685:2691:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6691:7652:7903:7904:9025:10004:10400:10848:11232:11658:11914:12043:12296:12297:12555:12679:12740:12760:12895:13069:13161:13229:13311:13357:13439:14181:14659:14721:21080:21325:21451:21611:21627:30012:30054:30071:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: grass58_040f2d327625
X-Filterd-Recvd-Size: 2922
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sat, 13 Feb 2021 00:39:27 +0000 (UTC)
Message-ID: <0c276a12b04d8078dc3a22e57b4f41547178329f.camel@perches.com>
Subject: Re: [PATCH] proc: Convert S_<FOO> permission uses to octal
From:   Joe Perches <joe@perches.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 12 Feb 2021 16:39:25 -0800
In-Reply-To: <m1y2fszwa7.fsf@fess.ebiederm.org>
References: <85ff6fd6b26aafdf6087666629bad3acc29258d8.camel@perches.com>
         <m1im6x0wtv.fsf@fess.ebiederm.org>
         <130bc5f98c2fd501d32024d267ea73f1fb9d88b6.camel@perches.com>
         <m1y2fszwa7.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-02-12 at 17:44 -0600, Eric W. Biederman wrote:

> I certainly do not see sufficient consensus to go around changing code
> other people maintain.

Every patch by a non-maintainer that doesn't have commit rights to
whatever tree is just a proposal.

> My suggest has the nice property that it handles all 512 different
> combinations.  I think that was the only real downside of Ingo's
> suggestion.  There are just too many different combinations to define
> a set of macros to cover all of the cases.

The treewide kernel use of octal vs symbolic permissions is ~2:1

There are about 11k uses of 4 digit octal values used for permissions
already in the kernel sources that are not in comments or strings.

$ git ls-files -- '*.[ch]' | xargs scc | sed 's/".*"//g' | grep -P -w '0[0-7]{3,3}' | wc -l
10818

(scc is a utility tool that strips comments from c source
 see: https://github.com/jleffler/scc-snapshots#readme)

vs:

$ git grep -w -P 'S_I[RWX][A-Z]{3,5}' | wc -l
5247

To my knowledge there just aren't many 4 digit octal uses in the
kernel sources that are _not_ permissions.

I believe the only non-permission 4 digit octal int uses not in
comments are:

include/uapi/linux/a.out.h
#define OMAGIC 0407
#define NMAGIC 0410
#define ZMAGIC 0413
#define QMAGIC 0314
#define CMAGIC 0421
#define N_STAB 0340

include/uapi/linux/coff.h
#define COFF_STMAGIC	0401
#define COFF_OMAGIC     0404
#define COFF_JMAGIC     0407     
#define COFF_DMAGIC     0410     
#define COFF_ZMAGIC     0413     
#define COFF_SHMAGIC	0443

fs/binfmt_flat.c:
	if ((buf[0] != 037) || ((buf[1] != 0213) && (buf[1] != 0236))) {

lib/inflate.c:
	((magic[1] != 0213) && (magic[1] != 0236))) {

And maybe those last 2 tests for gzip identification should be combined
into some static inline and use something other than magic constants.


