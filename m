Return-Path: <linux-fsdevel+bounces-41908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B53CEA39056
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 02:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBD21894DBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 01:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968BA74040;
	Tue, 18 Feb 2025 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ec6MQOG6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F81D52B;
	Tue, 18 Feb 2025 01:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841698; cv=none; b=dFWb+nr7OoGt3ZROcIxNVtk0nT62S6PlNq1mEEQQFfSUG0ujm/fY2wCh2BglmzvZyyGeQSJC9YyYEk2O84Ci/h1jP05sfemxh4THqimJQ0RnQzGOH+PycK/cjfsom/Svj4TBZA5VFfOe2Zk4DAh90msULjV5vEoBQ+DaOnqkvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841698; c=relaxed/simple;
	bh=7DGxI1QlBEmJ0uwXnLMdfKtd1VHwoWygB6sBz2GO6Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0MncxNLGGdtw42LVh+ZYqF+7x6CmDEwnDmh0xvA8uVqplcofmm1ZUqUR+oRf1F4ig9u2vKHA53tGwZ2MNBE5iu6pwezI1HpJjZVuLBrwe05qeX8zhmERerO+VQ1HiXg9ZAzCiu5fS//yyqRYJ7q0y8HzaKWJ4G9iRm8evHSl98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ec6MQOG6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WF9Ri4h1K95Pl/my+41is+x07VggVScf/HOnxc636yI=; b=Ec6MQOG6rdNdOixigqk/VmqAK1
	tH81I3Q9OnTGFIRRDuNLy7MRsZn8LFeoVrrMx1Y80CiO+j2uQEngX/GYf/6ax1sCepUVUO7U2cRpi
	8xy+HTmlC65fErcY6g4gxbv5+C4o1hKSdmPDuNux0XkgmFNvYMN2tr1B/bkDnTwMbhkMVR7dYBdiP
	F/Tw0HYeyjlGL0No9m4o8T0nrFbQ++bts5GsXodOoV1uIb/xtLo7Ff8RC6Fk206su5qGx3BkQmpVH
	o+wTlK6VtZpXcqrQbDXfOfjDh9/liKgQ4VXAmNva9kLh93WaMQ4G1b2CjvZswGT5MTitTs1OguEkp
	rhJFXUrQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkCIm-0000000HSMu-16PI;
	Tue, 18 Feb 2025 01:21:32 +0000
Date: Tue, 18 Feb 2025 01:21:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "luis@igalia.com" <luis@igalia.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"idryomov@gmail.com" <idryomov@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] odd check in ceph_encode_encrypted_dname()
Message-ID: <20250218012132.GJ1977892@ZenIV>
References: <20250214024756.GY1977892@ZenIV>
 <20250214032820.GZ1977892@ZenIV>
 <bbc3361f9c241942f44298286ba09b087a10b78b.camel@kernel.org>
 <87frkg7bqh.fsf@igalia.com>
 <20250215044616.GF1977892@ZenIV>
 <877c5rxlng.fsf@igalia.com>
 <4ac938a32997798a0b76189b33d6e4d65c23a32f.camel@ibm.com>
 <87cyfgwgok.fsf@igalia.com>
 <2e026bd7688e95440771b7ad4b44b57ab82535f6.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e026bd7688e95440771b7ad4b44b57ab82535f6.camel@ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 17, 2025 at 10:04:50PM +0000, Viacheslav Dubeyko wrote:

> [  326.477120] This frame has 1 object:
> [  326.477466]  [32, 287) 'buf'

> (gdb) l *ceph_encode_encrypted_dname+0x4a5
> 0xffffffff829d6605 is in ceph_encode_encrypted_dname (fs/ceph/crypto.c:273).
> 268		u32 len;
> 269		int name_len = elen;
> 270		int ret;
> 271		u8 *cryptbuf = NULL;
> 272	
> 273		buf[elen] = '\0';

Cute...  The fix is obvious (should be
                        char buf[NAME_MAX + 1];
rather than
                        char buf[NAME_MAX];
), but the funny part is that it had been a bug all along -
if you give the mainline a name that has a 255-character component
that happens to start with _, you'll get buf[] filled with a copy
of that component (no NUL in sight) and have it passed as 'name' to
parse_longname() that starts with

        /* Skip initial '_' */
	name++;
	name_end = strrchr(name, '_');

See the problem?  strrchr() expects a NUL-terminated string; giving it an
array that has no zero bytes in it is an UB.

That one is -stable fodder on its own, IMO...

