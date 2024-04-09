Return-Path: <linux-fsdevel+bounces-16490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB34389E39F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B3D1F222EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E438A157A5D;
	Tue,  9 Apr 2024 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="1OuKEq82"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187F156F5D
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691085; cv=none; b=uLMXske+Q/+g+OQjvKgUV6ynza71uSe34lEu+ziiW8aWiy1qgl82qQ81F3YMrzqK7ytNt1PQkAYSnVlWPLf9TquhmrRfi0sH85Tw3PP3xXfBySxoaOVfA6dVrjPfeIiMO911bl+uPQkafFzkzGHkGRlEihL0rs79XXUVk7VfSi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691085; c=relaxed/simple;
	bh=r3oaYNNeLntvNV12v5ISfGztrNAjroY69ZkeLyThNNY=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=ejp86fRpF/wnOOFcfs5SbrPWx91jRO8aFEs+I0kF2JgKsUKMMZImyFvuZR3pgKnREGaMrf3MoSRlkOk8Q8TAaRNYuqxv2oDAo7NapNKCku2YLmmLHlg9eY5KagdE6InohJ0N+brQn5VzLrjILYeu4+Ngc1Ep4rqMR7FJ+pd2+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=1OuKEq82; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso4255822a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712691082; x=1713295882; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zkqBW13xKJfREHcFryvAOleoMYv1R7hLODFSXkPVC0g=;
        b=1OuKEq82bwGHZXsnnxxGLKbc8pm1TqYVQEQs1l7z60MAbZN0zj/Sq1xap6nKLRK0pN
         d8IDAAWHnd+c0h+NZVXRGu6Z+/sDkH8HeqgaLlKFPn7/i+B8Ngzz1nbsHAaAoVUJ34qO
         hTZdvK3MRriLQAJrt+WCHef7SLPgpEN5J0oYVP1C8irWselwnK86YWi7XfWKLu7afVJV
         7Gyrt2AGWJBnCUfU/oGwHd+lppRC1YQN/LexvMsSDUZdzf9fsNEabOEnSFqUL3A1L2+J
         V486V3kTXZqUd+IOLGPMm50nAZSqWhAe7iUkIMOa9e7jT0Ja1FEdJKrIrmWQftuq0xhE
         R3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712691082; x=1713295882;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkqBW13xKJfREHcFryvAOleoMYv1R7hLODFSXkPVC0g=;
        b=lMqDP3pOP9LFHJ85FetQJ2tkVc64irZDM4wTky/yW60fdCFcyM8tOgvzSrGddxiZRT
         f7ZMMjpELSzmGeIfaHfOqyJyidjK6p1GbG3VjF80YS9D51tPeeraMpnXGsGCZu3slU5I
         pJ4w6CQlPYtysc/+vcnZpoD0ds43m6f/0cTV3DUvCGkWhyhDg2Fm8CpKDn8Iytd5NlPf
         NOFICkO4E84BtI4aK453Kquqg0nuOuzrJcNp2l70QSgbU//Qe+ENi/996o/xfSXWwpvE
         qMvcI0M02zXqizHCJG5IPxdqooNcRqPcjtUDtCZGN7fOzfbtHGQ5F0YPUtCMt7iSoNkz
         UDgA==
X-Forwarded-Encrypted: i=1; AJvYcCXt8QZdEGIVxlt6M5kTm9PJ7Q4sQFmm4srnwQV5qrBRC6YUWm2eX9FZS/gm5anOFd6H83ptIeu/wZK8nEN+D3R76kxX08/KaAhmjYYLSg==
X-Gm-Message-State: AOJu0Yw6Rr/V8obdJuF1LbiffNXTya1icNjdlh14L3Hzp4avrJfLpfoS
	ssS+1rHLcgc8cmD6TXUntcmX6INvlJRfG5SECxlygIS1NkmWa6lV0Mt016FtOxg=
X-Google-Smtp-Source: AGHT+IF8Oo+Tiui6v4vF2Yrc9KLG6KG+CMoFj36zjynNYHU5ymVezqdA6lTVY2EakxxYYrw3V1+q8Q==
X-Received: by 2002:a05:6a21:150c:b0:1a9:487a:b6d1 with SMTP id nq12-20020a056a21150c00b001a9487ab6d1mr875569pzb.23.1712691082255;
        Tue, 09 Apr 2024 12:31:22 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 17-20020a056a00073100b006ed7684304dsm1931157pfm.61.2024.04.09.12.31.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2024 12:31:21 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <1868FA47-1303-4E14-BF35-4F89701A3572@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_FC114AEE-C80F-4C7C-8344-496C4B305C2F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 5/5] btrfs: fiemap: return extent physical size
