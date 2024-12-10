Return-Path: <linux-fsdevel+bounces-36975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D38E99EB8C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30EF16742E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8921B86D5;
	Tue, 10 Dec 2024 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="H3YT8vDJ";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="g8DRxOD+";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="s95DwmAL";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="GZTr/ngl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24505204681
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853211; cv=none; b=Y5UL7PtfiTRiCHTmsozM0zP3mztXUonvABTJ1T1wlH5Jhdg1D101bbIyypV/mS4dT/WpJp/NrrsJ/6Ss9XRT/lwQIU5kYNXR0V+nKpn2Tvh0cZI+u7Q5/OK/KK1+5HE8Euih8pzzQi37541OBwthjn7ocHP3DKN4iUfHK9cJB2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853211; c=relaxed/simple;
	bh=AevsIn3w8dK30SPqyqiYSLKsfh62Sheog2K2UQh6anI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaFG32rA2sQ2VtAOoXG5KxcWmaLw9DUJEawf5oY0Op/NIH7vR5pr7opDWiEdrgoUDHCridJIitWkEDKLegr1gtIgGZGYIpnIVYgMlf/bCEGUOd+M7IjGkvQXT0HtSkVeDHsqed83qrHi3xt/NWwbmH16TBa1qPa+JxGZFrZpDME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=H3YT8vDJ; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=g8DRxOD+; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=s95DwmAL; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=GZTr/ngl; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:d4b:86e:d01:6477])
	by mail.tnxip.de (Postfix) with ESMTPS id B1B7B208D7;
	Tue, 10 Dec 2024 18:53:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1733853191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toexV8dsWQrYDRCZE1DV3R6VfPw4DMyJ083Ut2bY/o4=;
	b=H3YT8vDJ447qRhmVhHBIAMkrvnPfNKJ+rPDI7IyxSB8pndQCBiFHV77BT9eIq17pZc+zRw
	1fwhcf5MYPPBpYBGEKDZBJ7HWJf1DXd/+azYmzQ4h6Iz4d4pzCtGEAXnToJ7UmrG/rjqv8
	1ZNYPkadaYjNvC3uI901H5MkaTLqpUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1733853191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toexV8dsWQrYDRCZE1DV3R6VfPw4DMyJ083Ut2bY/o4=;
	b=g8DRxOD+nfNE1JmHfzPG4+2u3pdcoTC8iNbjKmtFSGnVCqRtIWvU+WAGQ6sQHzonK7mhn0
	mndqP4W3YE/JZrDg==
Received: from [IPV6:2a04:4540:8c05:7700:2354:e42d:63e7:4df3] (highlander.local [IPv6:2a04:4540:8c05:7700:2354:e42d:63e7:4df3])
	by gw.tnxip.de (Postfix) with ESMTPSA id 5C75250100C2A;
	Tue, 10 Dec 2024 18:53:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1733853186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toexV8dsWQrYDRCZE1DV3R6VfPw4DMyJ083Ut2bY/o4=;
	b=s95DwmALOzPe4C5rt0tOEd2cMgecECg0w/bfvR2aDly3QVEcaSawz/DS72esNtDVckDsIG
	DnZswwy158THmoAfcueCzSpP6HMCAqBvfr/+AQEJ07veXi6za/KtZzhuOa8599Hi1s2vhK
	UGg/4JP0cHaOG8t3S4XhKOitqdHz0KQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1733853186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toexV8dsWQrYDRCZE1DV3R6VfPw4DMyJ083Ut2bY/o4=;
	b=GZTr/ngliqt8fuaWDUbVLySLfVtUmoy8OaY0vhz2p1RzlHH8D62TYvR+PXL5adAbMUQk0j
	9GSeWXwHBUY4DJDw==
Message-ID: <0f09af0f-2524-42a5-bdfa-d241c3a19329@tnxip.de>
Date: Tue, 10 Dec 2024 18:53:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: silent data corruption in fuse in rc1
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
 <Z1T09X8l3H5Wnxbv@casper.infradead.org>
 <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
 <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
 <20241209144948.GE2840216@perftesting>
 <Z1cMjlWfehN6ssRb@casper.infradead.org>
 <20241209154850.GA2843669@perftesting>
 <4707aea6-addb-4dc3-96f7-691d2e94ab25@tnxip.de>
 <CAJnrk1apXjQw7LEgSTmjt1xywzjp=+QMfYva4k1x=H0q2S6mag@mail.gmail.com>
 <CAJnrk1YfeNNpt2puwaMRcpDefMVg1AhjYNY4ZsKNqr85=WLXDg@mail.gmail.com>
 <CAJnrk1aF-_N6aBHbuWz0e+z=B4cH3GjZZ60yHRPbctMMG6Ukxw@mail.gmail.com>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <CAJnrk1aF-_N6aBHbuWz0e+z=B4cH3GjZZ60yHRPbctMMG6Ukxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/12/2024 06:14, Joanne Koong wrote:
