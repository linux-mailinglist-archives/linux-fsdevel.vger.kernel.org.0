Return-Path: <linux-fsdevel+bounces-62344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F70B8DF62
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 18:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF5E3B9292
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BBA1E3DE5;
	Sun, 21 Sep 2025 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="XKwnksBr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jkVD54yU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816AB15A848;
	Sun, 21 Sep 2025 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758471897; cv=none; b=FkdJ85fuViA4VPNORG2mdP3juwm+7OHUBBfBdPyXDBrzFVY2YVz6+4P9zOnv8J/wekIMjtCt6QHZXiAG2+VGOMWwtByajPvovUGMvEt2mEd78AOwRPKP34yZROiR25DTdUsgDXr3Ai9bgdkG4fzHNQX7AijpP99gGII3fwA8J04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758471897; c=relaxed/simple;
	bh=vofvVqIwEXXUJakzj5j7rwP9RPw89yZQ+UZ8CoeIav4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KowRh6tCI816XzceidM6KD1CocvVG3OTaSzphRISK1t6pIY32j3Kw23LMGhuko4WEcutI7KxkRSgElHmK79keA2J8z1nxxnutsEG3QujldLcjMp3ezJgqEwKWj15dE0YJc8gcIdoWmOZQFbsTqS4X0/u3FhF4Z51B4ECQjSL40Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=XKwnksBr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jkVD54yU; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D4F41D000A9;
	Sun, 21 Sep 2025 12:24:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 21 Sep 2025 12:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758471894;
	 x=1758558294; bh=4eL43QlVEchwrR99hYuuh9qOZvowspMF0C2vAQGQJF0=; b=
	XKwnksBrWk2Sg12kuShfGuyNCaDOK+WTQf8peBwkmX4EbsHXzEOmdiPNDdHJ77s6
	1Ki+veEMPWpAJJDLuSqYx9gLvjfNuZ5bKbgxXsL96clTisawHmweXNF0lReYefvf
	/AHuDZs47I3Hf5FQ2AEbwqbEzDiqI6aKk0rADjPxi7WAdbVAehmZmsFw7wxGZY3X
	XRGnReZ4QYjQ3FJQrXr7T6EX7R94CR6XRQWnP3Sm8ttNmD/Y5/1d5k7LLhpfGz12
	QjechboMS1mZLd67xkxf+fwLe1n2qDv2mx/ybwr/Z1pnQDZpdRR7vG7DGMxub1QK
	GUrpvFMxmY4O/SBIRWhttA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758471894; x=
	1758558294; bh=4eL43QlVEchwrR99hYuuh9qOZvowspMF0C2vAQGQJF0=; b=j
	kVD54yUn9RjtYkPscv8FdUaziPtbNHg5+gpT9q1wNiXcmY4U4A2wHyTmnuWJAhgJ
	LcBYhDnYNhF/P+XoeFoO84Y1m0g3WVdcVvYYk9ErQMbHB578wY8wTUxEmlPQKWy9
	jtDz/x1DUQVQx+0DIaMofFTuiemWsXrl6eLryx8vQVdP7kJMclZ/kuRFITZHO24p
	OhRAsTAI6DVlxtzBhj/IoRZ9PQM/VVI5w1zOz5y4Z5Ys6Ufu+66os8SBUOMYZiK8
	Cg1o6Sol75qUUZCM0mSTX+hxGjfprnSgJDg6FsnMU+ri4Z47K879qNWZLhG7bmsu
	k5numXpZj342P8y1l/eDA==
X-ME-Sender: <xms:1CbQaFCnR_Yxk0zFVAoaHV5voz_g3cB9o3IytAs3BWxGIF9LDxnugA>
    <xme:1CbQaLYnP_VLvG-OKmcDZTllDieir_2sJxTxl41y1LegyY1QEendaGDU31h0FiUdY
    RcZtqGNvnQ46iLFIIE>
