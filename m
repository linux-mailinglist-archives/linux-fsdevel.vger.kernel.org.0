Return-Path: <linux-fsdevel+bounces-70381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDF6C99350
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 22:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFF17345BE8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 21:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512ED2857C1;
	Mon,  1 Dec 2025 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xgs+HtWy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76027AC57
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 21:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625186; cv=none; b=gsrtYh61NuVlNMdQBuyEApo2I2tijPi3K66USYzMFCuPlgdLnn050x2hCTVopldslekGFQfeml4O2fldLiDBk323ucfR/4yugWQGaXi73tAcm/hcwfAyOi1TeZhwTmOrO6AEWcChv3MxGAE87Ed3VPd82/vdbypFiMCmSAe+3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625186; c=relaxed/simple;
	bh=/RkCgTE/4Sl75hR0rlbGxd11uecUwoBDhtpuhsWfVcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgSzw7NSyhB5yyb61hnNnen727fhulTUdIsLuoeEl4cePtdTRHblbVLxZca47fujyvK+YfSuu7T5okj418mQ2ytJv93kKISqUEJZu11mpwXDBkDmWE1EhKHLDtePEg7nRi+jidYXDtmXdnvMZQqIpkhVwmnfOHQRmHv0MTK43ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xgs+HtWy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2d5e119fso1119381f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 13:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764625183; x=1765229983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZmRqhdDnonRvflYIO2SfgDWhvVya0E7TMh9w4AtTjQ=;
        b=Xgs+HtWyK5MQ/jnUBr+KIXECHApj+OALgOKz5VtDzjPSEoR5FInlvgHiZtFUB3z1kK
         U4lUkEBt5mnvZLshW54S4+8YTzEZtZ6xV6iL6RlCQhyCKa9PUBMlbcaf5cBv3v6RMJ1s
         BFQZM+CZZH4u+O8+faUtrMkIZZLphrZfzjqqFvlOyCq7oRa3HEfnaZ/douzRMaStvpzp
         CVNlJUKb235ZbLDqxyhtbaloqGaEjUXjATUGSNNLSg9X7KtXzm8EgJszk0ucghsmrLGc
         ZqDG7pOo5kKkOtEeCb+B1CNyQKzGISircodxMAwfMv+8qB6Xhg+88+xdEq/Tr9C5cCeU
         ZUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764625183; x=1765229983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uZmRqhdDnonRvflYIO2SfgDWhvVya0E7TMh9w4AtTjQ=;
        b=B9fkLPksmFUr7MkMthL8kJDJZv0QmZVX27+lrwxe3mb8KURr7u/i4Ig/iYgVIvr1PQ
         gc1fGeJUz1Gg9sDhXhHx741iRDMI0ZClM6F7N4bX37CyeOnbigtfiCy563tFIFM2IUuL
         pMFiSO1KzlYKNkgqF24ip0XLD5Fhve0j6gL6cyQ9aUrynL99GJBB8M2oIA1eGiOE/Hkw
         MExoou5Oe8e8lWWHEDTbm0mBo1ZGgfixHCaM52knFUeFCdq2wyMlbKAyIPUasoFY9Pln
         O4zPfTufUykirpRo1F3HWO+ymLAnNU0lL1YaGQyQ9PB54OVnNtZMlVnq2gqBK7hHcduw
         xwKw==
X-Forwarded-Encrypted: i=1; AJvYcCXV3nVlkXktJt+s0D5AhTkpHlXs3Gf2NJPcH8+5fbBliB1oNbHgVdL88rKKwH6cEsvafdbz3Y9sAeNAubZ4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2PBEtVPtbIP2r1Oen0XVvekSSmbPTRv0UPyIuY1ROPsYpIkEb
	gI86EINpGyX9AaOJCVOJbXm3er5Znq8Bd8v5zocSx9f1SoLsF55SeCUP
X-Gm-Gg: ASbGncv4k8EV+uMfImZ5EIFJxvwV+VSCE2LUe2WO0dKMy3Do96uRf0GXlKNKy2Wmxmj
	vfYbZjkfrCFDLLl9dsdvtKHVnXnIiM9kdHs9TZTLURZDHGxamT7ra3NMItEyCZLRmpKFlnt31b0
	YQuM1fWdcvmgorR7B8zXUl0qx3iRCnWKRqK6yTmXY/imF7+Emd0ObrWS6cn4jdpCCv9/Rralo3t
	T2Buaugzu1mKZ7x2xFnzeRZ5WrZdHYgfmt/JfB+akutafvJE4wdWWEhfXDAPEtDVLfglUx4Lzus
	XoJzp2oNZKu5/d153ZH2tyMv7JBejpMS7fEZ0AyDBITe4zhrmntRA6IKo/85p6K4JMgv75CoLnC
	W4fEklY/jwezFpX370fiwk8lfKCZDOft0wV+sW+g11eUIBHJJIYhePNpblHc0IEad0vLBBKVX4T
	K8b/2Mv42dkiQhiGa+GAyQaNGywgd+9lXtcrK5YGRr3odMHhQCl0YS
