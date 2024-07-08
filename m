Return-Path: <linux-fsdevel+bounces-23315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1CE92A896
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 20:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFB01C2116A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 18:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A7F149DFB;
	Mon,  8 Jul 2024 18:00:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B231014372B;
	Mon,  8 Jul 2024 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461651; cv=none; b=Sb7VkfWW9CaRfahXcmj/QHfTCFL4jnQbvgM2eORUDDVe4gU1omQnZ5pFp7BN01PETC06xKJvB8aEdPbw6ucmpB2JexEGeeAB2JRBJpEtZn2qXZp1zpvdMeCFm+g+mlBk01yE6MQ8gAX9dbUPnufDtQCJQRtvBqY2od6kjuF9XI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461651; c=relaxed/simple;
	bh=SVibBxcj+AK1QJInyK2NAclAx7e6KQ9QQ8U2h2WYdLk=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=bODzwbUn7g7x+4dq5hGkoYhaoCwhWPI0ZjWc57LFzoGIA+BBh0jOp3aXlbfGcNoEat0BzIVyr7OBUL4tvnMXUqcG09NVISejeV1kGRQFAGeS2dhjRu84DLaEd6scew/4wC9dAiZ8Yw9blHNL87N67r/xALg91GnmQwGJSxw5IkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:54410)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sQsGh-006EIl-Hs; Mon, 08 Jul 2024 11:35:15 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:41240 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sQsGg-009Wzz-4Z; Mon, 08 Jul 2024 11:35:15 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,  Al Viro
 <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Kees Cook
 <keescook@chromium.org>,  Linus Torvalds <torvalds@linux-foundation.org>,
  Paul Moore <paul@paul-moore.com>,  Theodore Ts'o <tytso@mit.edu>,
  Alejandro Colomar <alx@kernel.org>,  Aleksa Sarai <cyphar@cyphar.com>,
  Andrew Morton <akpm@linux-foundation.org>,  Andy Lutomirski
 <luto@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,  Casey Schaufler
 <casey@schaufler-ca.com>,  Christian Heimes <christian@python.org>,
  Dmitry Vyukov <dvyukov@google.com>,  Eric Biggers <ebiggers@kernel.org>,
  Eric Chiang <ericchiang@google.com>,  Fan Wu <wufan@linux.microsoft.com>,
  Geert Uytterhoeven <geert@linux-m68k.org>,  James Morris
 <jamorris@linux.microsoft.com>,  Jan Kara <jack@suse.cz>,  Jann Horn
 <jannh@google.com>,  Jeff Xu <jeffxu@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  Jordan R Abrahams <ajordanr@google.com>,  Lakshmi
 Ramasubramanian <nramas@linux.microsoft.com>,  Luca Boccassi
 <bluca@debian.org>,  Luis Chamberlain <mcgrof@kernel.org>,  "Madhavan T .
 Venkataraman" <madvenka@linux.microsoft.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Matthew Garrett <mjg59@srcf.ucam.org>,
  Matthew Wilcox <willy@infradead.org>,  Miklos Szeredi
 <mszeredi@redhat.com>,  Mimi Zohar <zohar@linux.ibm.com>,  Nicolas
 Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,  Scott Shell
 <scottsh@microsoft.com>,  Shuah Khan <shuah@kernel.org>,  Stephen Rothwell
 <sfr@canb.auug.org.au>,  Steve Dower <steve.dower@python.org>,  Steve
 Grubb <sgrubb@redhat.com>,  Thibaut Sautereau
 <thibaut.sautereau@ssi.gouv.fr>,  Vincent Strubel
 <vincent.strubel@ssi.gouv.fr>,  Xiaoming Ni <nixiaoming@huawei.com>,  Yin
 Fengwei <fengwei.yin@intel.com>,  kernel-hardening@lists.openwall.com,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-integrity@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-security-module@vger.kernel.org,  linux-mm@kvack.org
References: <20240704190137.696169-1-mic@digikod.net>
	<20240704190137.696169-2-mic@digikod.net>
	<87bk3bvhr1.fsf@oldenburg.str.redhat.com>
	<20240706.poo9ahd3La9b@digikod.net>
	<871q46bkoz.fsf@oldenburg.str.redhat.com>
	<20240708.zooj9Miaties@digikod.net>
	<878qybet6t.fsf_-_@oldenburg.str.redhat.com>
