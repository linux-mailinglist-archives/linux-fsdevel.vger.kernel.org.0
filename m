Return-Path: <linux-fsdevel+bounces-64456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FDDBE819D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13E39507D35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CF43128DC;
	Fri, 17 Oct 2025 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cuD2Jm51"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6952F3126D1;
	Fri, 17 Oct 2025 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697809; cv=none; b=nLaYlFAiLhfbSDjtheHXI6OtLzvEwjhTINmnFehxNUSG34UaMlH1qnFjl2yUjiRDuob6QJMSYYyh2J3h/Vpq0lrc35NaMmDgGJf0dc8bDk6u6zLhekpm7XYdkFbVognsiKotKkCd+9zwh62y7zM1Om4y1QpHhsffGk5f9nTQhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697809; c=relaxed/simple;
	bh=hf+F/gI3YS+CEaOWjxTNaXAcxDISx7e00ZbT2jiaGho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dM0NBDmU9SO+l1d+ezxRAicrDAqQx63kdU+f4EoERquhU8F08ICFYMUEq+mjucwB3mpqHfiK0vRYe9jjPz62oCfSJWP5o1y4JUYQO6sR5U964i82ULnZkAoJYDErrlI/XNEKyhhdMqpqKhUr+6syJEAaNsnxb8Tus1KnoSfBb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cuD2Jm51; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760697805; x=1761302605; i=quwenruo.btrfs@gmx.com;
	bh=hf+F/gI3YS+CEaOWjxTNaXAcxDISx7e00ZbT2jiaGho=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cuD2Jm51vKnzcsTHQOyaxsiW8KnzxjQLoNOGRl1a2np3HbQ81u1S7BY59QAEpUHj
	 qZKmPp6Z54uEtZ7F+qR3DNyDtPMyFggyfgh9/yQzOknhb0o2xcuHfyxRsmPBiT7Oe
	 tUdu5DE9HU1CeQitIFEU5oicRwQSqUbftSzX1ds55/IwqrxS40723/lFS+vLYyn3C
	 CYfnax/GLPmcIMcf1A42W+U9/JdYfOx4zsIl/7mX1dlZQR65Vxoni/WdFoQVpEHud
	 qUSQVZQzRnYkPp3xuSjB54DE4S5HgpyXiZqEcwpgaKoJKMuWBIOaUOZ5kCFr4vtzA
	 kEAVXi9DanwiyA4DcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHG8m-1uwWey3qQi-004IbK; Fri, 17
 Oct 2025 12:43:25 +0200
Message-ID: <0d2eb0c9-9885-417f-bb0a-d78e5e0d1c23@gmx.com>
Date: Fri, 17 Oct 2025 21:13:21 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Long running ioctl and pm, which should have higher priority?
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <3a77483d-d8c3-4e1b-8189-70a2a741517e@gmx.com>
 <20251017103932.1176085-1-safinaskar@gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20251017103932.1176085-1-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HdXGAdKNkMRwVp1YGGer+D9X6WQybvsuMuAvk9oJ0NsfCuRkNYX
 jBoIi3yqWPmExOTMi6pvstc5+gfJ+znlakaVJSfqhQVZjofVcL9FkJK98ftzRgT1myoITkN
 enlTGniLkLp+gXP4uqFEqUj0+/crxCY2RfsGdT0YNHDTsS7IuWNa26Q3Pu/STcHX5y5TSxr
 ytWOYKhoM54fIy9RB7zyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yCxOblLS4Vc=;Pqyu74fbm1htZASDjqHDfwx1BwB
 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
 yzFXm9wcClZSRBQwd0W7PdPqHQZMA5GaSOQ=



=E5=9C=A8 2025/10/17 21:09, Askar Safin =E5=86=99=E9=81=93:
> Qu Wenruo <quwenruo.btrfs@gmx.com>:
>> But there is a question concerning me, which should have the higher
>> priority? The long running ioctl or pm?
>=20
> Of course, pm.
>=20
> I have a huge btrfs fs on a laptop.
>=20
> I don't want scrub to prevent suspend, even if that suspend is happening
> automatically.
>=20
>> Furthermore the interruption may be indistinguishable between pm and
>> real user signals (SIGINT etc).
>=20
> If we interrupted because of signal, ioctl should return EINTR. This is
> what all other syscalls do.
>=20
> If we were cancelled, we should return ECANCELED.
>=20
> If we interrupted because of process freeze or fs freeze, then... I
> don't know what we should do in this case, but definitely not ECANCELED
> (because we are not cancelled). EINTR will go, or maybe something else
> (EAGAIN?).
>=20
> Then, userspace program "btrfs scrub" can resume process if it
> got EINTR. (But this is totally unimportant for me.)

The problem is, dev-replace can not be resumed, but start again from the=
=20
very beginning.
As the interrupted dev-replace will remove the to-be-added device.

Scrub it self is more or less fine, just need some extra parameters to=20
tell scrub to start from certain bytenr.

Thanks,
Qu

>=20
> Also, please CC me when sending any emails about this scrub/trim bug.
>=20


