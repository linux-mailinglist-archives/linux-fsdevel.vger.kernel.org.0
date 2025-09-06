Return-Path: <linux-fsdevel+bounces-60443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D36B46AA4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D31C5633BC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6F8258EF3;
	Sat,  6 Sep 2025 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uAMaUbRp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B6D2045B7
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757150217; cv=none; b=Vx4s3xLdN9tXhkQotJtAWJkCkXM6pkTZPBpT0i4PqeqwmfQ8KdHnx/U5Bahb5Eu2l1znx1LMOuPgrZ1On8uPMkELpiTC7Bhs3fINsumjmHjM9vrDVX3tOUQNciKnjQDTiaIdDWPAjPe+3+KGK34ceArmAtoHXG63XPGlf8HCXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757150217; c=relaxed/simple;
	bh=I0/8Iqxu0zv2lZo9ohWT+P1kuMlmsbXw6YZ5BkXI2+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gG5dEp2eiITC8GV3bZ63uJbId1wxxLfeN+TuxqysiB13Bpu1Tz5pWb5cqKm4ccIyv5bYyG8Q6UfFVhnJCxhosqF8V/ek6ow/srXCgirvNDT2P5uOnXJ2JhMA7scCsejoDQVh1cu7wbIFNvrzgD4xYEwVu9xs+6+VZl+zxVnKkCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uAMaUbRp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I0/8Iqxu0zv2lZo9ohWT+P1kuMlmsbXw6YZ5BkXI2+w=; b=uAMaUbRpIwziRF4YBn2CX78q6I
	ee13DZW1gQ8xdg41cyxyjR/EjOF/BaUj0AnckyIFr35j236S48Pc/SocLvylMuax451KfzZC1H8cZ
	M6h5q9wDzobaBaREEdP7XhWjoD48g5y62aV5zFg2RlCOH1BTz2Hm3i0yYncjs4hISUL/hCngyDjFF
	yVaxaZITGkOMLFxIINUWThVH5JJr3D5AlXVAg27mpRXKue4ZPvu0P5jcMb4rmYB+fdEeveIZCKljh
	jR2SUejFeVEsFVjgNHiuwEnR/ztwQGDn/nAecKahPQSnwL/eoQ364K7pW8l3QiuEsMk+cAdop9oZl
	sKmwfKWA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uup2T-00000000T4v-1ch6;
	Sat, 06 Sep 2025 09:16:53 +0000
Date: Sat, 6 Sep 2025 10:16:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	John Johansen <john@apparmor.net>
Subject: Re: [PATCHES] file->f_path safety and struct path constifications
Message-ID: <20250906091653.GD31600@ZenIV>
References: <20250906090738.GA31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906090738.GA31600@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Sep 06, 2025 at 10:07:38AM +0100, Al Viro wrote:

> Branches are in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.path and
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.f_path resp.;
> individual patches in followups.

PS: 21-patch series is #work.path, other 2 are #work.f_path proper - it's
(1/2) + merge with #work.path and #work.mount + (2/2)

