Return-Path: <linux-fsdevel+bounces-21339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF8F902286
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 15:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF09C1C213DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 13:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E053824B5;
	Mon, 10 Jun 2024 13:16:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73E4501B;
	Mon, 10 Jun 2024 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025405; cv=none; b=AbRXtFhtAP3d4jIZ5YWz+14Kby8GPBB4BUYro2sZNj8UQavqs8qLQ6161lfPDBE/xoSmh+DVr2Oc+Gwnt/21haqLW8ff+/uewKlBYryT8Xen6XB/pK2d6svxIA7mpLT0iiuy6hxi0bvHj7mVwp3U/OiivD26OJuAev3JvyLxE6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025405; c=relaxed/simple;
	bh=77k5rIMoIWHg6IseVGjYJC6hiieeMJ1RXLsTOo5sn9Q=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=lo9bYUA9nPyAd4qw/6n7qTJ7rBgTEijbFYdu7OmqgLYvob6eo0Lm1my5mCb17U8q4rJd/6k2aH6LbblQMWcxLMUGSn+2inSQINZOYGRitgnoAqC0Wutd8dVxar+NkQFenVHD8NaBUTt7/JmqrQ0xUX3P4/NeRUUv4iLOvrDtRjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:38392)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sGeE1-007QxW-Ub; Mon, 10 Jun 2024 06:34:14 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54200 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sGeE0-00FROe-SU; Mon, 10 Jun 2024 06:34:13 -0600
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
	<874jabdygo.fsf@email.froward.int.ebiederm.org>
	<CAADnVQ+9T4n=ZhNMd57qfu2w=VqHM8Dzx-7UAAinU5MoORg63w@mail.gmail.com>
Date: Mon, 10 Jun 2024 07:34:01 -0500
In-Reply-To: <CAADnVQ+9T4n=ZhNMd57qfu2w=VqHM8Dzx-7UAAinU5MoORg63w@mail.gmail.com>
	(Alexei Starovoitov's message of "Sun, 2 Jun 2024 11:23:17 -0700")
Message-ID: <87ikyhrn7q.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1sGeE0-00FROe-SU;;;mid=<87ikyhrn7q.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+aqS3BV7g8TVW+kULFxysO2TVuiqUO+14=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4982]
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 465 ms - load_scoreonly_sql: 0.13 (0.0%),
	signal_user_changed: 11 (2.3%), b_tie_ro: 9 (1.9%), parse: 1.04 (0.2%),
	 extract_message_metadata: 12 (2.7%), get_uri_detail_list: 1.43 (0.3%),
	 tests_pri_-2000: 13 (2.8%), tests_pri_-1000: 3.0 (0.6%),
	tests_pri_-950: 1.29 (0.3%), tests_pri_-900: 1.09 (0.2%),
	tests_pri_-90: 82 (17.7%), check_bayes: 81 (17.4%), b_tokenize: 8
	(1.6%), b_tok_get_all: 10 (2.1%), b_comp_prob: 2.5 (0.5%),
	b_tok_touch_all: 58 (12.5%), b_finish: 0.75 (0.2%), tests_pri_0: 320
	(68.9%), check_dkim_signature: 0.66 (0.1%), check_dkim_adsp: 3.4
	(0.7%), poll_dns_idle: 1.19 (0.3%), tests_pri_10: 2.7 (0.6%),
	tests_pri_500: 14 (2.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/6] fs/exec: Drop task_lock() inside __get_task_comm()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sun, Jun 2, 2024 at 10:53=E2=80=AFAM Eric W. Biederman <ebiederm@xmiss=
ion.com> wrote:
>>
>> If you are performing lockless reads and depending upon a '\0'
>> terminator without limiting yourself to the size of the buffer
>> there needs to be a big fat comment as to how in the world
>> you are guaranteed that a '\0' inside the buffer will always
>> be found.
>
> I think Yafang can certainly add such a comment next to
> __[gs]et_task_comm.
>
> I prefer to avoid open coding memcpy + mmemset when strscpy_pad works.

Looking through the code in set_task_comm
strscpy_pad only works when both the source and designation are aligned.
Otherwise it performs a byte a time copy, and is most definitely
susceptible to the race I observed.

Further I looked a couple of the uses of set_task_com, in
fs/proc/base.c, kernel/kthread.c, and kernel/sys.c.

Nowhere do I see a guarantee that the source buffer is word aligned
or even something that would reasonably cause a compiler to place the
buffer that is being passed to set_task_comm to be word aligned.

As far as I can tell it is completely up to the compiler if it will
cause strscpy_pad to honor the word at a time guarantee needed
to make strscpy_pad safe for reading the information.

This is not to say we can't make it safe.

The easiest would be to create an aligned temporary buffer in
set_task_comm, and preserve the existing interface.  Alternatively
a type that has the appropriate size and alignment could be used
as input to set_task_comm and it could be caller's responsibility
to use it.

While we can definitely make reading task->comm happen without taking
the lock.  Doing so without updating set_task_comm to provide the
guarantees needed to make it safe, looks like a case of play silly
games, win silly prizes.

Eric

