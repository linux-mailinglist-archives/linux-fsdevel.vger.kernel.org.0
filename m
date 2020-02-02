Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77A7314FFDA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2020 23:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgBBWx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Feb 2020 17:53:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53642 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727053AbgBBWx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Feb 2020 17:53:29 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 012MrLER017940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 2 Feb 2020 17:53:22 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8BBD9420324; Sun,  2 Feb 2020 17:53:21 -0500 (EST)
Date:   Sun, 2 Feb 2020 17:53:21 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: About read-only feature EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS
Message-ID: <20200202225321.GA560191@mit.edu>
References: <4697ab8d-f9cf-07cc-0ce9-db92e9381492@gmx.com>
 <F933761F-D748-4FD9-9FC3-2C52D7CA205D@dilger.ca>
 <546928bf-842e-0f2d-721b-216f04c696ec@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546928bf-842e-0f2d-721b-216f04c696ec@gmx.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The production Android system image is designed not to be modifiable,
for security reasons.  Otherwise it's possible for malware to make
changes to a system image in such a way that it's essentially
impossible to remove the malware.  This includes (1) a bootloader that
can only be unlocked using a proof of physical preference (so that a
malware can't do remotely; it requires a human to physically reset the
computer, and then use the physical volume buttons so the user can
explicitly agree to erase all of the data and unlock the bootloader
--- the last bit is so that if the phone falls into the hands of
someone bad, they can't use the boot unlock to gain access to the
user's sex tapes), (2) dm-verity to protect the system image so that
even if malware can break root, it can't make changes to the system
image so that security breach persist past a reboot, and (3) on new
phones with fs-verity, privileged APK's (think: setuid root
executables in traditional Linux systems) which are stored on the
user's data partition are protected against modification by malware.

So the basic idea is that even if the Ministry of State Ministry takes
away your phone at the China's border check, the goal is to make it as
hard as possible for the malware to persist beyond a reboot and
removal of said malware installed by the MSS when entering the
country.  (Or replace MSS by CIA, NSA, KGB, BND, Mossad, etc.,
depending on your citizenship and which country you are paranoid
against.  :-)

So it's in this environment where the goal is to make it as hard as
possible for a border guard or intelligence agent covered as a hotel
maid, to make changes to the system image that won't be rejected by
the system software after a reboot, that the goal was made to save
space by using a block-level dedupe.

Ext4's data structures make it very hard to support read/write
copy-on-write / reflink scheme.  It could be done, but someone would
have to replace ext4's block allocatiopn bitmaps with a jbd2-protected
b-tree which kept track of refcounts on an extent basis.  If someone
is interested in implementing such a thing; feel free to contact me.
(For now, I don't know of any of the current ext4 developers who work
at a company which has a business reason for such a feature.  And the
feature is too complex to implement as a Google Summer of Code or
Outreachy project.)

But for now; we don't have such a thing, so the simplest way to
implement block-level dedupe is to do it by simply having multiple
inodes reference the same physical block.  It is not safe to mount
such a file system read/write, since if one of the inodes containing
the deduped block is deleted, the block will be marked unused, even
though other inodes are still using that block.

Fortunately, for Android's use case, the system image is already
*designed* to make it as hard as possible for foreign agents (or
criminals) to modify.  And that's the context behind which
EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS was developed.  It didn't have an
evil motive --- well, unless you are a member of the Chinese MSS, or
the American FBI; then you probably hate Android/Google, but you
probably also hate Apple/IOS equally and consider them evil, just like
the US Attorney General Bill Barr.  :-)

As far as how to create file systems using this feature, the core code
to create it is in the contrib/android directory in the e2fsprogs
sources, where the sources for the e2fsdroid and ext2simg are located.

Yes, there is no Makefile.in; it is currently built using the Android
build system, in the AOSP.  It would be great to be able to build it
using the traditional Linux toolchain; again, if you are interested,
please let me know; patches are appreciated, since I don't have time
to work on it at the moment.  Actually, if you have time, it would be
great to work on Debian Bug #928551[1] first, since this will allow
e2fsprogs to be built in a way that allows fastboot to be installed,
and this will also be a prerequisite if you want e2fsdroid and
ext2simg to be shippable in a Linux distro (since otherwise we'd have
to build a e2fsprogs in a way that drags in a whole bunch of
Android-related shared libraries into the Debian, Red Hat, SuSE,
installers and bootstrap chroots; and that's a non-starter for most
distros).

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=928551

Also missing is documentation for e2fsdroid and ext2simg.  Sorry, the
original work was done by an intern, and he left before having time to
document it all.  (Again, I find that it's better not to attribute
something to company being evil when it can be explained by an intern
who needed to get the project done in 12-14 weeks before he or she
needs to go back to complete their undergraduate career. :-)

How e2fsdroid is called is in AOSP, and yes, I'm afraid if you can't
figure it out by reading the sources in contrib/android in e2fsprogs,
you may need to look at the AOSP tree to see how it is used.

Speaking of AOSP, that may ultimately be the easist way to make a
change to the system image.  The assumption was that anyone who wanted
to make a change would either (a) built a userdebug image, which
allows you to get root by using "adb root", and where the image is not
protected using dm-verity and is not built using
RO_COMPAT_SHARED_BLOCKS --- so the image is larger, and not protected
against sophisticated adversaries and malware, but it's convenient for
developers.  This is what the Android developers at Google .  Or, (b)
that you would simply rebuild the system image from sources with
whatever changes you want to make to config filess, etc.

If you are using a Google Pixel device, userdebug images and
instructions on how to flash them are available[2].  And of course,
full sources with instructions are available so you can build the
images from scratch, with whatever changes you want[3].

[2] https://source.android.com/setup/build/running
[3] https://source.android.com/setup

If you are using a mobile device from another manufacturer, you'll
have to contact them for sources and ask them if they make userdebug
images available.

> Exactly what I'm going to try.
> 
> (Thankfully EXT4 hasn't implemented data checksum)

Actually, see above; Android system images are protecting by
dm-verity, which is a block-level checksum, for security reasons.  So
just making changes to a block is probably not going to work, because
the kernel's dm-verity code can't tell the difference between you and
the Chinese MSS.  :-)

Cheers,

					- Ted
