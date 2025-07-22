Return-Path: <linux-fsdevel+bounces-55634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D7FB0D0AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 05:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B81C7A51A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 03:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E64028C03A;
	Tue, 22 Jul 2025 03:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHNMSlmv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5C928B7D4;
	Tue, 22 Jul 2025 03:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753156468; cv=none; b=VLnUEGDxn8GSnK00zNlMElOcNg3TniJ+ZLtv0s2pRTrymkXs6b7ABFKUfMpBF8wB2oJGydmiCe6BBjO6QRnqt+JHiR0HYaZFpwwYPaJNmPdK6Xux/HwdD3pElHDX6Z7rWFIKekuAixKyGO1nGDYkYdFj4dnr5bA9gTp0uaEyxws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753156468; c=relaxed/simple;
	bh=pMF5pqseEWjPYxGMLMeAr2jDTsuh1B1VIVqreXIt6BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiRQ87qDB9IBgEgXadOap6MiVXPOdNFrlbU5HaSfCM4/ioKVtLzBH7P4Ry0X8DtbwwJRO+GCjvif9+j+zYNWTMn5k1AzrlrgHaJTnVWbsNijw4x46e4SodABAGsw4C9J90CudwbXBaSR19ywUhQGIT98PlxK6MLrkHDon1EcFYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHNMSlmv; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5313eff2649so1307251e0c.0;
        Mon, 21 Jul 2025 20:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753156466; x=1753761266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAAlykKu642VPrQqfIgQ/sSqAoZceoQZhIURS8zROzA=;
        b=HHNMSlmvGp0O5Wi8BNwT/aC7xyoErxCcQXEaZin/5pMrGvYKZJeeRB9naW4m+b6J8k
         iSrDa6ZD083TbxAFMkj/maiwQjoVzJNIxUxn1Uh31nJUziKCa2Z0UPLnSY+kdbpAu9nB
         J5Kf/u/tUkguYF4UVb0KAg2/WFvO/jixT4F1CCdOQlsszqwy6dGtYxXoHSZ0S9o8U8Fs
         9pq4sXYZ+Ug+bt20UloMPj5MJQOmYrKIQDgqNZvCJaV14eDnLNrP3WHTSbo6MlE1sjyc
         4lPYfit+BjaZWh5oNHNNGZIFOK4qSAXx3wgLyqQ7w71Hy3czhrvugpmpLHQdwAM7bRTg
         JoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753156466; x=1753761266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAAlykKu642VPrQqfIgQ/sSqAoZceoQZhIURS8zROzA=;
        b=KRkw4sg54nq/F9w1UazxcvId78FgVWJXrGSiJ7FGmhyhhJtD7va7Haf9TCe6Gqrd4p
         BpBdYcpouOVZzdop/U5U5vkgWdGK3lPlelJZCPp7XU5rFfhmYuFsOxtdNvbM3uM5OGYB
         2I3Wnl126nB0yKeAmU6Du5fdGSu/H7VYlpEFWG0Zzo7LCnCaP/f+uHxyBURnlsFDjLJ3
         QuFpngno7P3+ix+/Bl0+2RY5ST44zoTl1yMeW6iYMXRhiKPP+zvmwjSrbQMWCzVvIJky
         WVbzV58/UcQkbp+v3KyP8IXdBsiGcZw2ixzjnwINgakem0xmbxpMqoXY/5hxu/0jYstO
         QgDg==
X-Forwarded-Encrypted: i=1; AJvYcCW+bZdVUqxCQ57nBJK/V68DedEw2GXSYYgrjPy3RqRfZZVFfImKt0/LlaPn0rd1+mgi5+QGJt5FdYZzZcSURw==@vger.kernel.org, AJvYcCW45UszouiKkzx8fOfCZI/g8IksQ8QkI9IaVQhcs4PJSRvuekH8w8A8jXydoib1Qb6fzvZwR4Q9ZbP9Zw==@vger.kernel.org, AJvYcCXWO4oA7ggtWapZe+qiDyqxDwuB3Zd60LpwEFiMqOskc+WNbrZqrlD6hCjvNd5FvWw6vxAq4duKjnQi/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu8UI5a5Why1BTH2OxrlqgKIIxluLYOsoV2suEuO1cRVxu3Tao
	R196S2/fE9Tb+xL1qPIh3jznF6oTzM0PehXS/owJn7JEGvS0/KXmj+sSjLuqNNTMGIlzNYND8NY
	7qYvmagU9BOEarwGm+vyN1EtKSkH2Lmk=
