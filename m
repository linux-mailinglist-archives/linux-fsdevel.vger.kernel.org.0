Return-Path: <linux-fsdevel+bounces-30088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF499860A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E187B288799
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEA74AECE;
	Wed, 25 Sep 2024 13:18:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6259F487B0;
	Wed, 25 Sep 2024 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270330; cv=none; b=dCV4cibeHzCN1JDTVaAA/Wd/XEhjsKZZieZFT04JFZvmFdbEjJAbsqgv7/6fDpVf0dlO6fBlwjGGd6Jnh3VtGvZ8xL2XAXpXIqclAK76wd/1ibDu37wm1qVhg55rvJVXbpcSVdtm8wzFYCYh936Y5nm7dTtCw+f6Tv/ZtLYxGgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270330; c=relaxed/simple;
	bh=PP7aq5C8n8TxDp+EHp46ciDzlU37Fv5PHSVhKT+8QHk=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=Kn0JouL5poqp6ABJxzTLCc5+DBxmPjTJxHXJjfc+m8lQXZRl9QA7Eq2/2psm7zZtQ9atqJC2V0aJlGnrMEIrXaaK15cwFvJ72BjTGVnx0tRFe/OUEk/5nqxug/rEjWi22whwMl5tsBIJkiG+TiXvh4KyXttesI36jMyFFyTxG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:53986)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1stRup-006dUP-MN; Wed, 25 Sep 2024 07:18:47 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:58286 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1stRuo-004SfG-DQ; Wed, 25 Sep 2024 07:18:46 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Tycho Andersen <tycho@tycho.pizza>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Jan Kara <jack@suse.cz>,  Kees Cook
 <kees@kernel.org>,  Jeff Layton <jlayton@kernel.org>,  Chuck Lever
 <chuck.lever@oracle.com>,  Alexander Aring <alex.aring@gmail.com>,
  linux-fsdevel@vger.kernel.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Tycho Andersen <tandersen@netflix.com>,
  Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,  Aleksa
 Sarai
 <cyphar@cyphar.com>
References: <20240924141001.116584-1-tycho@tycho.pizza>
	<20240925-herziehen-unerbittlich-23c5845fed06@brauner>
Date: Wed, 25 Sep 2024 08:18:39 -0500
In-Reply-To: <20240925-herziehen-unerbittlich-23c5845fed06@brauner> (Christian
	Brauner's message of "Wed, 25 Sep 2024 10:31:04 +0200")
Message-ID: <874j63an2o.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1stRuo-004SfG-DQ;;;mid=<874j63an2o.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+iuWV+WzFVZr6NUegQlBB1YDjWlT50k0Y=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4009]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <brauner@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 346 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 9 (2.6%), b_tie_ro: 7 (2.1%), parse: 1.01 (0.3%),
	extract_message_metadata: 3.1 (0.9%), get_uri_detail_list: 0.77 (0.2%),
	 tests_pri_-2000: 2.5 (0.7%), tests_pri_-1000: 3.3 (1.0%),
	tests_pri_-950: 1.35 (0.4%), tests_pri_-900: 1.15 (0.3%),
	tests_pri_-90: 146 (42.1%), check_bayes: 143 (41.3%), b_tokenize: 5
	(1.5%), b_tok_get_all: 4.1 (1.2%), b_comp_prob: 1.71 (0.5%),
	b_tok_touch_all: 128 (37.1%), b_finish: 0.91 (0.3%), tests_pri_0: 159
	(45.9%), check_dkim_signature: 0.54 (0.2%), check_dkim_adsp: 8 (2.3%),
	poll_dns_idle: 6 (1.8%), tests_pri_10: 2.2 (0.6%), tests_pri_500: 7
	(2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: cyphar@cyphar.com, zbyszek@in.waw.pl, tandersen@netflix.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, alex.aring@gmail.com, chuck.lever@oracle.com, jlayton@kernel.org, kees@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk, tycho@tycho.pizza, brauner@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Christian Brauner <brauner@kernel.org> writes:

> Please add a:
>
> Link: https://github.com/uapi-group/kernel-features#set-comm-field-before-exec
>
> to the commit where this originated from.

What standing does some random github project have? 

Eric

