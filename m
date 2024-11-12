Return-Path: <linux-fsdevel+bounces-34514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A30739C63CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 22:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405D4B2EB1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5168A215021;
	Tue, 12 Nov 2024 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="m1TOqpEK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4512201270
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434964; cv=none; b=i69hEiAUX/+pH9PqrSl3mfUkZBHy4+26W7OwW4x2cji5xJmwdN9dV/OXZmvSNlQ61LhoAg3XlGHa266qYizPeYyjYA5E7+i8LjGVmakHcPF+BQ739OjIeQoA+Bp4szy28eZ1NYX2ol0YewpHxSK8Fwk9j5kGsX4KlO0lty748UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434964; c=relaxed/simple;
	bh=ZeMsQ9qmz6sar1+qRF1IrbSxJqQDOI7B1ydNY+Vxfh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPbYrJLL76tkXWnzXFduaEv6PYCOgUsbYu1Vg+eEItUJOPdHRac8Ea8F3y8s9c6AD5xWTcKwzoj+lVFn96qnz4xytlxTzLQiAyhz884MgDYK0SZOvVWc8lh7BJVA8Giu3Um+v7TCRewFIyTdo5x6xm+G7PRgqCxa000yZG6robc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=m1TOqpEK; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731434956; bh=qiA6OYbVINpqQio6bZbVkubTbHjsCHoFHaRkfiCUYvE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=m1TOqpEKfjTCdbsqML8ApsEQZnIofSFcKFDfNlhQzJc5NZQdFQn+ZngwZ+qY1DYWGKjAzdSwsJoLQm31H0XIUteQNjrNjMUir4wnY8GphbJQiKBhfK2t9QVIklUEUGAbKd142mH+Tg6nzyZSKetcz8S8BHF8Di12i9qtnOBbEVF9L6aVj4LS1cy+M4GUzFHwBMP7BhviTJeTLeA49wzjy2jEDJ8cAPyZLxB8VkulEJX64HadBNg1dixTXfGzGDaCfeDlzFfkC4tKeg+sgRNBt6cA+Rt4aoi+bMB/XmB2Up4GYri1FY+69/TeRdu+njrG2JrUj/iqDDIpjpAowVOJjA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731434956; bh=mdWo68nfuXRRyC/wYJDcgExv0uWteKy1HOyNntiQJDB=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=b3PXUPfdA5g7fA8xk3CG5M4kt86nZpG2BLzFnBq0Tzh0v1nJBjaH/4RzTr9tEygsjZtvgWcAaCsnWn28dQShNNGZEORqeLn1L8JLuExvT9F7gl+6SX9jpA+EyQdp3gAaIKKQ43TBnnWdtRQZ5rpYOO3+k1+RUfyc7scu5E28o+/hEmEtgRDmdiJwg9a3XHyKrMHnap6wrqUzb0q74dxey8D6ZiHXfLgk29RBNpgPtxgePVL8y306/cK20nCjPo2XREteHocYmI4SsEh1qhekzrFJsKNUUEpjwZ44FJWQjyd+meJdJXq3YDcSiXk3n5kH2fnR72ZfO028bxurthlzAg==
