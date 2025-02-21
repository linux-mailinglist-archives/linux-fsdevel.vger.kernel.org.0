Return-Path: <linux-fsdevel+bounces-42294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2024A3FF1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 19:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8902A702B33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98272512FA;
	Fri, 21 Feb 2025 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="nZfDONwA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179B1F7561
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164116; cv=none; b=RTjwz+vkTVjpZk8Yozimjy5YEYJ8Vbb6WCFumLFy5LI/OzDRoDYGLsLwS04/NY5mOMQOGtNwv+E9KJGZ/6CY8FeE8sCvX0MK/WPwArjZ+JUyU7VbvstyhWN9liC90D5uUAghjO73WWECpD14NIVuBM8wCqMbHtH4ii8QeSuFaRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164116; c=relaxed/simple;
	bh=zTNRvaXssq/gJT25Wr9fqcI96nvvXb5oYejMTSf24vM=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=cb5A6Nng6YfqvsFKUX4loZ+yTtPeCpD9Pe8BccAuGvKWRr4GQLUoZo3FSc6IqQhiW5jtzyxD1KDl0VDCTC09Vjj4V7G7DUPosTGezMX6JPuumhlSBv0aQOelvVwGp1UxhSydo1JvBZPmpbjvtAXYlRXWlITDUB19KF07vCbraww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=nZfDONwA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc32756139so3983391a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 10:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1740164113; x=1740768913; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4d6uQVUeeZgznwA3p1q8tL13Il1lBkBvDJFuqttDEGc=;
        b=nZfDONwAialxovWGSYQaIEzkR3OAbKU2ihUqC6ZPgNNHIyUQ20IhZJTj0SWwLrf3zc
         HMl4/p8H8hwOCmfYQOh8sJG8BuHWh4Bb1lDD3nfcxtj8FRIkeJ6/czMsRd0OJ3jWlUFI
         zYj+WVmObQNoluAKgZKPxeqE1JgncqZSq/Kf/w/VOiHyRmTLgA1Z06HV0CE3qCnke72o
         iD+3QrSuP1LqaijiJeBAhMEYlYCVD1z2Ee5UU4eKVMmQLC+CeJm7qMHtD0iLrtgaqaog
         4CdfN0s4czBxfL9mRxbn0NDpobjiN7UIjnIdLRiWpW1ADrjWf7co+NFEMj2JiFfSPVeb
         AC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740164113; x=1740768913;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4d6uQVUeeZgznwA3p1q8tL13Il1lBkBvDJFuqttDEGc=;
        b=pEUMIr1eYLQ7wtADCoLkbtk1BqJUX7Ex5LVBXlnZydlCUqe+n5d9B1zOsP8cCSU5C5
         Xhjsnbh87fjUXCKMvMsGK5e7Pp7p+/PHh4JPbnjqQhq6zW8Kq8qqo4bbFX/gDwWn1LFC
         FHSYyadLye+ZOJcKFzivDM16eAJYSsEJx5CH2YFTnhbFSQ5OSqYXDKk2djRGPG8YkfqI
         7iRTzAVrjMQwFx/6oTIT9MUdqcGH8AKYnxErjeEObnB5//QPYHvmSwLHXqyFWROqK9fM
         juV3U0Z22ArDv25WoScJNQ67qpcJ+NmEtk/9yMgCHqMBZBhrMHpyKyYlOt7oq5E26cO4
         BwGA==
X-Forwarded-Encrypted: i=1; AJvYcCUyMsmF/axCgKkJcRmgNTZG5WboiyhGHaEhyJA90juTL7T2cpjeSiXuGb8E8ID1jo0SSGtoHVy6QDAMbGvb@vger.kernel.org
X-Gm-Message-State: AOJu0YzT2d5Cx9k5GVlIa1lqPJUkWKItKL8ZlMj8nGgIXenzZsRayyTI
	Yk7LNje787MuE8OJIwEF0+nyNFP6Tsjij/J9l9iJXkCzGcH90+2oQAssWIblOx4=
X-Gm-Gg: ASbGnctk0qasmsyommP3D7yOVHlkpoOId3c/tjnL9zCaeicxEYABj/DMex52aJsyXnB
	VmOjmM0c28C2MJ4p+E7Y/Zv5w9u/tJGDZ7rj+W6VpGdLbpDlWJ85+cXjFvIq2RmSxEQSmE/oqtx
	SVKO6pXLjcvZ5Es8I6AmmUMyReiC69z+pWXIkEW4W4HVaZzL/Rpf2FT/h7d4M8QT92AL8Mh7tCZ
	GFTim8wwp4lSXQz68a7fK60u4lUdQkc5FFKb0QnKwMMsmCEWmQKhgUQu5eXaBphBBaSkW3VV0y+
	zqKGGlY5j7iA0hgDgYrRxpSF5dF0d09OMuqL6521YFQ6yWVscHYymOlSQee3tzQBifAVRN2bCig
	=
