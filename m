Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D7E1420A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 00:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgASXIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 18:08:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39790 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgASXIO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 18:08:14 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itJft-00BhLp-Jl; Sun, 19 Jan 2020 23:08:09 +0000
Date:   Sun, 19 Jan 2020 23:08:09 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200119230809.GW8904@ZenIV.linux.org.uk>
References: <20200119221455.bac7dc55g56q2l4r@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200119221455.bac7dc55g56q2l4r@pali>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 19, 2020 at 11:14:55PM +0100, Pali Rohár wrote:

> So when UTF-8 on VFS for VFAT is enabled, then for VFS <--> VFAT
> conversion are used utf16s_to_utf8s() and utf8s_to_utf16s() functions.
> But in fat_name_match(), vfat_hashi() and vfat_cmpi() functions is used
> NLS table (default iso8859-1) with nls_strnicmp() and nls_tolower().
> 
> Which means that fat_name_match(), vfat_hashi() and vfat_cmpi() are
> broken for vfat in UTF-8 mode.
> 
> I was thinking how to fix it, and the only possible way is to write a
> uni_tolower() function which takes one Unicode code point and returns
> lowercase of input's Unicode code point. We cannot do any Unicode
> normalization as VFAT specification does not say anything about it and
> MS reference fastfat.sys implementation does not do it neither.

Then how can that possibly be broken?  If it matches the native behaviour,
that's it.

> As you can see lowercase 'd' and uppercase 'D' are same, but lowercase
> 'č' and uppercase 'Č' are not same. This is because 'č' is two bytes
> 0xc4 0x8d sequence and comparing is done by Latin1 table. 0xc4 is in
> Latin 'Ä' which is already in uppercase. 0x8d is control char so is not
> changed by tolower/toupper function.

Again, who the hell cares?  Does the behaviour match how Windows handles
that thing?  "Case" is not something well-defined; the only definition
is "whatever weird crap does the native implementation choose to do".
That's the only reason to support that garbage at all...
