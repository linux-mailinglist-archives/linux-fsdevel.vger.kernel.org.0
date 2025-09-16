Return-Path: <linux-fsdevel+bounces-61727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0DEB59674
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCFA3247F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 12:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A96830E838;
	Tue, 16 Sep 2025 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="VpniS6ED";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KaqRk9P6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F862877FC;
	Tue, 16 Sep 2025 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026675; cv=none; b=J/jmNMD7hUS1vLFGWOY7UPT0lRoDavAc9G95PdXRYk/d6RMq1/PpdUhC2UFRjkkxBUiZu6zzsTmEEBN7Q8cPgVo1TMcckTI8svsCp26bjWDbCQaF7fBJGKzD8KlziQqBsA3FB52T0c4d/iNgiD034kSTD7hqXWdyL3ayBrni+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026675; c=relaxed/simple;
	bh=pp6VS8wfKD4WbYFwKVJ9DgnVGuEkZwsqQIckY+Lzxw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zoh8PMzRGXqYhH8gRT4RUodFSDfLf/7NwIW8vGxEWfTpm/khaAFV5+n4AmMakRhgWvvu+j0y0TcSWGI2c+mY39NM39AKlSgOW+ScgTCr/9TiE5biepeQDaShH+VH78hwq2VBlXm/VDGnQoNkdzqJkWfyE2jQ7FkUAHYO0OwclCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=VpniS6ED; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KaqRk9P6; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B8E781D00274;
	Tue, 16 Sep 2025 08:44:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 16 Sep 2025 08:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758026671;
	 x=1758113071; bh=QMiHHL7HOro34ACIJzbC1zuje8l5Xh5uCKqtWdvq8yo=; b=
	VpniS6EDrSBqjBwrS6tDHvtZ2IglEDYuNuLP861f4foUE7HxBrQ80LaqoQp9ZuzD
	mboBWUffMxGu1NHvnao5TRBcADd2PEmkHjIDcO6Py8/ZGMXtlzgXWggEV6iaC1Kr
	cWm1vWicatX0mnNY/4QdTiucjBWel1m6HZ22tV92k5KsDedsFpFvOprYoHFJ9w9y
	u9leCmAsd3g6GahBhCxUiQcg7HYrOyGAQZcplVOtfACWHji3tYsZTlnvHoqKEKAA
	SIK7aZEeHw8RJCLE+PraMA0abISHjOKB6Ctljj8n/YZZ+ZriDGMsILQqbQcCMKMX
	oo7UUuKBLAxTk3ixA0wpVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758026671; x=
	1758113071; bh=QMiHHL7HOro34ACIJzbC1zuje8l5Xh5uCKqtWdvq8yo=; b=K
	aqRk9P6zTIAmAlQQuI6ctREiI4skKL9aXrzB3TmO/I4mOsZ4Nq1k7cqPU96uO9Ss
	fpdpYOn4rdWYtrIp/woxY7LZj9Ldfhx9aV3NhAPRjK+SZ18KiqKIfNVkmHadmd78
	GA5o24ZhFi62GSVyETfNEgKGAJrlIiUc/wYlFmb0JTceaLzhdg+xYHmecjKcG5P+
	JtzUBOqNsrglXiRVsFzhIxPKhGSTDIliiecYDPGJHSnJkZ9u7/64/sNhj0yMuJPG
	Hf9+sr9OkKuWk0meDXgwn/QH+/o1PT6V1huepTLJ5qq2XkvXWYV95/AdUioPzdwZ
	ocFvl7d9CbaBua85VHuuQ==
X-ME-Sender: <xms:rlvJaBCgyvZQLMj0FUNmGLsv7ycKdYe2NQR858lGFIGBP8TjiYo9wg>
    <xme:rlvJaLUmmzuSBnh_yaEg_y5zvVunY57qbdamTlGj1B4N8QNMjEHw0Jzqhkzr972HL
    rfuut45h2_rOEkt2BA>
X-ME-Received: <xmr:rlvJaDA9GYb6AzUFp1qtK29hauT-Lw_xZjwLOYlSXbOopis5kq0Ft2N5ylinBBqfC77W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtdeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduke
    evhfegvedvveeihedvvdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehlih
    hnuhigpghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepmhhitgesughi
    ghhikhhougdrnhgvthdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtohepvhelfhhs
    sehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghhnohgrtghksehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtg
    ii
X-ME-Proxy: <xmx:rlvJaIcyI2LlXBZRvujZfs4hSaQO4LbkfGhI1S5e5uzOWZlvF4P-WA>
    <xmx:rlvJaKpAgEIbReSEsCojnAFbPtYP9kXsFdNjVdrzQ7jb8FwCp7zzPw>
    <xmx:rlvJaJS0T_RxmYh5PGjrNj85YyiViwJYExgrxqd7SB2U7_bh3cB1kA>
    <xmx:rlvJaKWqLslmJMwnzQ_GuxaqmnA7pJZjZyobj6CPDZePHvtNbXTKXQ>
    <xmx:r1vJaARjZ1PADkXbfH4FLzxllL3oJkly5AJzXULYm2PkSoEGE7yYMTil>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 08:44:28 -0400 (EDT)
