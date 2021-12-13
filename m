Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AA8472136
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 07:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhLMGuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 01:50:17 -0500
Received: from tartarus.angband.pl ([51.83.246.204]:34492 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhLMGuQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 01:50:16 -0500
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mwf7g-00HGOd-Va; Mon, 13 Dec 2021 07:47:44 +0100
Date:   Mon, 13 Dec 2021 07:47:44 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Sean Young <sean@mess.org>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Incorrect handling of . and .. files
Message-ID: <YbbskNBJI8Ak1Vl/@angband.pl>
References: <20210927111948.GA16257@gofer.mess.org>
 <20211211020453.mkuzumgpnignsuri@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211211020453.mkuzumgpnignsuri@pali>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 11, 2021 at 03:04:53AM +0100, Pali Rohár wrote:
> I tried to find some information what is allowed and what not.
> 
> On Monday 27 September 2021 12:19:48 Sean Young wrote:
> > Windows allows files and directories called "." and ".." to be created
> > using UNC paths, i.e. "\\?\D:\..". Now this is totally insane behaviour,
> > but when an exfat filesytem with such a file is mounted on Linux, those
> > files show up as another directory and its contents is inaccessible.
> > 
> > I can replicate this using exfat filesystems, but not ntfs.
> 
> Microsoft exFAT specification explicitly disallow "." and "..", see:
[...]
> On the other hand Microsoft FAT32 specification can be understood that
> file may have long name (vfat) set to "." or ".." but not short name.
[...]
> OSTA UDF 2.60 specification does not disallow "." and ".." entries, but
[...]
> So it means that "." and ".." entries could be stored on disk as valid
> file names.

It doesn't matter one whit what the specification says.  Anyone with a disk
editor can craft a filesystem containing filenames such as "." or "..", "/"
"foo/bar" or anything else we would like to ban.

> > So, in Linux cannot read "." or ".." (i.e., I can't see "Hello, World!"). I
> > don't know what the correct handling should be, but having two "." and two
> > ".." files does not seem right at all.
> 
> This is really a bug in Linux kernel. It should not export "." and ".."
> into VFS even when filesystem disk format supports such insane file
> names.

This.

Otherwise, every filesystem driver would need to contain redundant code for
checking for such bad names.

> So either Linux needs to completely hide these insane file names from
> VFS or translate them to something which do not conflict with other
> files in correct directory.

Escaping bad names has the problem of the escaped name also possibly
existing -- perhaps even recursively.  Plus, the filesystem might be using
hashed or tree indices which could go wrong if a name is altered.

But then, I once proposed (and I'm pondering reviving) a ban for characters
\x01..\x1f and possibly others, and if banned, they can still legitimately
occur in old filesystems.

> I guess that hiding them for exfat is valid thing as Microsoft
> specification explicitly disallow them. Probably fsck.exfat can be teach
> to rename these files and/or put them to lost+found directory.

fsck fixing those is a good thing but we still need to handle them at
runtime.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ in the beginning was the boot and root floppies and they were good.
⢿⡄⠘⠷⠚⠋⠀                                       -- <willmore> on #linux-sunxi
⠈⠳⣄⠀⠀⠀⠀
