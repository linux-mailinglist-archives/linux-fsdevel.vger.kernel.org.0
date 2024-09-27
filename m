Return-Path: <linux-fsdevel+bounces-30264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FF7988866
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 17:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D3C1F225F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B871C1739;
	Fri, 27 Sep 2024 15:39:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4821E4AE;
	Fri, 27 Sep 2024 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727451543; cv=none; b=CwR39nIQvdJZ5fB8P5zYModO7foKjocJuKr40yGjFdN5kMgvXrT4mAkH7CW2OXoKJhYQPWnKzbe8q8oZryqRjhSZVQ0btff0+3o3WGAoFqc0691u19ZTpxKzH+HM2Udbbr24skKa+ixzLlXPzOxeK8jx1tynN9tFAFSDcQDhHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727451543; c=relaxed/simple;
	bh=A+nnFcqSOeTK/ORQTho2XfZbvuo2e1Q/u8SLxixq3Mg=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=BJ9gkUZGW9fLa8S11iF74PNvAx6JUHXQm84qx5P02o/q1az1xnhXr29tJvOtaX+GCPmV9hjw9lpI102wJwy4NTQKx1o7R1E42dHld0P3m9H6FjvgbBkWy6uudIgjOdb2KuXrjh6Vq2EJjS8Xam82TGWVejUGix7NZzHENlJfw0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:55628)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1suD3V-004ZpH-Bb; Fri, 27 Sep 2024 09:38:53 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:36938 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1suD3U-009xfm-B0; Fri, 27 Sep 2024 09:38:52 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Aleksa Sarai <cyphar@cyphar.com>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  Kees Cook <kees@kernel.org>,  Jeff Layton
 <jlayton@kernel.org>,  Chuck Lever <chuck.lever@oracle.com>,  Alexander
 Aring <alex.aring@gmail.com>,  linux-fsdevel@vger.kernel.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Tycho Andersen
 <tandersen@netflix.com>,  Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?=
 <zbyszek@in.waw.pl>
References: <20240924141001.116584-1-tycho@tycho.pizza>
	<87msjx9ciw.fsf@email.froward.int.ebiederm.org>
	<20240925.152228-private.conflict.frozen.trios-TdUGhuI5Sb4v@cyphar.com>
	<ZvR+k3D1KGALOIWt@tycho.pizza>
	<878qvf17zl.fsf@email.froward.int.ebiederm.org>
	<Zva8GEUv1Xj8SsLf@tycho.pizza>
	<87h6a1xilx.fsf@email.froward.int.ebiederm.org>
	<ZvbHlChEmj35+jHF@tycho.pizza>
Date: Fri, 27 Sep 2024 10:38:45 -0500
In-Reply-To: <ZvbHlChEmj35+jHF@tycho.pizza> (Tycho Andersen's message of "Fri,
	27 Sep 2024 08:56:20 -0600")
Message-ID: <87wmixw1h6.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1suD3U-009xfm-B0;;;mid=<87wmixw1h6.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/SeLu3lFfn5+34ujWa2fAf2nSewHm7GeA=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4774]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Tycho Andersen <tycho@tycho.pizza>
X-Spam-Relay-Country: 
X-Spam-Timing: total 454 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 11 (2.5%), b_tie_ro: 10 (2.2%), parse: 1.01
	(0.2%), extract_message_metadata: 12 (2.7%), get_uri_detail_list: 2.0
	(0.4%), tests_pri_-2000: 13 (2.9%), tests_pri_-1000: 2.8 (0.6%),
	tests_pri_-950: 1.24 (0.3%), tests_pri_-900: 0.98 (0.2%),
	tests_pri_-90: 82 (18.1%), check_bayes: 81 (17.8%), b_tokenize: 9
	(2.0%), b_tok_get_all: 10 (2.1%), b_comp_prob: 2.7 (0.6%),
	b_tok_touch_all: 56 (12.4%), b_finish: 0.84 (0.2%), tests_pri_0: 316
	(69.6%), check_dkim_signature: 0.55 (0.1%), check_dkim_adsp: 3.3
	(0.7%), poll_dns_idle: 1.57 (0.3%), tests_pri_10: 2.1 (0.5%),
	tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: zbyszek@in.waw.pl, tandersen@netflix.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, alex.aring@gmail.com, chuck.lever@oracle.com, jlayton@kernel.org, kees@kernel.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, cyphar@cyphar.com, tycho@tycho.pizza
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Tycho Andersen <tycho@tycho.pizza> writes:

> On Fri, Sep 27, 2024 at 09:43:22AM -0500, Eric W. Biederman wrote:
>> Tycho Andersen <tycho@tycho.pizza> writes:
>> 
>> > On Wed, Sep 25, 2024 at 09:09:18PM -0500, Eric W. Biederman wrote:
>> >> Tycho Andersen <tycho@tycho.pizza> writes:
>> >> 
>> >> > Yep, I did this for the test above, and it worked fine:
>> >> >
>> >> >         if (bprm->fdpath) {
>> >> >                 /*
>> >> >                  * If fdpath was set, execveat() made up a path that will
>> >> >                  * probably not be useful to admins running ps or similar.
>> >> >                  * Let's fix it up to be something reasonable.
>> >> >                  */
>> >> >                 struct path root;
>> >> >                 char *path, buf[1024];
>> >> >
>> >> >                 get_fs_root(current->fs, &root);
>> >> >                 path = __d_path(&bprm->file->f_path, &root, buf, sizeof(buf));
>> >> >
>> >> >                 __set_task_comm(me, kbasename(path), true);
>> >> >         } else {
>> >> >                 __set_task_comm(me, kbasename(bprm->filename), true);
>> >> >         }
>> >> >
>> >> > obviously we don't want a stack allocated buffer, but triggering on
>> >> > ->fdpath != NULL seems like the right thing, so we won't need a flag
>> >> > either.
>> >> >
>> >> > The question is: argv[0] or __d_path()?
>> >> 
>> >> You know.  I think we can just do:
>> >> 
>> >> 	BUILD_BUG_ON(DNAME_INLINE_LEN >= TASK_COMM_LEN);
>> >> 	__set_task_comm(me, bprm->file->f_path.dentry->d_name.name, true);
>> >> 
>> >> Barring cache misses that should be faster and more reliable than what
>> >> we currently have and produce the same output in all of the cases we
>> >> like, and produce better output in all of the cases that are a problem
>> >> today.
>> >> 
>> >> Does anyone see any problem with that?
>> >
>> > Nice, this works great. We need to drop the BUILD_BUG_ON() since it is
>> > violated in today's tree, but I think this is safe to do anyway since
>> > __set_task_comm() does strscpy_pad(tsk->comm, buf, sizeof(tsk->comm)).
>> 
>> Doh.  I simply put the conditional in the wrong order.  That should have
>> been:
>> 	BUILD_BUG_ON(TASK_COMM_LEN > DNAME_INLINE_LEN);
>> 
>> Sorry I was thinking of the invariant that needs to be preserved rather
>> than the bug that happens.
>
> Thanks, I will include that. Just for my own education: this is still
> *safe* to do, because of _pad, it's just that it is a userspace
> visible break if TASK_COMM_LEN > DNAME_INLINE_LEN is ever true?

Not a userspace visible issue at all.

With TASK_COMM_LEN <= DNAME_INLINE_LEN we could just use a memcpy of
TASK_COMM_LEN bytes, and everything will be safe.  (But we aren't
guaranteed a terminating '\0').

If you look at d_move and copy_name in dcache.c you can see that
there are cases where a rename of the dentry that happens as we
are reading it to fill task->comm a terminating '\0' might be
missed.

strscpy_pad relies on either finding a final '\0' after which
is adds more '\0's or on finding the end of the source buffer.

strscpy_pad will guarantee that there is a final '\0' in task->comm.

There might be some race in reading dentry->d_name, but I don't think we
much care.

Eric

