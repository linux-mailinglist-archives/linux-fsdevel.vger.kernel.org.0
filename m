Return-Path: <linux-fsdevel+bounces-38987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E995BA0A95B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 13:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F1A3A76BC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 12:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7091B4138;
	Sun, 12 Jan 2025 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="YCgCQ9JH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2303C1F;
	Sun, 12 Jan 2025 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736686328; cv=none; b=CpsWwMfkhXcqWhBBGYlrg8TezQ68gkptShS88uxs+pfnHb0LDdMjKpXTfekc+CdnBTqCkcOJ29Ir8OXI/OjROhLA4N2+U0MxmUWCxfRA1o1tzL5q3YuI/zmXr1iOFVMfTHAcedt9Y+Ml9PNT2nXgOU8OCIJs6wJxqTqRbTPRIPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736686328; c=relaxed/simple;
	bh=5LQHBkaKUPqBPAk6tMLzYZAzlnMAMIIhj1mnyNvVsn4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XLJzz8KszEDOyPeO93RTJgNE7/e+TY80c3aPy8SBsjk3BEE5VBaYu4Okx4B9JSdHoFyoVN0dGjmfrFb7FGV3+R1EYsUoNbaYbntm8da3qg8IhBRHt/Tb8itdsPBOJ+sK126BkH0Lrj7Nhbh1rsPbtL2EME/CqWnIIV7MOKxf4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=YCgCQ9JH; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736686298;
	bh=Tl+fWuGXe5iQjnPui9x56uWIbCDrPeNumyicJYppU7g=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=YCgCQ9JHUNz6UkwGD4uI8ZMrtRVpTEGR/5ObRPHfcN6/5IEiJBhQEPbCFM4ZjR4La
	 CVRbHTZQj+VXTDd7tClPz74XWibVZEa9SU6uYH+ap85FXIlgMMR5oJXF79NnE+NYU6
	 UbOSofpNT+dWicYvhV7ogC9qPObLPhYbEWd5mk1Q=
X-QQ-mid: bizesmtpsz9t1736686294t9q19wg
X-QQ-Originating-IP: bUg3qcZfIe3XPIZlPiWRG+8tfkv6vvL5AZ3Lx35MpFI=
Received: from smtpclient.apple ( [202.120.235.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 12 Jan 2025 20:51:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18120257315158823718
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: task hung in shmem_swapin_folio
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <Z4OvQfse4hekeD-A@casper.infradead.org>
Date: Sun, 12 Jan 2025 20:51:20 +0800
Cc: hch@lst.de,
 jlayton@kernel.org,
 kirill.shutemov@linux.intel.com,
 vbabka@suse.cz,
 william.kucharski@oracle.com,
 rppt@linux.ibm.com,
 dhowells@redhat.com,
 akpm@linux-foundation.org,
 hughd@google.com,
 linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <431D467D-10F3-4316-A34B-6C1315178B05@m.fudan.edu.cn>
References: <F5B70018-2D83-4EA8-9321-D260C62BF5E3@m.fudan.edu.cn>
 <Z4OvQfse4hekeD-A@casper.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MShfLn39PbN2noE65VQpc7v+jRhbe0U2u6A1kAfRKv2CJN1Ix9a+20HF
	3gRUPDrUMioiN3dxHF/iNwbv2/Pll/3aS2vXqc7c2c4Hq0bUrbj53gR57fMO0/QFAwYdYQu
	x6FiOJHDgkOIhynN3zGVekO/R8HdOmJ/g/nYXCWNJOhlDHnpRAjgnmC2aiYWnPw1J+zfhtJ
	iDfSEw9lrorDOotI0We2fBznrKZaL1WfzjwYBX1hOCfaBjzu0raYYxMjeSHCbIlNC7fye9d
	j5nSY9Dre6/kb9/g6jWCMRkxqa7SAHOMybTsBONLdlxDaxCaDewgLPtK7xE49i4W4lPTUmD
	2nj3Sp1bnYU9/nEWetFW6HivG4oAOhJxOoI6z1G9Cs5cg338Zm5O1JDpphzYZbpVXrhcMLV
	ukxZdJwvbdpL5bjDDV9ri/b0qdtVvc7tDqOb+kERhN8T7hRZtvLnweUyoUceowZjj5Jx/Sa
	ZKfFNDT9FnuAlEOCxJv19EdH5UL8WN3TMKQIqIzjseK/lOdBRpywzSLaDX4eZzRlJPSiDYQ
	uX7fRuZtGzaDV1xA6feE3fzoQbgQ+TDdjwW5y4VEYf49CUY5zKA5pkw1sddq7ffxI8Kd9vU
	A+HkNkoJfCa6wPvT9kInkiIQJbeea5ZZhSdHs7revTgFtuZ3vqYnw0A8TmlfyYsuyf4I7u4
	jkkajxoHDv4VwofeK+0kpvBR2v87zQEH9kUjmPX6S1TMXnfOrgT7dB4AIdsr2CPLU/iPJ+h
	imTWyXNqjqaPHhBYB24OzBq9+4x30AG3LMwp1W8MTaKmU9A5ap4HMLFjidUhq9ucW9g10NX
	nVnpl4zvemsbd1KAgXnKGLO/odHZ3TxMJzKJFUO0UcDcLYrTrLvg9XFaHPCKo9G5xXOdUQ3
	C+/UwJ++jxKqPgeYyEwaK9jhzIRKwW3lBeaBC5Qh985vLbXWnFTzxDiPKSfL05kQtHUzuuC
	+Uj5CcN3V2cuSEgWKAf2UZnsnTXTiqfvA+PwP76BmfWDNAQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B41=E6=9C=8812=E6=97=A5 20:02=EF=BC=8CMatthew Wilcox =
<willy@infradead.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sun, Jan 12, 2025 at 05:46:24PM +0800, Kun Hu wrote:
>> Hello,
>>=20
>> When using our customized fuzzer tool to fuzz the latest Linux =
kernel, the following crash (42s)
>> was triggered.
>=20
> It's not a crash.  It's a warning.  You've just configured your kernel
> to crash when emitting a warning.
>=20
> What you need to do is poke around in the reproducer you've found and
> figure out what it is you're doing that causes this warning.  Are
> you constraining your task with memory groups, for example?  Are you
> doing a huge amount of I/O which is causing your disk to be
> bottlenecked?  Something else?
>=20
> It's all very well to automate finding bugs, but you're asking other
> people to do a lot of the work for you.
>=20

Thank you very much and sorry at the same time.

We know that most of the work of locating a issue should be done by the =
reporter, but having just looked into fuzzing against the kernel, the =
background knowledge of the kernel is not very familiar at the moment. =
That's why we've taken the approach of sending out a report first, and =
after getting professional feedback from the maintainers, we're able to =
target test a particular subsystem or module for them to improve =
efficiency.

Our strategy seems to be incorrect and certainly due to our lack of =
Kernel expertise, again I apologize, we will improve and hopefully =
report really useful information.

=E2=80=94=E2=80=94=E2=80=94=E2=80=94
Thanks,
Kun Hu=

