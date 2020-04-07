Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 624B51A0AC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 12:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgDGKGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 06:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbgDGKGw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:06:52 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09B772074B;
        Tue,  7 Apr 2020 10:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586254012;
        bh=V9cZtdFZm4vp72AYlH0hCNozkSgOmUMQmfD7R0ja7VY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x0bR0HrultTum5d1bG8ab+EPJyodFKlXKthf0O7D580Md4C/2E3YhDaDzx+ekGLwG
         w5svOwJbVmQmleIrjgLhDwNK5MecCA3ykdw78ppmoI0dnnBZGKFlagVOO2Iar4xd8s
         B3rzQaDzSmMCpxUHwhCcF7Otvyt+x6jg3ftI5VYs=
Received: by pali.im (Postfix)
        id 75F8B5F1; Tue,  7 Apr 2020 12:06:48 +0200 (CEST)
Date:   Tue, 7 Apr 2020 12:06:48 +0200
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
Message-ID: <20200407100648.phkvxbmv2kootyt7@pali>
References: <TY1PR01MB15782019FA3094015950830590C70@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200403204037.hs4ae6cl3osogrso@pali>
 <TY1PR01MB1578D63C6F303DE805D75DAA90C20@TY1PR01MB1578.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1578D63C6F303DE805D75DAA90C20@TY1PR01MB1578.jpnprd01.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 06 April 2020 09:37:38 Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp wrote:
> > > If you want to get an unbiased hash value by specifying an 8 or 16-bit
> > > value,
> > 
> > Hello! In exfat we have sequence of 21-bit values (not 8, not 16).
> 
> hash_32() generates a less-biased hash, even for 21-bit characters.
> 
> The hash of partial_name_hash() for the filename with the following character is ...
>  - 21-bit(surrogate pair): the upper 3-bits of hash tend to be 0.
>  - 16-bit(mostly CJKV): the upper 8-bits of hash tend to be 0.
>  - 8-bit(mostly latin): the upper 16-bits of hash tend to be 0.
> 
> I think the more frequently used latin/CJKV characters are more important
> when considering the hash efficiency of surrogate pair characters.
> 
> The hash of partial_name_hash() for 8/16-bit characters is also biased.
> However, it works well.
> 
> Surrogate pair characters are used less frequently, and the hash of 
> partial_name_hash() has less bias than for 8/16 bit characters.
> 
> So I think there is no problem with your patch.

So partial_name_hash() like I used it in this patch series is enough?