Date: Tue, 9 Apr 2024 13:31:18 -0600
In-Reply-To: <20240409185247.GJ3492@twin.jikos.cz>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Qu Wenruo <wqu@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-doc@vger.kernel.org,
 linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 kernel-team@meta.com
To: David Sterba <dsterba@suse.cz>
References: <cover.1711588701.git.sweettea-kernel@dorminy.me>
 <93686d5c4467befe12f76e4921bfc20a13a74e2d.1711588701.git.sweettea-kernel@dorminy.me>
 <a2d3cdef-ed4e-41f0-b0d9-801c781f9512@suse.com>
 <ff320741-0516-410f-9aba-fc2d9d7a6b01@dorminy.me>
 <d01b4606-38fa-4f27-8fbd-31de505ba3a3@dorminy.me>
 <305008f4-9e17-4435-bb1d-a56b1de63c9b@gmx.com>
 <20240409185247.GJ3492@twin.jikos.cz>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_FC114AEE-C80F-4C7C-8344-496C4B305C2F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Apr 9, 2024, at 12:52 PM, David Sterba <dsterba@suse.cz> wrote:
>=20
> On Wed, Apr 03, 2024 at 05:49:42PM +1030, Qu Wenruo wrote:
>>=20
>>=20
>> =E5=9C=A8 2024/4/3 16:32, Sweet Tea Dorminy =E5=86=99=E9=81=93:
>>>>> This means, we will emit a entry that uses the end to the physical
>>>>> extent end.
>>>>>=20
>>>>> Considering a file layout like this:
>>>>>=20
>>>>>      item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
>>>>>          generation 7 type 1 (regular)
>>>>>          extent data disk byte 13631488 nr 65536
>>>>>          extent data offset 0 nr 4096 ram 65536
>>>>>          extent compression 0 (none)
>>>>>      item 7 key (257 EXTENT_DATA 4096) itemoff 15763 itemsize 53
>>>>>          generation 8 type 1 (regular)
>>>>>          extent data disk byte 13697024 nr 4096
>>>>>          extent data offset 0 nr 4096 ram 4096
>>>>>          extent compression 0 (none)
>>>>>      item 8 key (257 EXTENT_DATA 8192) itemoff 15710 itemsize 53
>>>>>          generation 7 type 1 (regular)
>>>>>          extent data disk byte 13631488 nr 65536
>>>>>          extent data offset 8192 nr 57344 ram 65536
>>>>>          extent compression 0 (none)
>>>>>=20
>>>>> For fiemap, we would got something like this:
>>>>>=20
>>>>> fileoff 0, logical len 4k, phy 13631488, phy len 64K
>>>>> fileoff 4k, logical len 4k, phy 13697024, phy len 4k
>>>>> fileoff 8k, logical len 56k, phy 13631488 + 8k, phylen 56k
>>>>>=20
>>>>> [HOW TO CALCULATE WASTED SPACE IN USER SPACE]
>>>>> My concern is on the first entry. It indicates that we have wasted
>>>>> 60K (phy len is 64K, while logical len is only 4K)
>>>>>=20
>>>>> But that information is not correct, as in reality we only wasted =
4K,
>>>>> the remaining 56K is still referred by file range [8K, 64K).
>>>>>=20
>>>>> Do you mean that user space program should maintain a mapping of =
each
>>>>> utilized physical range, and when handling the reported file range
>>>>> [8K, 64K), the user space program should find that the physical =
range
>>>>> covers with one existing extent, and do calculation correctly?
>>>>=20
>>>> My goal is to give an unprivileged interface for tools like =
compsize
>>>> to figure out how much space is used by a particular set of files.
>>>> They report the total disk space referenced by the provided list of
>>>> files, currently by doing a tree search (CAP_SYS_ADMIN) for all the
>>>> extents pertaining to the requested files and deduplicating extents
>>>> based on disk_bytenr.
>>>>=20
>>>> It seems simplest to me for userspace for the kernel to emit the
>>>> entire extent for each part of it referenced in a file, and let
>>>> userspace deal with deduplicating extents. This is also most =
similar
>>>> to the existing tree-search based interface. Reporting whole =
extents
>>>> gives more flexibility for userspace to figure out how to report
>>>> bookend extents, or shared extents, or ...
>>>>=20
>>>> It does seem a little weird where if you request with fiemap only =
e.g.
>>>> 4k-16k range in that example file you'll get reported all 68k
>>>> involved, but I can't figure out a way to fix that without having =
the
>>>> kernel keep track of used parts of the extents as part of =
reporting,
>>>> which sounds expensive.
>>>>=20
>>>> You're right that I'm being inconsistent, taking off extent_offset
>>>> from the reported disk size when that isn't what I should be doing, =
so
>>>> I fixed that in v3.
>>>=20
>>> Ah, I think I grasp a point I'd missed before.
>>> - Without setting disk_bytenr to the actual start of the data on =
disk,
>>> there's no way to find the location of the actual data on disk =
within
>>> the extent from fiemap alone
>>=20
>> Yes, that's my point.
>>=20
>>> - But reporting disk_bytenr + offset, to get actual start of data on
>>> disk, means we need to report a physical size to figure out the end =
of
>>> the extent and we can't know the beginning.
>>=20
>> disk_bytenr + offset + disk_num_bytes, and with the existing things =
like
>> length (aka, num_bytes), filepos (aka, key.offset) flags
>> (compression/hole/preallocated etc), we have everything we need to =
know
>> for regular extents.
>>=20
>> For compressed extents, we also need ram_bytes.
>>=20
>> If you ask me, I'd say put all the extra members into fiemap entry if =
we
>> have the space...
>>=20
>> It would be u64 * 4 if we go 1:1 on the file extent items, otherwise =
we
>> may cheap on offset and ram_bytes (u32 is enough for btrfs at least), =
in
>> that case it would be u64 * 2 + u32 * 2.
>>=20
>> But I'm also 100% sure, the extra members would not be welcomed by =
other
>> filesystems either.
>=20
> That's probably right, too many btrfs-specific information in the
> generic FIEMAP, but we may also do our own enhanced fiemap ioctl that
> would provide all the information you suggest and we'd be free to put
> the compression information there too.

