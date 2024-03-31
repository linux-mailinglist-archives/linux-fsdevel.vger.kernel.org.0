Return-Path: <linux-fsdevel+bounces-15802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1870893103
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 11:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B002824E7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 09:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C25757F2;
	Sun, 31 Mar 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UT4ERiH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D904C6E5EC
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711875825; cv=none; b=nE9wXatyrHbzuJGngrdTSsD2LIRmUH+b6bLBpjIYxv85MQkyLCwCeOrvS4dJugn5IpFcEPZict8qe7almPCOhij0C5bT2HXy06RL5wsBYwsZxLMp9H2IkZPrZ4weQBsrWEE5EVU1O92K59AxLoxxc/ruosOHBAHSaE/U6Hmos2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711875825; c=relaxed/simple;
	bh=+GUX9N7KTWqDazQlkr4dOjvGUXRVNVbAjc11ZWEUXfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j8fNQ7f+9lMEYwQCxTQHrtFbyn7ZGXTQNtKi9O0oXgEp8yZPvJ0jWfNttcnrFl8mmPFceeiYc+ocSvFFRiowEVguLRwTv2o1fD+FCMR+I0mIRcW3R0bGH/pGgmo08Cs+eeOWVrogRl/qjLpOdxK7mIgtv6d8QtjB0vflBBaCD3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UT4ERiH6; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-515a86daf09so3964724e87.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 02:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711875821; x=1712480621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=enqKlhrqJxOY+Eg7jfBUlxt+b2cgWgCVyMnuUniyPjo=;
        b=UT4ERiH6Acl0kCe3NDuaNz4AOWi5uiNlFubfWdqc0qZ9GCrlER04mO4bgwdeoOt+4B
         CLCgJXhBSjTp5BhSbDMW95V6f1aC4OanknHTkuaG2YDy7APn2DshXJSh7LxfgZZxt/dG
         28FyOMFQw46OxtYUcGoXKLtcodK/8oSrU6yjKdIIs1MHYKvtrF89vZ3neK/dhMdK/pA6
         fdz0uN1WOAV6m1NjuLvPw3OLaPQHPbxnxvBdeGkIe6RIbiSnDGe+L6DfA0bR6JLHMe5o
         xE7YSJX+ix5hy5AUo+6zsVcoR22BagvDIrSm1jX2bit+AR8mURBzpG8qwrSTxAs5mE3M
         qj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711875821; x=1712480621;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enqKlhrqJxOY+Eg7jfBUlxt+b2cgWgCVyMnuUniyPjo=;
        b=f0uQ0gXn+WlxlS772Pc6XCuGbFOZyOBjC7PVa+cULQNfGTu7WbSlunJM8yXffW9bmR
         BDKGBw37YDKUaz2kjAeCKyRjOLE3921AU/j7i2MB/SFNQJix8Rm9KIHRC9YUwFGczC/H
         HErdNkE5EuwW/2CcJROVx+eBNaiYrvBzaofpsTIxoUeoHHO/oY5cLLfNTgeC4TTd6284
         mZNFCfhaQthbIP3BXMa8Fy/779xkMG+WBBgrFK5GjUrv0+jyPHGioCM9Jsm1YrAAuM9N
         +0fAkcBx2w/XCk4O0T8S8rb10wuu0kKHGzpiUwT+b8rty1KtFOs75uGQcy3LvY+nE55y
         lWEA==
X-Forwarded-Encrypted: i=1; AJvYcCWtETAgcch/T+6FPHMX0TZp85NbwXIfFcawvfw5h50bVcBi04iI6Ip7w6XPf9s5FykYpJRK5o4K17OU3DD7bID3szE46k7HsJNYAtFfIQ==
X-Gm-Message-State: AOJu0Yw6HE/7VBO7bKwRhi5xcIHfXo7A8+fdsjvueewv+VoO5V74G+Bt
	3IPyiV6ZTnrA1qirLLITqKxd5kR6UPlOd+nlSh89wCwvy7Jugt8KJOOJoIK3kt8=
