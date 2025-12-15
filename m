Return-Path: <linux-fsdevel+bounces-71350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A21DDCBE6E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E38903007A92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E955D34405D;
	Mon, 15 Dec 2025 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5mlNd08"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3376344036
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809965; cv=none; b=OAey5ADgrnVvyAoIPlBKgK947FuYMYwPQ2YxAHFKoGNhJOnP1Bei9L74zmT14r8dJieXjSLeVgZRvcLPK9B+bb6xvQOdJX/TAfDfIY9E+36y5E12Yjn6UZ0ICmLzmHPn2YgMsoifASM85Rgf4KdWvugCkUJcKrbjZDfcB9ZZcwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809965; c=relaxed/simple;
	bh=UkwbhPBH6v6iuGA++QLEZTiBSrnPQHO4IbRsksKf7ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAY5oXro1430zm+pVC88KFOW5nCqgfqwoPvM6gn6rdLLM7bUZpQcxibsWLvw1vXL9wWMF0nE55n9EQQSp5k2DFfKDNXjPY1IaRGEiCK06CwmJGEB25L8YIlwlOQJLO59QGhpBJsUYFAP982shJHaGaGHMPaswbB0hC2ey6UzZp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5mlNd08; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b2d6df99c5so376426485a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 06:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765809963; x=1766414763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oV0jaZrI8aZtsZE9apOwrB8bJI30o+iCw2TQfGhgA5Q=;
        b=a5mlNd08D65NzkEkpMCby+8pUYIRm2B1APJXYpPOvn2uYMyttc54O98YrpZ51R+55X
         vJEc77H0GqMdQi8W4fNnZFCUKUDHXx1AblhbrjLg0BNUFv2EcxbHa/9H/qFYdjdeE+H4
         zUEAzUAl+9DXIkwz4iQe69EDhnv3WBl3bR8aYOXhn3PR6lSdVERz0Pe3hyN5mqNrQ0+k
         QVdqlvtLVp3jwSWG8VUAhXPYI90/Q/6mYUckO7+vJNcpNHxX2DQaML2BcwSYL1iCVKu7
         xrP/a9IBw282k6UY3kHsnomKYNMMPpGAEP3vampxs0gn8/tFWV4Weya1C7gdy/NzqXyW
         22bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765809963; x=1766414763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oV0jaZrI8aZtsZE9apOwrB8bJI30o+iCw2TQfGhgA5Q=;
        b=irAyWOeJv7QSp6mo9GlofJ+vc7kmUSBO6VZxkLR20iOeQoa529QtQqHwh55nmccsvY
         j9h04HwjTIRSRKxmvCWFL7tfQ2s66H0b4pOKV+9YDCQ100xCsM512CWs6oil9AmHOsRH
         GPzO+95DTAZ4ta/qBKRoa9jfs5Aha2NBlarzCBi+2IWoT+8ClIjaaoBf55jJ2mlIAVsg
         9KbCN/kVHlZsNGkNI4u1tQarTbAe9pTAZPBZS8x6cHp6cYq2S/D4RogOzkue7CIxjm68
         rIHO0Fj8XQ+KgLPjUOwqsE0xX4UTQ4uDj909KQKeKTcQNdReJZHPekx0KfCnxsN1b4rE
         OTOg==
X-Forwarded-Encrypted: i=1; AJvYcCXoY7HifO5tdSebDHyVpgNmWnWce0AwMRlhI6t8WGah54Uc8yb+MjHJsIVZ5V+NxvTmTjuFpYQVN/jlaDUN@vger.kernel.org
X-Gm-Message-State: AOJu0YxVt645dTO4BFxNlGdG4L2pzR2YG/trFoOYJ5KLg70fkpqlKBtr
	QP/Ra5JCqVmFJtfcRA9lNsJAQPk0OarpCNUHnU82F8/T7lEequ4Y0pMx
X-Gm-Gg: AY/fxX5hgNMUMsWdYWnx4E0QQKa5lsi78Lyl6dytObFBHIda+GCu+n+uflwBKOWJFFR
	ucWsbNba10HonT3zh2Cv9VQkW/eegEVKGENEk2iq90Kf7511JFzxdZLMkwTWeR41zlty4kdVhBA
	C/KCyxTa8fBPFf5lXdXKSLmXpCQBgzwSkksaFE3lJPwlM19ZCsJqSV5mLKXXAqZwCBCFwwP3FDB
	tdSURoV09uRLD51N1hxqN9OzBrTcnMI6kv1jFtvVqD0ppDfpAviDb7h1WIQJovtNPqEyVz3/dXC
	6LfyDJaVz7LAB8w3ZAtIbRcUxs8FiV4A3SupvVCMysbGEwHIZG1LyE9bNHyyRonXiZmxEBqIDqa
	L4qcyfknIc1RN0Ye4t2wLrLA8AhtBkPONafWZHPAps9MskaHAYWOrJ9xJ3GEUbmphmaCOqXkwt5
	OrUluFNHZ/OXGnTCphBuZaI9zUI20No33Oxd3W
