Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C48251BF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 17:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgHYPMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 11:12:19 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:49545 "EHLO
        lizzy.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgHYPMQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=0MI3VOiyX28BCPCWkXuL10WyW/l8Djt/ohsk/duKLBE=; b=LowtZwq96wp58HqH3XFfU/3cK6
        VlyyNAmPeGs7Swhz78P277uAsaY4+I0o2UIm5spuyUTDahfp9JEv/2fziWZPrf5hXWc2C6kUpj82a
        DxFROyIIi5W7pPOiX68vL15rZRGipag7Q7uif436nhWcwe7Ti+Qz+61pKwLGeVG2zm1oiWaNtlBvv
        N8wnN40GcNCi8RnywU4bt9X3CYImLgXXtcTjzFJwdQGlBfJe/NEsudUbNJm7FgVhdH461zRDBivDg
        4Sp8Rz4EQ96DSoBWJncjaZUHNAqNLrLZV7q1Q0tTNHCgwhdfpJnM52y7BDBKN33GFrd2hItrBbWyF
        okWobF3Q==;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: file forks vs. xattr (was: xattr names for unprivileged stacking?)
Date:   Tue, 25 Aug 2020 17:12:01 +0200
Message-ID: <3918915.AdkhnqkaGN@silver>
In-Reply-To: <20200824222924.GF199705@mit.edu>
References: <20200824222924.GF199705@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Montag, 24. August 2020 22:01:43 CEST Miklos Szeredi wrote:
> > But as they already pointed out, it would be a problem to actually agree
> > about a delimiter between the filename and the fork name portion. Miklos
> > suggested a a double/triple slash, but I agree with other ones that this
> > would render misbehaviours with all sorts of existing applications:
> > https://lore.kernel.org/lkml/c013f32e-3931-f832-5857-2537a0b3d634@schaufle
> > r-ca.com/
> That argument starts like this:
> 
>  - Path resolution has allowed multiple slashes in UNIX systems for 50
> years, so everyone got used to building paths by concatenating things
> ending in slashes and beginning in slashes and putting more slashes in
> the middle.
> 
> This can't be argued with, we probably have to live with that for 50
> more years  (if we are lucky).
> 
> The argument continues so:
> 
>  - Because everyone got lazy, we can't introduce a new interface with
> new rules, because all those lazy programmers won't be bothered to fix
> their ways and will use the old practices while trying to use the new
> interface, which will break their new apps.
> 
> Huh?  Can't they just fix those broken apps, then?

Picking a delimiter is a huge problem. No matter which delimiter you choose, 
you will always find people screaming out loud.

However the slash character is in fact one that would cause much more trouble 
than other alternatives. The sheer amount of code that blindly concatenates 
pathes without eliminating redundant slashes already renders it an unrealistic 
candidate IMO.

I can give you another argument which might be more convincing to you: say you 
maintain a middleware lib that takes a path as argument somewhere, and that 
lib now gets path="/foo//bar". How could that lib judge whether it should a) 
eliminate the double slash, or rather b) it was really meant to be fork "bar" 
of file "foo" and hence shall pass the string as-is to underlying 
framework(s)? Simply: It can't, as it requires knowledge from either upper or 
lower end that the lib in the middle might not have.

Whatever the delimiter would be, it should at least be an ASCII character (or 
sequence of). If you'd pick a binary or some odd Unicode character, the 
outcome would be that each shell would remap their own ASCII delimiter on top 
of it, and that's actually the oppositive of what a built-in path resolution 
should accomplish, right?

> The most important thing, I think, is to not fragment the interface
> further.  So O_ALT should allow not just one application (like ADS)
> but should have a top level directory for selecting between the
> various data sources.

Well, that's what name spaces are for IMO. So you would probably reserve some 
prefixes for system purposes, like it is already done for Linux xattrs. Or do 
you see any advantage for adding a dedicated directory layer in between 
instead?

