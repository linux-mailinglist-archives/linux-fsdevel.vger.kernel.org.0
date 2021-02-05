Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E244D3104DB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 07:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhBEGIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 01:08:41 -0500
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:50744 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229586AbhBEGIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 01:08:38 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E4A561E0B;
        Fri,  5 Feb 2021 06:07:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3870:3871:3872:3874:4250:4321:5007:7652:7903:7904:7974:8531:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12346:12740:12895:13069:13311:13357:13439:13894:14659:14721:21080:21611:21627:21990:30012:30025:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fowl10_5b09907275e2
X-Filterd-Recvd-Size: 2146
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri,  5 Feb 2021 06:07:54 +0000 (UTC)
Message-ID: <1055f62a90a03d6f9c8092d17b7a03c0dd3cbc69.camel@perches.com>
Subject: Re: [PATCH v2 2/3] fs/efs: Correct spacing after C keywords
From:   Joe Perches <joe@perches.com>
To:     Amy Parker <enbyamy@gmail.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 04 Feb 2021 22:07:52 -0800
In-Reply-To: <20210205051429.553657-3-enbyamy@gmail.com>
References: <20210205051429.553657-1-enbyamy@gmail.com>
         <20210205051429.553657-3-enbyamy@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-02-04 at 21:14 -0800, Amy Parker wrote:
> In EFS code, some C keywords (most commonly 'for') do not have spaces 
> before their instructions, such as for() vs for (). The kernel style 
> guide indicates that these should be of the latter variant. This patch 
> updates them accordingly.

ok but:

> diff --git a/fs/efs/super.c b/fs/efs/super.c
[]
> @@ -169,7 +169,7 @@ static efs_block_t efs_validate_vh(struct volume_header *vh) {
>  		return 0;
>  
> 
>  	ui = ((__be32 *) (vh + 1)) - 1;
> -	for(csum = 0; ui >= ((__be32 *) vh);) {
> +	for (csum = 0; ui >= ((__be32 *) vh);) {
>  		cs = *ui--;
>  		csum += be32_to_cpu(cs);
>  	}

I think this loop is atypical.  More common would be:

	csum = 0;
	for (ui = ((__be32 *)(vh + 1)) - 1; ui >= (__be32 *)vh; ui--)
		csum += be32_to_cpu(*ui);


> @@ -198,9 +198,9 @@ static efs_block_t efs_validate_vh(struct volume_header *vh) {
>  	}
>  #endif
>  
> 
> -	for(i = 0; i < NPARTAB; i++) {
> +	for (i = 0; i < NPARTAB; i++) {
>  		pt_type = (int) be32_to_cpu(vh->vh_pt[i].pt_type);
> -		for(pt_entry = sgi_pt_types; pt_entry->pt_name; pt_entry++) {
> +		for (pt_entry = sgi_pt_types; pt_entry->pt_name; pt_entry++) {
>  			if (pt_type == pt_entry->pt_type) break;

Also atypical is the break location, it should be on a separate line.