> On Mon, Dec 9, 2024 at 11:52 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>> On Mon, Dec 9, 2024 at 10:47 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>>> On Mon, Dec 9, 2024 at 9:07 AM Malte Schröder <malte.schroeder@tnxip.de> wrote:
>>>> On 09/12/2024 16:48, Josef Bacik wrote:
>>>>> On Mon, Dec 09, 2024 at 03:28:14PM +0000, Matthew Wilcox wrote:
>>>>>> On Mon, Dec 09, 2024 at 09:49:48AM -0500, Josef Bacik wrote:
>>>>>>>> Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I ended up
>>>>>>>> with 3b97c3652d91 as the culprit.
>>>>>>> Willy, I've looked at this code and it does indeed look like a 1:1 conversion,
>>>>>>> EXCEPT I'm fuzzy about how how this works with large folios.  Previously, if we
>>>>>>> got a hugepage in, we'd get each individual struct page back for the whole range
>>>>>>> of the hugepage, so if for example we had a 2M hugepage, we'd fill in the
>>>>>>> ->offset for each "middle" struct page as 0, since obviously we're consuming
>>>>>>> PAGE_SIZE chunks at a time.
>>>>>>>
>>>>>>> But now we're doing this
>>>>>>>
>>>>>>>     for (i = 0; i < nfolios; i++)
>>>>>>>             ap->folios[i + ap->num_folios] = page_folio(pages[i]);
>>>>>>>
>>>>>>> So if userspace handed us a 2M hugepage, page_folio() on each of the
>>>>>>> intermediary struct page's would return the same folio, correct?  So we'd end up
>>>>>>> with the wrong offsets for our fuse request, because they should be based from
>>>>>>> the start of the folio, correct?
>>>>>> I think you're 100% right.  We could put in some nice asserts to check
>>>>>> this is what's happening, but it does seem like a rather incautious
>>>>>> conversion.  Yes, all folios _in the page cache_ for fuse are small, but
>>>>>> that's not guaranteed to be the case for folios found in userspace for
>>>>>> directio.  At least the comment is wrong, and I'd suggest the code is too.
>>>>> Ok cool, Malte can you try the attached only compile tested patch and see if the
>>>>> problem goes away?  Thanks,
>>>>>
>>>>> Josef
>>>>>
>>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>>>> index 88d0946b5bc9..c4b93ead99a5 100644
>>>>> --- a/fs/fuse/file.c
>>>>> +++ b/fs/fuse/file.c
>>>>> @@ -1562,9 +1562,19 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>>>>>               nfolios = DIV_ROUND_UP(ret, PAGE_SIZE);
>>>>>
>>>>>               ap->descs[ap->num_folios].offset = start;
>>>>> -             fuse_folio_descs_length_init(ap->descs, ap->num_folios, nfolios);
>>>>> -             for (i = 0; i < nfolios; i++)
>>>>> -                     ap->folios[i + ap->num_folios] = page_folio(pages[i]);
>>>>> +             for (i = 0; i < nfolios; i++) {
>>>>> +                     struct folio *folio = page_folio(pages[i]);
>>>>> +                     unsigned int offset = start +
>>>>> +                             (folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
>>>>> +                     unsigned int len = min_t(unsigned int, ret, folio_size(folio) - offset);
>>>>> +
>>>>> +                     len = min_t(unsigned int, len, PAGE_SIZE);
>>>>> +
>>>>> +                     ap->descs[ap->num_folios + i].offset = offset;
>>>>> +                     ap->descs[ap->num_folios + i].length = len;
>>>>> +                     ap->folios[i + ap->num_folios] = folio;
>>>>> +                     start = 0;
>>>>> +             }
>>>>>
>>>>>               ap->num_folios += nfolios;
>>>>>               ap->descs[ap->num_folios - 1].length -=
>>>> The problem persists with this patch.
>>>>
>> Malte, could you try Josef's patch except with that last line
>> "ap->descs[ap->num_pages - 1].length  -= (PAGE_SIZE - ret) &
>> (PAGE_SIZE - 1);" also removed? I think we need that line removed as
>> well since that does a "-=" instead of a "=" and
>> ap->descs[ap->num_folios - 1].length gets set inside the for loop.
>>
>> In the meantime, I'll try to get a local repro running on fsx so that
>> you don't have to keep testing out repos for us.
> I was able to repro this locally by doing:
>
> -- start libfuse server --
> sudo ./libfuse/build/example/passthrough_hp --direct-io ~/src ~/fuse_mount
>
> -- patch + compile this (rough / ugly-for-now) code snippet --
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 777ba0de..9f040bc4 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1049,7 +1049,8 @@ dowrite(unsigned offset, unsigned size)
>         }
>  }
>
> -
> +#define TWO_MIB (1 << 21)  // 2 MiB in bytes
>
>  void
>  domapwrite(unsigned offset, unsigned size)
>  {
> @@ -1057,6 +1058,8 @@ domapwrite(unsigned offset, unsigned size)
>         unsigned map_size;
>         off_t    cur_filesize;
>         char    *p;
> +       int ret;
> +       unsigned size_2mib_aligned;
>
>         offset -= offset % writebdy;
>         if (size == 0) {
> @@ -1101,6 +1104,41 @@ domapwrite(unsigned offset, unsigned size)
>         pg_offset = offset & PAGE_MASK;
>         map_size  = pg_offset + size;
>
> +       size_2mib_aligned = (size + TWO_MIB - 1) & ~(TWO_MIB - 1);
> +       void *placeholder_map = mmap(NULL, size_2mib_aligned * 2, PROT_NONE,
> +                            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +       if (!placeholder_map) {
> +               prterr("domapwrite: placeholder map");
> +               exit(202);
> +       }
> +
> +       /* align address to nearest 2 MiB */
> +       void *aligned_address =
> +               (void *)(((uintptr_t)placeholder_map + TWO_MIB - 1) &
> ~(TWO_MIB - 1));
> +
> +       void *map = mmap(aligned_address, size_2mib_aligned, PROT_READ
> | PROT_WRITE,
> +                         MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED |
> MAP_POPULATE, -1, 0);
> +
> +       ret = madvise(map, size_2mib_aligned, MADV_COLLAPSE);
> +       if (ret) {
> +               prterr("domapwrite: madvise collapse");
> +               exit(203);
> +       }
> +
> +       memcpy(map, good_buf + offset, size);
> +
> +       if (lseek(fd, offset, SEEK_SET) == -1) {
> +               prterr("domapwrite: lseek");
> +               exit(204);
> +       }
> +
> +       ret = write(fd, map, size);
> +       if (ret == -1) {
> +               prterr("domapwrite: write");
> +               exit(205);
> +       }
> +
> +       /*
>         if ((p = (char *)mmap(0, map_size, PROT_READ | PROT_WRITE,
>                               MAP_FILE | MAP_SHARED, fd,
>                               (off_t)(offset - pg_offset))) == (char *)-1) {
> @@ -1119,6 +1157,15 @@ domapwrite(unsigned offset, unsigned size)
>                 prterr("domapwrite: munmap");
>                 report_failure(204);
>         }
> +       */
> +       if (munmap(map, size_2mib_aligned) != 0) {
> +               prterr("domapwrite: munmap map");
> +               report_failure(206);
> +       }
> +       if (munmap(placeholder_map, size_2mib_aligned * 2) != 0) {
> +               prterr("domapwrite: munmap placeholder_map");
> +               report_failure(207);
> +       }
>  }
>
> -- run fsx test --
> sudo ./fsx -b 3 ~/fuse_mount/example.txt -N 5000
>
> On the offending commit 3b97c3652, I'm seeing:
> [user]$ sudo ./fsx -b 3 ~/fuse_mount/example.txt -N 5000
> Will begin at operation 3
> Seed set to 1
> ...
> READ BAD DATA: offset = 0x1925f, size = 0xf7a3, fname =
> /home/user/fuse_mount/example.txt
> OFFSET      GOOD    BAD     RANGE
> 0x1e43f     0x4b4a  0x114a  0x0
> operation# (mod 256) for the bad data may be 74
> 0x1e441     0xa64a  0xeb4a  0x1
> operation# (mod 256) for the bad data may be 74
> 0x1e443     0x264a  0xe44a  0x2
> operation# (mod 256) for the bad data may be 74
> 0x1e445     0x254a  0x9e4a  0x3
> ...
> Correct content saved for comparison
> (maybe hexdump "/home/user/fuse_mount/example.txt" vs
> "/home/user/fuse_mount/example.txt.fsxgood")
>
>
> I tested Josef's patch with the "ap->descs[ap->num_pages - 1].length
> -= (PAGE_SIZE - ret) & (PAGE_SIZE - 1);" line removed and it fixed the
> issue:
>
> [user]$ sudo ./fsx -b 3 ~/fuse_mount/example.txt -N 5000
> Will begin at operation 3
> Seed set to 1
> ...
> copying to largest ever: 0x3e19b
> copying to largest ever: 0x3e343
> fallocating to largest ever: 0x40000
> All 5000 operations completed A-OK!
>
>
> Malte, would you mind double-checking whether this fixes the issue
> you're seeing on your end?

My test still fails.


>
>
> Thanks,
> Joanne
>
>> Thanks,
>> Joanne
>>> Catching up on this thread now. I'll investigate this today.
>>>
>>>> /Malte
>>>>