X-Google-Smtp-Source: AGHT+IF0GP+pqaKG4PhgW/HWMVcgie4ld9+aoLno5OGZiyBWMEqef3f9IS+F+vZ3lhE/VUXuRC3tJA==
X-Received: by 2002:a05:6000:2c0b:b0:429:d0b8:3850 with SMTP id ffacd0b85a97d-42cc1d0cd26mr39852844f8f.48.1764625182679;
        Mon, 01 Dec 2025 13:39:42 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1caae37esm28492546f8f.40.2025.12.01.13.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 13:39:42 -0800 (PST)
Date: Mon, 1 Dec 2025 21:39:38 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, Bernd Edlinger
 <bernd.edlinger@hotmail.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will
 Drewry <wad@chromium.org>, Christian Brauner <brauner@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Serge
 Hallyn <serge@hallyn.com>, James Morris <jamorris@linux.microsoft.com>,
 Randy Dunlap <rdunlap@infradead.org>, Suren Baghdasaryan
 <surenb@google.com>, Yafang Shao <laoar.shao@gmail.com>, Helge Deller
 <deller@gmx.de>, Adrian Reber <areber@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>, Alexei Starovoitov
 <ast@kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, tiozhang
 <tiozhang@didiglobal.com>, Luis Chamberlain <mcgrof@kernel.org>, "Paulo
 Alcantara (SUSE)" <pc@manguebit.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Frederic Weisbecker <frederic@kernel.org>,
 YueHaibing <yuehaibing@huawei.com>, Paul Moore <paul@paul-moore.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Stefan Roesch <shr@devkernel.io>, Chao Yu
 <chao@kernel.org>, xu xin <xu.xin16@zte.com.cn>, Jeff Layton
 <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand
 <david@redhat.com>, Dave Chinner <dchinner@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Elena Reshetova <elena.reshetova@intel.com>, David
 Windsor <dwindsor@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, Ard
 Biesheuvel <ardb@kernel.org>, "Joel Fernandes (Google)"
 <joel@joelfernandes.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hans Liljestrand <ishkamiel@gmail.com>, Penglei Jiang
 <superman.xpt@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Adrian Ratiu <adrian.ratiu@collabora.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Cyrill Gorcunov
 <gorcunov@gmail.com>, Eric Dumazet <edumazet@google.com>,
 zohar@linux.ibm.com, linux-integrity@vger.kernel.org, Ryan Lee
 <ryan.lee@canonical.com>, apparmor <apparmor@lists.ubuntu.com>
Subject: Re: Are setuid shell scripts safe? (Implied by
 security_bprm_creds_for_exec)
Message-ID: <20251201213938.184d71db@pumpkin>
In-Reply-To: <87ms42rq3t.fsf@email.froward.int.ebiederm.org>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
	<AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEEE807D016A79FE7A2F463E4D6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<87tsyozqdu.fsf@email.froward.int.ebiederm.org>
	<87wm3ky5n9.fsf@email.froward.int.ebiederm.org>
	<87h5uoxw06.fsf_-_@email.froward.int.ebiederm.org>
	<6dc556a0a93c18fffec71322bf97441c74b3134e.camel@huaweicloud.com>
	<87v7iqtcev.fsf_-_@email.froward.int.ebiederm.org>
	<dca0f01500f9d6705dccf3b3ef616468b1f53f57.camel@huaweicloud.com>
	<87ms42rq3t.fsf@email.froward.int.ebiederm.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 01 Dec 2025 12:53:10 -0600
"Eric W. Biederman" <ebiederm@xmission.com> wrote:

> Roberto Sassu <roberto.sassu@huaweicloud.com> writes:
...
> There is the partial solution of passing /dev/fd instead of passing the
> name of the script.  I suspect that would break things.  I don't
> remember why that was never adopted.

I thought that was what was done - and stopped the problem of a user
flipping a symlink between a suid script and one the user had written.

It has only ever been done for suid scripts when the uid actually changes.
Which makes it possible to set the permissions so that owner can't
run the script!
(The kernel only needs 'x' access, the shell needs 'r' access, so with 'x+s'
the owner can't execute the script but everyone else can.)

There is a much older problem that probably only affected the original 1970s
'sh' (not even the SVSV/Sunos version) that quoted redirects on the command
line would get actioned when the parameter was substituted - which I think
means the original 'sh' did post-substitution syntax analysis (the same
as cmd.exe still does).
That doesn't affect any shells used since the early 1980s.

	David

