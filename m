Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A55138706
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2020 17:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgALQXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jan 2020 11:23:15 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:36904 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbgALQXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jan 2020 11:23:15 -0500
Received: by mail-wr1-f44.google.com with SMTP id w15so6248223wru.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2020 08:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=g6BUP5rJe1lP3jLG8NPKne5Qz/aDu2ameaSaqy429+I=;
        b=LZcal9mfmXYyzWo5eZXk4lkGRuXnWRYWonfQ/267xWJ29D01ypKvnP0I33NhrOEWTQ
         98QPNkSawFseVZAwDMoTlUbm6UaFL42YNNaHUQTidTOTTUv27Y4rwofmFoIzktAkQ87w
         v7awUVDvZxLHqsJEpkG6UYjpvBcrOcNWyA3xmxQKp6IP6dtzx4FgErOyMtGlWgs+fvxL
         mXXCU0pdb9J0AWq9V00sPEp8g1ZkSBSjlNx3L5GdTOFuE8dl6q8HGA9FLwvFjhhkbAj4
         cEerBQswc96NnwH0/JCuMX240kxxS45gXFTNxWjxptvLE40gtGf/vzynVJOZs597dkt3
         xHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=g6BUP5rJe1lP3jLG8NPKne5Qz/aDu2ameaSaqy429+I=;
        b=edIIeMV05q+8MUgVhFmVOTLKKvHAqYSc4zmbF4qP9XU3/MwhygLb8+OLM+b9BOVjkp
         hg3/NZ5tI4KCBmHaOdZY215XNB9I67346L/l3YkgBnGpIPDAxeCPjX9VtMFrIKG7tj3t
         bwdagC32/SAJlk2y8m1umta38GopPr6LU+MdTT1Nj6H/B689TNPi8JI2J+G/B4hDw2q8
         ECoTSsaEyIrxcnszh21Eb7k6iXX4h0aZMUsHWme4o1KV6jnKaszGCGfrRY1P8E4hGjkr
         383UZyg1jK51Ox7xDIyehAvpHHim+gQQACdaPLGH0mhiajf9k+WZfsOfuYp4L3aNWIwn
         TsNA==
X-Gm-Message-State: APjAAAXy5O7L5WUD0a11lE23nfeqZY4vlceC8uWbbCFJOVLGJ3QuwGDS
        R1RFRG8lwvCAHm0Gl/evHSGI8nrg
X-Google-Smtp-Source: APXvYqybeU5NGheyCwTyp1sgF+udl8txl+wCQVLNXMCMCG9CyPFz7fGtNwmpKdse1PtIgHuC41M7jg==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr14040633wrp.1.1578846193285;
        Sun, 12 Jan 2020 08:23:13 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id i5sm10660774wml.31.2020.01.12.08.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 08:23:12 -0800 (PST)
Date:   Sun, 12 Jan 2020 17:23:11 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: udf: Suspicious values in udf_statfs()
Message-ID: <20200112162311.khkvcu2u6y4gbbr7@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tuu72vh4r3rvjhns"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--tuu72vh4r3rvjhns
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I looked at udf_statfs() implementation and I see there two things which
are probably incorrect:

First one:

	buf->f_blocks =3D sbi->s_partmaps[sbi->s_partition].s_partition_len;

If sbi->s_partition points to Metadata partition then reported number
of blocks seems to be incorrect. Similar like in udf_count_free().

Second one:

	buf->f_files =3D (lvidiu !=3D NULL ? (le32_to_cpu(lvidiu->numFiles) +
					  le32_to_cpu(lvidiu->numDirs)) : 0)
			+ buf->f_bfree;

What f_files entry should report? Because result of sum of free blocks
and number of files+directories does not make sense for me.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--tuu72vh4r3rvjhns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhtH7AAKCRCL8Mk9A+RD
UioPAJ9V/19hMxfC8BgioZsakKrbJ1sgIQCfb446PXLbUOmmKcaNOMt88RyC5AI=
=Iqjk
-----END PGP SIGNATURE-----

--tuu72vh4r3rvjhns--
