Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9593812DAD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 19:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLaSKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 13:10:41 -0500
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:49861 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726720AbfLaSKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 13:10:41 -0500
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Dec 2019 13:10:40 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 293EA1802CCDC
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2019 18:02:27 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 60D1718224D8D;
        Tue, 31 Dec 2019 18:02:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:152:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3870:3871:3872:4321:5007:6119:6120:7901:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12740:12895:13069:13311:13357:13894:14659:14721:14777:21080:21433:21451:21627:21810:21819:21990:30012:30022:30054:30056:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: song33_3208bae3f8801
X-Filterd-Recvd-Size: 2662
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue, 31 Dec 2019 18:02:23 +0000 (UTC)
Message-ID: <a6911ca13419af48d7170e4426cd23f22a2824f5.camel@perches.com>
Subject: Re: [PATCH v8 10/13] exfat: add nls operations
From:   Joe Perches <joe@perches.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Date:   Tue, 31 Dec 2019 10:01:36 -0800
In-Reply-To: <5b0febd5-642b-83f2-7d81-7a1cbb302e3c@web.de>
References: <20191220062419.23516-11-namjae.jeon@samsung.com>
         <5b0febd5-642b-83f2-7d81-7a1cbb302e3c@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-12-31 at 15:23 +0100, Markus Elfring wrote:
> …
> > +++ b/fs/exfat/nls.c
> …
> > +int exfat_nls_cmp_uniname(struct super_block *sb, unsigned short *a,
> > +		unsigned short *b)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < MAX_NAME_LENGTH; i++, a++, b++) {
> > +		if (exfat_nls_upper(sb, *a) != exfat_nls_upper(sb, *b))
> 
> Can it matter to compare run time characteristics with the following
> code variant?
> 
> +	for (i = 0; i < MAX_NAME_LENGTH; i++) {
> +		if (exfat_nls_upper(sb, a[i]) != exfat_nls_upper(sb, b[i]))

Markus, try comparing the object code produced by the compiler first,
it's likely identical.

If this is actually a performance sensitive path, it might improve
runtime by having 2 code paths to avoid the testing of
sbi->options.case_sensitive for each u16 value in the array.

Something like: (uncompiled, untested, written in email client)

static inline
unsigned short exfat_sbi_upper(struct exfat_sb_info *sbi, unsigned short a)
{
	if (sbi->vol_utbl[a])
		return sbi->vol_utbl[a];
	return a;
}

int exfat_nls_cmp_uniname(struct super_block *sb,
			  unsigned short *a,
			  unsigned short *b)
{
	int i;
	struct exfat_sb_info *sbi = EXFAT_SB(sb);

	if (!sbi->options.case_sensitive) {
		for (i = 0; i < MAX_NAME_LENGTH; i++, a++, b++) {
			if (exfat_sbi_upper(sbi, *a) != exfat_sbi_upper(sbi, *b))
				return 1;
			if (*a == 0x0)
				return 0;
		}
	} else {
		for (i = 0; i < MAX_NAME_LENGTH; i++, a++, b++) {
			if (*a != *b)
				return 1;	
			if (*a == 0x0)
				return 0;
		}
	}

	return 0;
}


