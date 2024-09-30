Return-Path: <linux-fsdevel+bounces-30416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4169498ADC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 22:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E6C2823AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 20:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5B31A0BC9;
	Mon, 30 Sep 2024 20:11:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBCA199236;
	Mon, 30 Sep 2024 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727074; cv=none; b=TydeuhJKG3D0w2OMLW6W00FRNIYU/S+tBYxdSccUv1z+2W0jSBnOOcsjcaMKOoL7QqAazGfobAfZ6exd4GuAy1p8Vj2hRziqXNvZei6J8rvqIO+SS8gB6sei8iHq4nrpEx4m7p/SNwt5qbBnRbn0yGUdluQnWQwnZQmbicvzTD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727074; c=relaxed/simple;
	bh=16wgqX3QeEVfNDAe/n90GmLOm3v9Aejvw0xD7oxZ77E=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=PqGSK/9lWqlAFb6MEuqPRUk8/g0/YNVLsC4DQBRbybGygDiywZ/cI5dLpVQPRVCSiX7uMcBrV5PnJkG4DM7kabrjpi0MBkV5n6Sb9ryPzKl8PyR6pg/GLocX95a1ryBPxtS9jFYX1cnygyKdFeujFR2aP7Nq30LeqlPxbI801pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:40336)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1svMjY-00FenK-1S; Mon, 30 Sep 2024 14:11:04 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:60936 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1svMjX-00GHAt-4e; Mon, 30 Sep 2024 14:11:03 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Kees Cook <kees@kernel.org>
Cc: Tycho Andersen <tycho@tycho.pizza>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  linux-fsdevel@vger.kernel.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,  Tycho
 Andersen <tandersen@netflix.com>,  Zbigniew =?utf-8?Q?J=C4=99drzejewski-S?=
 =?utf-8?Q?zmek?=
 <zbyszek@in.waw.pl>,  Aleksa Sarai <cyphar@cyphar.com>
References: <20240927151746.391931-1-tycho@tycho.pizza>
	<87ikuhw155.fsf@email.froward.int.ebiederm.org>
	<202409281453.B9B9999D@keescook>
	<87bk05vobx.fsf@email.froward.int.ebiederm.org>
Date: Mon, 30 Sep 2024 15:10:29 -0500
In-Reply-To: <87bk05vobx.fsf@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Sun, 29 Sep 2024 21:59:30 -0500")
Message-ID: <871q10vr62.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1svMjX-00GHAt-4e;;;mid=<871q10vr62.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+saTEKwt+JRZ60ZDFuo0pZti0glltWxMo=
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
	*      [score: 0.3837]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <kees@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 281 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 4.5 (1.6%), b_tie_ro: 3.2 (1.1%), parse: 1.10
	(0.4%), extract_message_metadata: 10 (3.7%), get_uri_detail_list: 0.96
	(0.3%), tests_pri_-2000: 10 (3.6%), tests_pri_-1000: 2.1 (0.7%),
	tests_pri_-950: 0.98 (0.3%), tests_pri_-900: 0.82 (0.3%),
	tests_pri_-90: 80 (28.6%), check_bayes: 79 (28.1%), b_tokenize: 4.3
	(1.5%), b_tok_get_all: 5 (1.9%), b_comp_prob: 1.24 (0.4%),
	b_tok_touch_all: 65 (23.2%), b_finish: 0.70 (0.2%), tests_pri_0: 160
	(56.9%), check_dkim_signature: 0.38 (0.1%), check_dkim_adsp: 3.1
	(1.1%), poll_dns_idle: 1.67 (0.6%), tests_pri_10: 1.73 (0.6%),
	tests_pri_500: 6 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 1/2] exec: add a flag for "reasonable" execveat() comm
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: cyphar@cyphar.com, zbyszek@in.waw.pl, tandersen@netflix.com, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, tycho@tycho.pizza, kees@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Kees Cook <kees@kernel.org> writes:

>> I'm not super comfortable doing this regardless of bprm->fdpath; that
>> seems like too many cases getting changed. Can we just leave it as
>> depending on bprm->fdpath?

I was recommending that because I did not expect that there was any
widespread usage of aliasing of binary names using symlinks.

I realized today that on debian there are many aliases
of binaries created with the /etc/alternatives mechanism.
So there is much wider exposure to problems than I would have
supposed.

So I remove any objections to making the new code conditional on bprm->fdpath.

Eric


