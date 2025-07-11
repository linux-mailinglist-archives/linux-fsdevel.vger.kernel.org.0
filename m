Return-Path: <linux-fsdevel+bounces-54733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BA0B02729
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 00:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668001C27897
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 22:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5965221FB4;
	Fri, 11 Jul 2025 22:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="CM2GR0u0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FDC1DD529;
	Fri, 11 Jul 2025 22:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752274287; cv=none; b=FzJXqz7hpKPnP81OfolvciuHFW+qDKxqMqCCuuedudARQfs6gvY+J8pXYkdV2uLbZNCDpNf9dOJfcXQzjgpV0+lKqRlUL3MfuAg9qZ2D2fOJPVquVAjRvz79ztpHOLzl+uwm2q6j45dhlak3Y4lsMhx7XKJ9xDJ0B3fCAP9u7/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752274287; c=relaxed/simple;
	bh=XR+N0TYld89We+7KIK+St0uRfgNZFBQ16AqZ53rbp1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZr0DkJMX4nZ97+m5PQU+k4mHluk0G09dDIESuTA8mMWsZbYnCR3bXFpsxaJSwlDZTQAvXWJW88L8zywoz9UZovtaHweb8mplS59wTT4ob/6NBoyFZBnbQwXr3C60ngp8Rtqvru1OzV0cKnZ4i1YK3jiAuD51laPIxTMPZ1MwRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=CM2GR0u0; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752274281; x=1752879081; i=quwenruo.btrfs@gmx.com;
	bh=2xUhhWixjLebMMC35oQavOhcJjwoY+k9yJ2cQdafVHg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CM2GR0u0gV748BeRUVhLvtkjYbBqS31EYqkdHtQozeUSMZonus82HAPBzAtmiiMa
	 FeWQ8AITHls/wDm1SzxCTwSNuJJsCRJ53kehNyZrye8HrVfC1zkWCCXBgkmxtHVHd
	 acZw0KY1nPGc4wZ1MU66IoEviUywslo4CHGV4SHm+UwZ7IcV6DjA/2AjTOd/6Zt5F
	 sWmOK3vgHmgxzaij4V/DlBR2eNaUHHjynU4r5+C+vIQ4cEnSr2WpUYKTp8BbEwY8y
	 wmG219qH1t/vL/Xdlr/9yfhLnlfUyR815aN2aOBg3ENkq5E47aUizKj0x9Ls89Ymp
	 u/P5hFYPm8MLM8Swlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdNY8-1v9QM40UCW-00j8wL; Sat, 12
 Jul 2025 00:51:20 +0200
Message-ID: <6bb8c4f4-bf17-471a-aa5f-ce26c8566a17@gmx.com>
Date: Sat, 12 Jul 2025 08:21:15 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: scrub: wip, pause on fs freeze
To: dsterba@suse.cz
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 wqu@suse.com, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20250708132540.28285-1-dsterba@suse.com>
 <72fe27cf-b912-4459-bae6-074dd86e843b@gmx.com>
 <20250711191521.GF22472@twin.jikos.cz>
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
In-Reply-To: <20250711191521.GF22472@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TguN6Xci06zgbTRcQzFqT3D6r7xwGyQUqknL3451sGR2B8L+GO1
 sqDEVWr9sOSkavXUt3rUx+U+fco/735uU7X/HK+kVoZ35c31+7C0qY0Eo8Rn3rdfFwt8UJe
 bTzv67+Z/m6j/+rmpScQIADOdMaaPFAiTgKPe7qaxYAJWTba6H1Tu4PWTY+I/1XABipIN1h
 9Szk8U11ROMRUCL/u1NSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nWLO6P0VEvM=;HJofD2Yoc3KzG6td88lRw8+wTw5
 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
 dHz/trpe0X14siN2Zp10I3k=



=E5=9C=A8 2025/7/12 04:45, David Sterba =E5=86=99=E9=81=93:
> On Wed, Jul 09, 2025 at 07:33:56AM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/7/8 22:55, David Sterba =E5=86=99=E9=81=93:
>>> Implement sb->freeze_super that can instruct our threads to pause
>>> themselves. In case of (read-write) scrub this means to undo
>>> mnt_want_write, implemented as sb_start_write()/sb_end_write().
>>> The freeze_super callback is necessary otherwise the call
>>> sb_want_write() inside the generic implementation hangs.
>>
>> I don't this this is really going to work.
>>
>> The main problem is out of btrfs, it's all about the s_writer.rw_sem.
>>
>> If we have a running scrub, it holds the mnt_want_write_file(), which i=
s
>> a read lock on the rw_sem.
>>
>> Then we start freezing, which will call sb_wait_write(), which will do =
a
>> write lock on the rw_sem, waiting for the scrub to finish.
>>
>> However the ->freeze() callback is only called when freeze_super() got
>> the write lock on the rw_sem.
>=20
> Note there are 2 callbacks for freeze, sb::freeze_super and
> sb::freeze_fs.
>=20
> ioctl_fsfreeze
>    if fs->freeze_super
>      call fs_freeze_super()

Oh I forgot you implemented a new callback, ->freeze_super() to do the=20
extra btrfs specific handling.

But this means, we're exposing ourselves to all the extra VFS handling,
I'm not sure if this is the preferred way, nor if the extra btrfs=20
handling is good enough to cover what's done inside freeze_super()=20
function (I guess not though).

The only user of ->freeze_super() callback is GFS2, and I didn't think=20
we have enough locking/protection compared to either GFS2 nor VFS.


In that case, I still don't believe it's the correct way to go.

Add fsdevel list to see if it's even recommended to use ->freeze_super()=
=20
callback.

Thanks,
Qu

>    else
>      freeze_super()
>        sb_wait_write()
>        if (sb->freeze_fs)
>          call sb->freeze_fs()
>=20
> What you describe matches the 'else' branch as this unconditionally
> blocks on the sb_wait_write and never gets to our callback. This is what
> I observed too.
>=20
> To fix that I've added the sb::freeze_super so it can do something
> to avoid the lockup in sb_wait_write(), because we must at some point
> call freeze_super().
>=20
> Schematically it goes like this:
>=20
>             Freeze thread                         Scrub
>=20
> 	                                  btrfs_ioctl_scrub
> 					    mnt_want_write_file (effectively sb_want_write())
> ioctl_fsfreeze
>    fs->freeze_super
>      set fs->flags FREEZING
>      freeze_super
>        sb_wait_freeze()
>        (BLOCKS)
>                                                (chunk loop)
>                                                  scrub_simple_mirror()
>                                                    if fs->flags
> 						    sb_end_write()
> 						      wait_on_bit fs->flags FREEZING
> 						      (BLOCKS)
>        (UNBLOCKS)
>        ...
>=20
>=20
> Unfreezing is basically the same in reverse:
>=20
> ioctl_fsthaw
>    fs->thaw_super
>      thaw_super()
>      unset fs->flags FREEZING
>                                                       (UNBLOCKS)
> 						     sb_want_write()
> 						     ...
>=20
> So if you see a problem in that please let me know, I've tested the
> patch and it worked but I might me missing something.