X-Google-Smtp-Source: AGHT+IEFl+fHjFxKCqXr1wfcw/tZ0o11CMu7VI22034XxsfuzUlS3bN1GEeMhfM4+5PMbXFTPtYY+Q==
X-Received: by 2002:a19:ac03:0:b0:516:a213:46d2 with SMTP id g3-20020a19ac03000000b00516a21346d2mr1775370lfc.69.1711875820967;
        Sun, 31 Mar 2024 02:03:40 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b001e245c5afbfsm92671plb.155.2024.03.31.02.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 02:03:40 -0700 (PDT)
Message-ID: <a2d3cdef-ed4e-41f0-b0d9-801c781f9512@suse.com>
Date: Sun, 31 Mar 2024 19:33:32 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] btrfs: fiemap: return extent physical size
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Jonathan Corbet <corbet@lwn.net>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-doc@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <cover.1711588701.git.sweettea-kernel@dorminy.me>
 <93686d5c4467befe12f76e4921bfc20a13a74e2d.1711588701.git.sweettea-kernel@dorminy.me>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <93686d5c4467befe12f76e4921bfc20a13a74e2d.1711588701.git.sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/28 11:52, Sweet Tea Dorminy 写道:
> Now that fiemap allows returning extent physical size, make btrfs return
> the appropriate extent's actual disk size.
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
[...]
> @@ -3221,7 +3239,9 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>   
>   			ret = emit_fiemap_extent(fieinfo, &cache, key.offset,
>   						 disk_bytenr + extent_offset,
> -						 extent_len, flags);
> +						 extent_len,
> +						 disk_size - extent_offset,

This means, we will emit a entry that uses the end to the physical 
extent end.

Considering a file layout like this:

	item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
		generation 7 type 1 (regular)
		extent data disk byte 13631488 nr 65536
		extent data offset 0 nr 4096 ram 65536
		extent compression 0 (none)
	item 7 key (257 EXTENT_DATA 4096) itemoff 15763 itemsize 53
		generation 8 type 1 (regular)
		extent data disk byte 13697024 nr 4096
		extent data offset 0 nr 4096 ram 4096
		extent compression 0 (none)
	item 8 key (257 EXTENT_DATA 8192) itemoff 15710 itemsize 53
		generation 7 type 1 (regular)
		extent data disk byte 13631488 nr 65536
		extent data offset 8192 nr 57344 ram 65536
		extent compression 0 (none)

For fiemap, we would got something like this:

fileoff 0, logical len 4k, phy 13631488, phy len 64K
fileoff 4k, logical len 4k, phy 13697024, phy len 4k
fileoff 8k, logical len 56k, phy 13631488 + 8k, phylen 56k

[HOW TO CALCULATE WASTED SPACE IN USER SPACE]
My concern is on the first entry. It indicates that we have wasted 60K 
(phy len is 64K, while logical len is only 4K)

But that information is not correct, as in reality we only wasted 4K, 
the remaining 56K is still referred by file range [8K, 64K).

Do you mean that user space program should maintain a mapping of each 
utilized physical range, and when handling the reported file range [8K, 
64K), the user space program should find that the physical range covers 
with one existing extent, and do calculation correctly?

[COMPRESSION REPRESENTATION]
The biggest problem other than the complexity in user space is the 
handling of compressed extents.

Should we return the physical bytenr (disk_bytenr of file extent item) 
directly or with the extent offset added?
Either way it doesn't look consistent to me, compared to non-compressed 
extents.

[ALTERNATIVE FORMAT]
The other alternative would be following the btrfs ondisk format, 
providing a unique physical bytenr for any file extent, then the 
offset/referred length inside the uncompressed extent.

That would handle compressed and regular extents more consistent, and a 
little easier for user space tool to handle (really just a tiny bit 
easier, no range overlap check needed), but more complex to represent, 
and I'm not sure if any other filesystem would be happy to accept the 
extra members they don't care.

Thanks,
Qu

> +						 flags);
>   		}
>   
>   		if (ret < 0) {
> @@ -3259,7 +3279,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>   		prev_extent_end = range_end;
>   	}
>   
> -	if (cache.cached && cache.offset + cache.len >= last_extent_end) {
> +	if (cache.cached && cache.offset + cache.log_len >= last_extent_end) {
>   		const u64 i_size = i_size_read(&inode->vfs_inode);
>   
>   		if (prev_extent_end < i_size) {

