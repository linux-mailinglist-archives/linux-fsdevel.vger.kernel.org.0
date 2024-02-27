Return-Path: <linux-fsdevel+bounces-13006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F8F86A205
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A324FB236A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 22:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD39914F98E;
	Tue, 27 Feb 2024 22:00:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E85B1E2;
	Tue, 27 Feb 2024 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071241; cv=none; b=uPqV36e/n6XHEsesm7rwC8RZPTKpgrGiopUigAnrShoGzYQEuT1SYdsehtlhA8WJnoBrYjrQDv3z37tcL9U+mlMpIWHJtKI5TS0oGBrercFKSkY/xdGxD/fRBpP/9YKKQFgAyPTfQef3h4oBlmetQmeuvfHaBMk5fnoCG1Bp8sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071241; c=relaxed/simple;
	bh=yeJ0MC8KxBfrdQDP7vNN2S+oQaA2gBifiUKEeJ00/l8=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=H3cl4PmA6DX4nGbVM7Rg76YkLYjLxzGr2Kv2bKPxfKBpMICae2Q0tv989DkAamY7ow40jrGI+NHUuhhatDrMYWYmuBgivbGWzMIRTNOGzUbkLEdoPW0RW7zEZmUZuB+dSzHMkK8nFOmWrqqNJEp0csX9vxZyaD/IgwO6RYYI8ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:59646)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rf4Yo-004V6I-Ik; Tue, 27 Feb 2024 14:00:22 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:42108 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rf4Yn-005Syx-8G; Tue, 27 Feb 2024 14:00:22 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Kees Cook <keescook@chromium.org>
Cc: Jan Bujak <j@exia.io>,  Pedro Falcato <pedro.falcato@gmail.com>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,
  linux-fsdevel@vger.kernel.org
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
	<CAKbZUD2=W0Ng=rFVDn3UwSxtGQ5c13tRwkpqm54pPCJO0BraWA@mail.gmail.com>
	<f2ee9602-0a32-4f0c-a69b-274916abe27f@exia.io>
	<202402261821.F2812C9475@keescook>
	<878r35rkc4.fsf@email.froward.int.ebiederm.org>
	<202402270911.961702D7D6@keescook>
