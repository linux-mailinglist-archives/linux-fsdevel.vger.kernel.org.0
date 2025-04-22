Return-Path: <linux-fsdevel+bounces-46940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24135A96A34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A443A9623
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D4A27CCDF;
	Tue, 22 Apr 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="l9gUgxJS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFB278F52
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325310; cv=none; b=doHsjPrexMizvecHJ5PJxF0yCcbsITOjP9C/M3XVzsLmKLfXoWBaOKkSal60BBHMhSwIiTdERu7VAUHCL3mtOjgzkAaOVkl+qvGyFIAs1BIzfb/zTksqko4Iy+jk8H2Ebu2ZRrHdWN4VZQYuQZHHtwBJddgWPk4h9Mjc66bPKas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325310; c=relaxed/simple;
	bh=lER80+Pt+CzU7mQdcrKHzgvHgnRzuEHRpOLYXLE7KuA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lRjsOaRQIA2tESLB/sUnJ4EZdeTPaKt1eDNdbmyaAsvFXXKjyFUBmnp/w5tWFfkiKibgCUq4A8qiC2n8CFD8iAXBPCXSGX53VOBVTimBLloK1390W2EC7rKfHLD93pEdUWZI/jAOHC9FSYLyCW5WoWJKdaQ/6SAPh7Kv9iU28eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=l9gUgxJS; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k8rl5/6cYD+b4RybVpJb5JzRtiVY3NiFB4fyP2cin3Q=; t=1745325307; x=1745930107; 
	b=l9gUgxJSpTzQKKl6vSg+n9Iw4dEsV2LIYEPDWaQKoTZkACrshxhrbaKiy5Y81LWOkv+KCQamWwx
	mF0+FnwElc4OaTeh9DOqI6lLQxhzvHS5VPVAZDIyXPP2JIu9mxKjEoBZhoPb0aKUekozB2iV9UcN5
	1XlEpPL0hJ2R4CMVUy8+rqpvI405NLy9DiRFijBMzRnu89BcjxayCSJ77BGdbt/M43KNI/+TzxJtx
	OPI5ycXqsZpTr3RQoPKuR0OarcesSts5hhLAv9f/R7U+opAGlbmjKw8Gl7CcvUIp4nl0+V0UFYKIC
	jxHkaUe6O36J5KK1IHk94NrsvDB80Rpc1CBg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u7Cq8-00000001tJt-3yQB; Tue, 22 Apr 2025 14:35:04 +0200
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u7Cq8-00000003Ex8-2yOx; Tue, 22 Apr 2025 14:35:04 +0200
Message-ID: <2a7218cdc136359c5315342cef5e3fa2a9bf0e69.camel@physik.fu-berlin.de>
Subject: Re: HFS/HFS+ maintainership action items
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "brauner@kernel.org"
	 <brauner@kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
Date: Tue, 22 Apr 2025 14:35:03 +0200
In-Reply-To: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
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

Hi Slava,

On Mon, 2025-04-21 at 21:52 +0000, Viacheslav Dubeyko wrote:
> I am trying to elaborate the HFS/HFS+ maintainership action items:
> (1) We need to prepare a Linux kernel tree fork to collect patches.

Yes. I suggest creating a tree on git.kernel.org.

> (2) I think it needs to prepare the list of current known issues (TODO li=
st).

Shall we use the kernel wiki for that? I suggest starting with the collecti=
on
of known CVEs as well as possible patches. I know of at least one CVE that
Ubuntu has fixed locally.

I can send an email to the author of that patch and ask them to send their
patch upstream.

From my memory, there are some occasional filesystem corruptions reported
on HFS partitions which might be a result of a bug in the kernel driver.

They can be easily fixed with fsck_hfs from hfsprogs though.

> (3) Let me prepare environment and start to run xfstests for HFS/HFS+ (to=
 check
> the current status).

I suggest a Debian VM for that as it has hfsprogs which allows creating bot=
h
HFS and HFS+ filesystems. It's also easily possible to test on PowerPC insi=
de
QEMU if necessary.

> (4) Which use-cases do we need to consider for regular testing?

Definitely testing both legacy HFS and HFS+ with creating new filesystems, =
writing
and reading random files from it as well as running fsck on these.

I'm not a Linux kernel filesystem expert, so I don't know what the recommen=
d tests
for CI are, but I suggest everything that is commonly used, both with HFS a=
nd HFS+.

> Anything else? What am I missing?

No, I think that should get us going for the time being.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

