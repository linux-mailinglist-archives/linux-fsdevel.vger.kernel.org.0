Return-Path: <linux-fsdevel+bounces-76486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFkYIir/hGl47QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 21:35:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF62F7310
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 21:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FED03025910
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 20:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF4A32E152;
	Thu,  5 Feb 2026 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eNaQaWxY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1C12F3601;
	Thu,  5 Feb 2026 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323730; cv=none; b=sIdFe4AsrL89LS9F1S+6JA8OSBMxgKx6oQVRGAcRaGSUkOHE+khEpfPht8tbqpVphKA7aFGnH9oFyHoPlj0ph1hWjfLNbnMjgPWtKWqGxOqrYZPBXLFieR2BcA8uaCHyf5HL7a59Yqdp12GeP6xKdUqxaYz05aOB+jkr60YjtCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323730; c=relaxed/simple;
	bh=vM7jv+m+6bMkOShmYUN1ahQ9mC41CDLIlJMHJGRgfaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yfmpjy92gQXOdmc2HhsLSCpbIAa9iE0jDgEI3JBr+GVMhvDtF3ib6Rz51iw8hIX1TRVRtpOUtPE5q7X2OWmQylMsF9xRy3FA8A9OLBBSUELvhYMA1oXEJ0hHLrXscI5QQczg66Uxvv2u+rn7TTp85fgx1dhoqzp0Bja6vaVENXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eNaQaWxY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yHhcPcm7/aNDLEtRnOuhFSnTHyU3PJmqaMR5L62zSNU=; b=eNaQaWxYojWshirXCeqA9eyVJZ
	hZcnGM9H28EPr5osfLxORkm082Y6MkKZ5voUiADi394hCJ+XNhacAJh1LBRmNsyQoB4xZUVcwuVfj
	YGaPAZG+JMFzlnk7BDNjCRiAyQQLtUsVPuA1eZZYshIAwYWNpgs40J3djdEEtw8t3WTuN67ziGx1y
	rFpklmAl4+PoV/fL0slBG35ZyahuEDzQuEQQpaHP3OhTS542F8aTc3Ck6it796ftV4eKAnoVJEW+q
	WTnRFjYyNfg5nrpdc7UVma2NHmv6D4tGfOk0PaN8+NylCYq2Z1CJZnXg97oAE13fcllv6V0qHi4Ke
	/xvHK1tg==;
Received: from [187.57.129.220] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vo63v-00EXuY-38; Thu, 05 Feb 2026 21:34:51 +0100
Message-ID: <05c37282-715e-4334-82e6-aea3241f15eb@igalia.com>
Date: Thu, 5 Feb 2026 17:34:42 -0300
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
 <8ab387b1-c4aa-40a5-946f-f4510d8afd02@igalia.com>
 <CAOQ4uxiRpwuyfj_Wy3Zj+HAi+jgQOq8nPQK8wmn6Hgsz-9i1fw@mail.gmail.com>
 <CAOQ4uxhHFvYNAgES9wpM_C-7GvfwXC2xet1ensfeQOyPJRAuNQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxhHFvYNAgES9wpM_C-7GvfwXC2xet1ensfeQOyPJRAuNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76486-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	FROM_NEQ_ENVFROM(0.00)[andrealmeid@igalia.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:mid,igalia.com:email]
X-Rspamd-Queue-Id: 2FF62F7310
X-Rspamd-Action: no action