Date: Tue, 27 Feb 2024 14:59:54 -0600
In-Reply-To: <202402270911.961702D7D6@keescook> (Kees Cook's message of "Tue,
	27 Feb 2024 09:22:35 -0800")
Message-ID: <87v869pqr9.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1rf4Yn-005Syx-8G;;;mid=<87v869pqr9.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/DoQz7QJlvV3QX3of0uD+sm/D2JNl8PBs=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
	*      [score: 0.1979]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 536 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 12 (2.2%), b_tie_ro: 10 (1.9%), parse: 1.11
	(0.2%), extract_message_metadata: 26 (4.9%), get_uri_detail_list: 8
	(1.5%), tests_pri_-2000: 28 (5.3%), tests_pri_-1000: 3.0 (0.6%),
	tests_pri_-950: 1.41 (0.3%), tests_pri_-900: 1.13 (0.2%),
	tests_pri_-90: 146 (27.3%), check_bayes: 145 (27.0%), b_tokenize: 20
	(3.7%), b_tok_get_all: 12 (2.3%), b_comp_prob: 3.7 (0.7%),
	b_tok_touch_all: 103 (19.3%), b_finish: 1.42 (0.3%), tests_pri_0: 298
	(55.7%), check_dkim_signature: 0.94 (0.2%), check_dkim_adsp: 3.1
	(0.6%), poll_dns_idle: 0.97 (0.2%), tests_pri_10: 1.86 (0.3%),
	tests_pri_500: 11 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Kees Cook <keescook@chromium.org> writes:

> On Tue, Feb 27, 2024 at 09:35:39AM -0600, Eric W. Biederman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>>=20
>> > On Tue, Jan 23, 2024 at 12:23:27AM +0900, Jan Bujak wrote:
>> >> On 1/22/24 23:54, Pedro Falcato wrote:
>> >> > Hi!
>> >> >=20
>> >> > Where did you get that linker script?
>> >> >=20
>> >> > FWIW, I catched this possible issue in review, and this was already
>> >> > discussed (see my email and Eric's reply):
>> >> > https://lore.kernel.org/all/CAKbZUD3E2if8Sncy+M2YKncc_Zh08-86W6U5wR=
0ZMazShxbHHA@mail.gmail.com/
>> >> >=20
>> >> > This was my original testcase
>> >> > (https://github.com/heatd/elf-bug-questionmark), which convinced the
>> >> > loader to map .data over a cleared .bss. Your bug seems similar, but
>> >> > does the inverse: maps .bss over .data.
>> >> >=20
>> >>=20
>> >> I wrote the linker script myself from scratch.
>> >
>> > Do you still need this addressed, or have you been able to adjust the
>> > linker script? (I ask to try to assess the priority of needing to fix
>> > this behavior change...)
>>=20
>> Kees, I haven't had a chance to test this yet but it occurred to me
>> that there is an easy way to handle this.  In our in-memory copy
>> of the elf program headers we can just merge the two segments
>> together.
>>=20
>> I believe the diff below accomplishes that, and should fix issue.
>>=20
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>=20
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index 5397b552fbeb..01df7dd1f3b4 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
>> @@ -924,6 +926,31 @@ static int load_elf_binary(struct linux_binprm *bpr=
m)
>>  	elf_ppnt =3D elf_phdata;
>>  	for (i =3D 0; i < elf_ex->e_phnum; i++, elf_ppnt++)
>>  		switch (elf_ppnt->p_type) {
>> +		case PT_LOAD:
>> +		{
>> +			/*
>> +			 * Historically linux ignored all but the
>> +			 * final .bss segment.  Now that linux honors
>> +			 * all .bss segments, a .bss segment that
>> +			 * logically is not overlapping but is
>> +			 * overlapping when it's edges are rounded up
>> +			 * to page size causes programs to fail.
>> +			 *
>> +			 * Handle that case by merging .bss segments
>> +			 * into the segment they follow.
>> +			 */
>> +			if (((i + 1) >=3D elf_ex->e_phnum) ||
>> +			    (elf_ppnt[1].p_type !=3D PT_LOAD) ||
>> +			    (elf_ppnt[1].p_filesz !=3D 0))
>> +				continue;
>> +			unsigned long end =3D
>> +				elf_ppnt[0].p_vaddr + elf_ppnt[0].p_memsz;
>> +			if (elf_ppnt[1].p_vaddr !=3D end)
>> +				continue;
>> +			elf_ppnt[0].p_memsz +=3D elf_ppnt[1].p_memsz;
>> +			elf_ppnt[1].p_type =3D PT_NULL;
>> +			break;
>> +		}
>>  		case PT_GNU_STACK:
>>  			if (elf_ppnt->p_flags & PF_X)
>>  				executable_stack =3D EXSTACK_ENABLE_X;
>
> I don't think this is safe -- it isn't looking at flags, etc. e.g.,
> something like this could break:
>
> =C2=A0 Type=C2=A0 Offset=C2=A0=C2=A0 VirtAddr=C2=A0 PhysAddr=C2=A0 FileSi=
z=C2=A0 MemSiz=C2=A0=C2=A0 Flg Align
> =C2=A0 LOAD=C2=A0 0x003000 0x12000=C2=A0=C2=A0 0x12000=C2=A0=C2=A0 0x0010=
00 0x001000 R E 0x1000
> =C2=A0 LOAD=C2=A0 0x004000 0x13000=C2=A0=C2=A0 0x13000=C2=A0=C2=A0 0x0000=
00 0x001000 RW=C2=A0 0x1000

Yes.  I think it should be modified to only do something is the break
is not on a page boundary (which will automatically limit it's effect
to where we need to do something for backwards compatibility).

Still with a few tweaks and testing I think that is a good path forward
for dealing with the ``regression'' case.

Eric


