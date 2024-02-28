Return-Path: <linux-fsdevel+bounces-13078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F5486AFE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 14:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7811C22173
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 13:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5523BBCB;
	Wed, 28 Feb 2024 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="X5c+gvCJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9F73508
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125608; cv=none; b=N4qDaPwFd4pDJSWpxhkpnePQbv6+ZPTRfiTj0mjaVdujiLR4JVvZyHMqvHxeZzZJf3cZ8vCxS+hnAzD/SBl9x9S3wGnnUmoFK7jkKOrC93B3e8iGfvr/Zt/0s/9O7asZQgMWKHm0tWVKTfXUQtCUtD6DgWkdxevhFjNdefceGdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125608; c=relaxed/simple;
	bh=Y/RsrfUmJnCAYk9v/aUYrsMlV3XktMUAupKq4GcEL64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1mFArAo4xK/uM8BJ7o9z+pQXAzpcGz6+Slg21mjjzrYXSJhR5rLca9/0+Y5bj/WVEidOE5GzNZ9DGEpn2RN+3HuLfoRyYfAf6h9CYiGePb+0wXIcfruPR+qrGRYKB+o8k/PIRriamLrkih5kitVYa5qmME0pMzndpqlQIkISbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=X5c+gvCJ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-565a3910f86so6264892a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 05:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709125604; x=1709730404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Nlzv6k7NWhG0+QPE7xvOqaQ6udeSJAp8XgDPXueUu0=;
        b=X5c+gvCJ2+uK0CWOPx4d7ziaeoz+l30Jsuc5NkVxiUiUh9fndghxhK2SdIn4n7ONLN
         vlewwfSFHf39/rNlc17rl7S1/sMQ9VnNg4CZjnZNImI4Oytdw0fxF3k2O17SLFL05cns
         4n+HHzvkKezLfL+OOUw6HwNCBxU/E/h9tlGug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125604; x=1709730404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Nlzv6k7NWhG0+QPE7xvOqaQ6udeSJAp8XgDPXueUu0=;
        b=XE6BPPN3dQmTClkKRVo4JhZr7LWJIaDkwkeL9WMbDXrvTKDKQoKO024GMQ92H7lPIc
         V1PBwZG0yDZLRvPuTtOz2UqeZLEEaRF5TGS5tnNc32TR1GvCWi+jI2/ModTQ24MdNg6N
         uN8o9n1XbVnJVW6YM8H4qkH7imVTlUv6DxZ5xQGO3Tj6kQJFWs/gJziWmbQtCeBMO9nC
         VBvVISCe9Dyv02szDwajCmEM6ShDx03H7i6tJXX+3/iAgajVj4k9/7QCiM4gJU4kYSTE
         5ErhlA2Oyv/Iq5yMOyD0hdqo2L0UF16gWuTUuNQFhVAn5dEK6GrjIRCTgI5LF5naWvfU
         UnCg==
X-Forwarded-Encrypted: i=1; AJvYcCXGRarQsf6N4JODAGAfGrccx9+JwaL/4X9g4WB7RrNGoWljgiQKBBWSDO7WeDytmpTOdfv6a3fX1Hw20v+6fMqRwukbGAgzZA3ipqeR0g==
X-Gm-Message-State: AOJu0YxUDDtveNbw3eJgRMQAewHW4TjIDw87mJJHfmzaEbVHSV7uDDyA
	Vp4vTgCiX84fa6tqYd/TJJBGo3+PjSasCDBzt5OR/0nt3rdnpTFB+ufEYQnaBfRYfXIBJ8g2Gve
	NMl0uA+M08nbVQhi66wcZBPhRBZVsNSqNNmRzJHh0f1En+VAL
X-Google-Smtp-Source: AGHT+IHFFdYXMnvX1v7DFvLdleH9r4Dr/nn0IIlezE4UsoEcQBuAmsD7fzOAOu8aHnus+VD4738X5cyX5yHLuq/zk9A=
X-Received: by 2002:a17:906:1183:b0:a3e:e869:a151 with SMTP id
 n3-20020a170906118300b00a3ee869a151mr8503461eja.45.1709125604513; Wed, 28 Feb
 2024 05:06:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link>
 <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm> <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link>
 <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com>
 <5b7139d5-52fd-4fd0-8fa0-df0a38d96a33@spawn.link> <CAJfpeguvX1W2M9kY-4Tx9oJhSYE2+nHQuGXDNPw+1_9jtMO7zA@mail.gmail.com>
 <CAJfpegssrySj4Yssu4roFHZn1jSPZ-FLfb=HX4VDsTP2jY5BLA@mail.gmail.com>
 <6fb38202-4017-4acd-8fb8-673eee7182b9@spawn.link> <CAJfpegscxYn9drVRkbVhRztL-+V0+oge8ZqPhgt4BAnvzaPzwQ@mail.gmail.com>
 <f70732f8-4d67-474a-a4b8-320f78c3394d@spawn.link> <9b9aab6f-ee29-441b-960d-a95d99ba90d8@spawn.link>
In-Reply-To: <9b9aab6f-ee29-441b-960d-a95d99ba90d8@spawn.link>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Feb 2024 14:06:32 +0100
Message-ID: <CAJfpegsz_R9ELzXnWaFrdNqy5oU8phwAtg0shJhKuJCBhvku9Q@mail.gmail.com>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
To: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="00000000000088fcbb061270d041"

--00000000000088fcbb061270d041
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 21:58, Antonio SJ Musumeci <trapexit@spawn.link> wrote:

