Return-Path: <linux-fsdevel+bounces-68084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E2BC53F59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 19:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508CD3B63A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 18:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428DE34FF67;
	Wed, 12 Nov 2025 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO5qqAZ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D03431E9
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972198; cv=none; b=mNvGgWslrjDraAF/s/YDhth0asv4MGolkt8q9CYyika18rdkwG9nWnv4T6gnFW5Lt7lM+ru6ToqlAq2JHk8Fubj2cnPP8bqpO3Tzv+yuvau/VQO1JTez490ymP+qqmCZSFp6TrjQI2x6sqc8cL7sIScHb/sDehZxXfuw05hcTHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972198; c=relaxed/simple;
	bh=m+1Ia7kTgcgwak0tup6RnzackIUD2uj9VJ66wpL5vGU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=P88Hs+GPgaFySKfcAk2PfnqAfNPaRAVEmoRaXJBJtNzow5TEdSflIGzKMZeBZzGSQH1o1P4dUYfoq31Ztvvzyx1q7iJ4fCN31cTg9Z4oXXgzyp+9ZJcw1rRPdNQdIT09qmdoe80RKB5tMsxayrcIdgOuXJ9aDUUHN2WPZnY5Nmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO5qqAZ2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297dc3e299bso11489485ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 10:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762972196; x=1763576996; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+1Ia7kTgcgwak0tup6RnzackIUD2uj9VJ66wpL5vGU=;
        b=HO5qqAZ2+Gl5VjkG2JSxHnyizcDJJvWMPSuF1MP/DI6trW1yhrZRkin+PzYaYHUjS2
         RBcDDcacxNXxzTpkQ/9QSU8fDNFrnL3ojfLUMFAHe6rrP5dycCLZCJR2tOaEHv4GroS3
         vk5iiwOrc79Da3t+l4gAEAkQLQwCl4cvMyasv2eAP7TtSuNngSJwsg3EDzbRKarxMB4j
         CMLdpb9tw8Uo08ghQ046tPNG5SYpAxjbAymnPkLiuOTc9QR3XE1IMJrXuLAaui5sHjDB
         pXuJL2WENAvfEN1rNqM8iUhPKOX0ptF3OIQMAGOtcy1ZhDcsox6MwrRyW6w/1JAip8oC
         2Iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762972196; x=1763576996;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+1Ia7kTgcgwak0tup6RnzackIUD2uj9VJ66wpL5vGU=;
        b=Ppw9X0Vqxl3Wcu+b0zabmERKwoui66+FJ9jnvsVDYaADMJzKkxR+d//EI2iNOnMkoV
         estWkacYMuEL0jppzxf2m+WRvCByk8XHAoFdOkpU0/4aXoNwzTStV+VPWO0WTj0ocI3V
         Kiwp2ihRbuEnZ4oamiptiXdTFasdUb2CPqBGPFtPS2e9c4E11Y2UwIBbPYPxoQbMdQ+K
         GNC0DLbupyFcuyE9kkWWof8LPGEAWOxnOdtvyMMto+vKXlBTKfpwlLbUCJNCTamVMsgG
         dJlpxs68kS428sQgEcYSM2oXmEK8PKf4zvjQTSkfeR6H0SaaQP9/S5XyetkiHRTAzmtX
         pBzg==
X-Forwarded-Encrypted: i=1; AJvYcCXkhjJg0qwH/fVZcBNNKn63gWWlW9x4KrmwVpWwTK5jWuXfE2Dww9CrFwZ3eWPTNqiZDSDs/bUCMnjPSwAD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ek3F8Reqrn1giMA1preIioz4sQ5Gmu/X1BEQ056ceT0hKb7J
	OeLF18QgT713O+iGiM322M429oMlk0cIQLFlRGIlt0VWLLq5qoUMBcjJ
