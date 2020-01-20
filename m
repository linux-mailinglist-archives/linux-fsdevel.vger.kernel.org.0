Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74387142F5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 17:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgATQMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 11:12:13 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51872 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATQMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:12:12 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itZeo-00C6v8-G5; Mon, 20 Jan 2020 16:12:06 +0000
Date:   Mon, 20 Jan 2020 16:12:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Pali =?iso-8859-1?Q?Roh=E1r'?= <pali.rohar@gmail.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200120161206.GC8904@ZenIV.linux.org.uk>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120110438.ak7jpyy66clx5v6x@pali>
 <89eba9906011446f8441090f496278d2@AcuMS.aculab.com>
 <20200120152009.5vbemgmvhke4qupq@pali>
 <1a4c545dc7f14e33b7e59321a0aab868@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a4c545dc7f14e33b7e59321a0aab868@AcuMS.aculab.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 20, 2020 at 03:47:22PM +0000, David Laight wrote:
> From: Pali Rohár
> > Sent: 20 January 2020 15:20
> ...
> > This is not possible. There is 1:1 mapping between UTF-8 sequence and
> > Unicode code point. wchar_t in kernel represent either one Unicode code
> > point (limited up to U+FFFF in NLS framework functions) or 2bytes in
> > UTF-16 sequence (only in utf8s_to_utf16s() and utf16s_to_utf8s()
> > functions).
> 
> Unfortunately there is neither a 1:1 mapping of all possible byte sequences
> to wchar_t (or unicode code points), nor a 1:1 mapping of all possible
> wchar_t values to UTF-8.
> Really both need to be defined - even for otherwise 'invalid' sequences.

Who.  Cares?

Filename is a sequence of octets, not codepoints.  Its interpretation is
entirely up to the userland.

Same goes for the notion of "case" (locale-dependent, etc.); some
filesystems impose their (arbitrary) restrictions on the possible
octet sequences (and equally arbitrary equivalence relations between
them) that can be approximated in terms of upper/lower case in some
locale.  It does not matter how arbitrary those are, or what stands
behind them:
	* don't do that for any new filesystem designs
	* for existing filesystem types, the actual behaviour of
native implementation IS THE ONE AND ONLY AUTHORITY.  It does not
matter from what misguided thought process it has come from;
the absolute requirement is that if you mount a filesystem valid
from the native implementation POV, you must leave it in a state
that would be valid from the native implementation POV.  That's
it.

Any talk about normalization, etc. is completely pointless -
for any sane uses it's an opaque stream of octets that filesystem
and VFS should leave the fuck alone.  Codepoints, encodings, etc.
come into the game only to an extent they are useful to describe
the weird rules given filesystem might have.  And they are just
that - tools to describe externally imposed mappings.