I read this thread when it was first posted, but I don't understand what
these extra fields actually mean?  Definitely adding the =
logical/physical
length makes sense for compressed extents, but I didn't see any clear
explanation of what these other fields actually mean?

I'm extrapolating something like btrfs has aggregated compressed chunks
that have multiple independent/disjoint blocks within a chunk, and you
are trying to get the exact offset within the compression byte stream
for the start of each block in the chunk?

Cheers, Andreas






--Apple-Mail=_FC114AEE-C80F-4C7C-8344-496C4B305C2F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYVl4YACgkQcqXauRfM
H+CLUhAAqZRWH5u1exxRMG1aw8xEgIl4fGpO0wOykRwQ1rfVeUh8ZJ7/7cf7Wjsl
7iSJX7SAeejcKPXFx1zSAbNgg9oEGtNZpKebeeSHu41YoF3VUfm6vv9w5GBqfd1f
+vWZ+fn4j35Q9ptjx+3G5IHeQeGEDtEaSx6FI7NnOC9QCqnzETsOUtc43uYLVLLG
bNRaFrpOi4RSD31FTOzWe6jg6rLWpcI2Z6ArWs+qqPHHGY4OCwp2wnP9ysFt7gF5
eYIMU+LnySR9Z+p0Ppl+Rw3xs8wWyF9uVkDxdHB1poxM89cpeqWFVwzIe69y8MNo
fCb4YGdLV2WzM+za5bl4e21Q+ADxcLstN0+9+O3MFFA2hUVXpA/1gCqBRTPBWleA
XkUTBOqne5vs+E4CKwI+42Jx9TWHRHe8QwXk0dzeDR5062P9anEMS2HPpzess1fL
frd17j4+MGIdOipEjiEsaKKClR0HtG7dtctBvK6434NDuPlKb3oaCUFGrlZa93Kj
+Y59nW4g2p1sQFSZ2KlsG5FUAk5TKmLcKbZEAtxuRI86AqgyjnJ5E3R5AJ8vztj+
nhpDOGYIRlIdbuXqmrdUd7NGpfaI19mlxjmMTjMjTIqs3Q/XBMb3+BrqyLd70whu
bKCEW51XXdY8+J+hHsLUE7WKAt/Jawu6pqwhK/BOnL6z46RVE1E=
=rddc
-----END PGP SIGNATURE-----

--Apple-Mail=_FC114AEE-C80F-4C7C-8344-496C4B305C2F--

