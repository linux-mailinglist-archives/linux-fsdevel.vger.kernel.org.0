Return-Path: <linux-fsdevel+bounces-75888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOgSLqive2l3HwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 20:06:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9D6B3C82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 20:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26E20301ABB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 19:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFBD311C21;
	Thu, 29 Jan 2026 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="MwVKP/Np"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCC72D838B
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769713556; cv=none; b=GCwfczwb+ifsY1xXanaK6tFrNiDWB3y6WQY9ADWMLS7kkdaRk0f4gDVs5IcF5h2vBJZviqUJ/bXo7Ppp1075QnfCV9lj6zGpcxFx0Uj/tXjWWOpOLA2xn+V0mfy0hEnT4CwEqtqFpO4bJigrriBfGtfFbDECw+lIm6GgTa3BYFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769713556; c=relaxed/simple;
	bh=lOluY+kohGK59RnEdPozu9jf5kxwl95BMHOqO2h81u4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=b/xXGuKaNmKfTt/ccZn4424UZjf2lyVrbRYFN5630JTT35P8sG9YUgcIhZUS0BOhpT2rFthrNfaEt20uSz6GsKBH2HgeAW4AONSBCcL6dj4aj/AjDXDq+WUn2AdeFt3ngrBGKj2P0DD+QZhJ8mtadGhaoIUFFAtYp8yrJWW5nq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=MwVKP/Np; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 838863F915
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1769713502;
	bh=3YUwGhSe5cmulYnP+zjzxZ+VOJXRSZEIvRudrnykpq0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To;
	b=MwVKP/NphefDyhkCzZFfYA58vOfbIU2efKcfNpBLjz16wRnxOCKPTXZajhXX/zPKA
	 k/pG62jGCK9+QzPmgaVQcdF2W9qxjxuDRj2ZBKkBnXMfVy13M7UmYp2uKKuYwk0JoD
	 5IzFbzaaeC0+0AJvSM3XF6KTPcuxNS3663846hGAP/OJFwCgRqnZZj0Acf5EiurdgO
	 L0JeA4tvrSvT5e0weWZ3+Xroso6ZIJ5d4bs2mtlD/DLV2NDGvcwC7+7CrxjMOtJurd
	 svQFV8VEsrC8/GX9LR5C7W1/DGJJOAw2CMTidu/RuA4+o84JPKNmdmRCTqxzvwwCv1
	 QYrC5w674/EFRfyPvAWVH5UaAJL+UInDy50fTbvV8cHXpkJgTxWIhEgCEzlETxyT8r
	 tuDaI8v34s7hM18fZ3Ql+oSIpMlICxslbDBltZIIehkZJr4fJalXii4z6LBo3eOxel
	 n4ybcCjMOMG1CVKPDXkPBwDt9ku/8wCGaZM1eM/3bIh7LLQXhiFJiuui3L01iHAUUK
	 cI2zN0bDB+oEWVxk9k69dgViS4MwMiQJgaI/ZbbL/3/7UWoGoolZJqybGyuvAE1TzK
	 OWgXIkooxjZpTwnjblzlD/z+qUSnbNvUqw9/717PV7zPpaBd1BLflgL6Xuz5VZAB/O
	 Hqj1lbJg4vjbLD06SJ+/qCRU=
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48069a43217so12695345e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 11:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769713502; x=1770318302;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YUwGhSe5cmulYnP+zjzxZ+VOJXRSZEIvRudrnykpq0=;
        b=MCK366EvAV5AtvMHJK3ujfFyO/QbIbyQ+7G4YigfNC+uIDVUFXFHm0H0oI5yGfNJGF
         z7ghie3lIkipSEcCYcr1iEjWlF5qExKb4vOU8O82Lw12dNeEw1E7+yBb/TYukhv3Slc1
         beiugj0Sib4ruxbESa0x52HvM5qrgtSCQPhkCtdQa2/hJSKftFTqgUYVelJI07rvL3El
         NyTUyBfZiugDhcVuRCiRo/RDlZ0lW/xSPFVo3Mtv4PJDTfiAMJlmCluTJeiZ9UqM+TBB
         bO0bwsGf1boc4Jm5BUtzWtYr11gg2QVRHIiA1W/qydrntdxUdfz2SNYzwdfkWNjFeHP2
         8USQ==
X-Forwarded-Encrypted: i=1; AJvYcCXteHQMhl2RY+C8rvYxKlpCRlreQdO8xD3MYdNNevIrZ+1T4/X93AvSkPPn/p6TUAhkV+D4UCUDBtCEYRsb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8oHYgj7B0pOHRvsCRAz2BED+hM77pXJmhli4eZGqDaA5e1AAw
	zoormjckFUfEucR9PKb3GYhRp0Czwk76ZcJEN5veSEJJJ3X5lR2oicUQvpNkDyBmh3GFQ05YU/3
	IUQKjGRunkLtXpeYNR0BSfiZk1JRyZN2eR4pSO6UZomGRjNaz+Lre+8/Qm2yAAaJOBVgk/EC1y6
	rDmNI8TbDk13/RqtYIOw==
