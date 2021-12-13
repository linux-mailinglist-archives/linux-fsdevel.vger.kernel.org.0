Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC33472BA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 12:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbhLMLjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 06:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbhLMLjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:39:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89735C061574;
        Mon, 13 Dec 2021 03:39:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDCE7B80DBF;
        Mon, 13 Dec 2021 11:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEB9C34601;
        Mon, 13 Dec 2021 11:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639395546;
        bh=c3Ld5Zed1mPLfn+x846z5ghdQviWxfaGyoBdQ5Oni60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oovF6hXgQDoN2rdP35jD/78rRn8LGIOGnQp0SDT/T5XQujXUvyCYIWvl0K4jTx5JZ
         RK+/VytYvmE/wy2GAVmvzeyGpHHJp07xtXNFJOSWOD0I9ChDNqSe+LwOdipTQjlULt
         jwXiNC40TurFRiGsn1f9bd4QdH/pEA82grVrIvVLRg7wOa29Q8kKZQ+0aIjqD8Nd7B
         KvCT/cB3cOUETeak3sHZFAvZEW+VJ8Cw8pbY4vZBvMhbvUtyp65q+EVP3cedEmvgGB
         kpyB2hysxsRHOsIQzrhFKDmX5aYprImBHyJLIAGi5+ZhxjsLUO6mJG+yn5j32SC4Ah
         gsMs9mfnG5uxg==
Received: by pali.im (Postfix)
        id 435B47DA; Mon, 13 Dec 2021 12:39:03 +0100 (CET)
Date:   Mon, 13 Dec 2021 12:39:03 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Sean Young <sean@mess.org>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Incorrect handling of . and .. files
Message-ID: <20211213113903.bkspqw2qlpct3uxr@pali>
References: <20210927111948.GA16257@gofer.mess.org>
 <20211211020453.mkuzumgpnignsuri@pali>
 <YbbskNBJI8Ak1Vl/@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YbbskNBJI8Ak1Vl/@angband.pl>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 13 December 2021 07:47:44 Adam Borowski wrote:
> On Sat, Dec 11, 2021 at 03:04:53AM +0100, Pali Rohár wrote:
> > I tried to find some information what is allowed and what not.
> > 
> > On Monday 27 September 2021 12:19:48 Sean Young wrote:
> > > Windows allows files and directories called "." and ".." to be created
> > > using UNC paths, i.e. "\\?\D:\..". Now this is totally insane behaviour,
> > > but when an exfat filesytem with such a file is mounted on Linux, those
> > > files show up as another directory and its contents is inaccessible.
> > > 
> > > I can replicate this using exfat filesystems, but not ntfs.
> > 
> > Microsoft exFAT specification explicitly disallow "." and "..", see:
> [...]
> > On the other hand Microsoft FAT32 specification can be understood that
> > file may have long name (vfat) set to "." or ".." but not short name.
> [...]
> > OSTA UDF 2.60 specification does not disallow "." and ".." entries, but
> [...]
> > So it means that "." and ".." entries could be stored on disk as valid
> > file names.
> 
> It doesn't matter one whit what the specification says.  Anyone with a disk
> editor can craft a filesystem containing filenames such as "." or "..", "/"
> "foo/bar" or anything else we would like to ban.

That is truth. But question is what should do fsck tools with such file
names on filesystems where "." and ".." are permitted? Fully valid
argument is "do not touch them" because there is nothing bad with these
names.

> > > So, in Linux cannot read "." or ".." (i.e., I can't see "Hello, World!"). I
> > > don't know what the correct handling should be, but having two "." and two
> > > ".." files does not seem right at all.
> > 
> > This is really a bug in Linux kernel. It should not export "." and ".."
> > into VFS even when filesystem disk format supports such insane file
> > names.
> 
> This.
> 
> Otherwise, every filesystem driver would need to contain redundant code for
> checking for such bad names.
> 
> > So either Linux needs to completely hide these insane file names from
> > VFS or translate them to something which do not conflict with other
> > files in correct directory.
> 
> Escaping bad names has the problem of the escaped name also possibly
> existing -- perhaps even recursively.  Plus, the filesystem might be using
> hashed or tree indices which could go wrong if a name is altered.

vfat has already own escaping scheme and it is documented in mount(8)
manpage. Invalid characters are translated either to fixed char '?' or
to ':'... esc sequence if uni_xlate mount option is used. But it looks
like that that kernel vfat driver do not have these two entries "." and
".." in its blacklist.

And, another important thing about vfat is that it has two file names
for each file. One short 8.3 and one long vfat. Short 8.3 do not allow
"." or "..", so another possibility how to handle this issue for vfat is
to show short 8.3 name in VFS when long is invalid.

For UDF case, specification already says how to handle problematic
file names, so I think that udf.ko could implement it according to
specification.

But for all other filesystems it is needed to do something ideally on
VFS layer.

What about generating some deterministic / predicable file names which
will not conflict with other file names in current directory for these
problematic files?

> But then, I once proposed (and I'm pondering reviving) a ban for characters
> \x01..\x1f and possibly others, and if banned, they can still legitimately
> occur in old filesystems.
> 
> > I guess that hiding them for exfat is valid thing as Microsoft
> > specification explicitly disallow them. Probably fsck.exfat can be teach
> > to rename these files and/or put them to lost+found directory.
> 
> fsck fixing those is a good thing but we still need to handle them at
> runtime.

Namjae Jeon, would you be able to implement fixing of such filenames in
fsck.exfat tool?

> 
> Meow!
> -- 
> ⢀⣴⠾⠻⢶⣦⠀
> ⣾⠁⢠⠒⠀⣿⡁ in the beginning was the boot and root floppies and they were good.
> ⢿⡄⠘⠷⠚⠋⠀                                       -- <willmore> on #linux-sunxi
> ⠈⠳⣄⠀⠀⠀⠀