Date: Mon, 08 Jul 2024 12:34:28 -0500
In-Reply-To: <878qybet6t.fsf_-_@oldenburg.str.redhat.com> (Florian Weimer's
	message of "Mon, 08 Jul 2024 18:37:14 +0200")
Message-ID: <87cynn3hzv.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1sQsGg-009Wzz-4Z;;;mid=<87cynn3hzv.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19HTToYa5/poe3TSuCfV/i9WSH+lfvgNyM=
X-SA-Exim-Connect-IP: 68.227.165.127
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Florian Weimer <fweimer@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 739 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 3.6 (0.5%), b_tie_ro: 2.4 (0.3%), parse: 1.53
	(0.2%), extract_message_metadata: 7 (1.0%), get_uri_detail_list: 4.7
	(0.6%), tests_pri_-2000: 4.3 (0.6%), tests_pri_-1000: 11 (1.5%),
	tests_pri_-950: 1.27 (0.2%), tests_pri_-900: 1.15 (0.2%),
	tests_pri_-90: 148 (20.0%), check_bayes: 146 (19.8%), b_tokenize: 22
	(2.9%), b_tok_get_all: 15 (2.0%), b_comp_prob: 3.6 (0.5%),
	b_tok_touch_all: 103 (13.9%), b_finish: 0.70 (0.1%), tests_pri_0: 543
	(73.4%), check_dkim_signature: 0.49 (0.1%), check_dkim_adsp: 2.2
	(0.3%), poll_dns_idle: 0.94 (0.1%), tests_pri_10: 2.3 (0.3%),
	tests_pri_500: 8 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] binfmt_elf: Fail execution of shared objects with ELIBEXEC
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)


Florian Weimer <fweimer@redhat.com> writes:

> * Micka=C3=ABl Sala=C3=BCn:
>
>> On Sat, Jul 06, 2024 at 05:32:12PM +0200, Florian Weimer wrote:
>>> * Micka=C3=ABl Sala=C3=BCn:
>>>=20
>>> > On Fri, Jul 05, 2024 at 08:03:14PM +0200, Florian Weimer wrote:
>>> >> * Micka=C3=ABl Sala=C3=BCn:
>>> >>=20
>>> >> > Add a new AT_CHECK flag to execveat(2) to check if a file would be
>>> >> > allowed for execution.  The main use case is for script interprete=
rs and
>>> >> > dynamic linkers to check execution permission according to the ker=
nel's
>>> >> > security policy. Another use case is to add context to access logs=
 e.g.,
>>> >> > which script (instead of interpreter) accessed a file.  As any
>>> >> > executable code, scripts could also use this check [1].
>>> >>=20
>>> >> Some distributions no longer set executable bits on most shared obje=
cts,
>>> >> which I assume would interfere with AT_CHECK probing for shared obje=
cts.
>>> >
>>> > A file without the execute permission is not considered as executable=
 by
>>> > the kernel.  The AT_CHECK flag doesn't change this semantic.  Please
>>> > note that this is just a check, not a restriction.  See the next patch
>>> > for the optional policy enforcement.
>>> >
>>> > Anyway, we need to define the policy, and for Linux this is done with
>>> > the file permission bits.  So for systems willing to have a consistent
>>> > execution policy, we need to rely on the same bits.
>>>=20
>>> Yes, that makes complete sense.  I just wanted to point out the odd
>>> interaction with the old binutils bug and the (sadly still current)
>>> kernel bug.
>>>=20
>>> >> Removing the executable bit is attractive because of a combination of
>>> >> two bugs: a binutils wart which until recently always set the entry
>>> >> point address in the ELF header to zero, and the kernel not checking=
 for