X-Gm-Gg: AZuq6aJrSKY/WjbakOtnZL26i0h73oCOTBwiyTduDMP0gsTsDZBFrpnO9IIQyCwYgWL
	5gYIqDM4+Uf9jpy3XFmonqBR39wc9H/UQLI3BzfZKb542jHJctNU1xc2D4roCr8ZGyKgHR5428f
	yaaSVs/cj6PbOndcuHF47dt/MVT9fPGacb8aWg9Eg1mFXY99S/zdYdKGHM06TR9cWTdI35/TcAD
	a8gdzgcDCAObkUz2cv++Lz3O43egINvZ6FHt22zglbnD5Fy3tLxFM972/H4MB4Kr6vIAf1kkm5W
	p+CAcsKeTcnxG0ZH2Bi7KhaynQMBRkcihhlfdc3jqxtEH+m8H6Pzq+DH0mTOULemXOi19TBtHQx
	Xrg8kW4VE
X-Received: by 2002:a05:600c:1385:b0:47e:dc64:f1c6 with SMTP id 5b1f17b1804b1-482db493eb4mr2539185e9.6.1769713502060;
        Thu, 29 Jan 2026 11:05:02 -0800 (PST)
X-Received: by 2002:a05:600c:1385:b0:47e:dc64:f1c6 with SMTP id 5b1f17b1804b1-482db493eb4mr2538845e9.6.1769713501608;
        Thu, 29 Jan 2026 11:05:01 -0800 (PST)
Received: from localhost ([2001:67c:1562:8007::aac:4abc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482da909669sm1850615e9.9.2026.01.29.11.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 11:05:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Jan 2026 13:04:57 -0600
Message-Id: <DG1B2T5I7REV.30XR7YCI0RSZ4@canonical.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Duplicated entries in /proc/<pid>/mountinfo
From: "Zachary M. Raines" <zachary.raines@canonical.com>
To: "Christian Brauner" <brauner@kernel.org>
X-Mailer: aerc 0.20.0-2ubuntu1~jmap
References: <DG0B0GEW323Q.29Y4J0A0Q5DQ5@canonical.com>
 <20260129-geleckt-treuhand-4bb940acacd9@brauner>
In-Reply-To: <20260129-geleckt-treuhand-4bb940acacd9@brauner>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75888-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zachary.raines@canonical.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,canonical.com:mid,canonical.com:dkim]
X-Rspamd-Queue-Id: 4B9D6B3C82
X-Rspamd-Action: no action

On Thu Jan 29, 2026 at 8:28 AM CST, Christian Brauner wrote:
> On Wed, Jan 28, 2026 at 08:49:12AM -0600, Zachary M. Raines wrote:
>> ...
>> 2. Reads `/prod/1/mountinfo` and checks for duplicates
>>
>> #!/bin/bash
>> THRESHOLD=3D75
>> echo "Starting monitoring at $(date)"
>> while true; do
>>     # Get mountinfo entries and count total
>>     mountinfo=3D"$(cat /proc/1/mountinfo)"
>>     mountinfo_count=3D$(echo "$mountinfo" | wc -l)
>>
>>     if ((mountinfo_count > THRESHOLD)); then
>>         echo "$(date): Mount count ($mountinfo_count) exceeds threshold =
($THRESHOLD)"
>>
>>         # Find and log duplicate mount points with their counts
>>         duplicates=3D$(echo "$mountinfo" | sort | uniq -cd)
>>
>>         if [[ -n "$duplicates" ]]; then
>>             echo "Duplicate mounts :"
>>             echo "$duplicates"
>>         fi
>>         echo "=3D=3D=3D=3D=3D"
>>         echo "$mountinfo"
>>         echo "---"
>>     fi
>>
>>     sleep 0.1
>> done
>> ...

> Thanks for the report. So it's a bit unfortunate that you're showing
> duplication by source path. That's not as useful as that can
> legitimately happen. So the better test would be to see whether you get
> any duplicated unique mount ids, i.e., whether the same
> mnt->mnt_id_unique appears multiple times. Because that's a bug for
> sure.

It turns out I pasted the output of an old version of my test script,
above, but if you look at the script itself, it checks for duplicates,
of the entire mountinfo line, i.e., duplicates have the same unique id.

> I suspect the issue is real though. I'm appending a patch as a proposed
> fix. Can you test that and report back, please? I'm traveling tomorrow
> so might take a little.

Thank you for the quick turnaround on that patch. I applied it on top
of 6.19-rc7 and after about 3 hrs I haven't seen any duplicates, in
contrast to without the patch where they appear in under 10 minutes.

Let me know if there's any other testing that would help.

Best,
Zach

