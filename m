Return-Path: <linux-fsdevel+bounces-16224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29B889A4BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 21:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AF81C216AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 19:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EC1172BD0;
	Fri,  5 Apr 2024 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="dckJbH8t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA5172BAE
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344541; cv=none; b=em+cCMENXcpZ89HWvY4Juox4DyGMb6FtXZSDD/ip7tIXRWuN8v9WUNPM0GCo+Xv3n7LX1KyihX+kR1nLIQjCQToRQkIWDzBZLWefFKY8JaTZzMdtaFdBVM1P9tI7HrnUzwA1/EiKGe2NahWjRiGlRhsxCXHbs9xuBVzvUkUSOgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344541; c=relaxed/simple;
	bh=zXljUdGcTtBGipmnNDprBpcZkCkrHGztkJZeni3/5cA=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=JIxAROxyQq1qJAHRA1R37JRY6cB1K2Z9Lq0TJr+CPTR/ZRw+RvKkTo9tsUbWJqhPcCKzpqvw5vcQb/VZSNNQ2uwWby+sGf1h+jjezBdb0htwlhNecXy992PiriiJQAi0Dp/zRTMwqIErF81w2Edo109uSXe/a/INxhPsWGbZdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=dckJbH8t; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so1742049a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712344538; x=1712949338; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cWmfDDERJb42IjzSqTDZHJTCfY0P4Md9v2hGsxPXotE=;
        b=dckJbH8tqvhfIZg4vPllAk2/mB3njC7QURDRbLQER2R6RSPuZAogmdKPtofQEx7o5a
         wxmg3HPwxbGxYxgRUlpglq0j/lHMfWofkAObH5vnV2sV46r/zBD68qkJKW5BbL9p6haI
         6m1IYRK5whyxn84xP32ylcdC0ew4neH7Ky31k/3slaktV8xJstsG7ooEkQfNkgt2iRAP
         VhWaYppUhga3OzKvAqHneJluIeAAhLNIxZUEroae82POI3wa9rT7MyLAmQz4iBDh7bV/
         yli66L7hBIyNMOAveBns5sfHXoIsD+zhjNCwEzpu1RBr6Oo8dsbBsoUqH4Aez/g6+HWT
         LnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712344538; x=1712949338;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWmfDDERJb42IjzSqTDZHJTCfY0P4Md9v2hGsxPXotE=;
        b=mX+VP0pWX/gPOe7QVDS0qyTz/L3Kw8bDqQQq9uetYwZ1dFs9Rh8QBztelNfEBucB45
         +5IFZBO6ME3AkK3xrEZb4pJDYQfbOkMN4H/53NTwAsdsblvy1pJmxYAGznX41xFB4wPm
         JNJnaSMu0eZldwbwu2L8obgqb5/yajHlp1TRMuuleeuUZv8S2Y8QXaHA/abFvyWujc60
         72TWcogoYffi0rbxZYCUM4fKtvFfbyPmLTR7bJiW+BGiS9Q5S7slsEcosbbex91JRx1+
         I79j0U3qB+KpeXY479avzWNSyO5cUEca1iA32Gd3a6q1KA5f9vHKQXpJ5scanxrF2kZz
         RD5A==
X-Forwarded-Encrypted: i=1; AJvYcCVPuHguVtJnlV/7Z9wpCOsWDMQwei4qGDWgFT3iii264gcGAzVZMBRs6p7DrL1AynVZk6j542rwDn+FDCkT3NXNRmErYtfHQDaYudoIgw==
X-Gm-Message-State: AOJu0YzAPGBpiHxytZEKAuxQdEpiRClgw3p04LyUvYmtQGW7tgpxzA2U
	PP7MYwePpO4yAySdYsuRXXUaNE6MFSZmoWKhQeiC6ApK8OpoBZ9zvr0PhJKJ904=
X-Google-Smtp-Source: AGHT+IHlz7CYySz4NrOEi/P6qH0+BaOoz73hQtya4g8iBNYvzcjlBcDm5rsBAIWsDBMSIH8uUJ5Ubg==
X-Received: by 2002:a17:90a:d086:b0:2a0:38f0:dc4b with SMTP id k6-20020a17090ad08600b002a038f0dc4bmr2044465pju.7.1712344537643;
        Fri, 05 Apr 2024 12:15:37 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id l13-20020a17090aec0d00b0029c7963a33fsm3715620pjy.10.2024.04.05.12.15.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 12:15:37 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <7CF0A3D0-50E7-448F-A992-90B9168D557F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_580FDCAB-FBEF-42A4-B8AF-A599EDFED403";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 13/13] bcachefs: fiemap: emit new COMPRESSED state