X-Google-Smtp-Source: AGHT+IGIjUyLPQ2s1c3R37+ZrPel+kYybizImuQCQ0nwg9t2lK52jt/j411nr/IJFmgSVcm1Fa3+Ng==
X-Received: by 2002:a17:90b:3e8a:b0:2f1:4715:5987 with SMTP id 98e67ed59e1d1-2fce86ae503mr6974270a91.9.1740164112605;
        Fri, 21 Feb 2025 10:55:12 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb02d82csm1918425a91.10.2025.02.21.10.55.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2025 10:55:11 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <216AB14C-D182-4179-A5A9-327FADCD7D41@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_345505F9-8A2C-4EAD-B7F6-99D3EECB5259";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED
 for FS_IOC_FS[GS]ETXATTR API
Date: Fri, 21 Feb 2025 11:55:03 -0700
In-Reply-To: <20250221163443.GA2128534@mit.edu>
Cc: Amir Goldstein <amir73il@gmail.com>,
 =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Dave Chinner <david@fromorbit.com>,
 Eric Biggers <ebiggers@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 ronnie sahlberg <ronniesahlberg@gmail.com>,
 Chuck Lever <chuck.lever@oracle.com>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 Steve French <sfrench@samba.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org,
 linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
References: <20250216183432.GA2404@sol.localdomain>
 <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
 <20250216202441.d3re7lfky6bcozkv@pali>
 <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
 <Z7Pjb5tI6jJDlFZn@dread.disaster.area>
 <CAOQ4uxh6aWO7Emygi=dXCE3auDcZZCmDP+jmjhgdffuz1Vx6uQ@mail.gmail.com>
 <20250218192701.4q22uaqdyjxfp4p3@pali> <Z7UQHL5odYOBqAvo@dread.disaster.area>
 <20250218230643.fuc546ntkq3nnnom@pali>
 <CAOQ4uxiAU7UorH1FLcPgoWMXMGRsOt77yRQ12Xkmzcxe8qYuVw@mail.gmail.com>
 <20250221163443.GA2128534@mit.edu>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_345505F9-8A2C-4EAD-B7F6-99D3EECB5259
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Feb 21, 2025, at 9:34 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> 
> We can define some new interface for return what xflags are supported
> by a particular file system.  This could either be the long-debated,
> but never implemented statfsx() system call.  Or it could be extending
> what gets returned by FS_IOC_GETXATTR by using one of the fs_pad
> fields in struct fsxattr.  This is arguably the simplest way of
> dealing with the problem.
> 
> I suppose the field could double as the bitmask field when
> FS_IOC_SETXATTR is called, but that just seems to be an overly complex
> set of semantics.  If someone really wants to do that, I wouldn't
> really complain, but then what we would actually call the field
> "flags_supported_on_get_bitmask_on_set" would seem a bit wordy.  :-)

The nice thing about allowing the bitmask on SET to mean "only set/clear
the specified fields" is that this allows a race-free mechanism to change
the flags, whereas GET+SET could be racy between two callers.

I don't think the two uses are incompatible.  If called as GET+SET, where
the GET will return the flags+mask, then any flag bits set/cleared should
also be in mask when SET, and all of the other bits are reset to the same
value.  If called as "SET flags+mask" with a limited number of bits, only
those bits in mask would be set/cleared, and the other bits would be left
as-is.

Cheers, Andreas






--Apple-Mail=_345505F9-8A2C-4EAD-B7F6-99D3EECB5259
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAme4zAgACgkQcqXauRfM
H+CdJg//dBRx+db5qUwq2Yw3g7IQY3oad5rMJH7yBoZbJP5hKD/Wltc0MPDd/27T
V/er82Zr/fFpsIrgLTDFe12sDxY5GtPJcAWFgq1+a03pVpaVCY8cCXbmRy/fqh+O
6FFDbgT8IDlNOm347SCV0GNkUa78orDoAGRrt2XcEIoD372hwaaXtPrcug2Nd++O
hiNl3rm3ZNQ81xEYTAYjLy4YZCkdITcar9XwZMxB6lapSTKA/TW43L8MTNivXdKs
Sq3aSXWQiD1L632Eryn5TjEiBIs9tms5/s22UPL955kClEchZCe914Uo3Z2l/1Wn
ksWn1Af/FDezp+sqKIFmkhPBYLFiqgkABKRq0WctsrfgfJOnnUzFO6gk6cxUnVo0
EhNg+1bjNppus7opDnhqRH8Jas+SBvdiIFvEhTGi9kvK4AhW4jmbarpywg43PQ3O
4f9v7UoKs3xV4uc4GQOu+EndOKphLMrz1tyh+rvmix4YqB95rXmdCFfUM+0BvtU6
SEEuUIDCytbASKgOaCeia9Ln9q6uF6lBoIMVIgfPVgxS6B3kFMfmSHgy91FBHL2j
Ma0IZkoOuOdnXSjZEMsoWT62HEBTuS5r7bfnlCaVfUk3ns2C2QjLdsg3ST0JcTUK
8ttgMxUzbin/ndOP1sy6Og4tz0ezJ/WgNsZsG+mKXZBbiml+unE=
=7F0J
-----END PGP SIGNATURE-----

--Apple-Mail=_345505F9-8A2C-4EAD-B7F6-99D3EECB5259--

