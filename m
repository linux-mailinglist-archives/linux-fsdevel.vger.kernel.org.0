Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFBEA141DD3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 13:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgASMts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 07:49:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51675 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgASMts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 07:49:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id d73so11700687wmd.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2020 04:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=di4JEZljWWelDns1zpKZZpm57YnUPSQGJgKJK7XAGxU=;
        b=kT0w6tmxdWzSycwzs7vNT64RgxsuglsknvAhksKGBnXnCGsNmKU8Kvpx85swKXaUEe
         Pe9wS+b3DLEvqVOJnRZGi2FX5jLRYHpTdWy1O3OMmk4FbyK3skFptxn8nrjSTdlIMF27
         6DhGdT5SpZlPbhB90HlpjBQe24or/EQijEaf5zPfiCjvIR6DjEkY7IjcV+WicvPBJsDt
         PDvqqn5b3zgw1oDMi37WKfTNHC/ET3v1t2Kvs4ePvIvE1oveeo2ovir0gBMw+4IfPgYl
         TWdjDzz7d0aCy9Jr2TxPzP78k5gECQPztLr2IHzRNcMKkI/BdGpADEDJs/mlQecG+g6k
         uDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=di4JEZljWWelDns1zpKZZpm57YnUPSQGJgKJK7XAGxU=;
        b=Fi4pUzm3E8JapXlVmhwM1EWCaZK0QgdzWFoMvo6z9wq4thkkTaauBqsLrU41jKPmzb
         aPb28n1l6fQARv6RGYMhzwXtjbBG1BJi8CNrOC0dQUVjnuUN1socV/fhk4emGHfkJcic
         xdqqEe2icI0WaTAM2ObymD06K4ADV7vMpNntEYHAj2vh2Iu1N0pzEcGEjif1rCvJyxAj
         fxRzWfqRBQeBZMFIeNb9tEXvIeRn/ffSblklBSXgqSzlPCrZvpyJhkZnTrDipMC/1+dK
         pxqwpAnOTVR7oGaRirO5LbYp140bMTLKZVIvvMwn0fc0TiPQUMEeRF88DvcQPt2BTyHd
         jr6g==
X-Gm-Message-State: APjAAAUn/lmfKEC3yHXAzt8RbaN8GZvXDuUIF6ZBPG0gxLzdp9myy2xc
        4nwWLi0+yBfDbypXXYHy+knEeYnI
X-Google-Smtp-Source: APXvYqyK8MCTGkE94od8cYqYxvjuALrO7w0FsUSgt+lKeeQc/huj2X+DiTk+O3vbm+a3bdVyjivk1w==
X-Received: by 2002:a1c:22c6:: with SMTP id i189mr14297293wmi.15.1579438186135;
        Sun, 19 Jan 2020 04:49:46 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id s8sm41727691wrt.57.2020.01.19.04.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 04:49:45 -0800 (PST)
Date:   Sun, 19 Jan 2020 13:49:44 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: udf: Incorrect handling of timezone
Message-ID: <20200119124944.lf4vsqhwwbrxyibk@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cgxnvbadyusl35aw"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--cgxnvbadyusl35aw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello! I looked at udf code which converts linux time to UDF time and I
found out that conversion of timezone is incorrect.

Relevant code from udf_time_to_disk_stamp() function:

	int16_t offset;

	offset =3D -sys_tz.tz_minuteswest;

	dest->typeAndTimezone =3D cpu_to_le16(0x1000 | (offset & 0x0FFF));

UDF 2.60 2.1.4.1 Uint16 TypeAndTimezone; says:

  For the following descriptions Type refers to the most significant 4 bits=
 of this
  field, and TimeZone refers to the least significant 12 bits of this field=
, which is
  interpreted as a signed 12-bit number in two=E2=80=99s complement form.

  TimeZone ... If this field contains -2047 then the time zone has not been=
 specified.

As offset is of signed 16bit integer, (offset & 0x0FFF) result always
clears sign bit and therefore timezone is stored to UDF fs incorrectly.

This needs to be fixed, sign bit from tz_minuteswest needs to be
propagated to 12th bit in typeAndTimezone member.

Also tz_minuteswest is of int type, so conversion to int16_t (or more
precisely int12_t) can be truncated. So this needs to be handled too.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--cgxnvbadyusl35aw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXiRQZAAKCRCL8Mk9A+RD
UmU5AJ4z5tYD1bApqJGszN0beSFJrg899gCfQsH9MytK7VbpjIhwvS4WdzLwQEY=
=55SS
-----END PGP SIGNATURE-----

--cgxnvbadyusl35aw--