X-Google-Smtp-Source: AGHT+IGv+oWV+L8kWHp92FAVovjf1CCnrWsTpFVhPmh2RNosHWcTKLsi2sjAMqZ9z5iZ6IjkvQ1W2Q==
X-Received: by 2002:a05:620a:2847:b0:828:faae:b444 with SMTP id af79cd13be357-8bad430092emr1940562285a.20.1765809962557;
        Mon, 15 Dec 2025 06:46:02 -0800 (PST)
Received: from dans-laptop.miyazaki.mit.edu ([18.10.141.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a85eab16sm52150876d6.39.2025.12.15.06.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:46:01 -0800 (PST)
From: Dan Klishch <danilklishch@gmail.com>
To: legion@kernel.org,
	brauner@kernel.org
Cc: containers@lists.linux-foundation.org,
	ebiederm@xmission.com,
	keescook@chromium.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [RESEND PATCH v6 0/5] proc: subset=pid: Relax check of mount visibility
Date: Mon, 15 Dec 2025 09:46:00 -0500
Message-ID: <20251215144600.911100-1-danilklishch@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <aT_elfmyOaWuJRjW@example.org>
References: <aT_elfmyOaWuJRjW@example.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 12/15/25 5:10 AM, Alexey Gladkov wrote:
> On Sun, Dec 14, 2025 at 01:02:54PM -0500, Dan Klishch wrote:
>> On 12/14/25 11:40 AM, Alexey Gladkov wrote:
>>> But then, if I understand you correctly, this patch will not be enough
>>> for you. procfs with subset=pid will not allow you to have /proc/meminfo,
>>> /proc/cpuinfo, etc.
>>
>> Hmm, I didn't think of this. sunwalker-box only exposes cpuinfo and PID
>> tree to the sandboxed programs (empirically, this is enough for most of
>> programs you want sandboxing for). With that in mind, this patch and a
>> FUSE providing an overlay with cpuinfo / seccomp intercepting opens of
>> /proc/cpuinfo / a small kernel patch with a new mount option for procfs
>> to expose more static files still look like a clean solution to me.
> 
> I don't think you'll be able to do that. procfs doesn't allow itself to
> be overlayed [1]. What should block mounting overlayfs and fuse on top
> of procfs.
> 
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/proc/root.c#n274

This is why I have been careful not to say overlayfs. With [2] (warning:
zero-shot ChatGPT output), I can do:

$ ./fuse-overlay target --source=/proc
$ ls target
1   88   194   1374    889840  908552
2   90   195   1375    889987  908619
3   91   196   1379    890031  908658
4   92   203   1412    890063  908756
5   93   205   1590    890085  908804
6   94   233   1644    890139  908951
7   96   237   1802    890246  909848
8   97   239   1850    890271  909914
10  98   240   1852    894665  909924
13  99   243   1865    895854  909926
15  100  244   1888    895864  910005
16  102  246   1889    896030  acpi
17  103  262   1891    896205  asound
18  104  263   1895    896508  bus
19  105  264   1896    896544  driver
20  106  265   1899    896706  dynamic_debug
<...>

[2] https://gist.github.com/DanShaders/547eeb74a90315356b98472feae47474

This requires a much more careful thought wrt magic symlinks
and permission checks. The fact that I am highly unlikely to 100%
correctly reimplement the checks and special behavior of procfs makes me
not want to proceed with the FUSE route.

On 12/15/25 6:30 AM, Christian Brauner wrote:
> The standard way of making it possible to mount procfs inside of a
> container with a separate mount namespace that has a procfs inside it
> with overmounted entries is to ensure that a fully-visible procfs
> instance is present.

Yes, this is a solution. However, this is only marginally better than
passing --privileged to the outer container (in a sense that we require
outer sandbox to remove some protections for the inner sandbox to work).

> The container needs to inherit a fully-visible instance somehow if you
> want nesting. Using an unprivileged LSM such as landlock to prevent any
> access to the fully visible procfs instance is usually the better way.
> 
> My hope is that once signed bpf is more widely adopted that distros will
> just start enabling blessed bpf programs that will just take on the
> access protecting instead of the clumsy bind-mount protection mechanism.

These are big changes to container runtimes that are unlikely to happen
soon. In contrast, the patch we are discussing will be available in 2
months after the merge for me to use on ArchLinux, and in a couple more
months on Ubuntu.

So, is there any way forward with the patch or should I continue trying
to find a userspace solution?

Thanks,
Dan Klishch

