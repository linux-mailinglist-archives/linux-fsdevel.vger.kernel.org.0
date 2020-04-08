Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33511A1DCB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 11:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgDHJEj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 05:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgDHJEi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:04:38 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 406BB20692;
        Wed,  8 Apr 2020 09:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586336678;
        bh=9kbufo3o6enn038b+/eT3GGy2OJh9n+0Gmmfe1errw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gClleIa6JVwmMtFjQ+VLKstEyu2cAnmLBAYUvRdQ78Mc4QaUjCqjIY+lFgC2tJ/5d
         K4FpWE2X1K4NjctqOm0u4QC2TyJZxAsOzFJlHQY4zjVgUg7wUDsq0lu83XzZAvTv9y
         Vy870rZ8PwV6NlUxUWkTaGjnA+N3rxNwUyVmDf+A=
Received: by pali.im (Postfix)
        id 51648A7A; Wed,  8 Apr 2020 11:04:35 +0200 (CEST)
Date:   Wed, 8 Apr 2020 11:04:35 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>,
        viro@zeniv.linux.org.uk
Cc:     "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'namjae.jeon@samsung.com'" <namjae.jeon@samsung.com>,
        "'sj1557.seo@samsung.com'" <sj1557.seo@samsung.com>
Subject: Re: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Message-ID: <20200408090435.i3ufmbfinx5dyd7w@pali>
References: <TY1PR01MB15782019FA3094015950830590C70@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200403204037.hs4ae6cl3osogrso@pali>
 <TY1PR01MB1578D63C6F303DE805D75DAA90C20@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200407100648.phkvxbmv2kootyt7@pali>
 <TY1PR01MB1578892F886C62868F87663B90C00@TY1PR01MB1578.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1578892F886C62868F87663B90C00@TY1PR01MB1578.jpnprd01.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday 08 April 2020 03:59:06 Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp wrote:
> > So partial_name_hash() like I used it in this patch series is enough?
> 
> I think partial_name_hash() is enough for 8/16/21bit characters.

Great!

Al, could you please take this patch series?

> Another point about the discrimination of 21bit characters:
> I think that checking in exfat_toupper () can be more simplified.
> 
>  ex: return a < PLANE_SIZE && sbi->vol_utbl[a] ? sbi->vol_utbl[a] : a;

I was thinking about it, but it needs more refactoring. Currently
exfat_toupper() is used on other places for UTF-16 (u16 array) and
therefore it cannot be extended to take more then 16 bit value.

But I agree that this is another step which can be improved.
