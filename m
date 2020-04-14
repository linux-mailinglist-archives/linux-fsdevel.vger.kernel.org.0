Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C9F1A779C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437767AbgDNJr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 05:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437751AbgDNJr5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:47:57 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15B522072D;
        Tue, 14 Apr 2020 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586857676;
        bh=sioL0zCN73divv7tIV9/clBRJUGoE+vs+Zqbu35VaLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1b2PU4gSihGpA9yTKnq3mn1eyRFaN3dsShuws1Z4a1fV4s5j1fmf67UJ+jIlMnDIb
         Ds0oOc4gKoK0Cp0sQgGYfoHJpwkR305uuMMe8Kxl2SKiEjmGFukRMz4zCFnaj0rOEW
         3VxUkZZ771TV8bmKJxQ0gskDIRPlxoN9v+e3phAg=
Received: by pali.im (Postfix)
        id B68E7770; Tue, 14 Apr 2020 11:47:53 +0200 (CEST)
Date:   Tue, 14 Apr 2020 11:47:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'namjae.jeon@samsung.com'" <namjae.jeon@samsung.com>,
        "'sj1557.seo@samsung.com'" <sj1557.seo@samsung.com>,
        "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>
Subject: Re: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Message-ID: <20200414094753.kk2q2elgtwl6ubft@pali>
References: <TY1PR01MB15782019FA3094015950830590C70@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200403204037.hs4ae6cl3osogrso@pali>
 <TY1PR01MB1578D63C6F303DE805D75DAA90C20@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200407100648.phkvxbmv2kootyt7@pali>
 <TY1PR01MB1578892F886C62868F87663B90C00@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200408090435.i3ufmbfinx5dyd7w@pali>
 <TY1PR01MB15784063EED4CEC93A2B501390DD0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200413101007.lbey6q5u6jz3ulmr@pali>
 <TY1PR01MB15782010C68C0C568A6AE68690DA0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY1PR01MB15782010C68C0C568A6AE68690DA0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday 14 April 2020 09:29:32 Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp wrote:
> > We do not know how code points above U+FFFF could be converted to upper case. 
> 
> Code points above U+FFFF do not need to be converted to uppercase.
> 
> > Basically from exfat specification can be deduced it only for
> > U+0000 .. U+FFFF code points. 
> 
> exFAT specifications (sec.7.2.5.1) saids ...
> -- table shall cover the complete Unicode character range (from character codes 0000h to FFFFh inclusive).
> 
> UCS-2, UCS-4, and UTF-16 terms do not appear in the exfat specification.
> It just says "Unicode".

That is because in MS world, "Unicode" term lot of times means UCS-2 or
UTF-16. You need to have a crystal ball to correctly understand their
specifications.

> 
> > Second problem is that all MS filesystems (vfat, ntfs and exfat) do not use UCS-2 nor UTF-16, but rather some mix between
> > it. Basically any sequence of 16bit values (except those :/<>... vfat chars) is valid, even unpaired surrogate half. So
> > surrogate pair (two 16bit values) represents one unicode code point (as in UTF-16), but one unpaired surrogate half is
> > also valid and represent (invalid) unicode code point of its value. In unicode are not defined code points for values
> > of single / half surrogate.
> 
> Microsoft's File Systems uses the UTF-16 encoded UCS-4 code set.
> The character type is basically 'wchar_t'(16bit).
> The description "0000h to FFFFh" also assumes the use of 'wchar_t'.
> 
> This “0000h to FFFFh” also includes surrogate characters(U+D800 to U+DFFF),
> but these should not be converted to upper case.
> Passing a surrogate character to RtlUpcaseUnicodeChar() on Windows, just returns the same value.
> (* RtlUpcaseUnicodeChar() is one of Windows native API)
> 
> If the upcase-table contains surrogate characters, exfat_toupper() will cause incorrect conversion.
> With the current implementation, the results of exfat_utf8_d_cmp() and exfat_uniname_ncmp() may differ.
> 
> The normal exfat's upcase-table does not contain surrogate characters, so the problem does not occur.
> To be more strict...
> D800h to DFFFh should be excluded when loading upcase-table or in exfat_toupper().

Exactly, that is why surrogate pairs cannot be put into any "to upper"
function. Or rather "to upper" function needs to be identity for them to
not break anything. "to upper" does not make any sense on one u16 item
from UTF-16 sequence when you do not have a complete code point.
So API for UTF-16 "to upper" function needs to take full string, not
just one u16.

So for code points above U+FFFF it is needed some other mechanism how to
represent upcase table (e.g. by providing full UTF-16 pair or code point
encoded in UTF-32). And this is unknown and reason why I put question
which was IIRC forwarded to MS.

> > Therefore if we talk about encoding UTF-16 vs UTF-32 we first need to fix a way how to handle those non-representative
> > values in VFS encoding (iocharset=) as UTF-8 is not able to represent it too. One option is to extend UTF-8 to WTF-8 
> > encoding [1] (yes, this is a real and make sense!) and then ideally change exfat_toupper() to UTF-32 without restriction 
> > for surrogate pairs values.
> 
> WTF-8 is new to me.
> That's an interesting idea, but is it needed for exfat?
> 
> For characters over U+FFFF,
>  -For UTF-32, a value of 0x10000 or more
>  -For UTF-16, the value from 0xd800 to 0xdfff
> I think these are just "don't convert to uppercase."
> 
> If the File Name Directory Entry contains illegal surrogate characters(such as one unpaired surrogate half),
> it will simply be ignored by utf16s_to_utf8s().

This is the example why it can be useful for exfat on linux. exfat
filename can contain just sequence of unpaired halves of surrogate
pairs. Such thing is not representable in UTF-8, but valid in exfat.
Therefore current linux kernel exfat driver with UTF-8 encoding cannot
handle such filenames. But with WTF-8 it is possible.

So if we want that userspace would be able to read such files from exfat
fs, some mechanism for converting "unpaired halves" to NULL-term char*
string suitable for filenames is needed. And WTF-8 seems like a good
choice as it is backward compatible with UTF-8.

> string after utf8 conversion does not include illegal byte sequence.

Yes, but this is loosy conversion. When you would have two filenames
with different "surrogate halves" they would be converted to same file
name. So you would not be able to access both of them.

> 
> > Btw, same problem with UTF-16 also in vfat, ntfs and also in iso/joliet kernel drivers.
> 
> Ugh...
> 
> 
> BR
> ---
> Kohada Tetsuhiro <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
> 