Message-ID: <6502db0c-17ed-4644-a744-bb0553174541@maowtm.org>
Date: Tue, 16 Sep 2025 13:44:27 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, v9fs@lists.linux.dev, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, linux-security-module@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Matthew Bobrowski <repnop@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <aMih5XYYrpP559de@codewreck.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <aMih5XYYrpP559de@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/16/25 00:31, Dominique Martinet wrote:
> (Thanks Christian, replying just once but your reply was helpful)
> 
> Tingmao Wang wrote on Mon, Sep 15, 2025 at 02:44:44PM +0100:
>>> I'm fuzzy on the details but I don't see how inode pointers would be
>>> stable for other filesystems as well, what prevents
>>> e.g. vm.drop_caches=3 to drop these inodes on ext4?
>>
>> Landlock holds a reference to the inode in the ruleset, so they shouldn't
>> be dropped.  On security_sb_delete Landlock will iput those inodes so they
>> won't cause issue with unmounting.  There is some special mechanism
>> ("landlock objects") to decouple the ruleset themselves from the actual
>> inodes, so that previously Landlocked things can keep running even after
>> the inode has disappeared as a result of unmounting.
> 
> Thank you for the explanation, that makes more sense.
> iirc even in cacheless mode 9p should keep inode arounds if there's an
> open fd somewhere

Yes, because there is a dentry that has a reference to it.  Similarly if
there is a Landlock rule referencing it, the inode will also be kept
around (but not the dentry, Landlock only references the inode).  The
problem is that when another application (that is being Landlocked)
accesses the file, 9pfs will create a new inode in uncached mode,
regardless of whether an existing inode exists.

> 
>> [...]
>>
>> I tried mounting a qemu-exported 9pfs backed on ext4, with
>> multidevs=remap, and created a file, used stat to note its inode number,
>> deleted the file, created another file (of the same OR different name),
>> and that new file will have the same inode number.
>>
>> (If I don't delete the file, then a newly created file would of course
>> have a different ext4 inode number, and in that case QEMU exposes a
>> different qid)
> 
> Ok so from Christian's reply this is just ext4 reusing the same inode..
> I briefly hinted at this above, but in this case ext4 will give the
> inode a different generation number (so the ext4 file handle will be
> different, and accessing the old one will get ESTALE); but that's not
> something qemu currently tracks and it'd be a bit of an overhaul...
> In theory qemu could hash mount_id + file handle to get a properly
> unique qid, if we need to improve that, but that'd be limited to root
> users (and to filesystems that support name_to_handle_at) so I don't
> think it's really appropriate either... hmm..

Actually I think I forgot that there is also qid.version, which in the
case of a QEMU-exported 9pfs might just be the file modification time?  In
9pfs currently we do reject a inode match if that version changed server
side in cached mode:

v9fs_test_inode_dotl:
	/* compare qid details */
	if (memcmp(&v9inode->qid.version,
		   &st->qid.version, sizeof(v9inode->qid.version)))
		return 0;

(not tested whether QEMU correctly sets this version yet)

> 
> (I also thought of checking if nlink is 0 when getting a new inode, but
> that's technically legimitate from /proc/x/fd opens so I don't think we
> can do that either)
> 
> And then there's also all the servers that don't give unique qids at
> all, so we'll just get weird landlock/fsnotify behaviours for them if we
> go that way...
> 
> -----------------
> 
> Okay, you've convinced me something like path tracking seems more
> appropriate; I'll just struggle one last time first with a few more open
> questions:
>  - afaiu this (reusing inodes) work in cached mode because the dentry is
> kept around;

Based on my understanding, I think this isn't really to do with whether
the dentry is around or not.  In cached mode, 9pfs will use iget5_locked
to look up an existing inode based on the qid, if one exists, and use
that, even if no cached dentry points to it.  However, in uncached mode,
currently if vfs asks 9pfs to find an inode (e.g. because the dentry is no
longer in cache), it always get a new one:

v9fs_vfs_lookup:
	...
	else if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
	else
		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
	...
v9fs_qid_iget_dotl:
	...
	if (new)
		test = v9fs_test_new_inode_dotl;
	else
		test = v9fs_test_inode_dotl;
	...
v9fs_test_new_inode_dotl:
	static int v9fs_test_new_inode_dotl(struct inode *inode, void *data)
	{
		return 0;
	}


> I don't understand the vfs well enough but could the inodes
> hold its dentry and dentries hold their parent dentry alive somehow?
> So in cacheless mode, if you have a tree like this:
> a
> └── b
>     ├── c
>     └── d
> with c 'open' (or a reference held by landlock), then dentries for a/b/c
> would be kept, but d could be droppable?

I think, based on my understanding, a child dentry does always have a
reference to its parent, and so parent won't be dropped before child, if
child dentry is alive.  However holding a proper dentry reference in an
inode might be tricky as dentry holds the reference to its inode.

> 
> My understanding is that in cacheless mode we're dropping dentries
> aggressively so that things like readdir() are refreshed, but I'm
> thinking this should work even if we keep some dentries alive when their
> inode is held up.

If we have some way of keeping the dentry alive (without introducing
circular reference problems) then I guess that would work and we don't
have to track paths ourselves.

> 
>  - if that doesn't work (or is too complicated), I'm thinking tracking
> path is probably better than qid-based filtering based on what we
> discussed as it only affects uncached mode.. I'll need to spend some
> time testing but I think we can move forward with the current patchset
> rather than try something new.
> 
> Thanks!

Note that in discussion with Mickaël (maintainer of Landlock) he indicated
that he would be comfortable for Landlock to track a qid, instead of
holding a inode, specifically for 9pfs.

(This doesn't solve the problem for fsnotify though)

Kind regards,
Tingmao

