Return-Path: <linux-fsdevel+bounces-63397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BCABB81FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 22:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856F14C11CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 20:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A252475D0;
	Fri,  3 Oct 2025 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="Mv3BaZi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2653F23DEB6;
	Fri,  3 Oct 2025 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524192; cv=none; b=fqPepTgJPr+SfQb8Cun2TcNqAhk3f+dFmUcreizJrw9yIjJ3bpXoZxWd6m024TkfQ4szBgKIni1zdNZ36H1SjxxO8u0oHhMJHF0QAYDtVAdpHWhPlriUylVnwlfjaV1RNNprPvNsmxX5cFasn4T6dHCEuYUyYV8SDwJ6dFfrh9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524192; c=relaxed/simple;
	bh=S7eeOUP8hojOSwjYJPXhtFUuFl1sdjUrAVkWs0duBs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RyjzdUzd3GryI00GMZdufy+o05IhT3soSFYWw/lOKhdnC5cLcrj9cuo/C4cdjEjUsfYvBNZCsz1vKi8vexNsgQRMao+DJtPCaZX+lGAybMoFyfp1q4WF7GD7AWgiXmge5p72l8Go4vFaTpaKX/NXu4jZbSYf5rkOMf0WWHe+0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=Mv3BaZi3; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1AD9220638;
	Fri,  3 Oct 2025 20:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1759524187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZk79knIUqstMJyW/Ap35pdPR5P6bmETvfUIwAz64E4=;
	b=Mv3BaZi3XTx6k8D0riMN2OxjRYoRHoKWaef/0CrMuDdVDNe7KtG1yn5qWhXOnP1NyhEJa3
	HwoTF98ZlPfZm5+p9ZaAwoTaSJBIVntHav4zjycLMpOw9K0ZRbiXpNJ36VFl0JYqzwIlf0
	IFMtRbyyaIBSOYMDHxtibQ5JOs+yYpBW2udiHHbOZ5F0M/0DdLFbkdF8EILqk1kNvX5rYd
	jSuGV6o8AvCU/D7ChSk7RZ1/g99RK/GTNonRCXXCMmgu4TQEuEmhQVaC02nBh9h+EBaCm7
	fkvaUIIXlNmcQk8aYT3nuVV53IdCuRTJ+QOz+z2oRmChpx2YgXB2NiD0EuloGQ==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Chuck Lever <cel@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,  linux-fsdevel@vger.kernel.org,
  linux-nfs@vger.kernel.org,  Chuck Lever <chuck.lever@oracle.com>,  Jeff
 Layton <jlayton@kernel.org>,  Volker Lendecke <Volker.Lendecke@sernet.de>,
  CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
In-Reply-To: <28ffeb31-beec-4c7a-ad41-696d0fd54afe@kernel.org> (Chuck Lever's
	message of "Fri, 3 Oct 2025 11:34:17 -0400")
References: <20250925151140.57548-1-cel@kernel.org>
	<CAOQ4uxj-d87B+L+WgbFgmBQqdrYzrPStyfOKtVfcQ19bOEV6CQ@mail.gmail.com>
	<87tt0gqa8f.fsf@mailhost.krisman.be>
	<28ffeb31-beec-4c7a-ad41-696d0fd54afe@kernel.org>
Date: Fri, 03 Oct 2025 16:43:04 -0400
Message-ID: <87plb3ra1z.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be

Chuck Lever <cel@kernel.org> writes:

> On 10/3/25 11:24 AM, Gabriel Krisman Bertazi wrote:
>> Amir Goldstein <amir73il@gmail.com> writes:
>>=20
>>> On Thu, Sep 25, 2025 at 5:21=E2=80=AFPM Chuck Lever <cel@kernel.org> wr=
ote:
>
>>>> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
>>>> index 1686861aae20..e929b30d64b6 100644
>>>> --- a/include/uapi/linux/stat.h
>>>> +++ b/include/uapi/linux/stat.h
>>>> @@ -219,6 +219,7 @@ struct statx {
>>>>  #define STATX_SUBVOL           0x00008000U     /* Want/got stx_subvol=
 */
>>>>  #define STATX_WRITE_ATOMIC     0x00010000U     /* Want/got atomic_wri=
te_* fields */
>>>>  #define STATX_DIO_READ_ALIGN   0x00020000U     /* Want/got dio read a=
lignment info */
>>>> +#define STATX_CASE_INFO                0x00040000U     /* Want/got ca=
se folding info */
>>>>
>>>>  #define STATX__RESERVED                0x80000000U     /* Reserved fo=
r future struct statx expansion */
>>>>
>>>> @@ -257,4 +258,18 @@ struct statx {
>>>>  #define STATX_ATTR_WRITE_ATOMIC                0x00400000 /* File sup=
ports atomic write operations */
>>>>
>>>>
>>>> +/*
>>>> + * File system support for case folding is available via a bitmap.
>>>> + */
>>>> +#define STATX_CASE_PRESERVING          0x80000000 /* File name case i=
s preserved */
>>>> +
>>>> +/* Values stored in the low-order byte of .case_info */
>>>> +enum {
>>>> +       statx_case_sensitive =3D 0,
>>>> +       statx_case_ascii,
>>>> +       statx_case_utf8,
>>>> +       statx_case_utf16,
>>>> +};
>>>> +#define STATX_CASE_FOLDING_TYPE                0x000000ff
>>=20
>> Does the protocol care about unicode version?  For userspace, it would
>> be very relevant to expose it, as well as other details such as
>> decomposition type.
>
> For the purposes of indicating case sensitivity and preservation, the
> NFS protocol does not currently care about unicode version.
>
> But this is a very flexible proposal right now. Please recommend what
> you'd like to see here. I hope I've given enough leeway that a unicode
> version could be provided for other API consumers.

But also, encoding version information is filesystem-wide, so it would
fit statfs.

For filesystems using fs/unicode/, we'd want to expose the unicode
version, from sb->s_encoding->version and the sb->s_encoding_flags.
The tuple (version,flags)  defines the casefolding behavior.

Currently, it is written to the kernel log at mount-time, but that is
easily lost/wrapped.

> (As I mentioned to Jeff, there is no user space statx component in the
> current proposal, but it should get one if it is agreed that's useful to
> include).

I believe it is useful to expose it to userspace, simply because it
modifies the behavior of the filesystem.  An application like Steam can
poke it to decide whether it needs to enable compatibility alternatives
to in-kernel case-folding, instead of assuming the encoding and testing
if "chattr +F" works.

It is not a critical feature, because mkfs for all case-insensitive
filesystems only ever supported one unicode version and strict mode is
rarely used. But if we ever update unicode or provide more flavors of
casefolding for compatibility with other filesystems, which was
requested in the past, userspace would need to have a way to retrieve
that information.

--=20
Gabriel Krisman Bertazi