On Dienstag, 25. August 2020 00:29:24 CEST Theodore Y. Ts'o wrote:
> On Mon, Aug 24, 2020 at 05:30:18PM +0200, Christian Schoenebeck wrote:
> > Being realistic, I don't expect that forks are something that would be
> > landing in Linux very soon. I think it is an effort that will take its
> > time, probably as a Linux-test-fork / PoC for quite a while, up to a
> > point where a common acceptance is reached.
> 
> We're talking *decades*.  It's not enough for new protocol specs for
> https, rsync, nfs, etc., to be modified, and then implemented.  It's
> not enough for file formats for zip, xz, gzip, etc., to be created;
> all of this new software has to be deployed throughout the entire
> ecosystem.  People don't upgrade server software quickly; look up long
> IPv6 has taken to be adopted!

I am not endorsing forks for every app and user on the planet. Like other 
people who come up with new kernel features, I am just suggesting it because I 
am actually using them in an heterogenous network already, and the Linux nodes 
are the missing brick not supporting them yet.

My personal plan (if viable acceptance):

- At least basic support for forks inside the Linux kernel (e.g. *at() 
  functions).

- Adding support to ZFS, which provides most of it under the hood already.

- Modifying some Samba VFS modules to support those forks natively.

- Minor additions to QEMU.

That's already sufficient as starting point for my existing use cases. Other 
user space apps involved (e.g. on macOS) are already supporting forks.

> In that amount of time, it's going to be easier to implement a more
> modular application container format which allows for new features to
> be added into a file --- for example, such as ISO/IEC 26300....

That would provide an alternative for only a small portion of use cases of 
forks. E.g. even in the example I mentioned about adding features to a foreign 
file format, the point of using forks in that example was that you are *not* 
in charge of file format aspects. Companies of proprietary file formats are 
often not very keen to open their format to other companies at all.

And even if you would limit the problem to the open source world, it is 
unlikely that every OSS app would adopt and switch to ODF format for several 
reasons.

Just look how many media container formats are out there. Despite their 
individual codecs and precise payload being used; theoretically they could all 
have switched to exactly one container format, right? Just didn't happen.

> > Ok, maybe I should make this more clear with another example: one major
> > use
> > case for forks/ADS is extending (e.g. proprietary) binary file formats
> > with
> > new features. Say company B is developing an editor application that
> > supports working directly with a binary media file (format) of another
> > company A. And say that company B's application has some feature that
> > don't exist in app of company A.
> 
> But that's going to happen today (company B's feature silently getting
> dropped) when using data forks/ADS if the file is sent via zip,
> http/https, compressed using gzip, xz, bzip2, etc.  I remember that
> world when I had to deal with with MacOS files decades ago, and it was
> a total mess.

That's because you were transferring files between a system that supported 
forks vs. a system that did not support them. And that's exactly the problem I 
want to fix, because right now I have to remap forks on Linux to separate 
files for not losing data, or use archives, or other hacks.

Really, it is not about convincing people to use or not use forks. They are 
already there. It is about integrating Linux into such an existing 
infrastructure appropriately.

> They aren't actually used all that often with Windows/Windows Office.
> That's why you can upload/upload a docx file via https, or check it
> into git, etc. without it being broken.  (Trying doing that with an
> old-style MacOS file with resource forks; what a nightmare....)

You zip them, upload, download, unzip.

And right, you don't need forks for every file that you share with other 
people. But I don't see why that would put Linux support for forks into 
question.

On Montag, 24. August 2020 23:26:56 CEST Frank van der Linden wrote:
> When I implemented for NFS "user." xattrs, I noticed these things:
> 
> * Extended attributes have no common caching, so each filesystem implements
>   its own, which is a waste.
> * There is quite a bit of k(v)alloc-ing and copying going on, and it's hard
>   to avoid.
> * Given that, the upper size limit is understandable, but still feels kind
> of arbitrary.
> 
> So, it would be great to have alternate data streams, and put xattrs on top
> of them. Essentially they'd be streams with reserved names that are always
> locked for the reader or writer and only allow reads/writes at offset 0,
> and always truncate on write.

That would unify the existing Linux xattrs and forks, and probably simplify 
the code base, right. But I can imagine that some people would not be happy 
with this, as you basically force them to opt-in into that 'fork'-enabled code 
set when they are actually just about using old xattrs.

Personally I would leave them orthogonal, i.e. a fork could have xattrs on its 
own.

Best regards,
Christian Schoenebeck


