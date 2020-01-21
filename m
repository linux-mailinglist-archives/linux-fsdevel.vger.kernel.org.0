Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B149E1434A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 01:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAUAHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 19:07:08 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57038 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgAUAHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 19:07:08 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ith4P-00CK6C-FD; Tue, 21 Jan 2020 00:07:01 +0000
Date:   Tue, 21 Jan 2020 00:07:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200121000701.GG8904@ZenIV.linux.org.uk>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120110438.ak7jpyy66clx5v6x@pali>
 <875zh6pc0f.fsf@mail.parknet.co.jp>
 <20200120214046.f6uq7rlih7diqahz@pali>
 <20200120224625.GE8904@ZenIV.linux.org.uk>
 <20200120235745.hzza3fkehlmw5s45@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200120235745.hzza3fkehlmw5s45@pali>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 12:57:45AM +0100, Pali Rohár wrote:
> On Monday 20 January 2020 22:46:25 Al Viro wrote:
> > On Mon, Jan 20, 2020 at 10:40:46PM +0100, Pali Rohár wrote:
> > 
> > > Ok, I did some research. It took me it longer as I thought as lot of
> > > stuff is undocumented and hard to find all relevant information.
> > > 
> > > So... fastfat.sys is using ntos function RtlUpcaseUnicodeString() which
> > > takes UTF-16 string and returns upper case UTF-16 string. There is no
> > > mapping table in fastfat.sys driver itself.
> > 
> > Er...  Surely it's OK to just tabulate that function on 65536 values
> > and see how could that be packed into something more compact?
> 
> It is OK, but too complicated. That function is in nt kernel. So you
> need to build a new kernel module and also decide where to put output of
> that function. It is a long time since I did some nt kernel hacking and
> nowadays you need to download 10GB+ of Visual Studio code, then addons
> for building kernel modules, figure out how to write and compile simple
> kernel module via Visual Studio, write ini install file, try to load it
> and then you even fail as recent Windows kernels refuse to load kernel
> modules which are not signed...

Wait a sec...  From NT userland, on a mounted VFAT:
	for all s in single-codepoint strings
		open s for append
		if failed
			print s on stderr, along with error value
		write s to the opened file, adding to its tail
		close the file
the for each equivalence class you'll get a single file, with all
members of that class written to it.  In addition you'll get the
list of prohibited codepoints.

Why bother with any kind of kernel modules?  IDGI...
