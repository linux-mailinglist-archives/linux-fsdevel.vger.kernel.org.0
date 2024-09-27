Return-Path: <linux-fsdevel+bounces-30254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1109C988760
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 16:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B9128300A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62CB18BC1F;
	Fri, 27 Sep 2024 14:43:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063C0A2D;
	Fri, 27 Sep 2024 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727448215; cv=none; b=cmrCIr/K8WAiCpsLA/9ZEJ3iMoOYLKuaQWET3aSdL/E+ygcyxIFukwB5nMIwJqDHTqtMmtC4mPslKAawF9ot6vLTPbjKaRQL11WDoUOltMAtyqW6Da8MMppf966orIjRiLGFBDrblcUnByzElJD4e6Nyt6UPFcplLvxv5PJIPOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727448215; c=relaxed/simple;
	bh=jeR1ZYwbSsy/8gC6GLL0ewkTrLc8MHYfdMlTgdIpmxI=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=pjM38CvHD9JuWYV65zuLJq95n0ZIYz/Ps7qLMUNgayYN4h0bUWOnxifhL1GyqGUzn5F3mArmicgfRivgbACuwxeVYY0dInliO02CDp9/vbtbWjZdT6EnegbK3uZmMSMU4hLSFnAv+qffmcMIk5e3eN1VivHBLi1LePrx5Ja8sqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:43476)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1suCBu-002Tdn-EA; Fri, 27 Sep 2024 08:43:30 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:39014 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1suCBt-009qW1-G2; Fri, 27 Sep 2024 08:43:30 -0600
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
Date: Fri, 27 Sep 2024 09:43:22 -0500
In-Reply-To: <Zva8GEUv1Xj8SsLf@tycho.pizza> (Tycho Andersen's message of "Fri,
	27 Sep 2024 08:07:20 -0600")
Message-ID: <87h6a1xilx.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1suCBt-009qW1-G2;;;mid=<87h6a1xilx.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19odIX+pzGkJDzocY816Air47iY1grMlMY=
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4905]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Tycho Andersen <tycho@tycho.pizza>
X-Spam-Relay-Country: 
X-Spam-Timing: total 352 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 4.8 (1.4%), b_tie_ro: 3.3 (0.9%), parse: 1.22
	(0.3%), extract_message_metadata: 11 (3.1%), get_uri_detail_list: 1.85
	(0.5%), tests_pri_-2000: 10 (2.9%), tests_pri_-1000: 2.2 (0.6%),
	tests_pri_-950: 1.00 (0.3%), tests_pri_-900: 0.80 (0.2%),
	tests_pri_-90: 48 (13.5%), check_bayes: 46 (13.2%), b_tokenize: 6
	(1.6%), b_tok_get_all: 7 (2.1%), b_comp_prob: 1.90 (0.5%),
	b_tok_touch_all: 29 (8.1%), b_finish: 0.74 (0.2%), tests_pri_0: 262
	(74.5%), check_dkim_signature: 0.38 (0.1%), check_dkim_adsp: 3.5
	(1.0%), poll_dns_idle: 0.86 (0.2%), tests_pri_10: 1.71 (0.5%),
	tests_pri_500: 6 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: zbyszek@in.waw.pl, tandersen@netflix.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, alex.aring@gmail.com, chuck.lever@oracle.com, jlayton@kernel.org, kees@kernel.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, cyphar@cyphar.com, tycho@tycho.pizza
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Tycho Andersen <tycho@tycho.pizza> writes:

> On Wed, Sep 25, 2024 at 09:09:18PM -0500, Eric W. Biederman wrote:
>> Tycho Andersen <tycho@tycho.pizza> writes:
>> 
>> > Yep, I did this for the test above, and it worked fine:
>> >
>> >         if (bprm->fdpath) {
>> >                 /*
>> >                  * If fdpath was set, execveat() made up a path that will
>> >                  * probably not be useful to admins running ps or similar.
>> >                  * Let's fix it up to be something reasonable.
>> >                  */
>> >                 struct path root;
>> >                 char *path, buf[1024];
>> >
>> >                 get_fs_root(current->fs, &root);
>> >                 path = __d_path(&bprm->file->f_path, &root, buf, sizeof(buf));
>> >
>> >                 __set_task_comm(me, kbasename(path), true);
>> >         } else {
>> >                 __set_task_comm(me, kbasename(bprm->filename), true);
>> >         }
>> >
>> > obviously we don't want a stack allocated buffer, but triggering on
>> > ->fdpath != NULL seems like the right thing, so we won't need a flag
>> > either.
>> >
>> > The question is: argv[0] or __d_path()?
>> 
>> You know.  I think we can just do:
>> 
>> 	BUILD_BUG_ON(DNAME_INLINE_LEN >= TASK_COMM_LEN);
>> 	__set_task_comm(me, bprm->file->f_path.dentry->d_name.name, true);
>> 
>> Barring cache misses that should be faster and more reliable than what
>> we currently have and produce the same output in all of the cases we
>> like, and produce better output in all of the cases that are a problem
>> today.
>> 
>> Does anyone see any problem with that?
>
> Nice, this works great. We need to drop the BUILD_BUG_ON() since it is
> violated in today's tree, but I think this is safe to do anyway since
> __set_task_comm() does strscpy_pad(tsk->comm, buf, sizeof(tsk->comm)).

Doh.  I simply put the conditional in the wrong order.  That should have
been:
	BUILD_BUG_ON(TASK_COMM_LEN > DNAME_INLINE_LEN);

Sorry I was thinking of the invariant that needs to be preserved rather
than the bug that happens.

Eric


