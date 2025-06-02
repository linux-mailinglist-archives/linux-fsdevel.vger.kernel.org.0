Return-Path: <linux-fsdevel+bounces-50391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BC0ACBD8B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 00:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08ED3A4E86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 22:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B42253351;
	Mon,  2 Jun 2025 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="DLB+8rY5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W2KHsQNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3F2BAF4;
	Mon,  2 Jun 2025 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748905013; cv=none; b=QuPSWkWCwj7JrdyY7Q/sdcy7Qvc3ZzM5aap0xM0tjzRXMdm4aK6Fn2EXcH6cdxXzN0gqhclpOX5wy6lWflgIGddgPA3SgZzWK/9SI10EChR3h7DOFg0JXIK8OwLBCFSJOTyUZwng/JCnTlN+MYBhWyhwzm8TK3KivDsEyCGfmQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748905013; c=relaxed/simple;
	bh=wBRymSy6pm1xMaGxqNLjxgQ1pbR+HzhtP9SFpSv+T5o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RaJyUk6Zu7+2v0QaN276H89ZKPn3d9pPh6S/d5expDlTLFhcjIeIRjgZ2kFU1slPPMdJIIfTKuzxSjq49WvKuoXVb3XUrdkT5DyTzRGUZkq6Yon4bY+8CGcbCzgwJyVyCI2qvvVO1ow0hGpPUarLerohWvDR7SKRhauk2kalB0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=DLB+8rY5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W2KHsQNX; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id E45171D40820;
	Mon,  2 Jun 2025 18:56:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 02 Jun 2025 18:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748905008;
	 x=1748912208; bh=eNQ9KAS1S1Vk+MXBSAvSY/w8fah6BHR1YbT8DKN9qUE=; b=
	DLB+8rY5AbL49pnCM4iV1jMOU8LC59VSLaHedhhdIrBDwsEaQor75dhb/+9vDA7B
	lyYiIvUSJFWkEOHDAUzm4CROdZYtYC2zRgS6pXvro9B82jcmGF71uoSnu+7sbYAC
	5NcjZlw3yR1Rp5TtuLV7kVkaEiz212CPpV4tjGGegRsIo3Jy6dRlCf6YDHq3SP2e
	LxnePUt82O6HssTwdSnfWv+DbVKtSSimfGPSE5dRPKSbCT5AV8e9+YOY4CvFhiqu
	QV0KVOWmEBMZxxaQLG/Gpg2I36enDoqeo3w6EUvNLIecLhQ+ITrVxJhO+HOHaOdp
	/48W5P8r7xnkFSDCtmnpUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748905008; x=
	1748912208; bh=eNQ9KAS1S1Vk+MXBSAvSY/w8fah6BHR1YbT8DKN9qUE=; b=W
	2KHsQNXSzRV6FG4oOpppTfr1K1m7xCsLgU0PG0pehp46Eb8uoJsZps5uixU9Jd2n
	dBTgMKzWuQkTtQ1v7HgmfRu9wXjjgc6N6cFOh1ai3MFg7scKAsoC0CQUxSbWLsLs
	MsPHz8thmvYo93JTG/M53gZ0ZQubG1DkHw9c9uJweyl/EUAOmcwBtsMsjFiAfbeo
	jjE6G437Dm9REvpNvWJirUN4oa/uTbKJk60WSG65ndaEsj1XSNECa++FLYTS3eQS
	u9q5K/bkJXwQSaDtGQ/0e+ZH1ZutpO/Ul+I6yypkfXJ/BSb7srDmoLtFxE3587ML
	LYumSyK32Z0RGNDeFd1SQ==
X-ME-Sender: <xms:Lyw-aNSoiLLGMSVxFvEnyujkWRv1fFy13rFajdag11ponU19bcq30Q>
    <xme:Lyw-aGx2RI-KU-HSAktO5iF_hDFw5olsNZw5YkuUZZi4SGkCihSzngs42EJ7sxt_2
    Xv_N5eZZV7_1wiIgjA>
X-ME-Received: <xmr:Lyw-aC3Me03zTd-uzj1_QpuusB-gNzMIkARLV8IxPa_EjcA2_GZLFzw05BDp0lON89QVgAUyUjzC3xiZeKqY6lRq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefkeelvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfhuffv
    vehfjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomh
    esmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeekgeeihfeitdffteetueff
    ffehvddtieekvdegteeuffefveetheduhfeutdeigfenucffohhmrghinhepghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthho
    pehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggt
    uhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlh
    dqthgvrghmsehmvghtrgdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Lyw-aFDJhbsArf9isSkvQwYpO3op6LH8PF-3r81K-jwEw4qgxGgLkA>
    <xmx:Lyw-aGhb2Dwc3Tsa6jbtuSLqlujf9cjBkJGPaOT0jyzK8p1Ej5kOww>
    <xmx:Lyw-aJr3BD8C0iAtqOcWd5DLf9yslX5r15_e7nZupdIol-tC67qDmA>
    <xmx:Lyw-aBhaJ4xjeEh5B-XMz10uy_MGSylE_ojcO-35yE3cZjYLyNooPA>
    <xmx:MCw-aAa-snvx_T28hyovNoaNWu2FpjzIW8AGWONZj7hqoPgvavYAbmHc>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 18:56:44 -0400 (EDT)
