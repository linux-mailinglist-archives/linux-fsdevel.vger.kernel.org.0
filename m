Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866F04192F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 13:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhI0LVa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 07:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbhI0LV2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:21:28 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAD2C061575;
        Mon, 27 Sep 2021 04:19:51 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 57708C6378; Mon, 27 Sep 2021 12:19:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1632741588; bh=L1IgKxhZY5SXX5K6KMNMmMoAQ5ow0lZMPAx3ekvRkS4=;
        h=Date:From:To:Cc:Subject:From;
        b=K24bmRsrMc9DRtxys+PZDeNn6dCTA/bxCITgmLdSYim6GnmkoewHh0phtlM5LwL1N
         JrH3JhI5Zi05esVR1Syu3vNLxAAmiB+eQmaIzwhGrFIm4m611++BPM38+WA12+p5vm
         VD+KnYotzA0Rt7zX/hjOQ/1WlEhTufV9Q/SDwNQS8wM8KWb7K2T3ZCuEOWd6DnTFFn
         nXRIqRX68xUEDrn/Sn+BaKvFlN9vzwGDuNaC16anag2sQ7xlX/dEw1XjaBLPvupAA4
         GJUnHap/XTOQLGSFXmw8SkBdbJs+p/4/2IW90TB1oRgLVO6KHhILGaFS1i957+MgnK
         fDxdgSVTSxFpQ==
Date:   Mon, 27 Sep 2021 12:19:48 +0100
From:   Sean Young <sean@mess.org>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Incorrect handling of . and .. files
Message-ID: <20210927111948.GA16257@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Windows allows files and directories called "." and ".." to be created
using UNC paths, i.e. "\\?\D:\..". Now this is totally insane behaviour,
but when an exfat filesytem with such a file is mounted on Linux, those
files show up as another directory and its contents is inaccessible.

I can replicate this using exfat filesystems, but not ntfs.

This is what I did on Windows using rust:

	use std::fs::File;
	use std::io::Write;

	fn main() {
	    let mut file =
		File::create(r"\\?\D:\..").expect("create dot file");
	    file.write_all(b"Hello, world!").expect("write dot file");
	}

Now on Linux (I also created a file called ".").

[root@xywoleh tmp]# mount -t exfat /dev/loop0p1 /mnt
[root@xywoleh tmp]# cd /mnt
[root@xywoleh mnt]# ls -la
total 20
drwxr-xr-x. 5 root root 4096 Sep 27 11:47  .
drwxr-xr-x. 5 root root 4096 Sep 27 11:47  .
dr-xr-xr-x. 1 root root  176 Sep 21 11:05  ..
dr-xr-xr-x. 1 root root  176 Sep 21 11:05  ..
drwxr-xr-x. 2 root root 4096 Sep 27  2021 '$RECYCLE.BIN'
drwxr-xr-x. 2 root root 4096 Sep 27  2021 'System Volume Information'

Microsoft says this:

https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file#win32-file-namespaces

	Because it turns off automatic expansion of the path string, the
	"\\?\" prefix also allows the use of ".." and "." in the path names,
	which can be useful if you are attempting to perform operations on a
	file with these otherwise reserved relative path specifiers as part of
	the fully qualified path.

So, in Linux cannot read "." or ".." (i.e., I can't see "Hello, World!"). I
don't know what the correct handling should be, but having two "." and two
".." files does not seem right at all.

Thanks,
Sean