X-YMail-OSG: H6L6BawVM1lfrBYf9MsYCnXW_QeFhcbs22D86ti.DLuh4KZKbKfDDz.QT29qqQF
 tPrMD_9yFIQrWmhSQ3NgyoI7XTDXFDXq9rHzU112GZ_u18FumpenIWLMmnJVIT73ByRJb16kHped
 d8VASRP8HIK7QWB.9FJz5tnAOrTiEuxQxje2aTR4dPKtVN.x7X2hxd4wnTDTjH4QfC7zVpuKbtOY
 b4WjaPf2p3VCOjpAyid2YlZXTcRlV4vqh4ccottDD3fWBU7IBaMSBMxQi0p3uT7EfM2N.WDnXLQb
 wEFLwD8T070.P7dDsNr_GLLvgdJSTBb5r64xcwfksTKKtwwcRnPKqACpAVzmh5YYBP8AAbgLOCNf
 sQsFhn91uBtReRyM0UixeaKwpbkO5PT8P8f60R.xyoKPWL3pAfMNVsrvJyeJ17aOJCxVDPcMiRei
 CXeZ9xs9ekyIdQoS6u7dnYwREHoUtGukVl51e6aoWLXOM8NrFHSwYDrkaOkojjME_WSZhnYBxnJg
 eES9fYn37.FWkgr16wVjBqLLnh8Ogzcv7dAubQCkI5_xA_Q9fn5.8zceXwS1SgjR1k5Yjir9L5jh
 nDAunufoOUasm.vkAcA5GxIuB7zd84zECqen9ABoW56fEnDgxBlx9oVmIgn0BBW5g5EU3DCI6Iq0
 pr7JUrz.JMhtO0zrVjhZUbTKCuS.nid5j9CQshGSwmpNpHPDf9rjxK0MwMPi85H9z3mnc7TIONa7
 V.Fw.7CN8MgE0R4S.VVEJEglHf43st5NomEKQG_s52_VEj.0JDFqlIJwcHX0PRs0ewQIvg0k5.6o
 qQQ1hiMhKjJm7z8t5DnjTOykVGdf5GRfiFg_ELVUAxMr3Ks.d3eeTKTP3I9uSxn9o0nmixnx8Zo1
 wDMwlodAxcQVzG2MNjyMkfIdrQNJV3w1EF94ICHkM19GLQLnanDgXyTwSoD0Lc2n.ng7gOi3YYZn
 T3mRL3mfyY9dhSFENQMItvTgWncBjBYoxvvGywlPYO9WXK8J3U5oi1ooiU5qNz8sJxTOcYKzL_Ev
 qLhUIsHB1xfDD8tBoW5hKgS2z9JIHHre.pSNxCbhLNA.gK2ZhclVXehUerc362YMKQQ6Lqc8A9aQ
 nBybvbbuiLtApePo1d52Z.qeYFHmYU3p7Kynr94JECZ9G6bDFNregomZ_rDhQAW0YuIrzW.zZhOx
 ajbwxA9mGcoKb7NuJYXLcnQxLjIVnRGS8m_almf6BaLk0btIKPpOWcpkVTaGEQk0TW666vaM7v1Z
 79ZvqRDFglTodpdmxLOmxU0Bp7CelDjU4_D_p9Qy7Tq_FR7QJaMga1PwwjztRklak3ezunSeANYm
 P6TrVJ6XQ2hAM4gzxyUkhBlfOUqRhAUBBKt5Gtq799vg9iZtd2Li_be0E0Hx0ABus0M6YW2eXJxr
 _r1e5EX.kpegeaErAR6jLu22V31A8ggrzlHX9AgOhG_vlj711zzns.extcloO0RI3WS6kK4_u1ME
 CzlZ5NTMQvyheFqA.DfrMJdgnUst_JEv73rLUz8pGMpvVa9.stRHLJvRuabCpij5tmvcS_m2KixJ
 qcP5IG84Uea64HuhsMnLEzSm8c.qs4HW3RU8PUHHaGD7dnApm46cnNNXsKzU7q96cBmC.hB2_Pci
 FNQ1GhbTgw3CvLOLp3w0h_1RwmyIf.7uueL1DfALg0b.Ke4RXAywqaaX6pXvxmMg85t34kuG9oFA
 V8MxTUAf60KYecuvr6rw1YZhKh3VFEEGlXb28UkLraTAxxsDg0gGw1V32ILRIx4nWu0dd9IZ3yYf
 kHzzs0Bp.uiVJGdkYQv3OIKZ8RtxfTRdM3KbCw2Tb.KOelAsYLmT7a0hulaeVozvLv4ipCK5qkB7
 pC.rPRFi9QUHSKkV1ZSfuOndY2TknOultb4Ntd0pN5O_NlfKNqrF3vq9obVhHZDyRBrvbMznVRRz
 B8hx5Mo.1M1W8ohzU2b957gOaeFD8UlCfNXQ6skEEY5J4deS9nbm48MbMPdk_mBGr_eQkLnoLMr1
 JsdHntxLHYAJISlyr5ZupnIKvPO5SDcMAOFO.gSSMiwX7kL0P8QwQ8xSnrV5B68nxjni2hA3QlqV
 ld6ehRm1WYmfExRmg.aIPBG7PBL0PQSUNMUF8VHbzq2SQDba5eXvOWFMSUUZTl2JD13_2NzQg0eA
 wY5CiEEToUXT9MoJ1rZbnR3SwU7heFBSE_VWPZbWxyD5gJPafjmKoNpQD7HDH8yGcOpUMM9vuVAc
 8znvZmeq.cO0HRzo_K7TLkpR2hx6.50M6I4vHcGu3L4VqLTGqF_aDqdi0vJNfcDA7_JKIFwV8
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: be3fc355-73f1-4b57-8273-4c1fe9df1bf4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Nov 2024 18:09:16 +0000
Received: by hermes--production-gq1-5dd4b47f46-k4d2j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 09f46e153db59299890927b30af07809;
          Tue, 12 Nov 2024 18:09:12 +0000 (UTC)