X-ME-Received: <xmr:1CbQaP_LDE0nTtYc2i_fO15GoOQ5GDRPfWuQMcR3p4ExrmK2akozsndg9yig1wpU33MWMjCpeC9DCizTvbepKuuj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehheeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeetie
    evfeeifefgtdeikeegfeffteeiffetieeffeeiffekieekgeejlefhhefhhfenucffohhm
    rghinhepghhithhlrggsrdgtohhmpdhmrghofihtmhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdp
    nhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlih
    hnuhigpghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepmhhitgesughi
    ghhikhhougdrnhgvthdprhgtphhtthhopegrshhmrgguvghushestghouggvfihrvggtkh
    drohhrghdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtohepvhelfhhssehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:1CbQaHh9H5NveD9HuZPGMvD6y1U4RDzx3LjOeWxmVjTYc8Q0YrA4ng>
    <xmx:1CbQaCh6SImBUq__lNR0gAwMUQKeAnCLFA6w1EIqk7zzPK2G4ixdVA>
    <xmx:1CbQaN4OeFSgIS3eiw6DCDCO79_hJgGXCBsBe0kd2edELaBbg8IU9g>
    <xmx:1CbQaEQUiN4mnmjj9TDmLkXoxq9EXvdV0pW_oVM2O4iuP13jFd1iSQ>
    <xmx:1ibQaJgXPVXMmg1WWkLOp-MJphg3qYzsBpOMn3tZTW2uubpWQ_nRDaVF>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Sep 2025 12:24:51 -0400 (EDT)
Message-ID: <f1228978-dac0-4d1a-a820-5ac9562675d0@maowtm.org>
Date: Sun, 21 Sep 2025 17:24:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
To: Christian Schoenebeck <linux_oss@crudebyte.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org
References: <aMih5XYYrpP559de@codewreck.org> <3070012.VW4agfvzBM@silver>
 <f2c94b0a-2f1e-425a-bda1-f2d141acdede@maowtm.org> <3774641.iishnSSGpB@silver>
 <20250917.Eip1ahj6neij@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250917.Eip1ahj6neij@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/17/25 16:00, Mickaël Salaün wrote:
