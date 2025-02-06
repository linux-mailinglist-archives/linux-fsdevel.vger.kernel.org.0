Return-Path: <linux-fsdevel+bounces-41134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EECBEA2B6A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 00:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCEB11888B0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 23:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271B522A4E5;
	Thu,  6 Feb 2025 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="1ZIHiSlG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C022417EF
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738885019; cv=none; b=ugCIDc9hZud5i9OcYZ8zaEZjQA1zehX8fDCAbLtkxivw9HH3YCqUjQSNuWHsGhkjNZV3/sHrarDiR7oBi8BTuzrsR8EQfZTRffhQLEYHMCOSWG8Nsg5CPNjsRqX2xAIcqjN0Xqjp+7GpeHfgSRygBsNholrVrb4EZGBM8EUf7Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738885019; c=relaxed/simple;
	bh=0IEzOc0ZpYSSQl5AlhdCFxa35rpWa92zPKzv7WhJFUU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=l7swi/IohSzRa1W1qzB7bJbarUUbzadsYC1JwozanlSmVY4n7WwsBtOTUN7BLlk8fzMf0AP86Hyn4AZMWczMZegCxHmCwFwYc3UR2522de/1nV5JfffHl/TBUSe0nfOyHKRsi0ESHTO5lSl+EWSByIpBvFG9MtpiPd+fXespKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=1ZIHiSlG; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467838e75ffso19393751cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2025 15:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1738885015; x=1739489815; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eR9xK4c4JYLjvPO27KQ++TM5d0c6hUImr7nzgJgxGXM=;
        b=1ZIHiSlGLMKGuy7okm3rTCwsH1hhbbmBI29aICKCo9sXJRNX4OE4V+ZuJiV8iz/vni
         NS4XynphHAIyKeABUiPBqzG5GgyeVurh3XBGf+DSu43NLoAIcPHEG9XkcGE+C8KfuBep
         Xw1kKlOOEM8RR35/dF1VrBWVNb+Res1gPP5P2lBRk80g603huq+sBIBONBV4X8W1/R3N
         PCKKdRx/ebw0MsOqK2/c3RMESXlFE6plQPhPQs1Miy6zUSTAkkTiJ4Ro00qqghAZzUGJ
         gTXqCbT1A+8sQbqFO+J2DOLWhdQRD0ZS2ABClmqU4CrWdYoJcvosTnl/S1k1nr8aHPW/
         412g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738885015; x=1739489815;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eR9xK4c4JYLjvPO27KQ++TM5d0c6hUImr7nzgJgxGXM=;
        b=vdCnvcD3BGYs1GQW5CBuUGFrQR0nRFe1BaEWDs8iN8os7OHK3pAnnfC8iy/xoc83pp
         QYIxzreVhmv9KexwNgDWtmBX/Bx0Kx6AiIbLpGCOGbQGs6z8iZjJQziQnVR1XLta0qV0
         NQevL+xDImSbfBvAjChqI9PwdVrElYn7vHNUSqn5oZ/25M2zEfY1yjLvGs7jxakbd9iu
         1VLm29oTx5PF8bWEmNlQtWel5y0KK0HUqIQxulOHJ43of2lCiPxXmUctjnmTiSfpu0+7
         bf6mbi/84uchBDXp0GlCgOMymUoCY7opnYtLbYD/mS885hudn5zXwcm9vNjUhhb10GSF
         Zrjg==
X-Forwarded-Encrypted: i=1; AJvYcCXfTOyy8in0ZlOzuX9/yVV4Vl0UHKxuMl2M0Bn8hDfTCMTlO/QBPGAlEFFqRANfT30TyHQTd+PbzoULCDbh@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBMs6KtsmXbUiz98EIuYeQEUVzOjMxkKQfs67q1pmtZ7suld0
	bWN2fWfBNnaI+ScqC3wBZEhSb1VPKmBUD1aXhF+1+OhMc6nnjfmphffuyKSvLea3SIBKxNnTXbv
	cUbk=
X-Gm-Gg: ASbGncuzomT5mNXDZyHG63xlyTL5pFv/KcXg0lZ7lajhn+l/9XivXzStW1f3PgN2bCh
	DP3on3xmB4fBHlDQ/w5m0whkWYA18lEG4UIYOCQ2JEMt6GJB8REmrXUaAUgfHmqUr2ZMvc3ml/e
	yXyYgYRHWh251BCjckHwrIlaH+dA+oL0f5O6RBqmdJUIH2OdluBbmLkrG1vvAS4Yt4NZdwycQIA
	2CBIKTqdDWMVzN0SBEr0jRHtC0E6/LQDKH39KYOP0R8kKrYLDclZj1Uq8WG3jyDvNtI0aiJ/oyy
	ZE8rhQNc2dNwoZNEWfSTMOiieJ7e