> I've resolved the issue and I believe I know why I couldn't reproduce
> with current libfuse examples. The fact root node has a generation of 0
> is implicit in the examples and as a result when the request came in the
> lookup on ".." of a child node to root it would return 0. However, in my
> server I start the generation value of everything at different non-zero
> value per instance of the server as at one point I read that ensuring
> different nodeid + gen pairs for different filesystems was better/needed
> for NFS support. I'm guessing the increase in reports I've had was
> happenstance of people upgrading to kernels past 5.14.
>
> In retrospect it makes sense that the nodeid and gen are assumed to be 1
> and 0 respectively, and don't change, but due to the symptoms I had it
> wasn't clicking till I saw the stale check.
>
> Not sure if there is any changes to the kernel code that would make
> sense. A log entry indicating root was tagged as bad and why would have
> helped but not sure it needs more than a note in some docs. Which I'll
> likely add to libfuse.
>
> Thanks for everyone's help. Sorry for the goose chase.

Looking deeper this turned out to be a regression, introduced in v5.14
by commit 15db16837a35 ("fuse: fix illegal access to inode with reused
nodeid").  Prior to this commit the generation number would be ignored
and things would work fine.

The attached patch reverts this behavior for the root inode (which
wasn't intended, since the generation number is not supplied by the
server), but with an added warn_on_once() so this doesn't remain
hidden in the future.

Can you please test with both the fixed and unfixed server?

Thanks,
Miklos

--00000000000088fcbb061270d041
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fuse-fix-lookup-root-with-nonzero-generation.patch"
Content-Disposition: attachment; 
	filename="fuse-fix-lookup-root-with-nonzero-generation.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lt5t6bw70>
X-Attachment-Id: f_lt5t6bw70

RnJvbTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+ClN1YmplY3Q6IGZ1c2U6
IGZpeCByb290IGxvb2t1cCB3aXRoIG5vbnplcm8gZ2VuZXJhdGlvbgoKVGhlIHJvb3QgaW5vZGUg
aGFzIGEgZml4ZWQgbm9kZWlkIGFuZCBnZW5lcmF0aW9uICgxLCAwKS4KClByaW9yIHRvIHRoZSBj
b21taXQgMTVkYjE2ODM3YTM1ICgiZnVzZTogZml4IGlsbGVnYWwgYWNjZXNzIHRvIGlub2RlIHdp
dGgKcmV1c2VkIG5vZGVpZCIpIGdlbmVyYXRpb24gbnVtYmVyIG9uIGxvb2t1cCB3YXMgaWdub3Jl
ZC4gIEFmdGVyIHRoaXMgY29tbWl0Cmxvb2t1cCB3aXRoIHRoZSB3cm9uZyBnZW5lcmF0aW9uIG51
bWJlciByZXN1bHRlZCBpbiB0aGUgaW5vZGUgYmVpbmcKdW5oYXNoZWQuICBUaGlzIGlzIGNvcnJl
Y3QgZm9yIG5vbi1yb290IGlub2RlcywgYnV0IHJlcGxhY2luZyB0aGUgcm9vdAppbm9kZSBpcyB3
cm9uZyBhbmQgcmVzdWx0cyBpbiB3ZWlyZCBiZWhhdmlvci4KCkZpeCBieSByZXZlcnRpbmcgdG8g
dGhlIG9sZCBiZWhhdmlvciBpZiBpZ25vcmluZyB0aGUgZ2VuZXJhdGlvbiBmb3IgdGhlCnJvb3Qg
aW5vZGUsIGJ1dCBpc3N1aW5nIGEgd2FybmluZyBpbiBkbWVzZy4KClJlcG9ydGVkLWJ5OiBBbnRv
bmlvIFNKIE11c3VtZWNpIDx0cmFwZXhpdEBzcGF3bi5saW5rPgpGaXhlczogMTVkYjE2ODM3YTM1
ICgiZnVzZTogZml4IGlsbGVnYWwgYWNjZXNzIHRvIGlub2RlIHdpdGggcmV1c2VkIG5vZGVpZCIp
CkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2NS4xNApTaWduZWQtb2ZmLWJ5OiBNaWts
b3MgU3plcmVkaSA8bXN6ZXJlZGlAcmVkaGF0LmNvbT4KLS0tCiBmcy9mdXNlL2Rpci5jICAgIHwg
ICAgNCArKysrCiBmcy9mdXNlL2Z1c2VfaS5oIHwgICAgMiArKwogMiBmaWxlcyBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKykKCi0tLSBhL2ZzL2Z1c2UvZGlyLmMKKysrIGIvZnMvZnVzZS9kaXIuYwpA
QCAtMzkxLDYgKzM5MSwxMCBAQCBpbnQgZnVzZV9sb29rdXBfbmFtZShzdHJ1Y3Qgc3VwZXJfYmxv
Y2sKIAllcnIgPSAtRUlPOwogCWlmIChmdXNlX2ludmFsaWRfYXR0cigmb3V0YXJnLT5hdHRyKSkK
IAkJZ290byBvdXRfcHV0X2ZvcmdldDsKKwlpZiAob3V0YXJnLT5ub2RlaWQgPT0gRlVTRV9ST09U
X0lEICYmIG91dGFyZy0+Z2VuZXJhdGlvbiAhPSAwKSB7CisJCXByX3dhcm5fb25jZSgicm9vdCBn
ZW5lcmF0aW9uIHNob3VsZCBiZSB6ZXJvXG4iKTsKKwkJb3V0YXJnLT5nZW5lcmF0aW9uID0gMDsK
Kwl9CiAKIAkqaW5vZGUgPSBmdXNlX2lnZXQoc2IsIG91dGFyZy0+bm9kZWlkLCBvdXRhcmctPmdl
bmVyYXRpb24sCiAJCQkgICAmb3V0YXJnLT5hdHRyLCBBVFRSX1RJTUVPVVQob3V0YXJnKSwK
--00000000000088fcbb061270d041--

