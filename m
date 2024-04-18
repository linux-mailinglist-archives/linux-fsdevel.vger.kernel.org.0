Return-Path: <linux-fsdevel+bounces-17225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B998A931E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 08:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 056DDB20F6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 06:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0840D225D9;
	Thu, 18 Apr 2024 06:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3vXDRAb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F938F6B;
	Thu, 18 Apr 2024 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421900; cv=none; b=RF5gzvIVXEQowjQxsJrermo2KEGwTfRt+8ltXgrTWcK6Cnnt0PURtLGnWSjI1if+EW7CqRLfhrFk4pRMCASPujILJvBmE9xUTIz0SbwLhyy5wwwn0nIo4SnL92bmE+iFlmOxxwzO/HW8xJ4sJuJOAYIp2bxNyUzthgUjYVeJexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421900; c=relaxed/simple;
	bh=QK75sxWwO2BdHIbjXDFJ/BBEkaabbYciPzZkH2gMSO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUgErzZuhwxXQmO4bJUrmhzdPNCGi5DJ4PtZXHUOGqJ13ljEZ1+wJz8iOsW3VL9iri19w1vdU/U7VQvB2DW0nHbPTPVYa5CZeD0IHIIv5eB63hPv4wpMoA/nAa+kfvbal5hI+nkhoZAhcFygeabtctSZmWsIVHVpRVgnULNLQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3vXDRAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2867C113CC;
	Thu, 18 Apr 2024 06:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713421899;
	bh=QK75sxWwO2BdHIbjXDFJ/BBEkaabbYciPzZkH2gMSO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a3vXDRAbOzBSaBvWgOOMfd/pjQ+MqUjO6tpkplhL3OknsEqxjbURT8p0Az/SNglGZ
	 vsw72ELdF+CGJSmasxKoC4th0BMawFWtdHsFvpYMz7kFGldtI+oybvElpg43W9SSCF
	 Rrpt7oUpPvg8OaJS9LDz6Rre7AyOMb3I6y6ZZxuNLdxQReg3Y6Ci5ygO1seu8EQ08r
	 iGfd/f5XqnZ+KHi0Yt8BoRbn/TxcYA1NOqYKc5n5W6bkJXUge1n2OW0So3+o1SyzKH
	 WTXsf+TFYiDyiuPsY5ZG/YnZxo/Lk/rURBZEJDL3dh84SmVszrRM+PF1cy21a05Hpx
	 OL7L2Aj6njWjg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rxLJ6-000000000MM-3I9T;
	Thu, 18 Apr 2024 08:31:41 +0200
Date: Thu, 18 Apr 2024 08:31:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Anton Altaparmakov <anton@tuxera.com>
Subject: Re: [PATCH 11/11] fs/ntfs3: Taking DOS names into account during
 link counting
Message-ID: <ZiC-TNxianVojCJv@hovoldconsulting.com>
References: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
 <0cb0b314-e4f6-40a2-9628-0fe7d905a676@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cb0b314-e4f6-40a2-9628-0fe7d905a676@paragon-software.com>

On Wed, Apr 17, 2024 at 04:10:59PM +0300, Konstantin Komarov wrote:
> When counting and checking hard links in an ntfs file record,
> 
>    struct MFT_REC {
>      struct NTFS_RECORD_HEADER rhdr; // 'FILE'
>      __le16 seq;        // 0x10: Sequence number for this record.
>  >>  __le16 hard_links;    // 0x12: The number of hard links to record.
>      __le16 attr_off;    // 0x14: Offset to attributes.
>    ...
> 
> the ntfs3 driver ignored short names (DOS names), causing the link count
> to be reduced by 1 and messages to be output to dmesg.

I also reported seeing link counts being reduced by 2:

[   78.307412] ntfs3: nvme0n1p3: ino=34e6, Correct links count -> 1 (3).
[   78.307843] ntfs3: nvme0n1p3: ino=5bb23, Correct links count -> 1 (2).
[   78.308509] ntfs3: nvme0n1p3: ino=5c722, Correct links count -> 1 (2).
[   78.310018] ntfs3: nvme0n1p3: ino=5d761, Correct links count -> 1 (2).
[   78.310717] ntfs3: nvme0n1p3: ino=33d18, Correct links count -> 1 (3).
[   78.311179] ntfs3: nvme0n1p3: ino=5d75b, Correct links count -> 1 (3).
[   78.311605] ntfs3: nvme0n1p3: ino=5c708, Correct links count -> 1 (3).

 - https://lore.kernel.org/all/Zhz_axTjkJ6Aqeys@hovoldconsulting.com/

Are you sure there are not further issues with this code?

> For Windows, such a situation is a minor error, meaning chkdsk does not 
> report
> errors on such a volume, and in the case of using the /f switch, it silently
> corrects them, reporting that no errors were found. This does not affect
> the consistency of the file system.
> 
> Nevertheless, the behavior in the ntfs3 driver is incorrect and
> changes the content of the file system. This patch should fix that.

This patch is white space damaged and does not apply.

> PS: most likely, there has been a confusion of concepts
> MFT_REC::hard_links and inode::__i_nlink.

I'd also expect a Fixes and CC stable tag here.

And as this patch does not seem to depend on the rest of the series it
should go first (along with any other bug fixes).

> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Johan

