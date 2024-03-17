Return-Path: <linux-fsdevel+bounces-14641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4509687DF31
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 19:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77AEB20C7F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 18:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CC71CFB2;
	Sun, 17 Mar 2024 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFkl89L7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D361CD2D
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710699768; cv=none; b=F45twxnhej0tRU4IxGosIF4pBhaXBQuLqBZCfNK8ILeRsxgZE72xkF22dDd3vskqL1uwlf6B3/RG7PEjrwdNwZOny+M2BJZN9WHfF7KzXsqVDIr9jNDm/imk2WxeQMUsPmbw03Xb4gBkHYTSMpugx7jRaYSskNVPEkA2erChODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710699768; c=relaxed/simple;
	bh=74wXlQAq2ljOASHXdaZbDJcMyd1AGxjXzgBYqIYsDi8=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=JV/URzJZK6fpLj09nFNnV2q73gZLZBze/hZbKeAyv/3gjtUXhcnpW8BC7BMIHbdP6ZOuMLlvcFW4LuQtXHO8YsQ+kC6FRXxpXygNl060bydOxcyp9w8o15qDoUPmEb6A/UsnWknd/pMhFmebcvBXqhvliqgttZ/f2DMkMSIiKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFkl89L7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6adc557b6so3467974b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710699767; x=1711304567; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GQ6xlGdHCkSfX6Gm3eZeZEZb9Dz7J2qBGeB/N0DQhwk=;
        b=VFkl89L7MyBDIA85epY6gdN3A2tsMLLHbLeFz4VkVYjJW5b3ncNtm5w4uQJktdJneD
         JQl04QOwkXgzC+1YVJp0+St2fBPatOtAmhTow/i/h9UIQCTTDpAouvNOZevkS5Jbtc6N
         MpSBoj24pI2r6qxHs9STMo4HvEKgIoA8E5zf62GtrM26YF4jSbbDGy8z8PZVfr8L5Ob3
         8M0XNnMuUmT4Ripvi5Qh7xcyXJ7zVw/ku2Y4ck+FIH3Xxp3ZYKBRwqdC7uFZnQL6WTig
         C+wGIeBglPpYNvou60jnIk+MxW1zLXuGcS7Lb/O6LbAkrxZ4J+XayI2M8ZO/mn2t1czF
         mN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710699767; x=1711304567;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQ6xlGdHCkSfX6Gm3eZeZEZb9Dz7J2qBGeB/N0DQhwk=;
        b=bSrNIzADLvvbK7mw5u9fCHeEUNZAgDw2Exh9rdMT7naIzHPesZQrCUw3jprNnAEN1B
         tBkzLIleiUjN06R3fCVmx+WkH8uGHYmGA2xlWPdAJ4zeit1Hl+E7GZLq7PwoeBul9xs5
         SIhh59BjtbgwqqtSnyE+InmorO4dVFHqaoXSQdEzImwKqtCerwJiTi6lmbGnY2MDTdQ6
         CwETJyBWRp8xFSPwKyMm330ukclWm/aBnmJvtlnxMEgdF6zm2svp/2Q8IL+fdInnk7B3
         peKYHgzeyiuxqP33Z0aZViXC1rCx1R/FYoIcrnmwAiQX4OEAHRxSfH29fkNwQyIRP85t
         TddQ==
X-Gm-Message-State: AOJu0Yyqb1uIbgqjudYVVC2VXIvIinlCBEsWztGTlXKLOjHkvr/lrzd3
	g4C2jvq9EsU1HZAbqLE+hjd7YuEFVdLLCWlnMaHoYd9/S29CyHkR
X-Google-Smtp-Source: AGHT+IHF7EWrn2w+NLFfRdF+mR28OKohO5/iBZJBea3MyJlIyt3N+QV7Mnv2niFuztWauQpspF2RaA==
X-Received: by 2002:a05:6a20:d49b:b0:1a3:4786:1f87 with SMTP id im27-20020a056a20d49b00b001a347861f87mr12129537pzb.34.1710699766734;
        Sun, 17 Mar 2024 11:22:46 -0700 (PDT)
Received: from dw-tp ([171.76.82.124])
        by smtp.gmail.com with ESMTPSA id t12-20020a056a00138c00b006e69a196fb8sm6664056pfg.173.2024.03.17.11.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:22:45 -0700 (PDT)
Date: Sun, 17 Mar 2024 23:52:36 +0530
Message-Id: <87h6h4sopf.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Leah Rumancik <leah.rumancik@gmail.com>, lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>, Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem testing
In-Reply-To: <CACzhbgQakTF_ahv9HokgnwpW69q8M103w1kmhBBi21ZTkmRTEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Leah Rumancik <leah.rumancik@gmail.com> writes:

> Last year we covered the new process for backporting to XFS. There are
> still remaining pain points: establishing a baseline for new branches
> is time consuming, testing resources aren't easy to come by for
> everyone, and selecting appropriate patches is also time consuming. To
> avoid the need to establish a baseline, I'm planning on converting to
> a model in which I only run failed tests on the baseline. I test with
> gce-xfstests and am hoping to automate a relaunch of failed tests.
> Perhaps putting the logic to process the results and form new ./check
> commands could live in fstests-dev in case it is useful for other
> testing infrastructures.

Nice idea. Another painpoint to add - 
4k blocksize gets tested a lot but as soon as we switch to large block
size testing, either with LBS, or on a system with larger pagesize...
...we quickly starts seeing problems. Most of them could be testcase
failure, so if this could help establish a baseline, that might be helpful.


Also if could collborate on exclude/known failures w.r.t different
test configs that might come handy for people who are looking to help in
this effort. In fact, why not have different filesystems cfg files and their
corresponding exclude files as part of fstests repo itself?  
I know xfstests-bld maintains it here [1][2][3]. And it is rather
very convinient to point this out to anyone who asks me of what test
configs to test with or what tests are considered to be testcase
failures bugs with a given fs config.

So it will very helpful if we could have a mechanism such that all of
this fs configs (and it's correspinding excludes) could be maintained in
fstests itself, and anyone who is looking to test any fs config should
be quickly be able to test it with ./check <fs_cfg_params>. Has this
already been discussed before? Does this sound helpful for people who
are looking to contribute in this effort of fs testing?


[1] [ext4]: https://github.com/tytso/xfstests-bld/tree/master/test-appliance/files/root/fs/ext4/cfg
[2] [xfs]: https://github.com/tytso/xfstests-bld/tree/master/test-appliance/files/root/fs/xfs/cfg
[3] [fs]: https://github.com/tytso/xfstests-bld/tree/master/test-appliance/files/root/fs/

-ritesh