>>> >> a zero entry point (maybe in combination with an absent program
>>> >> interpreter) and failing the execve with ELIBEXEC, instead of doing =
the
>>> >> execve and then faulting at virtual address zero.  Removing the
>>> >> executable bit is currently the only way to avoid these confusing
>>> >> crashes, so I understand the temptation.
>>> >
>>> > Interesting.  Can you please point to the bug report and the fix?  I
>>> > don't see any ELIBEXEC in the kernel.
>>>=20
>>> The kernel hasn't been fixed yet.  I do think this should be fixed, so
>>> that distributions can bring back the executable bit.
>>
>> Can you please point to the mailing list discussion or the bug report?
>
> I'm not sure if this was ever reported upstream as an RFE to fail with
> ELIBEXEC.  We have downstream bug report:
>
>   Prevent executed .so files with e_entry =3D=3D 0 from attempting to bec=
ome
>   a process.
>   <https://bugzilla.redhat.com/show_bug.cgi?id=3D2004942>
>
> I've put together a patch which seems to work, see below.
>
> I don't think there's any impact on AT_CHECK with execveat because that
> mode will never get to this point.
>
> Thanks,
> Florian
>
> ---8<-----------------------------------------------------------------
> Subject: binfmt_elf: Fail execution of shared objects with ELIBEXEC
>=20=20=20=20=20
> Historically, binutils has used the start of the text segment as the
> entry point if _start was not defined.  Executing such files results
> in crashes with random effects, depending on what code resides there.
> However, starting with binutils 2.38, BFD ld uses a zero entry point,
> due to commit 5226a6a892f922ea672e5775c61776830aaf27b7 ("Change the
> linker's heuristic for computing the entry point for binaries so that
> shared libraries default to an entry point of 0.").  This means
> that shared objects with zero entry points are becoming more common,
> and it makes sense for the kernel to recognize them and refuse
> to execute them.
>
> For backwards compatibility, if a load segment does not map the ELF
> header at file offset zero, the kernel still proceeds as before, in
> case the file is very non-standard and can actually start executing
> at virtual offset zero.


As written I find the logic of the patch confusing, and slightly wrong.

The program header value e_entry is a virtual address, possibly adjusted
by load_bias.  Which makes testing it against the file offset of a
PT_LOAD segment wrong.  It needs to test against elf_ppnt->p_vaddr.

I think performing an early sanity check to avoid very confusing crashes
seems sensible (as long as it is inexpensive).  This appears inexpensive
enough that we don't care.  This code is also before begin_new_exec
so it is early enough to be meaningful.

I think the check should simply test if e_entry is mapped.  So a range
check please to see if e_entry falls in a PT_LOAD segment.

Having code start at virtual address 0 is a perfectly fine semantically
and might happen in embedded scenarios.

The program header is not required to be mapped or be first, (AKA
p_offset and p_vaddr can have a somewhat arbitrary relationship) so any
mention of the program header in your logic seems confusing to me.

I think your basic structure will work.  Just the first check needs to
check if e_entry is lands inside the virtual address of a PT_LOAD
segment.  The second check should just be checking a variable to see if
e_entry was inside any PT_LOAD segment, and there is no interpreter.

Does that make sense?

Eric


>
> Signed-off-by: Florian Weimer <fweimer@redhat.com>
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index a43897b03ce9..ebd7052eb616 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -830,6 +830,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	unsigned long e_entry;
>  	unsigned long interp_load_addr =3D 0;
>  	unsigned long start_code, end_code, start_data, end_data;
> +	bool elf_header_mapped =3D false;
>  	unsigned long reloc_func_desc __maybe_unused =3D 0;
>  	int executable_stack =3D EXSTACK_DEFAULT;
>  	struct elfhdr *elf_ex =3D (struct elfhdr *)bprm->buf;
> @@ -865,6 +866,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  			continue;
>  		}
>=20=20
> +		if (elf_ppnt->p_type =3D=3D PT_LOAD && !elf_ppnt->p_offset)
> +			elf_header_mapped =3D true;
> +
>  		if (elf_ppnt->p_type !=3D PT_INTERP)
>  			continue;
>=20=20
> @@ -921,6 +925,20 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		goto out_free_ph;
>  	}
>=20=20
> +	/*
> +	 * A zero value for e_entry means that the ELF file has no
> +	 * entry point.  If the ELF header is mapped, this is
> +	 * guaranteed to crash (often even on the first instruction),
> +	 * so fail the execve system call instead.  (This is most
> +	 * likely to happen for a shared object.)  If the object has a
> +	 * program interpreter, dealing with the situation is its
> +	 * responsibility.
> +	 */
> +	if (elf_header_mapped && !elf_ex->e_entry && !interpreter) {
> +		retval =3D -ELIBEXEC;
> +		goto out_free_dentry;
> +	}
> +
>  	elf_ppnt =3D elf_phdata;
>  	for (i =3D 0; i < elf_ex->e_phnum; i++, elf_ppnt++)
>  		switch (elf_ppnt->p_type) {

