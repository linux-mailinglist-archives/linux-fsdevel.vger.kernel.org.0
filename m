Return-Path: <linux-fsdevel+bounces-75309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLj6G2PVc2kCywAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 21:09:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C32D7A7ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 21:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9ADD3006103
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 20:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7462D7DD2;
	Fri, 23 Jan 2026 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LA+JHJHy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2FC2BD033;
	Fri, 23 Jan 2026 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769198938; cv=none; b=hQfx4H9LFb/f9zyfriMHZXCcJwRSHwv+mFGJnRw9RFDhDWfSaJQ2MjThtA4HYngtge1zrMCiR/8avIrkN5uI/B3NrGpoLp8xltWjp7TK4skwVkS9Ii5IdhDc79LnPfZCJEK76sKNN4itu1urXJy4afFvLFz/blDwCAE3WuEbajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769198938; c=relaxed/simple;
	bh=yw2HWRH6pNHZTTAZOoeK52aKZQxm6K/tbztdUXquWbo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cS++bvi63edmVKX36rlsB93cuonEo9DL15vY0vOK0grjroAp2JRKNLycqDGkr3oz4q3FSmFkz/FwXfH36ts/jPy6eXsup9QDq6vv/YpwXp28ngTLyGFGHqwqoOR08aBuVuqy+8i4omWKJSnFqfB4Lul1qt7qVRqqsqZQzkwOMME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LA+JHJHy; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=y2h4FKO/gqZGLIyqCMA1b/alWBeXTXRgrdUbRGvBD8A=; b=LA+JHJHy9q+ShI1ucA8baGdKFW
	apfmJBwwbRyg/M0uStUWHdqrGP6Uq8oDQ6Qafq2DC3jjhsULMZgZMXbzjKDflefY4cu/+NSA/R5I3
	43OKXh0Y9x6psWQsAzb3ZlsJVCqWLpbjO+QD/bPyzYhf2o089znqkibyqwr7IGbF2A8KKz+QAiTLP
	6h4yUT8dgXFlF+XJ5sebPr3tuVdPcG1cortS3kxQYOk+7sAlhuYzHvbjHwYMlxJo3x1CFuT9nych9
	CF31WIpq0da7Ro7d/1Mwv+C+UBBtpG8XahYjce/Eqx2Q9eS31trY5sH1K1S9laXQIXZK3ier//Umq
	1zOMyPnA==;
Received: from [179.98.220.182] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vjNSI-0092uX-KP; Fri, 23 Jan 2026 21:08:30 +0100
Message-ID: <8ab387b1-c4aa-40a5-946f-f4510d8afd02@igalia.com>
Date: Fri, 23 Jan 2026 17:08:23 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
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
 <ee38734b-c4c3-4b96-8ff2-b4ce5730b57c@igalia.com>
Content-Language: en-US
In-Reply-To: <ee38734b-c4c3-4b96-8ff2-b4ce5730b57c@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75309-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[igalia.com:-];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_NEQ_ENVFROM(0.00)[andrealmeid@igalia.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1C32D7A7ED
X-Rspamd-Action: no action

Em 23/01/2026 10:24, André Almeida escreveu:
> 
> Em 22/01/2026 17:07, Amir Goldstein escreveu:
>> On Tue, Jan 20, 2026 at 4:12 PM Amir Goldstein <amir73il@gmail.com> 
>> wrote:
>>>
>>> On Mon, Jan 19, 2026 at 5:56 PM André Almeida 
>>> <andrealmeid@igalia.com> wrote:
>>>>
>> ...
>>>> Actually they are not in the same fs, upper and lower are coming from
>>>> different fs', so when trying to mount I get the fallback to
>>>> `uuid=null`. A quick hack circumventing this check makes the mount 
>>>> work.
>>>>
>>>> If you think this is the best way to solve this issue (rather than
>>>> following the VFS helper path for instance),
>>>
>>> That's up to you if you want to solve the "all lower layers on same fs"
>>> or want to also allow lower layers on different fs.
>>> The former could be solved by relaxing the ovl rules.
>>>
>>>> please let me know how can
>>>> I safely lift this restriction, like maybe adding a new flag for this?
>>>
>>> I think the attached patch should work for you and should not
>>> break anything.
>>>
>>> It's only sanity tested and will need to write tests to verify it.
>>>
>>
>> Andre,
>>
>> I tested the patch and it looks good on my side.
>> If you want me to queue this patch for 7.0,
>> please let me know if it addresses your use case.
>>
> 
> Hi Amir,
> 
> I'm still testing it to make sure it works my case, I will return to you 
> ASAP. Thanks for the help!
> 

So, your patch wasn't initially working in my setup here, and after some 
debugging it turns out that on ovl_verify_fh() *fh would have a NULL 
UUID, but *ofh would have a valid UUID, so the compare would then fail.

Adding this line at ovl_get_fh() fixed the issue for me and made the 
patch work as I was expecting:

+       if (!ovl_origin_uuid(ofs))
+               fh->fb.uuid = uuid_null;
+
         return fh;

Please let me know if that makes sense to you.

Thanks!
	André



