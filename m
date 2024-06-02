Return-Path: <linux-fsdevel+bounces-20749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB178D775E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 19:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1C31C20E16
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA465FBA9;
	Sun,  2 Jun 2024 17:53:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229305EE78;
	Sun,  2 Jun 2024 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717350786; cv=none; b=BE3sYbA6/RYVnP0v40G7+usr4kqdCkW+bDHy7AhaLl62APCG4zBg7GgnBoNToSbOGsSZ8fdCKLyrgsJh4PtHY9gsa0FENRRi37P2eKAiuEtUrBoh+ipFs6mjEg4lIdbxa51WVGKy8EwlUVTN4bhYXD9mSE1F/4OR4R674PDc2+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717350786; c=relaxed/simple;
	bh=6jfHG90M+1tBb/pTVXVS1yCPQEFkng4uNS3p4WDfUg4=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=kLif1vc3rt8T/qurW0ZRKZuymd7EgSJDGFjbXJF1GUsn0bFCNXgzwZBtfhPpL2JbPAuu0Iim7i3jLJb8f0oM3flqW2sLzFV5StWM2qqZbZMmQgOaAnebynuozhVGTwYgNAvCgRBYZFvOCQ6NEWcCMi3EPuSURez9GXzb1mfYaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:60110)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sDpOB-00FHij-7D; Sun, 02 Jun 2024 11:53:03 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:39904 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sDpOA-003geg-4A; Sun, 02 Jun 2024 11:53:02 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yafang Shao <laoar.shao@gmail.com>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  linux-mm <linux-mm@kvack.org>,
  Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,  linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>,  audit@vger.kernel.org,  LSM List
 <linux-security-module@vger.kernel.org>,  selinux@vger.kernel.org,  bpf
 <bpf@vger.kernel.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Kees
 Cook <keescook@chromium.org>
References: <20240602023754.25443-1-laoar.shao@gmail.com>
	<20240602023754.25443-2-laoar.shao@gmail.com>
	<87ikysdmsi.fsf@email.froward.int.ebiederm.org>
	<CALOAHbAASdjLjfDv5ZH7uj=oChKE6iYnwjKFMu6oabzqfs2QUw@mail.gmail.com>
	<CAADnVQJ_RPg_xTjuO=+3G=4auZkS-t-F2WTs18rU2PbVdJVbdQ@mail.gmail.com>
Date: Sun, 02 Jun 2024 12:52:07 -0500
In-Reply-To: <CAADnVQJ_RPg_xTjuO=+3G=4auZkS-t-F2WTs18rU2PbVdJVbdQ@mail.gmail.com>
	(Alexei Starovoitov's message of "Sun, 2 Jun 2024 09:35:19 -0700")
Message-ID: <874jabdygo.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1sDpOA-003geg-4A;;;mid=<874jabdygo.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+Ptg8m9UOQAWOg+UUM4tiPArdjNGCwU1g=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4996]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 486 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 13 (2.7%), b_tie_ro: 11 (2.3%), parse: 1.54
	(0.3%), extract_message_metadata: 18 (3.7%), get_uri_detail_list: 2.7
	(0.6%), tests_pri_-2000: 19 (3.8%), tests_pri_-1000: 4.0 (0.8%),
	tests_pri_-950: 1.51 (0.3%), tests_pri_-900: 1.25 (0.3%),
	tests_pri_-90: 118 (24.2%), check_bayes: 115 (23.8%), b_tokenize: 10
	(2.1%), b_tok_get_all: 9 (1.9%), b_comp_prob: 3.2 (0.7%),
	b_tok_touch_all: 89 (18.2%), b_finish: 1.16 (0.2%), tests_pri_0: 290
	(59.6%), check_dkim_signature: 0.76 (0.2%), check_dkim_adsp: 3.4
	(0.7%), poll_dns_idle: 0.97 (0.2%), tests_pri_10: 4.1 (0.8%),
	tests_pri_500: 12 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/6] fs/exec: Drop task_lock() inside __get_task_comm()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sat, Jun 1, 2024 at 11:57=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
>>
>> On Sun, Jun 2, 2024 at 11:52=E2=80=AFAM Eric W. Biederman <ebiederm@xmis=
sion.com> wrote:
>> >
>> > Yafang Shao <laoar.shao@gmail.com> writes:
>> >
>> > > Quoted from Linus [0]:
>> > >
>> > >   Since user space can randomly change their names anyway, using loc=
king
>> > >   was always wrong for readers (for writers it probably does make se=
nse
>> > >   to have some lock - although practically speaking nobody cares the=
re
>> > >   either, but at least for a writer some kind of race could have
>> > >   long-term mixed results
>> >
>> > Ugh.
>> > Ick.
>> >
>> > This code is buggy.
>> >
>> > I won't argue that Linus is wrong, about removing the
>> > task_lock.
>> >
>> > Unfortunately strscpy_pad does not work properly with the
>> > task_lock removed, and buf_size larger that TASK_COMM_LEN.
>> > There is a race that will allow reading past the end
>> > of tsk->comm, if we read while tsk->common is being
>> > updated.
>>
>> It appears so. Thanks for pointing it out. Additionally, other code,
>> such as the BPF helper bpf_get_current_comm(), also uses strscpy_pad()
>> directly without the task_lock. It seems we should change that as
>> well.
>
> Hmm. What race do you see?
> If lock is removed from __get_task_comm() it probably can be removed from
> __set_task_comm() as well.
> And both are calling strscpy_pad to write and read comm.
> So I don't see how it would read past sizeof(comm),
> because 'buf' passed into __set_task_comm is NUL-terminated.
> So the concurrent read will find it.

The read may race with a write that is changing the location
of '\0'.  Especially if the new value is shorter than
the old value.

If you are performing lockless reads and depending upon a '\0'
terminator without limiting yourself to the size of the buffer
there needs to be a big fat comment as to how in the world
you are guaranteed that a '\0' inside the buffer will always
be found.

Eric

