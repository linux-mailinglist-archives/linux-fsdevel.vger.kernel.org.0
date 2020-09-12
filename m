Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC65267743
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 04:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgILC2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 22:28:32 -0400
Received: from smtprelay0241.hostedemail.com ([216.40.44.241]:35008 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725562AbgILC2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 22:28:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 87C84182CED2A;
        Sat, 12 Sep 2020 02:28:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1963:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3868:3871:3874:4321:5007:7903:8603:8957:10004:10400:10848:11232:11473:11658:11914:12296:12297:12740:12760:12895:13019:13161:13229:13439:14096:14097:14659:14721:21080:21451:21627:30012:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: waste77_160c1bc270f3
X-Filterd-Recvd-Size: 3171
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sat, 12 Sep 2020 02:28:28 +0000 (UTC)
Message-ID: <f32cdd694fcf647bbe17b54b983324bc24f1360c.camel@perches.com>
Subject: Re: [PATCH v5 01/10] fs/ntfs3: Add headers and misc files
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        pali@kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, mark@harmstone.com,
        nborisov@suse.com
Date:   Fri, 11 Sep 2020 19:28:27 -0700
In-Reply-To: <20200911141018.2457639-2-almaz.alexandrovich@paragon-software.com>
References: <20200911141018.2457639-1-almaz.alexandrovich@paragon-software.com>
         <20200911141018.2457639-2-almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-09-11 at 17:10 +0300, Konstantin Komarov wrote:
> This adds headers and misc files

The code may be ok, but its cosmetics are poor.

> diff --git a/fs/ntfs3/debug.h b/fs/ntfs3/debug.h
[]
> +#define QuadAlign(n) (((n) + 7u) & (~7u))
> +#define IsQuadAligned(n) (!((size_t)(n)&7u))
> +#define Quad2Align(n) (((n) + 15(&u) & (~15u))
> +#define IsQuad2Aligned(n) (!((size_t)(n)&15u))
> +#define Quad4Align(n) (((n) + 31u) & (~31u))
> +#define IsSizeTAligned(n) (!((size_t)(n) & (sizeof(size_t) - 1)))
> +#define DwordAlign(n) (((n) + 3u) & (~3u))
> +#define IsDwordAligned(n) (!((size_t)(n)&3u))
> +#define WordAlign(n) (((n) + 1u) & (~1u))
> +#define IsWordAligned(n) (!((size_t)(n)&1u))

All of these could use column alignment.
IsSizeTAligned could is the kernel's IS_ALIGNED

#define IsQuadAligned(n)	(!((size_t)(n) & 7u))
#define QuadAlign(n)		(((n) + 7u) & (~7u))
#define IsQuadAligned(n)	(!((size_t)(n) & 7u))
#define Quad2Align(n)		(((n) + 15u) & (~15u))
#define IsQuad2Aligned(n)	(!((size_t)(n) & 15u))

Though all of these could also use two macros with
the same form.  Something like:

#define NTFS3_ALIGN(n, at)	(((n) + ((at) - 1)) & (~((at) - 1)))
#define NTFS3_IS_ALIGNED(n, at)	(!((size_t)(n) & ((at) - 1)))

So all of these could be ordered by size and use actual size

#define WordAlign(n)		NTFS3_ALIGN(n, 2)
#define IsWordAligned(n)	NTFS3_IS_ALIGNED(n, 2)
#define DwordAlign(n)		NTFS3_ALIGN(n, 4)
#define IsDwordAligned(n)	
NTFS3_IS_ALIGNED(n, 4)
#define QuadAlign(n)		NTFS3_ALIGN(n, 8)
#define IsQuadAligned(n)	NTFS3_IS_ALIGNED(n, 8)
#define
Quad2Align(n)		NTFS3_ALIGN(n, 16)
#define IsQuad2Aligned(n)	NTFS3_IS_ALIGNED(n, 16)

#define IsSizeTAligned(n)	NTFS3_IS_ALIGNED(n, sizeof(size_t))


> +#ifdef CONFIG_PRINTK
> +__printf(2, 3) void ntfs_printk(const struct super_block *sb, const char *fmt,
> +				...);

Better would be

__printf(2, 3)
void ntfs_printk(const struct super_block *sb, const char *fmt, ...);

etc...

There's a lot of code that could be made more readable for a human.