X-Gm-Gg: ASbGncscKRGHE5rxpywx2kh1VTEfftFniKxm+ddCu7OAq7xdseaNETKFsM3u5XJwXsz
	9TtijKP8qypZltbo+vKBmN4wX4FdnII153rsSpBplkFUcIlLxQsOAojiGBAJCYbsxmEotaFbWgC
	cDRbrhxfooH76WCGPkEX5tbLEYUlyRWJd4A56/pwTsS65MaTKE+iuNYZg9Db+m0tKuRByMjvF/4
	L/j0lA=
X-Google-Smtp-Source: AGHT+IFdEM3sDnKSU7djtnY2X77gIkWr33PBhDuXfdQIDGEOAUgRW6b8nyrGT5SpWkQFjiRSNtgM+8Lmi+axf63N/6M=
X-Received: by 2002:a05:6122:4d0f:b0:531:236f:1295 with SMTP id
 71dfb90a1353d-5373fbda52dmr10043238e0c.5.1753156466033; Mon, 21 Jul 2025
 20:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aHa8ylTh0DGEQklt@casper.infradead.org> <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
 <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com> <CAGsJ_4xJjwsvMpeBV-QZFoSznqhiNSFtJu9k6da_T-T-a6VwNw@mail.gmail.com>
 <7ea73f49-df4b-4f88-8b23-c917b4a9bd8a@linux.alibaba.com> <z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5>
 <85946346-8bfd-4164-a49d-594b4a158588@gmx.com>
In-Reply-To: <85946346-8bfd-4164-a49d-594b4a158588@gmx.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 22 Jul 2025 11:54:14 +0800
X-Gm-Features: Ac12FXykbYYT14P53wpCeHJw2yoMEcQU-j3E43IYKsTdPACdf43QFDrlblVigVM
Message-ID: <CAGsJ_4ySQFzSbXZzecH9oy53KFpVsoaqXThPiJxfYUJF3_Y+Hg@mail.gmail.com>
Subject: Re: Compressed files & the page cache
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Jan Kara <jack@suse.cz>, Gao Xiang <hsiangkao@linux.alibaba.com>, 
	Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, 
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, 
	Paulo Alcantara <pc@manguebit.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, ntfs3@lists.linux.dev, 
	Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, 
	Phillip Lougher <phillip@squashfs.org.uk>, Hailong Liu <hailong.liu@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 7:37=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/7/21 19:55, Jan Kara =E5=86=99=E9=81=93:
> > On Mon 21-07-25 11:14:02, Gao Xiang wrote:
> >> Hi Barry,
> >>
> >> On 2025/7/21 09:02, Barry Song wrote:
> >>> On Wed, Jul 16, 2025 at 8:28=E2=80=AFAM Gao Xiang <hsiangkao@linux.al=
ibaba.com> wrote:
> [...]
> >>> Given the difficulty of allocating large folios, it's always a good
> >>> idea to have order-0 as a fallback. While I agree with your point,
> >>> I have a slightly different perspective =E2=80=94 enabling large foli=
os for
> >>> those devices might be beneficial, but the maximum order should
> >>> remain small. I'm referring to "small" large folios.
> >>
> >> Yeah, agreed. Having a way to limit the maximum order for those small
> >> devices (rather than disabling it completely) would be helpful.  At
> >> least "small" large folios could still provide benefits when memory
> >> pressure is light.
> >
> > Well, in the page cache you can tune not only the minimum but also the
> > maximum order of a folio being allocated for each inode. Btrfs and ext4
> > already use this functionality. So in principle the functionality is th=
ere,
> > it is "just" a question of proper user interfaces or automatic logic to
> > tune this limit.
> >
> >                                                               Honza
>
> And enabling large folios doesn't mean all fs operations will grab an
> unnecessarily large folio.
>
> For buffered write, all those filesystem will only try to get folios as
> large as necessary, not overly large.
>
> This means if the user space program is always doing buffered IO in a
> power-of-two unit (and aligned offset of course), the folio size will
> match the buffer size perfectly (if we have enough memory).
>
> So for properly aligned buffered writes, large folios won't really cause
>   unnecessarily large folios, meanwhile brings all the benefits.

I don't think this captures the full picture. For example, in memory
reclamation, if any single subpage is hot, the entire large folio is
treated as hot and cannot be reclaimed. So I=E2=80=99m not convinced that
"filesystems will only try to get folios as large as necessary" is the
right policy.

Large folios are a good idea, but the lack of control over their maximum
size limits their practical applicability. When an embedded device enables
large folios and only observes performance regressions, the immediate
reaction is often to disable the feature entirely. This, in turn, harms the
adoption and development of large folios.

>
> Although I'm not familiar enough with filemap to comment on folio read
> and readahead...
>
> Thanks,
> Qu

Best Regards
Barry

