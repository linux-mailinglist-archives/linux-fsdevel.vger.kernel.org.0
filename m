Return-Path: <linux-fsdevel+bounces-37060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEA59ECDDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 15:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2062D2841D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 14:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5579D2368E4;
	Wed, 11 Dec 2024 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="Uec4Zddk";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="e5YZpriw";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="p8RThuV1";
	dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="MpMhlBAx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2633205E06
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925704; cv=none; b=ovTs16OC1Sde0YEjgV6cUKvdX+3/T8J9PrXUgCGldJ4S/XGciLv1PPfavGgLml/+dII/LhkXW6P2E2jlKLtWoQMTeQDi1vjxHzvo7lh7WxJEOMiKkvEmF0ueOLr1Cy6WFI6GJFaTfbM5kDUW3fCL3hLp61wG+D3y7rpTSReE4eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925704; c=relaxed/simple;
	bh=8mxhtVim1oTLHN+nnfWOIG3zXY2VOqV4g5WhqGRD9hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOLzKb3CCpzC2iwXLDw8OPgkoplNlabcFH2q+e7TYruMj8hAKrclnA9QgYMsjk+iuEFCeZ8LB3kB25/eqL3iDRYk2bdFehnZ3CFUvYObKyjl+ZzHHZkstN9r3cTszYCm0+Vwi5mEbZtmY8u0DWQiOgPaMmWLNh8MqHD3zY12ZPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=Uec4Zddk; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=e5YZpriw; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=p8RThuV1; dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=MpMhlBAx; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:2c2d:bcfb:f79c:139])
	by mail.tnxip.de (Postfix) with ESMTPS id CA4AC208D4;
	Wed, 11 Dec 2024 15:01:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1733925692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4yTK9/Dvo2OtuUPfEus7JxSPvRqWPwXeMSSTxDFQoU=;
	b=Uec4ZddkxGCcjBfXKl0X8Nrt6lrVX7TdU6GD4FMn0RBoqr7V/SDkv1avNHRrNVPQ0zFk9V
	rmB2uUtqIX/XtUvtnjTvlKeGd4OYsPNH6UKBiRr4/bo/j/7uvJxl6PTlluPrGTbRjvqsmm
	Uio6Uz7OzE/3PjeywxUwTpDcSLRyauQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1733925693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4yTK9/Dvo2OtuUPfEus7JxSPvRqWPwXeMSSTxDFQoU=;
	b=e5YZpriw6vKzwd7TF6pBJGYeDpICIBAkUf9PvRrYidJ5kRhEpyMYmGTKbyxA4OAR2kZcbj
	h7LaYgoqOQFikUDQ==
Received: from [IPV6:2a04:4540:8c0a:db00:8ca8:fed6:14c9:dc40] (unknown [IPv6:2a04:4540:8c0a:db00:8ca8:fed6:14c9:dc40])
	by gw.tnxip.de (Postfix) with ESMTPSA id D81C35010158B;
	Wed, 11 Dec 2024 15:01:31 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1733925691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4yTK9/Dvo2OtuUPfEus7JxSPvRqWPwXeMSSTxDFQoU=;
	b=p8RThuV1rw+YQ5xFmcE0kXKc5wgf2fQVbfy1hpluI0e6hAHyoYyB8pF6RFUkS+wpqHSqC0
	jRkaECXV1DCqBwAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1733925692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4yTK9/Dvo2OtuUPfEus7JxSPvRqWPwXeMSSTxDFQoU=;
	b=MpMhlBAxttrc8vaztj/Nhw9Cj/VueI9bO+fgfMpjetEHrjZsPF3q3hx57JuYnFHVLHNFkj
	+xv1qpM9Da+GrKDoA3xN2t6BzlkC5gqwzroRKJiFrF41VhlayBvIu234fJtzPM/1w4RZRj
	9YgFXTl2HU1gCA61LHO93y6IC6soonw=
Message-ID: <cb096d18-cb2f-40af-8bf8-8fe27e69f5d3@tnxip.de>
Date: Wed, 11 Dec 2024 15:01:31 +0100
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
 <0f09af0f-2524-42a5-bdfa-d241c3a19329@tnxip.de>
 <CAJnrk1ZaAGNmVYVSFieJ-02mcX4N15zKF-yyjEPeEFotMpLYBA@mail.gmail.com>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <CAJnrk1ZaAGNmVYVSFieJ-02mcX4N15zKF-yyjEPeEFotMpLYBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/12/2024 03:57, Joanne Koong wrote:
> On Tue, Dec 10, 2024 at 9:53 AM Malte Schröder <malte.schroeder@tnxip.de> wrote:
>> On 10/12/2024 06:14, Joanne Koong wrote:
>>> On Mon, Dec 9, 2024 at 11:52 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>>>> On Mon, Dec 9, 2024 at 10:47 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>>>>> On Mon, Dec 9, 2024 at 9:07 AM Malte Schröder <malte.schroeder@tnxip.de> wrote:
>>>>>> On 09/12/2024 16:48, Josef Bacik wrote:
>>>>>>> On Mon, Dec 09, 2024 at 03:28:14PM +0000, Matthew Wilcox wrote:
>>>>>>>> On Mon, Dec 09, 2024 at 09:49:48AM -0500, Josef Bacik wrote:
>>>>>>>>>> Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I ended up
>>>>>>>>>> with 3b97c3652d91 as the culprit.
>>>>>>>>> Willy, I've looked at this code and it does indeed look like a 1:1 conversion,
>>>>>>>>> EXCEPT I'm fuzzy about how how this works with large folios.  Previously, if we
>>>>>>>>> got a hugepage in, we'd get each individual struct page back for the whole range
>>>>>>>>> of the hugepage, so if for example we had a 2M hugepage, we'd fill in the
>>>>>>>>> ->offset for each "middle" struct page as 0, since obviously we're consuming
>>>>>>>>> PAGE_SIZE chunks at a time.
>>>>>>>>>
>>>>>>>>> But now we're doing this
>>>>>>>>>
>>>>>>>>>     for (i = 0; i < nfolios; i++)
>>>>>>>>>             ap->folios[i + ap->num_folios] = page_folio(pages[i]);
>>>>>>>>>
>>>>>>>>> So if userspace handed us a 2M hugepage, page_folio() on each of the
>>>>>>>>> intermediary struct page's would return the same folio, correct?  So we'd end up
>>>>>>>>> with the wrong offsets for our fuse request, because they should be based from
>>>>>>>>> the start of the folio, correct?
>>>>>>>> I think you're 100% right.  We could put in some nice asserts to check
>>>>>>>> this is what's happening, but it does seem like a rather incautious
>>>>>>>> conversion.  Yes, all folios _in the page cache_ for fuse are small, but
>>>>>>>> that's not guaranteed to be the case for folios found in userspace for
>>>>>>>> directio.  At least the comment is wrong, and I'd suggest the code is too.
>>>>>>> Ok cool, Malte can you try the attached only compile tested patch and see if the
>>>>>>> problem goes away?  Thanks,
>>>>>>>
>>>>>>> Josef
>>>>>>>
>>>>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>>>>>> index 88d0946b5bc9..c4b93ead99a5 100644
>>>>>>> --- a/fs/fuse/file.c
>>>>>>> +++ b/fs/fuse/file.c
>>>>>>> @@ -1562,9 +1562,19 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>>>>>>>               nfolios = DIV_ROUND_UP(ret, PAGE_SIZE);
>>>>>>>
>>>>>>>               ap->descs[ap->num_folios].offset = start;
>>>>>>> -             fuse_folio_descs_length_init(ap->descs, ap->num_folios, nfolios);
>>>>>>> -             for (i = 0; i < nfolios; i++)
>>>>>>> -                     ap->folios[i + ap->num_folios] = page_folio(pages[i]);
>>>>>>> +             for (i = 0; i < nfolios; i++) {
>>>>>>> +                     struct folio *folio = page_folio(pages[i]);
>>>>>>> +                     unsigned int offset = start +
>>>>>>> +                             (folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
>>>>>>> +                     unsigned int len = min_t(unsigned int, ret, folio_size(folio) - offset);
>>>>>>> +
>>>>>>> +                     len = min_t(unsigned int, len, PAGE_SIZE);
>>>>>>> +
>>>>>>> +                     ap->descs[ap->num_folios + i].offset = offset;
>>>>>>> +                     ap->descs[ap->num_folios + i].length = len;
>>>>>>> +                     ap->folios[i + ap->num_folios] = folio;
>>>>>>> +                     start = 0;
>>>>>>> +             }
>>>>>>>
>>>>>>>               ap->num_folios += nfolios;
>>>>>>>               ap->descs[ap->num_folios - 1].length -=
>>>>>> The problem persists with this patch.
>>>>>>
>>>> Malte, could you try Josef's patch except with that last line
>>>> "ap->descs[ap->num_pages - 1].length  -= (PAGE_SIZE - ret) &
>>>> (PAGE_SIZE - 1);" also removed? I think we need that line removed as
>>>> well since that does a "-=" instead of a "=" and
>>>> ap->descs[ap->num_folios - 1].length gets set inside the for loop.
>>>>
>>>> In the meantime, I'll try to get a local repro running on fsx so that
>>>> you don't have to keep testing out repos for us.
>>> I was able to repro this locally by doing:
>>>
>>> -- start libfuse server --
>>> sudo ./libfuse/build/example/passthrough_hp --direct-io ~/src ~/fuse_mount
>>>
>>> -- patch + compile this (rough / ugly-for-now) code snippet --
>>> diff --git a/ltp/fsx.c b/ltp/fsx.c
>>> index 777ba0de..9f040bc4 100644
>>> --- a/ltp/fsx.c
>>> +++ b/ltp/fsx.c
>>> @@ -1049,7 +1049,8 @@ dowrite(unsigned offset, unsigned size)
>>>         }
>>>  }
>>>
>>> -
>>> +#define TWO_MIB (1 << 21)  // 2 MiB in bytes
>>>
>>>  void
>>>  domapwrite(unsigned offset, unsigned size)
>>>  {
>>> @@ -1057,6 +1058,8 @@ domapwrite(unsigned offset, unsigned size)
>>>         unsigned map_size;
>>>         off_t    cur_filesize;
>>>         char    *p;
>>> +       int ret;
>>> +       unsigned size_2mib_aligned;
>>>
>>>         offset -= offset % writebdy;
>>>         if (size == 0) {
>>> @@ -1101,6 +1104,41 @@ domapwrite(unsigned offset, unsigned size)
>>>         pg_offset = offset & PAGE_MASK;
>>>         map_size  = pg_offset + size;
>>>
>>> +       size_2mib_aligned = (size + TWO_MIB - 1) & ~(TWO_MIB - 1);
>>> +       void *placeholder_map = mmap(NULL, size_2mib_aligned * 2, PROT_NONE,
>>> +                            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>> +       if (!placeholder_map) {
>>> +               prterr("domapwrite: placeholder map");
>>> +               exit(202);
>>> +       }
>>> +
>>> +       /* align address to nearest 2 MiB */
>>> +       void *aligned_address =
>>> +               (void *)(((uintptr_t)placeholder_map + TWO_MIB - 1) &
>>> ~(TWO_MIB - 1));
>>> +
>>> +       void *map = mmap(aligned_address, size_2mib_aligned, PROT_READ
>>> | PROT_WRITE,
>>> +                         MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED |
>>> MAP_POPULATE, -1, 0);
>>> +
>>> +       ret = madvise(map, size_2mib_aligned, MADV_COLLAPSE);
>>> +       if (ret) {
>>> +               prterr("domapwrite: madvise collapse");
>>> +               exit(203);
>>> +       }
>>> +
>>> +       memcpy(map, good_buf + offset, size);
>>> +
>>> +       if (lseek(fd, offset, SEEK_SET) == -1) {
>>> +               prterr("domapwrite: lseek");
>>> +               exit(204);
>>> +       }
>>> +
>>> +       ret = write(fd, map, size);
>>> +       if (ret == -1) {
>>> +               prterr("domapwrite: write");
>>> +               exit(205);
>>> +       }
>>> +
>>> +       /*
>>>         if ((p = (char *)mmap(0, map_size, PROT_READ | PROT_WRITE,
>>>                               MAP_FILE | MAP_SHARED, fd,
>>>                               (off_t)(offset - pg_offset))) == (char *)-1) {
>>> @@ -1119,6 +1157,15 @@ domapwrite(unsigned offset, unsigned size)
>>>                 prterr("domapwrite: munmap");
>>>                 report_failure(204);
>>>         }
>>> +       */
>>> +       if (munmap(map, size_2mib_aligned) != 0) {
>>> +               prterr("domapwrite: munmap map");
>>> +               report_failure(206);
>>> +       }
>>> +       if (munmap(placeholder_map, size_2mib_aligned * 2) != 0) {
>>> +               prterr("domapwrite: munmap placeholder_map");
>>> +               report_failure(207);
>>> +       }
>>>  }
>>>
>>> -- run fsx test --
>>> sudo ./fsx -b 3 ~/fuse_mount/example.txt -N 5000
>>>
>>> On the offending commit 3b97c3652, I'm seeing:
>>> [user]$ sudo ./fsx -b 3 ~/fuse_mount/example.txt -N 5000
>>> Will begin at operation 3
>>> Seed set to 1
>>> ...
>>> READ BAD DATA: offset = 0x1925f, size = 0xf7a3, fname =
>>> /home/user/fuse_mount/example.txt
>>> OFFSET      GOOD    BAD     RANGE
>>> 0x1e43f     0x4b4a  0x114a  0x0
>>> operation# (mod 256) for the bad data may be 74
>>> 0x1e441     0xa64a  0xeb4a  0x1
>>> operation# (mod 256) for the bad data may be 74
>>> 0x1e443     0x264a  0xe44a  0x2
>>> operation# (mod 256) for the bad data may be 74
>>> 0x1e445     0x254a  0x9e4a  0x3
>>> ...
>>> Correct content saved for comparison
>>> (maybe hexdump "/home/user/fuse_mount/example.txt" vs
>>> "/home/user/fuse_mount/example.txt.fsxgood")
>>>
>>>
>>> I tested Josef's patch with the "ap->descs[ap->num_pages - 1].length
>>> -= (PAGE_SIZE - ret) & (PAGE_SIZE - 1);" line removed and it fixed the
>>> issue:
>>>
>>> [user]$ sudo ./fsx -b 3 ~/fuse_mount/example.txt -N 5000
>>> Will begin at operation 3
>>> Seed set to 1
>>> ...
>>> copying to largest ever: 0x3e19b
>>> copying to largest ever: 0x3e343
>>> fallocating to largest ever: 0x40000
>>> All 5000 operations completed A-OK!
>>>
>>>
>>> Malte, would you mind double-checking whether this fixes the issue
>>> you're seeing on your end?
>> My test still fails.
> Hi Malte,
>
> I simulated your repro with installing bcachefs as the root filesystem
> on a VM running Arch, then running "sudo pacman -S flatpak" and then
> installing FreeCAD with "flatpak install flathub org.freecad.FreeCAD".
>
> On base commit 3b97c3652, I see the same corruption you noted:
>
> error: Failed to install org.kde.Platform: Error pulling from repo:
> While pulling runtime/org.kde.Platform/x86_64/6.7 from remote flathub:
> fsck content object
> 886fd60617b81e81475db5e62beda5846d3e85fe77562eae536d2dd2a7af5b33:
> Corrupted file object; checksum
> expected='886fd60617b81e81475db5e62beda5846d3e85fe77562eae536d2dd2a7af5b33'
> actual='67f5a60d19f7a65e1ee272d455fed138b864be73399816ad18fa71319614a418'
>
>
> i tried this patch on top of commit 3b97c3652 and it fixed it for me:
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 14af8c41fc83..0d213a22972b 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1560,18 +1560,24 @@ static int fuse_get_user_pages(struct
> fuse_args_pages *ap, struct iov_iter *ii,
>
>                 nbytes += ret;
>
> -               ret += start;
> -               /* Currently, all folios in FUSE are one page */
> -               nfolios = DIV_ROUND_UP(ret, PAGE_SIZE);
> -
> -               ap->folio_descs[ap->num_folios].offset = start;
> -               fuse_folio_descs_length_init(ap->folio_descs,
> ap->num_folios, nfolios);
> -               for (i = 0; i < nfolios; i++)
> -                       ap->folios[i + ap->num_folios] = page_folio(pages[i]);
> -
> -               ap->num_folios += nfolios;
> -               ap->folio_descs[ap->num_folios - 1].length -=
> -                       (PAGE_SIZE - ret) & (PAGE_SIZE - 1);
> +               nfolios = DIV_ROUND_UP(ret + start, PAGE_SIZE);
> +
> +               for (i = 0; i < nfolios; i++) {
> +                       struct folio *folio = page_folio(pages[i]);
> +                       unsigned int offset = start +
> +                               (folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
> +                       unsigned int len = min_t(unsigned int, ret,
> folio_size(folio) - offset);
> +
> +                       len = min_t(unsigned int, len, PAGE_SIZE - start);
> +
> +                       ap->descs[ap->num_folios].offset = offset;
> +                       ap->descs[ap->num_folios].length = len;
> +                       ap->folios[ap->num_folios] = folio;
> +                       start = 0;
> +                       ret -= len;
> +                       ap->num_folios++;
> +               }
> +
>                 nr_pages += nfolios;
>         }
>         kfree(pages);
>
> I ran this multiple times and don't see the corruption issues.
>
> However, I do see another issue crop up on some of my VMs, which is
> flatpak hanging with this corresponding stack trace:
>
> [  368.520976] INFO: task pool-/usr/lib/f:582 blocked for more than 122 seconds.
> [  368.521509]       Not tainted 6.12.0-rc1-g86b74eb5a11e #734
> [  368.521905] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  368.522483] task:pool-/usr/lib/f state:D stack:0     pid:582
> tgid:405   ppid:1      flags:0x00000002
> [  368.523238] Call Trace:
> [  368.523411]  <TASK>
> [  368.523548]  __schedule+0xaf0/0x27f0
> [  368.523773]  ? __pfx___schedule+0x10/0x10
> [  368.524024]  schedule+0x7e/0x300
> [  368.524233]  __wait_on_freeing_inode+0xda/0x120
> [  368.524527]  ? __pfx___wait_on_freeing_inode+0x10/0x10
> [  368.524830]  ? _raw_spin_unlock_irqrestore+0xe/0x30
> [  368.525124]  ? __pfx_wake_bit_function+0x10/0x10
> [  368.525411]  bch2_inode_hash_find+0x372/0x580
> [  368.525700]  ? __pfx_bch2_dirent_read_target+0x10/0x10
> [  368.526023]  ? bch2_dirent_hash+0x23d/0x370
> [  368.526286]  ? __pfx_bch2_inode_hash_find+0x10/0x10
> [  368.526583]  ? __pfx_dirent_cmp_key+0x10/0x10
> [  368.526972]  bch2_lookup_trans+0x61a/0x990
> [  368.527247]  ? __pfx_bch2_lookup_trans+0x10/0x10
> [  368.527559]  ? __do_sys_newfstatat+0x75/0xd0
> [  368.527850]  ? do_syscall_64+0x4b/0x110
> [  368.528088]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  368.528411]  ? __pfx_bch2_hash_info_init+0x10/0x10
> [  368.528720]  ? __mod_memcg_state+0x102/0x390
> [  368.529134]  ? obj_cgroup_charge+0x1b4/0x4c0
> [  368.529500]  ? __memcg_slab_post_alloc_hook+0x536/0xba0
> [  368.529913]  ? kvm_sched_clock_read+0x11/0x20
> [  368.530265]  ? _raw_spin_lock+0x85/0xe0
> [  368.530553]  ? bch2_lookup_trans+0x323/0x990
> [  368.530909]  ? __asan_memset+0x24/0x50
> [  368.531204]  ? __bch2_trans_get+0x735/0xdd0
> [  368.531525]  ? bch2_lookup+0x18a/0x350
> [  368.531859]  bch2_lookup+0x18a/0x350
> [  368.532145]  ? __pfx_bch2_lookup+0x10/0x10
> [  368.532466]  ? __pfx_lockref_get_not_dead+0x10/0x10
> [  368.532860]  __lookup_slow+0x182/0x350
> [  368.533159]  ? __pfx___lookup_slow+0x10/0x10
> [  368.533513]  walk_component+0x2ab/0x4f0
> [  368.533816]  path_lookupat+0x120/0x660
> [  368.534110]  ? vfs_fstatat+0x53/0xb0
> [  368.534413]  filename_lookup+0x1aa/0x520
> [  368.534718]  ? __pfx_filename_lookup+0x10/0x10
> [  368.535052]  ? __wake_up_common+0xf2/0x170
> [  368.535385]  ? _raw_spin_unlock_irq+0xe/0x30
> [  368.535683]  ? __pfx_eventfd_write+0x10/0x10
> [  368.536019]  ? kasan_save_stack+0x24/0x50
> [  368.536313]  ? __kasan_record_aux_stack+0xad/0xc0
> [  368.536651]  ? kmem_cache_free+0x353/0x550
> [  368.536919]  ? do_syscall_64+0x4b/0x110
> [  368.537179]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  368.537528]  vfs_statx+0xbf/0x140
> [  368.537745]  ? kmem_cache_alloc_noprof+0x12d/0x340
> [  368.538057]  ? __pfx_vfs_statx+0x10/0x10
> [  368.538322]  ? getname_flags.part.0+0xaf/0x4a0
> [  368.538627]  vfs_fstatat+0x6c/0xb0
> [  368.538840]  __do_sys_newfstatat+0x75/0xd0
> [  368.539100]  ? __pfx___do_sys_newfstatat+0x10/0x10
> [  368.539415]  ? kasan_unpoison+0x27/0x60
> [  368.539675]  ? __pfx_slab_free_after_rcu_debug+0x10/0x10
> [  368.540081]  ? fdget_pos+0x366/0x5d0
> [  368.540355]  ? fput+0x1b/0x2d0
> [  368.540602]  ? ksys_write+0x18c/0x1c0
> [  368.540934]  ? __pfx_ksys_write+0x10/0x10
> [  368.541252]  ? fpregs_assert_state_consistent+0x20/0xa0
> [  368.541657]  ? clear_bhb_loop+0x45/0xa0
> [  368.541948]  do_syscall_64+0x4b/0x110
> [  368.542270]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  368.542711] RIP: 0033:0x7fef789bb94e
> [  368.543001] RSP: 002b:00007fef713fe468 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000106
> [  368.543605] RAX: ffffffffffffffda RBX: 00007fef713fe5d0 RCX: 00007fef789bb94e
> [  368.544129] RDX: 00007fef713fe540 RSI: 00007fef713fe5d0 RDI: 000000000000001f
> [  368.544636] RBP: 00007fef713ff710 R08: 0000000000000073 R09: 0000000000000000
> [  368.545130] R10: 0000000000000100 R11: 0000000000000246 R12: 000000000000001f
> [  368.545640] R13: 00007fef713fe540 R14: 00007fef5802dc00 R15: 00007fef713ff780
> [  368.546177]  </TASK>
>
> I'm seeing this happen on commit 86b74eb5 as well, which is the commit
> that's before any of my or Josef's folio changes, and this persists
> across reboots. I've seen this happen for a couple other tasks too,
> "task:flatpak" and "task:pool-flatpak" with similar stack traces eg
>
> [  368.505270] task:pool-flatpak in state:D stack:0     pid:568
> tgid:538   ppid:537    flags:0x00000002
> [  368.505872] Call Trace:
> [  368.506042]  <TASK>
> [  368.506191]  __schedule+0xaf0/0x27f0
> [  368.506430]  ? __pfx___schedule+0x10/0x10
> [  368.506715]  schedule+0x7e/0x300
> [  368.506940]  __wait_on_freeing_inode+0xda/0x120
> [  368.507490]  ? __pfx___wait_on_freeing_inode+0x10/0x10
> [  368.507965]  ? _raw_spin_unlock_irqrestore+0xe/0x30
> [  368.508312]  ? __pfx_wake_bit_function+0x10/0x10
> [  368.508650]  bch2_inode_hash_find+0x372/0x580
> [  368.508969]  ? __pfx_bch2_dirent_read_target+0x10/0x10
> [  368.509332]  ? bch2_dirent_hash+0x23d/0x370
> [  368.509637]  ? __pfx_bch2_inode_hash_find+0x10/0x10
> [  368.509991]  ? __pfx_dirent_cmp_key+0x10/0x10
> [  368.510309]  bch2_lookup_trans+0x61a/0x990
> [  368.510662]  ? __pfx_bch2_lookup_trans+0x10/0x10
> [  368.511155]  ? vfs_statx+0xbf/0x140
> [  368.511429]  ? vfs_fstatat+0x6c/0xb0
> [  368.511731]  ? do_syscall_64+0x4b/0x110
> [  368.512014]  ? __d_alloc+0x5cc/0x8f0
> [  368.512283]  ? memcg_list_lru_alloc+0x184/0x8a0
> [  368.512612]  ? __pfx_bch2_hash_info_init+0x10/0x10
> [  368.512943]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  368.513327]  ? __memcg_slab_post_alloc_hook+0x536/0xba0
> [  368.513753]  ? kvm_sched_clock_read+0x11/0x20
> [  368.514133]  ? _raw_spin_lock+0x85/0xe0
> [  368.515095]  ? bch2_lookup_trans+0x323/0x990
> [  368.516994]  ? __asan_memset+0x24/0x50
> [  368.517294]  ? __bch2_trans_get+0x735/0xdd0
> [  368.517675]  ? bch2_lookup+0x18a/0x350
> [  368.517987]  bch2_lookup+0x18a/0x350
> [  368.518271]  ? __pfx_bch2_lookup+0x10/0x10
> [  368.518568]  ? __pfx_lockref_get_not_dead+0x10/0x10
> [  368.518933]  __lookup_slow+0x182/0x350
> [  368.519264]  ? __pfx___lookup_slow+0x10/0x10
> [  368.519633]  walk_component+0x2ab/0x4f0
> [  368.519934]  ? fput+0x1b/0x2d0
> [  368.520206]  link_path_walk.part.0.constprop.0+0x4ad/0xac0
> [  368.520657]  path_lookupat+0x72/0x660
> [  368.521022]  ? vfs_fstatat+0x53/0xb0
> [  368.521343]  filename_lookup+0x1aa/0x520
> [  368.521664]  ? __pfx_filename_lookup+0x10/0x10
> [  368.522021]  ? __pfx_xa_load+0x10/0x10
> [  368.522319]  ? ___slab_alloc+0x128/0x9d0
> [  368.522683]  ? mntput_no_expire+0xcf/0x760
> [  368.523018]  ? lockref_put_return+0xc7/0x140
> [  368.523357]  ? kmem_cache_free+0x19e/0x550
> [  368.523686]  ? __pfx_mutex_unlock+0x10/0x10
> [  368.524035]  ? do_renameat2+0x1f4/0xa50
> [  368.524404]  ? do_renameat2+0x1f4/0xa50
> [  368.524716]  vfs_statx+0xbf/0x140
> [  368.524980]  ? kmem_cache_alloc_noprof+0x12d/0x340
> [  368.525355]  ? __pfx_vfs_statx+0x10/0x10
> [  368.525702]  ? getname_flags.part.0+0xaf/0x4a0
> [  368.526080]  vfs_fstatat+0x6c/0xb0
> [  368.526391]  __do_sys_newfstatat+0x75/0xd0
> [  368.526745]  ? __pfx___do_sys_newfstatat+0x10/0x10
> [  368.527206]  ? do_symlinkat+0x15d/0x260
> [  368.527509]  ? do_mkdirat+0x19d/0x2c0
> [  368.527807]  ? kasan_save_track+0x14/0x30
> [  368.528132]  ? getname_flags.part.0+0xaf/0x4a0
> [  368.528509]  ? fpregs_assert_state_consistent+0x20/0xa0
> [  368.529198]  ? clear_bhb_loop+0x45/0xa0
> [  368.529536]  do_syscall_64+0x4b/0x110
> [  368.529856]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  368.530279] RIP: 0033:0x7f592256194e
> [  368.530610] RSP: 002b:00007f5915bfe548 EFLAGS: 00000217 ORIG_RAX:
> 0000000000000106
> [  368.531350] RAX: ffffffffffffffda RBX: 0000000000000013 RCX: 00007f592256194e
> [  368.531943] RDX: 00007f5915bfe570 RSI: 00007f5915bfe600 RDI: 0000000000000013
> [  368.532491] RBP: 00007f5915bfe740 R08: 0000000000000073 R09: 0000000000000000
> [  368.533048] R10: 0000000000000100 R11: 0000000000000217 R12: 00007f5915bfe570
> [  368.533597] R13: 00007f5915bfe600 R14: 00007f5915bfe56c R15: 00007f5915bfe780
> [  368.534236]  </TASK>
> [  368.534419] INFO: task pool-flatpak in:571 blocked for more than 122 seconds.
>
> This seems like something we should investigate as well. I'm happy to
> help repro this if needed. I'm able to hit this pretty consistently.
>
> Malte, would you mind applying the patch above and confirming if this
> fixes it for you on your VM? And while you've been running flatpak,
> have you also been seeing some flatpak tasks hanging on some of your
> VMs?

This patch also passes my test :) I did not notice any hanging installs.

I think I will try it in addition with Kent's current code on my
workstation later. I will come back to you if I encounter further
issues, thanks :)


/Malte

>
> Thanks,
> Joanne
>
>>
>>>
>>> Thanks,
>>> Joanne
>>>
>>>> Thanks,
>>>> Joanne
>>>>> Catching up on this thread now. I'll investigate this today.
>>>>>
>>>>>> /Malte
>>>>>>

