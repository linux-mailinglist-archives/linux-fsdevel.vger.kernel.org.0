Return-Path: <linux-fsdevel+bounces-43939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E42BA600E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 20:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04913ABE85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 19:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090081F1927;
	Thu, 13 Mar 2025 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="HnpctnXl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212178C9C
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893300; cv=none; b=Ovc1b4EqphAJq6127vLUvD8oSCLr6Bakp8bbiCeYEGfEtgWkCRdhORQCaZ4Fh04cGNSMP358tHv2FayIYYOOqE2a3l5fCFVUSDoLwVI4K0UvipU0z0GUl5FzIeRgwNEQxbty1qteUxBboKcsvcz2kQwU21V30g/khNzWWkFGub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893300; c=relaxed/simple;
	bh=Zb+ZXYsETYl//4H2xcjbCVAdiU5mtxxYtFbhePzBlTY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fBL+Dsn6XB7cLlPhVTrniDu715+zEMsbsga2taWC7j5vSceyCDo7nEunD7BXduaBVZpylI9MVlo4KHE0vdZpek86aFu6JFasGsAIZzeHOMrZhQFPz4DrZ0wGCDQUTFtQiujjzaq3Uxbm+/K/PgqqVz8giS+e4G7URWSm5Taa7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=HnpctnXl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22398e09e39so29252035ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 12:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1741893298; x=1742498098; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zb+ZXYsETYl//4H2xcjbCVAdiU5mtxxYtFbhePzBlTY=;
        b=HnpctnXlP1sSHNqPi+sBd6CeYKJ9gI9vZit7d4kUFDIZa7mM40s/4LHr5MkzAR11cM
         M6vWT80oVR1ULNjERJTMoOnFHSChEPGTWEhxEfePAS4fOEiTfZ1obuavIPamydJaix+P
         IY01HTh5btMgZjo99KX+hlikgBz9u3UNIPIaiE5X96MX0LkKjl/6npUjhTfD4woRh/FF
         qEtxWMOWU9IdZsfwMds4z2UVbqaZrO5tevyK2/jE7lwUnVYpPe3F3CDPErGduHFfkbe4
         EZZQGCnmxRakijxfkiQV8Szb5+poIzI3zr2Fhn+QqRt1eU8Tf7rs74HMjMFAsO5udGRz
         tlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741893298; x=1742498098;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zb+ZXYsETYl//4H2xcjbCVAdiU5mtxxYtFbhePzBlTY=;
        b=RXgGYG/aoLRGSLlx5HLVtBX+ZhS75ObgG4GH1rZcoNJC/6dTmHb1HSx64XYLOvEoe7
         f/NltPY8eXJ3Z1KqccVicG5ZYNFGFaXfNbLianz8RKMavlCnhfMZcSYNDrR2JkFViazf
         8/yyEQoH6ukdUchhGYzOsmVlRKHbgv6uSro/I1ENL13xk6OIOmETm7+3bvymayyPtyy1
         QYgbCMf2/Aq0G5IFGiFWQ22TXds7/d54syFRu+fYksZ+7frNHOBdmD/+c6A4vYIiUd5m
         ufeKtw6FspjQlUAy72n82NskRe35CGGkn7FoAS8dTl8HDSwJaVgVdaDourVHW/Q7vANv
         tnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8qywijN6vKJRuCBzrIRK9dJKuMya0rygCngxL4E9tST8Jz0kuH+rBK+P6MtzzQGkktXeqF5ItopypVOGM@vger.kernel.org
X-Gm-Message-State: AOJu0YxA8laMJn0VSV1+fkNhj8adzzM3EIjurNMKhR+k6dcgSciFDiMG
	PQBIYht2pu2NhndlKlfcyXmEqFtbrhWOQ5Mqa2hP1oCUYTegChFuGz0moA8Ug5rVcY+2bii9P02
	C3Mkgew==
X-Gm-Gg: ASbGncvWgO9dAcdlS+cQ2dkKFlDlmZJJ0VzIep+R0zNwEil/O6OyFgShO3FGj4/U50y
	op1nmF+3oruovkOVJPTblq/Cyo4Vy1iP1kFIlECIe0EtCJw/PtPSWmYSIBOAhDy7TrKJrkuDRoi
	dx+3CxQWVKs2+jnxKWpjlbLHMiThoLPS2DYp5k2slTsNgSQXR5s4y5Z4WbhluHxCXx2ZZhp5vd9
	rQ6cAoeMat+YoXoIV8fVEtvPUpJGroZ98ZNtnMw8al7C328yjlDfilFiDQ9nNrlm2koV5m/iQsT
	D1x9BcjUHZf4MrkLdMrChtXFtl+un4LocujtbgNr1d1buXLPjjYi8PdDmnhkZKsbC/Ln/VlLzSJ
	wCrA+DeEeGY8Jy12e
X-Google-Smtp-Source: AGHT+IHHCeOtgNM+OytPitUTVjyp5IT+qMTAy7sJY2A+L7brq+8vKqWK5JWvWBrxjO7CL0wONpevIA==
X-Received: by 2002:a17:902:e78b:b0:223:33cb:335f with SMTP id d9443c01a7336-225dd8318c8mr8102905ad.3.1741893298125;
        Thu, 13 Mar 2025 12:14:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7c68:1792:75b7:f9af? ([2600:1700:6476:1430:7c68:1792:75b7:f9af])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68883adsm17091615ad.47.2025.03.13.12.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:14:57 -0700 (PDT)
Message-ID: <3cc1ac78a01be069f79dcf82e2f3e9bfe28d9a4b.camel@dubeyko.com>
Subject: Re: Does ceph_fill_inode() mishandle I_NEW?
From: slava@dubeyko.com
To: David Howells <dhowells@redhat.com>
Cc: Alex Markuze <amarkuze@redhat.com>, Xiubo Li <xiubli@redhat.com>, Ilya
 Dryomov <idryomov@gmail.com>, Christian Brauner <brauner@kernel.org>,
 ceph-devel@vger.kernel.org, 	linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	Slava.Dubeyko@ibm.com
Date: Thu, 13 Mar 2025 12:14:55 -0700
In-Reply-To: <1385372.1741861062@warthog.procyon.org.uk>
References: <1385372.1741861062@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-13 at 10:17 +0000, David Howells wrote:
> ceph_fill_inode() seems to be mishandling I_NEW.=C2=A0 It only check I_NE=
W
> when
> setting i_mode.=C2=A0 It then goes on to clobber a bunch of things in the
> inode
> struct and ceph_inode_info struct (granted in some cases it's
> overwriting with
> the same thing), irrespective of whether the inode is already set up
> (i.e. if I_NEW isn't set).
>=20
> It looks like I_NEW has been interpreted as to indicating that the
> inode is
> being created as a filesystem object (e.g. by mkdir) whereas it's
> actually
> merely about allocation and initialisation of struct inode in memory.
>=20

What do you mean by mishandling? Do you imply that Ceph has to set up
the I_NEW somehow? Is it not VFS responsibility?

Thanks,
Slava.


