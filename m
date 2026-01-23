Return-Path: <linux-fsdevel+bounces-75285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9TYQL9N2c2kfwAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 14:25:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 572727638A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 14:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1D3B301AA84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5876330274B;
	Fri, 23 Jan 2026 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="F0TG+4Df"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD53A2E6CAB;
	Fri, 23 Jan 2026 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769174728; cv=none; b=ftvxTXbTwW5IdsGfIHmOu2fDm6LO2SqxCSCtC7bVLtocmWMP2juOfFHzikspdYC+iXFPZUUeShCivc8mPRLYZfCGHgfckWEH+et56ZPyUVdrhWJ/0shK8AqqsckF+jhbdsUkgA6QGFrd2ymJv7y/1r2t0tpAU1laGtNUlNOrOK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769174728; c=relaxed/simple;
	bh=COI1Vn0YHKV3OVPLgMROQ8SgPobrtuTwkqABWHq9GFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVUwPOelcaLY6q2esZKgoBRU2kTVKu26gAU6VCClG2hwzdy+6ePM4q71O4XaY0pfASXCF97c9QmL8g9QKuWATf08XsEM6+TXEiySgtrrgixPNIxP2wxaRfAWa6Ej0HFuIuF/kJqBEW5TSMLFNXKtN/TiF0ysatKJYB3oGG6la2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=F0TG+4Df; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NkmcwHGTXfF74rwBRnsbltvXcHCGT5Xzk4r/Sa5CsWE=; b=F0TG+4DfKYqxbC9mBgnQPVdnqb
	SZ9Dc0np9ZEglfchr7h44jnjx+M9hFgLwhavB3Lz7ZlEKpl384mNcXOUSCu/24DIYNtLoMIC4xKc2
	2p6/dSQBF/g6NEdKb32Ql5ZLv925WgIVF1iVGSp9+Yjd3CwyEfhu4nZc4jgchJSEC3KPxz8lhTDZB
	te2x3kgzGQJyaxuECraVFbEzOcAJ9s4Hxe+1v+xsqk1xc7y1tUgaFFqYCVUuiA45ld4ZDSvQ4H8Sr
	ugdw6NYOtwP6YrzD9rY1US4CssTN/SBYbSu8DqbX63lqEi5/PwsaSmQxqdLIkztNuYkTpvGUzBych
	lUXKTx+g==;
Received: from [179.98.220.182] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vjH9m-008tyb-VC; Fri, 23 Jan 2026 14:24:59 +0100
Message-ID: <ee38734b-c4c3-4b96-8ff2-b4ce5730b57c@igalia.com>
Date: Fri, 23 Jan 2026 10:24:50 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, kernel-dev@igalia.com, vivek@collabora.com,
 Ludovico de Nittis <ludovico.denittis@collabora.com>
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
 <20260114062608.GB10805@lst.de>
 <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
 <20260115062944.GA9590@lst.de>
 <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
 <20260115072311.GA10352@lst.de>
 <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
 <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com>
 <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com>
 <CAOQ4uxi988PutUi=Owm5zf6NaCm90PUCJLu7dw8firH8305w-A@mail.gmail.com>
 <33c1ccbd-abbe-4278-8ab1-d7d645c8b6e8@igalia.com>
 <CAOQ4uxgCM=q29Vs+35y-2K9k7GP2A2NfPkuqCrUiMUHW+KhbWw@mail.gmail.com>
 <75a9247a-12f4-4066-9712-c70ab41c274f@igalia.com>
 <CAOQ4uxig==FAd=2hO0B_CVBDSuBwdqL-zaXkpf-QXn5iEL364g@mail.gmail.com>
 <CAOQ4uxg6dKr4XB3yAkfGd_ehZkBMcoNHiF5CeB9=3aca44yHRg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxg6dKr4XB3yAkfGd_ehZkBMcoNHiF5CeB9=3aca44yHRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75285-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	FROM_NEQ_ENVFROM(0.00)[andrealmeid@igalia.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 572727638A
X-Rspamd-Action: no action


Em 22/01/2026 17:07, Amir Goldstein escreveu:
> On Tue, Jan 20, 2026 at 4:12 PM Amir Goldstein <amir73il@gmail.com> wrote:
>>
>> On Mon, Jan 19, 2026 at 5:56 PM André Almeida <andrealmeid@igalia.com> wrote:
>>>
> ...
>>> Actually they are not in the same fs, upper and lower are coming from
>>> different fs', so when trying to mount I get the fallback to
>>> `uuid=null`. A quick hack circumventing this check makes the mount work.
>>>
>>> If you think this is the best way to solve this issue (rather than
>>> following the VFS helper path for instance),
>>
>> That's up to you if you want to solve the "all lower layers on same fs"
>> or want to also allow lower layers on different fs.
>> The former could be solved by relaxing the ovl rules.
>>
>>> please let me know how can
>>> I safely lift this restriction, like maybe adding a new flag for this?
>>
>> I think the attached patch should work for you and should not
>> break anything.
>>
>> It's only sanity tested and will need to write tests to verify it.
>>
> 
> Andre,
> 
> I tested the patch and it looks good on my side.
> If you want me to queue this patch for 7.0,
> please let me know if it addresses your use case.
> 

Hi Amir,

I'm still testing it to make sure it works my case, I will return to you 
ASAP. Thanks for the help!

> Thanks,
> Amir.