X-Google-Smtp-Source: AGHT+IE9ee2Dd2Lr8ow1mxDJA9BosoTfwoBpxLs42+ZtYoUemwjBuqr4XR9chiLE8G3/d3iXQbLA1g==
X-Received: by 2002:a05:622a:354:b0:466:b1a2:c03e with SMTP id d75a77b69052e-47167a05569mr16731741cf.17.1738885015178;
        Thu, 06 Feb 2025 15:36:55 -0800 (PST)
Received: from smtpclient.apple ([199.7.157.105])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47153beaacasm10227151cf.67.2025.02.06.15.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 15:36:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andreas Dilger <adilger@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [LSF/MM/BPF TOPIC] Design challenges for a new file system that needs to support multiple billions of file
Date: Thu, 6 Feb 2025 18:36:40 -0500
Message-Id: <1BCBC42C-668B-44AE-B6BF-74A423884FC6@dilger.ca>
References: <20250206185812.GA413506@localhost.localdomain>
Cc: Amir Goldstein <amir73il@gmail.com>,
 RIc Wheeler <ricwheeler@gmail.com>, lsf-pc@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
In-Reply-To: <20250206185812.GA413506@localhost.localdomain>
To: Zach Brown <zab@zabbo.net>
X-Mailer: iPhone Mail (21G93)

Lustre has production filesystems with hundreds of billions of files today, w=
ith
coherent renames running across dozens of servers.=20

We've relaxed the rename locking at the server to allow concurrent rename fo=
r regular
files within the same server, and directories that stay within the same pare=
nt (so cannot
break the namespace hierarchy).  They are still subject the VFS serializatio=
n on a single
client node, but hopefully Neil's parallel dirops patch will eventually land=
.=20

Cheers, Andreas

> On Feb 6, 2025, at 13:59, Zach Brown <zab@zabbo.net> wrote:
>=20
> =EF=BB=BF
> (Yay, back from travel!)
>=20
>> On Mon, Feb 03, 2025 at 04:22:59PM +0100, Amir Goldstein wrote:
>>> On Sun, Feb 2, 2025 at 10:40=E2=80=AFPM RIc Wheeler <ricwheeler@gmail.co=
m> wrote:
>>>=20
>>> Zach Brown is leading a new project on ngnfs (FOSDEM talk this year gave=

>>> a good background on this -
>>> https://www.fosdem.org/2025/schedule/speaker/zach_brown/).  We are
>>> looking at taking advantage of modern low latency NVME devices and
>>> today's networks to implement a distributed file system that provides
>>> better concurrency that high object counts need and still have the
>>> bandwidth needed to support the backend archival systems we feed.
>>>=20
>>=20
>> I heard this talk and it was very interesting.
>> Here's a direct link to slides from people who may be too lazy to
>> follow 3 clicks:
>> https://www.fosdem.org/2025/events/attachments/fosdem-2025-5471-ngnfs-a-d=
istributed-file-system-using-block-granular-consistency/slides/236150/zach-b=
row_aqVkVuI.pdf
>>=20
>> I was both very impressed by the cache coherent rename example
>> and very puzzled - I do not know any filesystem where rename can be
>> synchronized on a single block io, and looking up ancestors is usually
>> done on in-memory dentries, so I may not have understood the example.
>=20
> The meat of that talk was about how ngnfs uses its distributed block
> cache as a serializing/coherence/consistency mechanism.  That specific
> example was about how we can get concurrent rename between different
> mounts without needing some global equivelant of rename mutex.
>=20
> The core of the mechanism is that code paths that implement operations
> have a transactional object that holds on to cached block references
> which have a given access mode granted over the network.  In this rename
> case, the ancestor walk holds on to all the blocks for the duration of
> the walk.  (Can be a lot of blocks!).  If another mount somewhere else
> tried to modify those ancestor blocks, that mount would need to revoke
> the cached read access to be granted their write access.  That'd wait
> for the first rename to finish and release the read refs.  This gives us
> specific serialization of access to the blocks in question rather than
> relying on a global serializing object over all renames.
>=20
> That's the idea, anyway.  I'm implementing the first bits of this now.
>=20
> It's sort of a silly example, because who puts cross-directory rename in
> the fast path?  (Historically some s3<->posix servers implemented
> CompleteMultipartUpload be renaming from tmp dirs to visible bucket
> dirs, hrmph).  But it illustrates the pattern of shrinking contention
> down to the block level.
>=20
> - z
>=20