Message-ID: <d3e82f51-d381-4aaf-a6aa-917d5ec08150@schaufler-ca.com>
Date: Tue, 12 Nov 2024 10:09:10 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com,
 repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com,
 mic@digikod.net, gnoack@google.com, Casey Schaufler <casey@schaufler-ca.com>
References: <20241112082600.298035-1-song@kernel.org>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241112082600.298035-1-song@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22876 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/12/2024 12:25 AM, Song Liu wrote:
> bpf inode local storage can be useful beyond LSM programs. For example,
> bcc/libbpf-tools file* can use inode local storage to simplify the logic.
> This set makes inode local storage available to tracing program.

Mixing the storage and scope of LSM data and tracing data leaves all sorts
of opportunities for abuse. Add inode data for tracing if you can get the
patch accepted, but do not move the LSM data out of i_security. Moving
the LSM data would break the integrity (such that there is) of the LSM
model.

>
> 1/4 is missing change for bpf task local storage. 2/4 move inode local
> storage from security blob to inode.
>
> Similar to task local storage in tracing program, it is necessary to add
> recursion prevention logic for inode local storage. Patch 3/4 adds such
> logic, and 4/4 add a test for the recursion prevention logic.
>
> Song Liu (4):
>   bpf: lsm: Remove hook to bpf_task_storage_free
>   bpf: Make bpf inode storage available to tracing program
>   bpf: Add recursion prevention logic for inode storage
>   selftest/bpf: Test inode local storage recursion prevention
>
>  fs/inode.c                                    |   1 +
>  include/linux/bpf.h                           |   9 +
>  include/linux/bpf_lsm.h                       |  29 ---
>  include/linux/fs.h                            |   4 +
>  kernel/bpf/Makefile                           |   3 +-
>  kernel/bpf/bpf_inode_storage.c                | 185 +++++++++++++-----
>  kernel/bpf/bpf_lsm.c                          |   4 -
>  kernel/trace/bpf_trace.c                      |   8 +
>  security/bpf/hooks.c                          |   7 -
>  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
>  .../bpf/prog_tests/inode_local_storage.c      |  72 +++++++
>  .../bpf/progs/inode_storage_recursion.c       |  90 +++++++++
>  12 files changed, 320 insertions(+), 93 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/inode_local_storage.c
>  create mode 100644 tools/testing/selftests/bpf/progs/inode_storage_recursion.c
>
> --
> 2.43.5
>