> On Wed, Sep 17, 2025 at 11:52:35AM +0200, Christian Schoenebeck wrote:
>> On Wednesday, September 17, 2025 1:59:21 AM CEST Tingmao Wang wrote:
>>> On 9/16/25 20:22, Christian Schoenebeck wrote:
>>>> On Tuesday, September 16, 2025 4:01:40 PM CEST Tingmao Wang wrote:
>> [...]
>>>> I see that you are proposing an option for your proposed qid based
>>>> re-using of dentries. I don't think it should be on by default though,
>>>> considering what we already discussed (e.g. inodes recycled by ext4, but
>>>> also not all 9p servers handling inode collisions).
>>>
>>> Just to be clear, this approach (Landlock holding a fid reference, then
>>> using the qid as a key to search for rules when a Landlocked process
>>> accesses the previously remembered file, possibly after the file has been
>>> moved on the server) would only be in Landlock, and would only affect
>>> Landlock, not 9pfs (so not sure what you meant by "re-using of dentries").
>>>
>>> The idea behind holding a fid reference within Landlock is that, because
>>> we have the file open, the inode would not get recycled in ext4, and thus
>>> no other file will reuse the qid, until we close that reference (when the
>>> Landlock domain terminates, or when the 9p filesystem is unmounted)
>>
>> So far I only had a glimpse on your kernel patches and had the impression that 
>> they are changing behaviour for all users, since you are touching dentry 
>> lookup.
> 
> I think we should not hold dentries because:
> - they reference other dentries (i.e. a file hierarchy),
> - they block umount and I'm convinced the VFS (and users) are not going
>   to like long-lived dentries,
> - Landlock and inotify don't need dentries, just inodes.
> 
> I'm wondering why fid are referenced by dentries instead of inodes.
> 
> The need for Landlock is to be able to match an inode with a previously
> seen one.  Not all LSM hooks (nor VFS internals) always have access to
> dentries, but they do have access to inodes.
> 
>>
>>>> For all open FIDs QEMU retains a descriptor to the file/directory.
>>>>
>>>> Which 9p message do you see sent to server, Trename or Trenameat?
>>>>
>>>> Does this always happen to you or just sometimes, i.e. under heavy load?
>>>
>>> Always happen, see log: (no Trename since the rename is done on the host)
>> [...]
>>> Somehow if I rename in the guest, it all works, even though it's using the
>>> same fid 2 (and it didn't ask QEMU to walk the new path)
>>
>> Got it. Even though QEMU *should* hold a file descriptor (or a DIR* stream, 
> 
> It's reasonable to assume that QEMU and other should hold opened fid In
> practice, this might not always be the case, but let's move on and
> consider that a 9p server bug.
> 
> Landlock and fanotify need some guarantees on opened files, and we
> cannot consider every server bug.  For Landlock, inode may get an
> "ephemeral tag" (with the Landlock object mechanism) to match previously
> seen inodes.  In a perfect world, Landlock could keep a reference on 9p
> inodes (as for other filesystems) and these inodes would always match
> the same file.  In practice this is not the case, but the 9p client
> requirements and the Landlock requirements are not exactly the same.
> 
> A 9p client (the kernel) wants to safely deal with duplicated qid, which
> should not happen but still happen in practice as explained before.
> On the other side, Landlock wants to not deny access to allowed files
> (currently identified by their inodes), but I think it would be
> reasonable to allow access theoretically denied (i.e. not allowed to be
> precise, because of the denied by default mechanism) files because of a
> 9p server bug mishandling qid (e.g. mapping them to recycled ext4
> inodes).
> 
> All that to say that it looks reasonable for Landlock to trust the
> filesystem, and by that I mean all its dependencies, including the 9p
> server, to not have bugs.
> 
> Another advantage to rely on qid and server-side opened files is that we
> get (in theory) the same semantic as when Landlock is used with local
> filesystems (e.g. files moved on the server should still be correctly
> identified by Landlock on the client).
> 
>> which should imply a file descriptor), there is still a path string stored at 
>> V9fsFidState and that path being processed at some places, probably because 
>> there are path based and FID based variants (e.g Trename vs. Trenameat). Maybe 
>> that clashes somewhere, not sure. So I fear you would need to debug this.
> 
> Good to know that it is not a legitimate behavior for a 9p client.

So I did some quick debugging and realized that I had a wrong
understanding of how fids relates to opened files on the host, under QEMU.
It turns out that in QEMU's 9p server implementation, a fid does not
actually correspond to any opened file descriptors - it merely represents
a (string-based) path that QEMU stores internally.  It only opens the
actual file if the client actually does an T(l)open, which is in fact
separate from acquiring the fid with T(l)walk.  The reason why renaming
file/dirs from the client doesn't break those fids is because QEMU will
actually fix those paths when a rename request is processed - c.f.
v9fs_fix_fid_paths [1].

It turns out that even if a guest process opens the file with O_PATH, that
file descriptor does not cause an actual Topen, and therefore QEMU does
not open the file on the host, and later on reopening that fd with another
mode (via e.g. open("/proc/self/fd/...", O_RDONLY)) will fail if the file
has moved on the host without QEMU's knowledge.  Also, openat will fail if
provided with a dir fd that "points" to a moved directory, regardless of
whether the fd is opened with O_PATH or not, since path walk in QEMU is
completely string-based and does not actually issue openat on the host fs
[2].

I'm not sure if this was is intentional in QEMU - it would seem to me that
a fid should translate to a fd (maybe opened with just O_PATH) on the
host, and path walks based on that fid should be done via openat with this
fd, which will also "automatically" handle renames without QEMU needing to
fixup the string paths?

In any case, this probably means that even if Landlock were to hold a fid
reference, and QEMU does qid remapping, that's still not enough to
guarantees that we won't have a different, unrelated file ending up with
the same qid, at least under ext4.

I'm not sure what's the way forward - would Landlock need to actually
"open" the files (or do something that will cause a Topen to be issued by
v9fs)?  Alternatively if we believe this to be a QEMU issue, maybe
Landlock don't need to work around it and should just hold fids (and use
QIDs to key the rules) anyway despite server quirks like these.  This can
perhaps then be fixed in QEMU?

(I guess the fact that QEMU is doing path tracking in the first place does
gives more precedent for justifying doing path tracking in v9fs as well,
but maybe that's the wrong way to think about it)

Test programs: openat.c [3], open_procselffd.c [4]


[1]: https://gitlab.com/qemu-project/qemu/-/blob/44f51c1a3cf435daa82eb757740b59b1fd4fe71c/hw/9pfs/9p.c#L3403
[2]: https://gitlab.com/qemu-project/qemu/-/blob/371a269ff8ce561c28e4fa03bb49e4940f990637/hw/9pfs/9p-local.c#L1243
[3]: https://fileshare.maowtm.org/9pfs-landlock-fix/20250921/openat.c
[4]: https://fileshare.maowtm.org/9pfs-landlock-fix/20250921/open_procselffd.c

