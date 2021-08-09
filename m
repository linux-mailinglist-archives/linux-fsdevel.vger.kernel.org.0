Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E60C3E4AE4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 19:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhHIRcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 13:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbhHIRcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:32:22 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E802EC0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Aug 2021 10:32:01 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id y130so6581242qkb.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7Vd5SsqyCkC/WgUABGMpKlM3a+dx8fPcAdSDlrr7kY0=;
        b=seUpAt0yXvIirfnAYoUqFGjwoZC+rgyLhRUXlyHk3nDPCzLGfb78L05dlREknR+/XH
         iO69QBKFLuPFL9UszB05RDwabdo0TMVtwRm0dHaqAGTiCJsivHKb2IEQr6zGJAWNkHzT
         OymplCtr3L4tWqzFprpeRpm7lUfzEi4mAKMYbTSTeun3UgJxEtf9LyiJ2EKDWirNC0Bl
         O8QDSpv2LBkMbEgJrr84bAO/JRCYDNIgEV65WmX6Ci9knvEWvmy8Su/1GHvbJO+aynvE
         qMAbzsWh+CdaYqzxlIN4W2esY+q5bXjvs3YHho+kD1ATwChA7LooxcjoKjQBj6h58ZaB
         6TAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7Vd5SsqyCkC/WgUABGMpKlM3a+dx8fPcAdSDlrr7kY0=;
        b=mxj+DJAczRRFFfgjwjep8eeCUI8BdMSlA6i7i5HgExbD746kdErHHAHTD2R+XwO2J+
         CL/keU5AxHjYYdAHNDtL6Q/ExPsQ3uClSl6FAUWwXKu6QxdyznzEexNifZaIgyI7lHfw
         2508Bg5ibXmFB1Aq2fif49m+nvM35R4fn6gZkhfGfK4tJDs/8gjNZpOx7GH8rHAo3GL6
         5onD8ZtAg+uxK6e6yGumRKOquuBOv2EN3ETdKPQTc9gc02y8B94X30SEg0om+fL1lI3j
         Y5gLZbcS94CBib1bPzgSvBHOU9C/ISAuizNW2Afdn76yAAOBGSmKFcYWTNBxZ1lzSOwH
         ogbQ==
X-Gm-Message-State: AOAM531ptAgpmy217cI2G+vSLL0HyKODY2ENs+e2OVB9s6z2+6dbdrw1
        y82PL4TlPWVdK6K723KYF46UCg==
X-Google-Smtp-Source: ABdhPJxDxb8Z+GtvraOrw4meO7gw2JzU3WYo0bH8LeIk4lSkmYbk6azkakGXV9z7D9hJ8zUXrToayw==
X-Received: by 2002:a05:620a:1193:: with SMTP id b19mr23546498qkk.439.1628530321096;
        Mon, 09 Aug 2021 10:32:01 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:615b:6e84:29a:3bc6])
        by smtp.gmail.com with ESMTPSA id t14sm9006401qkm.7.2021.08.09.10.31.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Aug 2021 10:32:00 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 11/20] hfs: Explicitly set hsb->nls_disk when
 hsb->nls_io is set
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20210808162453.1653-12-pali@kernel.org>
Date:   Mon, 9 Aug 2021 10:31:55 -0700
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?utf-8?Q?Marek_Beh=C3=BAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0302F93-BAE5-48F0-87D0-B68B10D7757B@dubeyko.com>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-12-pali@kernel.org>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 8, 2021, at 9:24 AM, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>=20
> It does not make any sense to set hsb->nls_io (NLS iocharset used =
between
> VFS and hfs driver) when hsb->nls_disk (NLS codepage used between hfs
> driver and disk) is not set.
>=20
> Reverse engineering driver code shown what is doing in this special =
case:
>=20
>    When codepage was not defined but iocharset was then
>    hfs driver copied 8bit character from disk directly to
>    16bit unicode wchar_t type. Which means it did conversion
>    from Latin1 (ISO-8859-1) to Unicode because first 256
>    Unicode code points matches 8bit ISO-8859-1 codepage table.
>    So when iocharset was specified and codepage not, then
>    codepage used implicit value "iso8859-1".
>=20
> So when hsb->nls_disk is not set and hsb->nls_io is then explicitly =
set
> hsb->nls_disk to "iso8859-1".
>=20
> Such setup is obviously incompatible with Mac OS systems as they do =
not
> support iso8859-1 encoding for hfs. So print warning into dmesg about =
this
> fact.
>=20
> After this change hsb->nls_disk is always set, so remove code paths =
for
> case when hsb->nls_disk was not set as they are not needed anymore.
>=20


