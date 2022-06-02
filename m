Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A293A53B667
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 11:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiFBJx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 05:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiFBJxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:53:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FF438BFC;
        Thu,  2 Jun 2022 02:53:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45670614B9;
        Thu,  2 Jun 2022 09:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48252C385A5;
        Thu,  2 Jun 2022 09:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654163632;
        bh=I5Mm7R454ghX3y+4lNT7scOk785tAQqHkkGPCAKIiPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cU0O4BUWTfM7SfMOueIwu+MkdcuOE5k/cSh/FcAu5t51+nKHKNY1U19B7Gw3J+ORR
         QS7pIK9OFE4kJzd3H7V/dLP632UmSl4YLKZ3xS/Ndjt8Q1wz6UKCHJM/fpKdxajp9x
         oosP5B+ViSDDSta92zFKwdkYc8kezdsTTsTRXK9igX9v4WIKshwI1cGOcnjuwBemsJ
         adhta/wWLsDN5GVJjYa0hAyiFzWdT+G4snVuWrf3zh1m7MPqZ7X8sIweL/UjELU7sh
         vbj72mqE4j9oegex5YKsy3G5QdqU+dDDMoPxXvkBw2GAg4oCMx3tNxyr3GFMz3Cp83
         7tGiRDl5wB+Yw==
Received: by pali.im (Postfix)
        id 21192689; Thu,  2 Jun 2022 11:53:49 +0200 (CEST)
Date:   Thu, 2 Jun 2022 11:53:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Sean Young <sean@mess.org>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Incorrect handling of . and .. files
Message-ID: <20220602095349.7yttadyibgw5za5y@pali>
References: <20210927111948.GA16257@gofer.mess.org>
 <20211211020453.mkuzumgpnignsuri@pali>
 <YbbskNBJI8Ak1Vl/@angband.pl>
 <20211213113903.bkspqw2qlpct3uxr@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211213113903.bkspqw2qlpct3uxr@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 13 December 2021 12:39:03 Pali Rohár wrote:
> On Monday 13 December 2021 07:47:44 Adam Borowski wrote:
> > On Sat, Dec 11, 2021 at 03:04:53AM +0100, Pali Rohár wrote:
> > > I tried to find some information what is allowed and what not.
> > > 
> > > On Monday 27 September 2021 12:19:48 Sean Young wrote:
> > > > Windows allows files and directories called "." and ".." to be created
> > > > using UNC paths, i.e. "\\?\D:\..". Now this is totally insane behaviour,
> > > > but when an exfat filesytem with such a file is mounted on Linux, those
> > > > files show up as another directory and its contents is inaccessible.
> > > > 
> > > > I can replicate this using exfat filesystems, but not ntfs.
> > > 
> > > Microsoft exFAT specification explicitly disallow "." and "..", see:
> > [...]
> > > On the other hand Microsoft FAT32 specification can be understood that
> > > file may have long name (vfat) set to "." or ".." but not short name.
> > [...]
> > > OSTA UDF 2.60 specification does not disallow "." and ".." entries, but
> > [...]
> > > So it means that "." and ".." entries could be stored on disk as valid
> > > file names.
> > 
> > It doesn't matter one whit what the specification says.  Anyone with a disk
> > editor can craft a filesystem containing filenames such as "." or "..", "/"
> > "foo/bar" or anything else we would like to ban.
> 
> That is truth. But question is what should do fsck tools with such file
> names on filesystems where "." and ".." are permitted? Fully valid
> argument is "do not touch them" because there is nothing bad with these
> names.
> 
> > > > So, in Linux cannot read "." or ".." (i.e., I can't see "Hello, World!"). I
> > > > don't know what the correct handling should be, but having two "." and two
> > > > ".." files does not seem right at all.
> > > 
> > > This is really a bug in Linux kernel. It should not export "." and ".."
> > > into VFS even when filesystem disk format supports such insane file
> > > names.
> > 
> > This.
> > 
> > Otherwise, every filesystem driver would need to contain redundant code for
> > checking for such bad names.
> > 
> > > So either Linux needs to completely hide these insane file names from
> > > VFS or translate them to something which do not conflict with other
> > > files in correct directory.
> > 
> > Escaping bad names has the problem of the escaped name also possibly
> > existing -- perhaps even recursively.  Plus, the filesystem might be using
> > hashed or tree indices which could go wrong if a name is altered.
> 
> vfat has already own escaping scheme and it is documented in mount(8)
> manpage. Invalid characters are translated either to fixed char '?' or
> to ':'... esc sequence if uni_xlate mount option is used. But it looks
> like that that kernel vfat driver do not have these two entries "." and
> ".." in its blacklist.
> 
> And, another important thing about vfat is that it has two file names
> for each file. One short 8.3 and one long vfat. Short 8.3 do not allow
> "." or "..", so another possibility how to handle this issue for vfat is
> to show short 8.3 name in VFS when long is invalid.
> 
> For UDF case, specification already says how to handle problematic
> file names, so I think that udf.ko could implement it according to
> specification.
> 
> But for all other filesystems it is needed to do something ideally on
> VFS layer.
> 
> What about generating some deterministic / predicable file names which
> will not conflict with other file names in current directory for these
> problematic files?

PING? Any opinion how to handle this issue?

For VFAT this is still open question.

> > But then, I once proposed (and I'm pondering reviving) a ban for characters
> > \x01..\x1f and possibly others, and if banned, they can still legitimately
> > occur in old filesystems.
> > 
> > > I guess that hiding them for exfat is valid thing as Microsoft
> > > specification explicitly disallow them. Probably fsck.exfat can be teach
> > > to rename these files and/or put them to lost+found directory.
> > 
> > fsck fixing those is a good thing but we still need to handle them at
> > runtime.
> 
> Namjae Jeon, would you be able to implement fixing of such filenames in
> fsck.exfat tool?
> 
> > 
> > Meow!
> > -- 
> > ⢀⣴⠾⠻⢶⣦⠀
> > ⣾⠁⢠⠒⠀⣿⡁ in the beginning was the boot and root floppies and they were good.
> > ⢿⡄⠘⠷⠚⠋⠀                                       -- <willmore> on #linux-sunxi
> > ⠈⠳⣄⠀⠀⠀⠀
