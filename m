Return-Path: <linux-fsdevel+bounces-71177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF35ACB7A8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 03:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E50CC3048096
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 02:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2D4242D78;
	Fri, 12 Dec 2025 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="i6jPmsRZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0BA1E7C2E
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765505951; cv=none; b=VRyMnvsHpKw78nc4Ij6Da/MvzV/2G5K/TMeErksEs6ppQnfu/XljwJHtYzUUUYCv0qe8rZoHBiQvhwODPSxBhXIRZiAAn30hg+FtibZkk7GkWzjAp/rpDEARPkCepIVxAMySPJ0B/uqLKS7FlLS82wrwKuQiwq7SEz5AA3VWT/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765505951; c=relaxed/simple;
	bh=oKmWqno+42Yszq+X+3dPg3C6ZlbSV4utaiC5PwGM8sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiliKBNsinQbk8H87gZj9jlwNkw7AJD9vlmI3wgZnkqe9QbTFirdvWmNXHkhh8mbw0bQ/qI34HMNSLpyueeLtuHQGVsYKcSuH4NCwdik2jGvpn1X49UjeOxspr4/HTuIk0RvvK6XUaW7QF1kzx7NyV2YhAapkdOcCBQFLml11KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=i6jPmsRZ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (fs96f9c361.tkyc007.ap.nuro.jp [150.249.195.97])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5BC2IYhd032743
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Dec 2025 21:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1765505920; bh=kHgJW7HgRu8VCSroGjRmOAwqb8zj56QpPoiLbKKowPw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=i6jPmsRZFsshYqSOPIZXGaEp16grpLapyL5n0LAa2Y6q8+Fs8uoaOx0TtcUMCd9nT
	 2QJBxhWViCMXJm9xiBNNmCNgBmX8ohWnVb+u+NSungMPk4KDsQnj1CS1cxwnmzRsMe
	 wnnEbYZxZl0UAga3IRec8PoDOt70P9QmDHgoBwo4K0Wdd055p4anCouP5qjkiGV0HY
	 RQ99LXn14r/Ocge+yCwLrc+U95yc6POn/QHywjGkdpv9yXUBtv+e3GaIj1CQttTaPr
	 8DL9FWdStVjTIIUGYKrgiC2f5PF9BCJtwx9R7MN+LZ8mLysvkjMBXB2Y7nJIjNp6mo
	 Uuck8DUHWQ+rg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 3E7DE4FB3D3C; Fri, 12 Dec 2025 11:18:34 +0900 (JST)
Date: Fri, 12 Dec 2025 11:18:34 +0900
From: "Theodore Tso" <tytso@mit.edu>
To: Chuck Lever <cel@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp,
        almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
        Volker.Lendecke@sernet.de, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/6] fs: Add case sensitivity info to file_kattr
Message-ID: <20251212021834.GB65406@macsyma.local>
References: <20251211152116.480799-1-cel@kernel.org>
 <20251211152116.480799-2-cel@kernel.org>
 <20251211234152.GA460739@google.com>
 <9f30d902-2407-4388-805b-b3f928193269@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f30d902-2407-4388-805b-b3f928193269@app.fastmail.com>

On Thu, Dec 11, 2025 at 08:16:45PM -0500, Chuck Lever wrote:
> 
> > I see you're proposing that ext4, fat, and ntfs3 all set
> > FILEATTR_CASEFOLD_UNICODE, at least in some cases.
> >
> > That seems odd, since they don't do the matching the same way.
> 
> The purpose of this series is to design the VFS infrastructure. Exactly what
> it reports is up to folks who actually understand i18n.

Do we know who would be receiving this information and what their needs might be?

      	       	     		       - Ted