Sounds reasonable. But it will be great to know that the change has been =
tested reasonably well.

Thanks,
Slava.


> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
> fs/hfs/super.c | 31 +++++++++++++++++++++++++++++++
> fs/hfs/trans.c | 38 ++++++++++++++------------------------
> 2 files changed, 45 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 12d9bae39363..86bc46746c7f 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -351,6 +351,37 @@ static int parse_options(char *options, struct =
hfs_sb_info *hsb)
> 		}
> 	}
>=20
> +	if (hsb->nls_io && !hsb->nls_disk) {
> +		/*
> +		 * Previous version of hfs driver did something =
unexpected:
> +		 * When codepage was not defined but iocharset was then
> +		 * hfs driver copied 8bit character from disk directly =
to
> +		 * 16bit unicode wchar_t type. Which means it did =
conversion
> +		 * from Latin1 (ISO-8859-1) to Unicode because first 256
> +		 * Unicode code points matches 8bit ISO-8859-1 codepage =
table.
> +		 * So when iocharset was specified and codepage not, =
then
> +		 * codepage used implicit value "iso8859-1".
> +		 *
> +		 * To not change this previous default behavior as some =
users
> +		 * may depend on it, we load iso8859-1 NLS table =
explicitly
> +		 * to simplify code and make it more reable what =
happens.
> +		 *
> +		 * In context of hfs driver it is really strange to use
> +		 * ISO-8859-1 codepage table for storing data to disk, =
but
> +		 * nothing forbids it. Just it is highly incompatible =
with
> +		 * Mac OS systems. So via pr_warn() inform user that =
this
> +		 * is not probably what he wants.
> +		 */
> +		pr_warn("iocharset was specified but codepage not, "
> +			"using default codepage=3Diso8859-1\n");
> +		pr_warn("this default codepage=3Diso8859-1 is =
incompatible with "
> +			"Mac OS systems and may be changed in the =
future");
> +		hsb->nls_disk =3D load_nls("iso8859-1");
> +		if (!hsb->nls_disk) {
> +			pr_err("unable to load iso8859-1 codepage\n");
> +			return 0;
> +		}
> +	}
> 	if (hsb->nls_disk && !hsb->nls_io) {
> 		hsb->nls_io =3D load_nls_default();
> 		if (!hsb->nls_io) {
> diff --git a/fs/hfs/trans.c b/fs/hfs/trans.c
> index 39f5e343bf4d..c75682c61b06 100644
> --- a/fs/hfs/trans.c
> +++ b/fs/hfs/trans.c
> @@ -48,18 +48,13 @@ int hfs_mac2asc(struct super_block *sb, char *out, =
const struct hfs_name *in)
> 		wchar_t ch;
>=20
> 		while (srclen > 0) {
> -			if (nls_disk) {
> -				size =3D nls_disk->char2uni(src, srclen, =
&ch);
> -				if (size <=3D 0) {
> -					ch =3D '?';
> -					size =3D 1;
> -				}
> -				src +=3D size;
> -				srclen -=3D size;
> -			} else {
> -				ch =3D *src++;
> -				srclen--;
> +			size =3D nls_disk->char2uni(src, srclen, &ch);
> +			if (size <=3D 0) {
> +				ch =3D '?';
> +				size =3D 1;
> 			}
> +			src +=3D size;
> +			srclen -=3D size;
> 			if (ch =3D=3D '/')
> 				ch =3D ':';
> 			size =3D nls_io->uni2char(ch, dst, dstlen);
> @@ -119,20 +114,15 @@ void hfs_asc2mac(struct super_block *sb, struct =
hfs_name *out, const struct qstr
> 			srclen -=3D size;
> 			if (ch =3D=3D ':')
> 				ch =3D '/';
> -			if (nls_disk) {
> -				size =3D nls_disk->uni2char(ch, dst, =
dstlen);
> -				if (size < 0) {
> -					if (size =3D=3D -ENAMETOOLONG)
> -						goto out;
> -					*dst =3D '?';
> -					size =3D 1;
> -				}
> -				dst +=3D size;
> -				dstlen -=3D size;
> -			} else {
> -				*dst++ =3D ch > 0xff ? '?' : ch;
> -				dstlen--;
> +			size =3D nls_disk->uni2char(ch, dst, dstlen);
> +			if (size < 0) {
> +				if (size =3D=3D -ENAMETOOLONG)
> +					goto out;
> +				*dst =3D '?';
> +				size =3D 1;
> 			}
> +			dst +=3D size;
> +			dstlen -=3D size;
> 		}
> 	} else {
> 		char ch;
> --=20
> 2.20.1
>=20

