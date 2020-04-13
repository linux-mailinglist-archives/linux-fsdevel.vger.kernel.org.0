Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59EA1A6507
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 12:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgDMKKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 06:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbgDMKKL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:10:11 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8BE1206E9;
        Mon, 13 Apr 2020 10:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586772610;
        bh=7qI04vutPCDuNF2NDS2Ze8iRiFNiOMPONsZJ3KLq4U8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLEHL99NsAudonUlrw1+pxZYvpIGGNNDWZtHpEG9GBPMypfAfHIAGoPDgu90BJ1Dn
         5DJgsijlCpKG/y7l4veviAiq+F1fyBpixJrpY4Y/ugRy6VrXza5kZqq0WvVFFa4uob
         niLJ/2Jslsf3PJaSbH/jxweFIShaCVPtmF89GDbU=
Received: by pali.im (Postfix)
        id 82054895; Mon, 13 Apr 2020 12:10:07 +0200 (CEST)
Date:   Mon, 13 Apr 2020 12:10:07 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'namjae.jeon@samsung.com'" <namjae.jeon@samsung.com>,
        "'sj1557.seo@samsung.com'" <sj1557.seo@samsung.com>
Subject: Re: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Message-ID: <20200413101007.lbey6q5u6jz3ulmr@pali>
References: <TY1PR01MB15782019FA3094015950830590C70@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200403204037.hs4ae6cl3osogrso@pali>
 <TY1PR01MB1578D63C6F303DE805D75DAA90C20@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200407100648.phkvxbmv2kootyt7@pali>
 <TY1PR01MB1578892F886C62868F87663B90C00@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200408090435.i3ufmbfinx5dyd7w@pali>
 <TY1PR01MB15784063EED4CEC93A2B501390DD0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY1PR01MB15784063EED4CEC93A2B501390DD0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 13 April 2020 08:13:45 Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp wrote:
> > On Wednesday 08 April 2020 03:59:06 Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp wrote:
> > > > So partial_name_hash() like I used it in this patch series is enough?
> > >
> > > I think partial_name_hash() is enough for 8/16/21bit characters.
> > 
> > Great!
> > 
> > Al, could you please take this patch series?
> 
> I think it's good.
> 
> 
> > > Another point about the discrimination of 21bit characters:
> > > I think that checking in exfat_toupper () can be more simplified.
> > >
> > >  ex: return a < PLANE_SIZE && sbi->vol_utbl[a] ? sbi->vol_utbl[a] : a;
> > 
> > I was thinking about it, but it needs more refactoring. Currently
> > exfat_toupper() is used on other places for UTF-16 (u16 array) and therefore it cannot be extended to take more then 16
> > bit value.
> 
> I’m also a little worried that exfat_toupper() is designed for only utf16.
> Currently, it is converting from utf8 to utf32 in some places, and from utf8 to utf16 in others.
> Another way would be to unify to utf16.
> 
> > But I agree that this is another step which can be improved.
> 
> Yes.

There are two problems with it:

We do not know how code points above U+FFFF could be converted to upper
case. Basically from exfat specification can be deduced it only for
U+0000 .. U+FFFF code points. We asked if we can get answer from MS, but
I have not received any response yet.

Second problem is that all MS filesystems (vfat, ntfs and exfat) do not
use UCS-2 nor UTF-16, but rather some mix between it. Basically any
sequence of 16bit values (except those :/<>... vfat chars) is valid,
even unpaired surrogate half. So surrogate pair (two 16bit values)
represents one unicode code point (as in UTF-16), but one unpaired
surrogate half is also valid and represent (invalid) unicode code point
of its value. In unicode are not defined code points for values of
single / half surrogate.

Therefore if we talk about encoding UTF-16 vs UTF-32 we first need to
fix a way how to handle those non-representative values in VFS encoding
(iocharset=) as UTF-8 is not able to represent it too. One option is to
extend UTF-8 to WTF-8 encoding [1] (yes, this is a real and make sense!)
and then ideally change exfat_toupper() to UTF-32 without restriction
for surrogate pairs values.

Btw, same problem with UTF-16 also in vfat, ntfs and also in iso/joliet
kernel drivers.

[1] - https://simonsapin.github.io/wtf-8/