X-Gm-Gg: ASbGncsJk3tOXJiL6rFvNxkXsQN5nDwBEdh0eADeo4P2+s5CwcdJWavc+beahLK1KsE
	BfSrC7j4tMDRMbcy7eW/JplUBoOVXlTFv+ocuHRjwFEt1iy43zfAr0iEBpoSutHl7qMuHv7h+bR
	il2cWaYrIHocNyoZFifkeNw0qiaCoDUz8ayTYv3ZMuGx2vEc96jRtehRwTZx3D9LySGRU93WXff
	PB15IWV3W5VZ7M9oCIdxhBKY6oEwTR9dYs0j8fBXE5qkoRFh6ldKpQ8WbAYs5KQx9k8NSDveDG2
	Bn/wpa8Gi/aaQWVl4ueQz0Vl2KeWFQ1qpCQ4riLOQWw/MECP2wSZsZ2OzBfZEzaEzBs4YYXgD4T
	fJIOVa6nqP1/OHbDCyLt8XR9byml5jQlzo2hbmcTaRYUJ2dIv4D+978I2Db/yqmDa9l6CCAqeMR
	EInHRM
X-Google-Smtp-Source: AGHT+IFVnSebX+tve6ow5sKGnu/YjQAUbucUwHpAyxG58VlkbMSagtb5MvrLUf3x+LSxMJMf4HjlNQ==
X-Received: by 2002:a17:903:286:b0:295:4d24:31bd with SMTP id d9443c01a7336-2984ed45e40mr49939405ad.17.1762972196331;
        Wed, 12 Nov 2025 10:29:56 -0800 (PST)
Received: from localhost ([2405:201:3017:184:2d1c:8c4c:2945:3f7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dc9f8f1sm37254355ad.54.2025.11.12.10.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 10:29:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Nov 2025 23:59:48 +0530
Message-Id: <DE6XHERVPQ7Y.163VOB8V2BURD@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <criu@lists.linux.dev>, "Aleksa Sarai"
 <cyphar@cyphar.com>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>, "Jan
 Kara" <jack@suse.cz>, "John Garry" <john.g.garry@oracle.com>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>, "Darrick J . Wong"
 <djwong@kernel.org>, "Namhyung Kim" <namhyung@kernel.org>, "Ingo Molnar"
 <mingo@kernel.org>, "Alexander Mikhalitsyn" <alexander@mihalicyn.com>
Subject: Re: [PATCH v5] statmount: accept fd as a parameter
From: "Bhavik Sachdev" <b.sachdev1904@gmail.com>
To: "Andrei Vagin" <avagin@gmail.com>, "Bhavik Sachdev"
 <b.sachdev1904@gmail.com>
X-Mailer: aerc 0.21.0
References: <20251109053921.1320977-2-b.sachdev1904@gmail.com>
 <CANaxB-wjqGDiy523w6s+CDKpC0JbQLsQB6ZipW20jieNPe3G6Q@mail.gmail.com>
In-Reply-To: <CANaxB-wjqGDiy523w6s+CDKpC0JbQLsQB6ZipW20jieNPe3G6Q@mail.gmail.com>

On Wed Nov 12, 2025 at 11:30 PM IST, Andrei Vagin wrote:
> On Sat, Nov 8, 2025 at 9:40=E2=80=AFPM Bhavik Sachdev <b.sachdev1904@gmai=
l.com> wrote:
>>
>> Extend `struct mnt_id_req` to take in a fd and introduce STATMOUNT_BY_FD
>> flag. When a valid fd is provided and STATMOUNT_BY_FD is set, statmount
>> will return mountinfo about the mount the fd is on.
>
> It would be great to add self-tests for this new feature in
> `tools/testing/selftests/filesystems/statmount/`. These tests would
> serve two purposes:
> demonstrate the functionality of the new feature and ensure its
> continued stability
> against future changes.
>

We are currently working on adding selftests!

You can see the progress on this branch on github [1] and this commit
[2]. We will try to send a patch as soon as possible.

[1]: https://github.com/bsach64/linux/tree/statmount-fd-tests
[2]: https://github.com/bsach64/linux/commit/9ad91e5e2f01d5c7a8ac24b6e13c79=
42457a5270

Kind Regards,
Bhavik

