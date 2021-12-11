Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1D4471098
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 03:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241422AbhLKCIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 21:08:47 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:37098 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241304AbhLKCIg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 21:08:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D83A0CE2D34;
        Sat, 11 Dec 2021 02:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806F6C00446;
        Sat, 11 Dec 2021 02:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639188296;
        bh=MhQShSnRIzNvyMUq3ckYrycP8kO80RVx5wmfq2vwJOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEh6ZKwGrHl9boly93oUeOarJzJSDa7mOB6hEzhRMB9nj+lU9dry5/c39xg/YsRhO
         jPYQ96hfQLPhxO8TwxlllxNZ1ktbUspnRIiXcb2oO480p/+iBGa9wk3neP9P116x8h
         Ii9VZqYkgV67/wOuE66A7xTROOKs+Zh4Yv3zLK5HB7hrQjh6ltR+glnNdtPzJc4Fhc
         6ynXEke+X+nucBJfFnRUt/Ig8iwkPXUDwY/DLksZowvNtUNEeFC2Gh32TrHqFz4UoI
         jfn6aqIeAxTMVLrghwcXSk+jyvGhmRZJG6lvIYooBFL0LCi3Rsz6qiluMpk761mnON
         qCGtJpbItE2/Q==
Received: by pali.im (Postfix)
        id C0927252C; Sat, 11 Dec 2021 03:04:53 +0100 (CET)
Date:   Sat, 11 Dec 2021 03:04:53 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Sean Young <sean@mess.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Incorrect handling of . and .. files
Message-ID: <20211211020453.mkuzumgpnignsuri@pali>
References: <20210927111948.GA16257@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210927111948.GA16257@gofer.mess.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

I tried to find some information what is allowed and what not.

On Monday 27 September 2021 12:19:48 Sean Young wrote:
> Hi,
> 
> Windows allows files and directories called "." and ".." to be created
> using UNC paths, i.e. "\\?\D:\..". Now this is totally insane behaviour,
> but when an exfat filesytem with such a file is mounted on Linux, those
> files show up as another directory and its contents is inaccessible.
> 
> I can replicate this using exfat filesystems, but not ntfs.

Microsoft exFAT specification explicitly disallow "." and "..", see:

https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification#773-filename-field

  The file names "." and ".." have the special meaning of "this
  directory" and "containing directory", respectively. Implementations
  shall not record either of these reserved file names in the FileName
  field.

On the other hand Microsoft FAT32 specification can be understood that
file may have long name (vfat) set to "." or ".." but not short name.

https://download.microsoft.com/download/0/8/4/084c452b-b772-4fe5-89bb-a0cbf082286a/fatgen103.doc (section Long Directory Entries)

  The characters may be any combination of those defined for short names
  with the addition of the period (.) character used multiple times
  within the long name.

Microsoft NTFS specification is not available.

OSTA UDF 2.60 specification does not disallow "." and ".." entries, but
specifies what UNIX operating system should do with invalid file names:

http://osta.org/specs/pdf/udf260.pdf (section 4.2.2.1.5 UNIX)

  A FileIdentifier that contains characters considered invalid within a
  UNIX file name for the current system environment, or not displayable
  in the current environment shall have them translated into “_” (#005E).

By default non-multi-volume Volume Set on UDF use Interchange Level 2
which do not have defined any restriction for File Identifier in UDF
reference ECMA 167 specification. Interchange Level 1 has following
restrictions:

https://www.ecma-international.org/publications-and-standards/standards/ecma-167/ (section 4/15.1)

  A sequence of fileid-characters shall be a sequence of d-characters
  (1/7.2) excluding SPACE, COMMA, FULL STOP and REVERSE SOLIDUS
  characters except as part of a code extension character (see 1/7.2.9.1).

So it means that "." and ".." entries could be stored on disk as valid
file names.

> This is what I did on Windows using rust:
> 
> 	use std::fs::File;
> 	use std::io::Write;
> 
> 	fn main() {
> 	    let mut file =
> 		File::create(r"\\?\D:\..").expect("create dot file");
> 	    file.write_all(b"Hello, world!").expect("write dot file");
> 	}
> 
> Now on Linux (I also created a file called ".").
> 
> [root@xywoleh tmp]# mount -t exfat /dev/loop0p1 /mnt
> [root@xywoleh tmp]# cd /mnt
> [root@xywoleh mnt]# ls -la
> total 20
> drwxr-xr-x. 5 root root 4096 Sep 27 11:47  .
> drwxr-xr-x. 5 root root 4096 Sep 27 11:47  .
> dr-xr-xr-x. 1 root root  176 Sep 21 11:05  ..
> dr-xr-xr-x. 1 root root  176 Sep 21 11:05  ..
> drwxr-xr-x. 2 root root 4096 Sep 27  2021 '$RECYCLE.BIN'
> drwxr-xr-x. 2 root root 4096 Sep 27  2021 'System Volume Information'
> 
> Microsoft says this:
> 
> https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file#win32-file-namespaces
> 
> 	Because it turns off automatic expansion of the path string, the
> 	"\\?\" prefix also allows the use of ".." and "." in the path names,
> 	which can be useful if you are attempting to perform operations on a
> 	file with these otherwise reserved relative path specifiers as part of
> 	the fully qualified path.
> 
> So, in Linux cannot read "." or ".." (i.e., I can't see "Hello, World!"). I
> don't know what the correct handling should be, but having two "." and two
> ".." files does not seem right at all.

This is really a bug in Linux kernel. It should not export "." and ".."
into VFS even when filesystem disk format supports such insane file
names.

For FAT32 we could show short file name instead of long name as short
name alias has explicitly disallowed "." and ".." names. I think that
NTFS has optional support for DOS short name alias. UDF specification
defines translation to "_" but it just opens a new question how to deal
with conflicts with real file name "_".

So either Linux needs to completely hide these insane file names from
VFS or translate them to something which do not conflict with other
files in correct directory.

I guess that hiding them for exfat is valid thing as Microsoft
specification explicitly disallow them. Probably fsck.exfat can be teach
to rename these files and/or put them to lost+found directory.

I'm really surprised that some filesystems specifications really allow
such insane file names and also the fact that there is an implementation
(Windows kernel) which allows creating them and it is even documented.

> Thanks,
> Sean