Em 28/01/2026 08:49, Amir Goldstein escreveu:
> On Sat, Jan 24, 2026 at 11:45 AM Amir Goldstein <amir73il@gmail.com> wrote:
>>
>> On Fri, Jan 23, 2026 at 9:08 PM André Almeida <andrealmeid@igalia.com> wrote:
>>>
>>> Em 23/01/2026 10:24, André Almeida escreveu:
>>>>
>>>> Em 22/01/2026 17:07, Amir Goldstein escreveu:
>>>>> On Tue, Jan 20, 2026 at 4:12 PM Amir Goldstein <amir73il@gmail.com>
>>>>> wrote:
>>>>>>
>>>>>> On Mon, Jan 19, 2026 at 5:56 PM André Almeida
>>>>>> <andrealmeid@igalia.com> wrote:
>>>>>>>
>>>>> ...
>>>>>>> Actually they are not in the same fs, upper and lower are coming from
>>>>>>> different fs', so when trying to mount I get the fallback to
>>>>>>> `uuid=null`. A quick hack circumventing this check makes the mount
>>>>>>> work.
>>>>>>>
>>>>>>> If you think this is the best way to solve this issue (rather than
>>>>>>> following the VFS helper path for instance),
>>>>>>
>>>>>> That's up to you if you want to solve the "all lower layers on same fs"
>>>>>> or want to also allow lower layers on different fs.
>>>>>> The former could be solved by relaxing the ovl rules.
>>>>>>
>>>>>>> please let me know how can
>>>>>>> I safely lift this restriction, like maybe adding a new flag for this?
>>>>>>
>>>>>> I think the attached patch should work for you and should not
>>>>>> break anything.
>>>>>>
>>>>>> It's only sanity tested and will need to write tests to verify it.
>>>>>>
>>>>>
>>>>> Andre,
>>>>>
>>>>> I tested the patch and it looks good on my side.
>>>>> If you want me to queue this patch for 7.0,
>>>>> please let me know if it addresses your use case.
>>>>>
>>>>
>>>> Hi Amir,
>>>>
>>>> I'm still testing it to make sure it works my case, I will return to you
>>>> ASAP. Thanks for the help!
>>>>
>>>
>>> So, your patch wasn't initially working in my setup here, and after some
>>> debugging it turns out that on ovl_verify_fh() *fh would have a NULL
>>> UUID, but *ofh would have a valid UUID, so the compare would then fail.
>>>
>>> Adding this line at ovl_get_fh() fixed the issue for me and made the
>>> patch work as I was expecting:
>>>
>>> +       if (!ovl_origin_uuid(ofs))
>>> +               fh->fb.uuid = uuid_null;
>>> +
>>>           return fh;
>>>
>>> Please let me know if that makes sense to you.
>>
>> It does not make sense to me.
>> I think you may be using the uuid=off feature in the wrong way.
>> What you did was to change the stored UUID, but this NOT the
>> purpose of uuid=off.
>>
>> The purpose of uuid=off is NOT to allow mounting an overlayfs
>> that was previously using a different lower UUID.
>> The purpose is to mount overlayfs the from the FIRST time with
>> uuid=off so that ovl_verify_origin_fh() gets null uuid from the
>> first call that sets the ORIGIN xattr.
>>
>> IOW, if user want to be able to change underlying later UUID
>> user needs to declare from the first overlayfs mount that this
>> is expected to happen, otherwise, overlayfs will assume that
>> an unintentional wrong configuration was used.
>>
>> I updated the documentation to try to explain this better:
>>
>> Is my understanding of the problems you had correct?
>> Is my solution understood and applicable to your use case?
>>
> 
> Hi Andre,
> 
> Sorry to nag you, but if you'd like me to queue the suggested change to 7.0,
> I would need your feedback soon.
> 

Hey Amir, sorry for my delay. I just had a week out of the office and 
just got back to this.

Our initial test case worked great! We managed to mount both images and 
use overlayfs without a problem after your clarification of where to use 
uuid=off, which should be on the first mount.

However, when rebooting to the other partition, the mount failed with 
"failed to verify upper root origin" again, but I believe that I forgot 
to add `uuid=off` somewhere in the mount scripts. I'm still debugging this.

Anyhow, I see that we are now too close to the merge window, and from my 
side we can delay this for 7.1 and merge it when it gets 100% clear that 
this is the solution that we are looking for.

Thanks again for your help!
	André

> FWIW, I think that this change of restrictions for uuid=null could be backported
> to stable kernels, but I am not going to mark it for auto select, because
> I'd rather see if anyone shouts with upstream kernel first when (if) we make
> this change and manually backport later per demand.
> 
> Thanks,
> Amir.


