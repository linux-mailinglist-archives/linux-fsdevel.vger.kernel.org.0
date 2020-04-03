Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7AC19DF95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 22:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgDCUkk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 16:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728108AbgDCUkk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:40:40 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A98F621D6C;
        Fri,  3 Apr 2020 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585946439;
        bh=A/b6WcEW+sgH9ELmZUWFVlvFcBJ6Y5ZwDFeJXrdljgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCtSW77DmOIggT9pPUwNw/yxTO2kMUimvir19ZiIiCURT6k8tIAOAnJeo20VJE6PJ
         8TneIQB00aX2wLWdofO3lisn97vK/2swAHw2d1a9lPIq3aoEoVBRnd/nR2fnU1550R
         fB84Qety3Ov5CLHFyr/lEOEBm1MRkZajQBFLSS4w=
Received: by pali.im (Postfix)
        id 9DB575DE; Fri,  3 Apr 2020 22:40:37 +0200 (CEST)
Date:   Fri, 3 Apr 2020 22:40:37 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'namjae.jeon@samsung.com'" <namjae.jeon@samsung.com>,
        "'sj1557.seo@samsung.com'" <sj1557.seo@samsung.com>,
        "'viro@zeniv.linux.org.uk'" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Message-ID: <20200403204037.hs4ae6cl3osogrso@pali>
References: <TY1PR01MB15782019FA3094015950830590C70@TY1PR01MB1578.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB15782019FA3094015950830590C70@TY1PR01MB1578.jpnprd01.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 03 April 2020 02:18:15 Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp wrote:
> > I guess it was designed for 8bit types, not for long (64bit types) and
> > I'm not sure how effective it is even for 16bit types for which it is
> > already used.
> 
> In partial_name_hash (), when 8bit value or 16bit value is specified, 
> upper 8-12bits tend to be 0.
> 
> > So question is, what should we do for either 21bit number (one Unicode
> > code point = equivalent of UTF-32) or for sequence of 16bit numbers
> > (UTF-16)?
> 
> If you want to get an unbiased hash value by specifying an 8 or 16-bit value,

Hello! In exfat we have sequence of 21-bit values (not 8, not 16).

> the hash32() function is a good choice.
> ex1: Prepare by hash32 () function.
>    hash = partial_name_hash (hash32 (val16,32), hash);
> ex2: Use the hash32() function directly.
>    hash + = hash32 (val16,32);

Did you mean hash_32() function from linux/hash.h?

> > partial_name_hash(unsigned long c, unsigned long prevhash)
> > {
> >	return (prevhash + (c << 4) + (c >> 4)) * 11;
> > }
> 
> Another way may replace partial_name_hash().
> 
> 	return prevhash + hash32(c,32)
> 
