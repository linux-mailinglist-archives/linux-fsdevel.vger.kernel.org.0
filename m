Return-Path: <linux-fsdevel+bounces-75962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFeQO5AWfWkGQQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 21:37:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8E2BE712
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 21:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52869300A5B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 20:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA18346E6A;
	Fri, 30 Jan 2026 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LZT2DYxf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38612737F2;
	Fri, 30 Jan 2026 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769805446; cv=none; b=Bus33uvksiln4cZgeqZDX1g4bwWQFiyZg47X/f+5rijkw5zOB+z7ahfbOcAJSkvi3t1aSlRoZouQ48ECmFIr+7wedf9BANX+IzTjW//1GQqjosQqkSwWkkgIo42jbW7WWl0g3N34msxnNeb97i+PDDKX5aVYZCYpRggguiTl6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769805446; c=relaxed/simple;
	bh=92V6GMxlPPjGAnqbQR2v9wmykRSrciuCBlgxpwfvg6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baGh2X91wdVCqmUqEi/tDPpToAbpDSZrMnUZt5FVkTC5D05rOe2lovVsB1h1z7s/Mx74yLldTTHPSpIM1Skg56iGmbAzbegUu9xUfpl/+nFisRFTsM2dv4ViWD2je5jahu5TjkYkNDbfIVNXP51oPwUy9/pdquJ2x2p3VyZy9MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LZT2DYxf; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769805431; x=1770410231; i=quwenruo.btrfs@gmx.com;
	bh=92V6GMxlPPjGAnqbQR2v9wmykRSrciuCBlgxpwfvg6E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LZT2DYxfaJGraQDg+HuPfOTNH6QqnzRH4AW9/q4QcTk1uCL8VfGKSZOIG+MJL2vo
	 FovPh7eQ27p9fqrjeQD2XJyk+Wv4qeUgOI8sVpn5X4uOM2lQJKMCUv4E1c/d6UhTb
	 XXAvXGRLrJLohY4fHBtGibUmmay9lYFV1LqN8TCzKPf4FwyjrJD0UMYGhRlzPDUyj
	 wltq7l0GvEqQAgqfTk5iHr4ufA8omBerzdTjf/CAUy7oMAMjgbJ51RHIjNPumGZsq
	 aQI7sxsdmoGVGSXX/8DMrsz+UK7R4TrgGFzfNbl+tsweXEMYQ9Gb0+B+i1D52eYiq
	 XZkFTT0Oo28C5sm2RA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCsQ4-1vd9nR2rM8-00BSzS; Fri, 30
 Jan 2026 21:37:10 +0100
Message-ID: <ee4898be-b0e0-4163-b734-c2891239dce6@gmx.com>
Date: Sat, 31 Jan 2026 07:06:59 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] btrfs: defer freeing of subpage private state to
 free_folio
To: JP Kobryn <inwardvessel@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: boris@bur.io, clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260129230822.168034-1-inwardvessel@gmail.com>
 <776e54f6-c9b7-4b22-bde5-561dc65c9be7@gmx.com>
 <aXw-MiQWyYtZ3brh@casper.infradead.org>
 <00d098da-0d01-43f9-9efb-c18b6e8a771e@gmail.com>
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
In-Reply-To: <00d098da-0d01-43f9-9efb-c18b6e8a771e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/9AAMhqgvKd7v0u0F7Y6Tu8fdrsHeQfq9w+sxgPCWvkF9he563J
 SrnlEP+ilEKW+Lhem8erRl1iaIEkdsXr1koeaYN8LxQpu5YYa1gqSixAroX+kFZwxna7S1C
 Fv9teerDQMQmqcom4mweqY8xmqJyXQuk2ijemhvcRi2klEpe6nIq+7zcTQViAa/eJDJOARS
 YUTxBqpX73jlhF0iC4JHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZVxBjtDwgeg=;p/kYkBV8kVoGyOLROkn5jdFuH81
 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
 P1CRiejku4rXzsBjLWoeRKfJwqxs6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-75962-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.com];
	FREEMAIL_TO(0.00)[gmail.com,infradead.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.com:mid,gmx.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B8E2BE712
X-Rspamd-Action: no action



=E5=9C=A8 2026/1/31 03:40, JP Kobryn =E5=86=99=E9=81=93:
> On 1/29/26 9:14 PM, Matthew Wilcox wrote:
>> On Fri, Jan 30, 2026 at 01:46:59PM +1030, Qu Wenruo wrote:
>>> Another question is, why only two fses (nfs for dir inode, and=20
>>> orangefs) are
>>> utilizing the free_folio() callback.
>>
>> Alas, secretmem and guest_memfd are also using it.=C2=A0 Nevertheless, =
I'm
>> not a fan of this interface existing, and would prefer to not introduce
>> new users.=C2=A0 Like launder_folio, which btrfs has also mistakenly us=
ed.
>>
>=20
> The part that felt concerning is how the private state is lost. If
> release_folio() frees this state but the folio persists in the cache,
> users of the folio afterward have to recreate the state. Is that the
> expectation on how filesystems should handle this situation?

I believe that's the case.

Just like what we did in btrfs_do_readpage() and prepare_one_folio().

There is no difference between getting a new page and a page that is=20
released but not removed from the filemap.

>=20
> In the case of the existing btrfs code, when the state is recreated (in
> subpage mode), the bitmap data and lock states are all zeroed.

That's expected.

Thanks,
Qu

