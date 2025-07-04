Return-Path: <linux-fsdevel+bounces-53898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026F1AF885A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 09:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCE054193E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 07:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3358A26FD9A;
	Fri,  4 Jul 2025 07:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="pbvgY4pd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F21E47AD;
	Fri,  4 Jul 2025 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612474; cv=none; b=iFDEdAi9oeHo3noDwsHLDdNLkUleH55IRx5zUlqgA+itQ6irJnjBeTEpSF1Y9O0Sa0Fq//1CF1/lLP6uwA4FCVJynbXRhWDFNBfiaXBvl3i4JMTH0VfskaP7ERIZ8OCmhZEmUB9r67RjX96OLB21N5m3AI9sdwDcQvzsq2DgYf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612474; c=relaxed/simple;
	bh=yzuMe071uaayuSB4vit4jXDTJuXEt+KQlnRalkqfVGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFb19EPKXK1IT+e+qwO/O2Tq35X65SPs9ZPlic3oPRUqaGnITA9mv2gOZuJmP4PUA0PGMNTfwwcSCQgDoW7IncfY+fSyooqQ4bnYdYHcjMIsDFK0Yw5htbRi6YiGzqBVX0avBhTaU/bzNrOw2hMRmacWshkN+P7jjeqf/3+ip3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=pbvgY4pd; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751612469; x=1752217269; i=quwenruo.btrfs@gmx.com;
	bh=+5l77JsqwJKaMJlEox7kqLrMQusqyKaUYTFElmSTTyY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pbvgY4pdZZcJy51LtjVcueVOS+uBLYNMHwpeyIDu9CvquTzbQUIhGsw7bd+QbsA9
	 tqsxylx+xig5wV0TqzZwkapTqTA5NcliT1fcPgMy9cjq5EY15H5gBy+42Bd2Ies1G
	 sYHQs6nB2bcvSKXuLROOkCstjiKfRoQroL9+4RU74fw5xu4n8fiUFYSjpvDnN5HTC
	 zCY9bhzLrih5jJr8bvKzDl3jL78mM4VuhqYOYV0oIq1TK1tpuAXiQgDiP89Mccezh
	 pYhXkZTsW58W1Rfia0aJ37UNDmVjaBlv5lsZD+MWLMsZNMwopg3kZn117M12bJq6J
	 n0t5Yt1d+cYvXBl10g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCtj-1v4zpL2Rk7-00iroE; Fri, 04
 Jul 2025 09:01:09 +0200
Message-ID: <12d8534d-1c91-4f48-97f9-468117ca9524@gmx.com>
Date: Fri, 4 Jul 2025 16:31:03 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] btrfs: implement shutdown ioctl
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, WenRuo Qu
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>
References: <cover.1751577459.git.wqu@suse.com>
 <b2e79c1e16e498b9eb99447499a0d8a353ff6d21.1751577459.git.wqu@suse.com>
 <eba400eb-645e-4aee-9074-5f561b1baead@wdc.com>
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
In-Reply-To: <eba400eb-645e-4aee-9074-5f561b1baead@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zBTMDridl5JP3aR8/CKg4HbEcQKVVZpQFK5asS9S1zQ15/wsUQ0
 sPXrXXnpJOCIJgqCpY2Rqax1dEBEX1LQhyJHr4PB0mMYbKf4yY5VYPU6NIjzctA7wPqeJWV
 F1Vxf9soWMcAJn4NGdGGlQS8ST0I51UXV+wEJHbB5f/1Vx5hPH3i2QZ5OYOYYEXu4vAf3D0
 JZGki6BZsyTZMQQzjteYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ug9p1w2OeAw=;d26838dYcrO+5TLL4XUVtwLVH0p
 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
 TTke4n+



=E5=9C=A8 2025/7/4 15:55, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 04.07.25 01:43, Qu Wenruo wrote:
>>    long btrfs_ioctl(struct file *file, unsigned int
>>    		cmd, unsigned long arg)
>>    {
>> @@ -5201,6 +5231,8 @@ long btrfs_ioctl(struct file *file, unsigned int
>>    	struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
>>    	struct btrfs_root *root =3D BTRFS_I(inode)->root;
>>    	void __user *argp =3D (void __user *)arg;
>> +	/* If @arg is just an unsigned long value. */
>> +	unsigned long flags;
>>   =20
>>    	switch (cmd) {
>>    	case FS_IOC_GETVERSION:
>> @@ -5349,6 +5381,14 @@ long btrfs_ioctl(struct file *file, unsigned int
>>    #endif
>>    	case BTRFS_IOC_SUBVOL_SYNC_WAIT:
>>    		return btrfs_ioctl_subvol_sync(fs_info, argp);
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +	case BTRFS_IOC_SHUTDOWN:
>> +		if (!capable(CAP_SYS_ADMIN))
>> +			return -EPERM;
>> +		if (get_user(flags, (__u32 __user *)arg))
>> +			return -EFAULT;
>> +		return btrfs_emergency_shutdown(fs_info, flags);
>> +#endif
>=20
> With that you'll get buildbot complaints if CONFIG_BTRFS_EXPERIMENTAL=3D=
n
> because flags is unused.
>=20
> I'd probably put the get_user(flags, ...) into
> btrfs_emergency_shutdown() to silence the compiler.

That sounds a lot better than all my alternatives (a dedicated {} block=20
to put @flags into, get_user() at the beginning of btrfs_ioctl())

Will go your path when merging the patches.

Thanks,
Qu