Date: Fri, 5 Apr 2024 13:17:45 -0600
In-Reply-To: <943938ff75580b210eebf6c885659dd95f029486.1712126039.git.sweettea-kernel@dorminy.me>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Brian Foster <bfoster@redhat.com>,
 Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-doc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-bcachefs@vger.kernel.org,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 kernel-team@meta.com
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Kent Overstreet <kent.overstreet@linux.dev>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <943938ff75580b210eebf6c885659dd95f029486.1712126039.git.sweettea-kernel@dorminy.me>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_580FDCAB-FBEF-42A4-B8AF-A599EDFED403
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 3, 2024, at 1:22 AM, Sweet Tea Dorminy =
<sweettea-kernel@dorminy.me> wrote:
>=20
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
> fs/bcachefs/fs.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index d2793bae842d..54f613f977b4 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -921,7 +921,7 @@ static int bch2_fill_extent(struct bch_fs *c,
> 				flags2 |=3D FIEMAP_EXTENT_UNWRITTEN;
>=20
> 			if (p.crc.compression_type) {
> -				flags2 |=3D FIEMAP_EXTENT_ENCODED;
> +				flags2 |=3D =
FIEMAP_EXTENT_DATA_COMPRESSED;

(defect) This should *also* set FIEMAP_EXTENT_ENCODED in this case,
along with FIEMAP_EXTENT_DATA_COMPRESSED.  Both for compatibility with
older code that doesn't understand FIEMAP_EXTENT_DATA_COMPRESSED, and
because the data still cannot be read directly from the volume when it
is not mounted.

Probably Kent should chime in here with what needs to be done to set
the phys_len properly for bcachefs, or leave this patch out of your
series and let him submit it directly.  With proposed wrapper in the
first patch of the series there isn't a hard requirement to change
all of the filesystems in one shot.

Cheers, Andreas






--Apple-Mail=_580FDCAB-FBEF-42A4-B8AF-A599EDFED403
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYQTlkACgkQcqXauRfM
H+Da1w/+KwGpB/pDp08sIkXnagyqUWMdqtRK9hS/4cehNOAAdPTlbycb3PfNiTxy
m2DZwrCbnPe4P1WB1nFy5DNsprtdOTGEbOiuOXKS3hkgnf9qY2lrFoC4inAMpNZi
W+p1IXURkUadjDgKS5Ijwyl0HpDheQcN/AVdLKUR9vKebxRsIBlJ2qlekVVOakYS
Y5wM2U8Ct3eaU6MAW3Mr0KMZKQPj5Ez5cVNZHm0046DtRmV/LI9/5RAKJUheesok
eF88SBmXg4t5KUsCLRIqi8wUHnrdfWEVrc83RK3l8LYAVpw/SdP+5TSYwontrBU5
KoUUEkwdKv6p5yvzGKkdh0iR00oEQHtUvYJR1es9oCl0er6eeqOAryoNTtK7BpBG
XbmY3rFRTCAgOp1gElHCIddnAIs2G5hDSo4jAqU/RzMkadFfS3YPuYL95BWAALlY
bfmmXpRyeD4z9wzBQz5HRu+rhKThHdvKyOL5GkaYcYNEmFWQq64+bDTtb5aKm1DD
FtfSEbx89tF6RyoafS3H6ESbhH4hmyYTWVmx9wpXtzLrGd8HWnRGsuQzFLx/uRWN
tRMosixMwAJsO3rzvuAXyZKcDqsAHyzF9hHwogaZn0SmpyGwFPZc5/iIr8tBZS+U
OWrKlNAy6Q0U91xdZPx3ZWpwSC3zh5BtCehRD0b8YX+G7DVSeFk=
=8Pjr
-----END PGP SIGNATURE-----

--Apple-Mail=_580FDCAB-FBEF-42A4-B8AF-A599EDFED403--