Message-ID: <39e4c079-aa62-404d-a415-8a53af039122@maowtm.org>
Date: Mon, 2 Jun 2025 23:56:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH bpf-next 2/4] landlock: Use path_parent()
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com,
 amir73il@gmail.com, repnop@google.com, jlayton@kernel.org,
 josef@toxicpanda.com, gnoack@google.com
References: <20250528222623.1373000-1-song@kernel.org>
 <20250528222623.1373000-3-song@kernel.org>
 <027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org>
 <20250602.Oqu6piethung@digikod.net>
Content-Language: en-US
In-Reply-To: <20250602.Oqu6piethung@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/2/25 18:35, Mickaël Salaün wrote:
> On Sat, May 31, 2025 at 02:51:22PM +0100, Tingmao Wang wrote:
>> [...]
>>
>> / # cd /
>> / # cp /linux/samples/landlock/sandboxer .
>> / # mkdir a b
>> / # mkdir a/foo
>> / # echo baz > a/foo/bar
>> / # mount --bind a b
>> / # LL_FS_RO=/ LL_FS_RW=/ ./sandboxer bash
>> Executing the sandboxed command...
>> / # cd /b/foo
>> /b/foo # cat bar
>> baz
>> /b/foo # mv /a/foo /foo
>> /b/foo # cd ..     # <- We're now disconnected
>> bash: cd: ..: No such file or directory
>> /b/foo # cat bar
>> baz                # <- but landlock still lets us read the file
>>
>> However, I think this patch will change this behavior due to the use of
>> path_connected
>>
>> root@10a8fff999ce:/# mkdir a b
>> root@10a8fff999ce:/# mkdir a/foo
>> root@10a8fff999ce:/# echo baz > a/foo/bar
>> root@10a8fff999ce:/# mount --bind a b
>> root@10a8fff999ce:/# LL_FS_RO=/ LL_FS_RW=/ ./sandboxer bash
>> Executing the sandboxed command...
>> bash: cannot set terminal process group (191): Inappropriate ioctl for device
>> bash: no job control in this shell
>> root@10a8fff999ce:/# cd /b/foo
>> root@10a8fff999ce:/b/foo# cat bar
>> baz
>> root@10a8fff999ce:/b/foo# mv /a/foo /foo
>> root@10a8fff999ce:/b/foo# cd ..
>> bash: cd: ..: No such file or directory
>> root@10a8fff999ce:/b/foo# cat bar
>> cat: bar: Permission denied
> 
> This is a good test case, we should add a test for that.

Agreed with Mickaël that I will work on a Landlock selftest for this.

> 
>>
>> I'm not sure if the original behavior was intentional, but since this
>> technically counts as a functional changes, just pointing this out.
> 
> This is indeed an issue.

Because in the non-Landlocked case, applications with a disconnected CWD
still can access files under its CWD, just not above, my thinking is that
it's best to keep the current Landlock behaviour.  Mickaël might reply
here too but he also thought that, from the point of view of the person
creating the policy, the current behaviour is less surprising.

>
>>
>> Also I'm slightly worried about the performance overhead of doing
>> path_connected for every hop in the iteration (but ultimately it's
>> Mickaël's call).
> 
> Yes, we need to check with a benchmark.  We might want to keep the
> walker_path.dentry == walker_path.mnt->mnt_root check inlined.

I think this will depend on how the final implementation goes, but if we
can check it only once at the very end (potentially for free by having
logic that can realize the walk never reached path.mnt?), I would think it
ought to not make a difference.

For Song's benefit, if you want to do it, here are some scripts that might
come in handy in benchmarking (created by Mickaël):
https://github.com/landlock-lsm/landlock-test-tools/pull/16
and comparing results / BPF-based overhead tracing:
https://github.com/landlock-lsm/landlock-test-tools/pull/17

> >> At least for Landlock, I think if we want to block all
>> access to disconnected files, as long as we eventually realize we have
>> been disconnected (by doing the "if dentry == path.mnt" check once when we
>> reach root), and in that case deny access, we should be good.
>>
>>
>>> @@ -918,12 +915,15 @@ static bool is_access_to_paths_allowed(
>>>  				allowed_parent1 = true;
>>>  				allowed_parent2 = true;
>>>  			}
>>> +			goto walk_done;
>>> +		case PATH_PARENT_SAME_MOUNT:
>>>  			break;
>>> +		default:
>>> +			WARN_ON_ONCE(1);
>>> +			goto walk_done;
>>>  		}
>>> -		parent_dentry = dget_parent(walker_path.dentry);
>>> -		dput(walker_path.dentry);
>>> -		walker_path.dentry = parent_dentry;
>>>  	}
>>> +walk_done:
>>>  	path_put(&walker_path);
>>>  
>>>  	if (!allowed_parent1) {
>>
>>


