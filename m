Return-Path: <linux-fsdevel+bounces-69683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA05C8102F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1643AAE37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AF830FC3A;
	Mon, 24 Nov 2025 14:28:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7280130F818;
	Mon, 24 Nov 2025 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763994489; cv=none; b=vF9AsPh5h3Hvmnsq7ivB9G4QxqUjQQe6g76zTPkD8DaCGZpBQvF6QBoPT2H8fITuZQJ/uyHD/VXfioXh0VV2vne4ESYX5rpQ9FLaBttbxOzc1A+sXY6khNPbj1sINKKDj5VG1FBKTPoJPcpiiDLkGzVzS+LATzr7e7u3Y4Bawfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763994489; c=relaxed/simple;
	bh=UOH3L1PAcZXM/qfMxyW2ujcALSBFZdSV7XLCASl6KLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUC4lHqqJO69SW+DGprSd7OhPm8lO2DD4zuDixWAXUnoFhJK5Q+I0YaTzzdJDr1SrphgB1Q9Uzdw4B4nQECRm5Hg13olh5rZRtnOrhMbmNWZq4bScErGJueWeWEWpl0tMMR0MAWOdKy8VYiWdz9sLWlF9X1RW7PENO69I6wrTqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BC2CC68B05; Mon, 24 Nov 2025 15:28:04 +0100 (CET)
Date: Mon, 24 Nov 2025 15:28:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org, linux-block@vger.kernel.org,
	initramfs@vger.kernel.org, linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Dave Young <dyoung@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Jessica Clarke <jrtc27@jrtc27.com>,
	Nicolas Schichan <nschichan@freebox.fr>,
	David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
Subject: Re: [PATCH v4 3/3] init: remove /proc/sys/kernel/real-root-dev
Message-ID: <20251124142804.GC16938@lst.de>
References: <20251119222407.3333257-1-safinaskar@gmail.com> <20251119222407.3333257-4-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119222407.3333257-4-safinaskar@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 19, 2025 at 10:24:07PM +0000, Askar Safin wrote:
> It is not used anymore.

Let's hope whacky userspace agrees with that :)

But we'll have to try this to find out, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>


