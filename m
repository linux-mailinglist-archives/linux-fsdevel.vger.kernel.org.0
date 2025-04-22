Return-Path: <linux-fsdevel+bounces-46891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81045A95F23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 09:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC1C17727A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 07:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCFF238C1F;
	Tue, 22 Apr 2025 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="IvTuDDMe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA61624DF
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306455; cv=none; b=qNKYtNPxe2JHcrrCvLYexOB2GlJLUZ4GTDuQBmP0k/5Yy/2XrAogPVR1kfyE0o4TUtpOK7gVTcx/We9qIIBdKB1v5Z4hP/yCGnxL/fNvkSWMx4hUP8Da6EB4m2VIai/6hUL0wws2fh/XiBY5J4LEgK1IhtZtHyQLPKYS4GCFfuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306455; c=relaxed/simple;
	bh=NKn2eFitA6PtIdgQsTTgwHuZo2XhIV0bW+MDjDDzxxc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dkYlLWonwsSdv86UkJhlLxUgAt0OyXAWJA2pwlLRj67jZeVFANGuDT5AX0D7zbZbcAurAwZ68WY0rv0wYFD4zXSrfZtzN/Yy3K0VPPueF7Q7nIz8IPiOU7m3JMyRDYCt34GuCOcw9Ed4KsNHyLIZFH7r85aS3ZZOlBMPrMBdrxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=IvTuDDMe; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oAULY09e/+D1ONFlyrFombiDBX0ddNAmarxxszudSMU=; t=1745306451; x=1745911251; 
	b=IvTuDDMehkRmqvhmAZleMr756kXVXg+v8S4pBwYQiUwR7KtHcOOkkj+6yyLBOBalx/4beNMtzTl
	+rtZXIvs4JnWIVAZIjgn3fnxu5uPy4M/BrLh6m+XuueK/PXDZIOoY2846R7qKSyDwtRvIvSR+N+wi
	wJjROiQeIVU8OlwwaynBYtBWnq2xnPUrnk9bIrRPsIkZbA4RK2rJ0VidpblJ9PK49/ZAblbjgwKNW
	2iskiGX6PUiR+VEM/uRI440YdWVPFPo4q/5qnoNa72V+/qiSWxbcaN4JtfMlefLalqjC7ZpFo1wUR
	gDCyPd/xsB+ey3445QwuKhKn+yK6ZeUJ/F9Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u77vv-00000003b9u-1jAq; Tue, 22 Apr 2025 09:20:43 +0200
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u77vv-00000001oZb-0kEY; Tue, 22 Apr 2025 09:20:43 +0200
Message-ID: <1e5d5c5ca88584534cb9b658025da5fc2bf0f119.camel@physik.fu-berlin.de>
Subject: Re: HFS/HFS+ maintainership action items
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Theodore Ts'o <tytso@mit.edu>, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "brauner@kernel.org"
	 <brauner@kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
Date: Tue, 22 Apr 2025 09:20:42 +0200
In-Reply-To: <20250422024333.GD569616@mit.edu>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
	 <20250422024333.GD569616@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ted,

On Mon, 2025-04-21 at 21:43 -0500, Theodore Ts'o wrote:
> On Mon, Apr 21, 2025 at 09:52:14PM +0000, Viacheslav Dubeyko wrote:
> > Hi Adrian,
> >=20
> > I am trying to elaborate the HFS/HFS+ maintainership action items:
> > (1) We need to prepare a Linux kernel tree fork to collect patches.
> > (2) I think it needs to prepare the list of current known issues (TODO =
list).
> > (3) Let me prepare environment and start to run xfstests for HFS/HFS+ (=
to check
>=20
> One potential problem is that the userspace utilities to format,
> check, repair HFS/HFS+ utilities don't really exist.  There is the HFS
> Utilities[1] which is packaged in Debian as hfsutils, but it only
> supports HFS, not HFS+, and it can only format an HFS file system; it
> doesn't have a fsck analog.  This is going to very limit the ability
> to run xfstests for HFS or HFS+.

There is actually hfsprogs from Apple themselves which supports both HFS
and HFS+ works without any problems. I'm maintaining it in Debian [1] and
openSUSE. It's available in Fedora as hfsplus-tools. I have hacked on it
for a while, so I can also provide updated versions.

In the future, I'm planning to split the package into a normal and -legacy
version as Apple dropped legacy HFS support from the utility somewhere arou=
nd
version 500.

Adrian

> [1] https://tracker.debian.org/pkg/hfsprogs

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

