Return-Path: <linux-fsdevel+bounces-20751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2946A8D777F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 20:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D581C20E70
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6B76EB7C;
	Sun,  2 Jun 2024 18:41:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341B6328DB;
	Sun,  2 Jun 2024 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717353671; cv=none; b=bn0DOsU6nmiXFHLjiOSWYtrwuZ6nSWWlBqbABbEB1VQrdVz/IZ6JGqbjh4RJ3k0X0uAHcSPvuU7ro0SRKbuHikaJndI+BMDNow3V2UDDa3KdJsyZkps6Wmc6t4sFd5AV3uMMFuC/y7EUzjxZ256a8VQjxUo8ya2VbgZ1sZ+BNRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717353671; c=relaxed/simple;
	bh=eGg3c9C8/Bhq0WgBY61Ni0ok6O/Iz1o8Lhi2ZxZ9LPM=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=jFgZHFgBOX+Nnajk/qZ8znPmNxhbVrR+xErizhRxbod4FgG+oNdw8QSwjCzvDE6HJrPNL1ff/X6G3ALYCM2ZmwvFofoQ+sIL7rhzuzaIBcMhxu5WchC85wKB9lusSyN+0pyOvpk/QgLSA++6iCPy/FKdOqyIcZKSvNMsa/a3L9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:55724)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sDpSX-005b58-9E; Sun, 02 Jun 2024 11:57:33 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:33916 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sDpSV-00HTHK-GO; Sun, 02 Jun 2024 11:57:32 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org,  linux-mm@kvack.org,
  linux-fsdevel@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
  audit@vger.kernel.org,  linux-security-module@vger.kernel.org,
  selinux@vger.kernel.org,  bpf@vger.kernel.org,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  Kees Cook <keescook@chromium.org>
References: <20240602023754.25443-1-laoar.shao@gmail.com>
	<20240602023754.25443-2-laoar.shao@gmail.com>
	<87ikysdmsi.fsf@email.froward.int.ebiederm.org>
	<CALOAHbAASdjLjfDv5ZH7uj=oChKE6iYnwjKFMu6oabzqfs2QUw@mail.gmail.com>
Date: Sun, 02 Jun 2024 12:56:52 -0500
In-Reply-To: <CALOAHbAASdjLjfDv5ZH7uj=oChKE6iYnwjKFMu6oabzqfs2QUw@mail.gmail.com>
	(Yafang Shao's message of "Sun, 2 Jun 2024 14:56:23 +0800")
Message-ID: <87o78jxm6z.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1sDpSV-00HTHK-GO;;;mid=<87o78jxm6z.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/H+WMELW2v4o3gxreTIa+W60BpyDuHpZ4=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4999]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Yafang Shao <laoar.shao@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 379 ms - load_scoreonly_sql: 0.13 (0.0%),
	signal_user_changed: 14 (3.8%), b_tie_ro: 12 (3.2%), parse: 1.77
	(0.5%), extract_message_metadata: 19 (4.9%), get_uri_detail_list: 1.98
	(0.5%), tests_pri_-2000: 19 (5.1%), tests_pri_-1000: 3.6 (1.0%),
	tests_pri_-950: 1.64 (0.4%), tests_pri_-900: 1.36 (0.4%),
	tests_pri_-90: 59 (15.6%), check_bayes: 57 (15.0%), b_tokenize: 8
	(2.2%), b_tok_get_all: 9 (2.4%), b_comp_prob: 2.9 (0.8%),
	b_tok_touch_all: 33 (8.7%), b_finish: 1.00 (0.3%), tests_pri_0: 243
	(64.3%), check_dkim_signature: 0.89 (0.2%), check_dkim_adsp: 3.4
	(0.9%), poll_dns_idle: 0.89 (0.2%), tests_pri_10: 2.6 (0.7%),
	tests_pri_500: 8 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/6] fs/exec: Drop task_lock() inside __get_task_comm()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Yafang Shao <laoar.shao@gmail.com> writes:

> On Sun, Jun 2, 2024 at 11:52=E2=80=AFAM Eric W. Biederman <ebiederm@xmiss=
ion.com> wrote:
>>
>> Yafang Shao <laoar.shao@gmail.com> writes:
>>
>> > Quoted from Linus [0]:
>> >
>> >   Since user space can randomly change their names anyway, using locki=
ng
>> >   was always wrong for readers (for writers it probably does make sense
>> >   to have some lock - although practically speaking nobody cares there
>> >   either, but at least for a writer some kind of race could have
>> >   long-term mixed results
>>
>> Ugh.
>> Ick.
>>
>> This code is buggy.
>>
>> I won't argue that Linus is wrong, about removing the
>> task_lock.
>>
>> Unfortunately strscpy_pad does not work properly with the
>> task_lock removed, and buf_size larger that TASK_COMM_LEN.
>> There is a race that will allow reading past the end
>> of tsk->comm, if we read while tsk->common is being
>> updated.
>
> It appears so. Thanks for pointing it out. Additionally, other code,
> such as the BPF helper bpf_get_current_comm(), also uses strscpy_pad()
> directly without the task_lock. It seems we should change that as
> well.

Which suggests that we could really use a helper that handles all of
the tricky business of reading the tsk->comm lock-free.

Eric

