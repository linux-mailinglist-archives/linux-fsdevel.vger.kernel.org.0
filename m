Return-Path: <linux-fsdevel+bounces-19683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45C38C88EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 17:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5CA2891A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 15:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0D06BB26;
	Fri, 17 May 2024 14:59:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1723665194;
	Fri, 17 May 2024 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957981; cv=none; b=FRUEjW8s85prfks01xROpmRw0aaoG/OLMgWl4vUnLjI8sRrIPhO4YYtev7aP1Mc5K1flBEDg01BAAXROkT6bNBIv+9p4TRCM7qIFvWjphc4c3aZDdi49adIv3Coj+x6dj2k6PG9mjT+G+IZ4C9PESiZBA4GIo1GKVUHjP3F1Bc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957981; c=relaxed/simple;
	bh=avilw900f6d/x8c9K8ZiuzFANTi4g2LTrG2nEouV5+A=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=AMxUw1V68VZCn8y1DvJP1Q4FhhHkDBsD+jnxQ/GqdmErol+DU1lXqGV5Jxu/iYbpEHre4JfZjN8kwe83qQJahkmnFx1RLjNrPM8uD9S1upzShSZDQOLWxOwMnSpzOw+jE8rPZQj8FcW8LJ+o+BgfycbiH1BKnqV0wMCBW3ou11s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:51178)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1s7yTv-00G0Ui-NK; Fri, 17 May 2024 08:22:47 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:32812 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1s7yTu-00FFhy-O4; Fri, 17 May 2024 08:22:47 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Jonathan Calmels <jcalmels@3xx0.net>
Cc: brauner@kernel.org,  Luis Chamberlain <mcgrof@kernel.org>,  Kees Cook
 <keescook@chromium.org>,  Joel Granados <j.granados@samsung.com>,  Serge
 Hallyn <serge@hallyn.com>,  Paul Moore <paul@paul-moore.com>,  James
 Morris <jmorris@namei.org>,  David Howells <dhowells@redhat.com>,  Jarkko
 Sakkinen <jarkko@kernel.org>,  containers@lists.linux.dev,
  linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-security-module@vger.kernel.org,  keyrings@vger.kernel.org
References: <20240516092213.6799-1-jcalmels@3xx0.net>
	<20240516092213.6799-2-jcalmels@3xx0.net>
	<878r08brmp.fsf@email.froward.int.ebiederm.org>
	<xv52m5xu5tgwpckkcvyjvefbvockmb7g7fvhlky5yjs2i2jhsp@dcuovgkys4eh>
Date: Fri, 17 May 2024 09:22:23 -0500
In-Reply-To: <xv52m5xu5tgwpckkcvyjvefbvockmb7g7fvhlky5yjs2i2jhsp@dcuovgkys4eh>
	(Jonathan Calmels's message of "Fri, 17 May 2024 04:55:03 -0700")
Message-ID: <87jzjsa57k.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1s7yTu-00FFhy-O4;;;mid=<87jzjsa57k.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18IkHUj49fRJqM7REx3ND8lhM0yvX7TxF4=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4999]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Jonathan Calmels <jcalmels@3xx0.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 365 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 11 (3.0%), b_tie_ro: 10 (2.6%), parse: 0.86
	(0.2%), extract_message_metadata: 19 (5.2%), get_uri_detail_list: 1.95
	(0.5%), tests_pri_-2000: 15 (4.2%), tests_pri_-1000: 2.9 (0.8%),
	tests_pri_-950: 1.21 (0.3%), tests_pri_-900: 1.01 (0.3%),
	tests_pri_-90: 70 (19.1%), check_bayes: 68 (18.6%), b_tokenize: 7
	(2.0%), b_tok_get_all: 6 (1.7%), b_comp_prob: 2.2 (0.6%),
	b_tok_touch_all: 49 (13.5%), b_finish: 0.87 (0.2%), tests_pri_0: 231
	(63.4%), check_dkim_signature: 0.52 (0.1%), check_dkim_adsp: 2.4
	(0.7%), poll_dns_idle: 0.44 (0.1%), tests_pri_10: 2.1 (0.6%),
	tests_pri_500: 7 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/3] capabilities: user namespace capabilities
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Jonathan Calmels <jcalmels@3xx0.net> writes:

> On Fri, May 17, 2024 at 06:32:46AM GMT, Eric W. Biederman wrote:
>> 
>> Pointers please?
>> 
>> That sentence sounds about 5 years out of date.
>
> The link referenced is from last year.
> Here are some others often cited by distributions:
>
> https://nvd.nist.gov/vuln/detail/CVE-2022-0185
> https://nvd.nist.gov/vuln/detail/CVE-2022-1015
> https://nvd.nist.gov/vuln/detail/CVE-2022-2078
> https://nvd.nist.gov/vuln/detail/CVE-2022-24122
> https://nvd.nist.gov/vuln/detail/CVE-2022-25636
>
> Recent thread discussing this too:
> https://seclists.org/oss-sec/2024/q2/128

My apologies perhaps I trimmed too much.

I know that user namespaces enlarge the attack surface.
How much and how serious could be debated but for unprivileged
users the attack surface is undoubtedly enlarged.

As I read your introduction you were justifying the introduction
of a new security mechanism with the observation that distributions
were carrying distribution specific patches.

To the best of my knowledge distribution specific patches and
distributions disabling user namespaces have been gone for quite a
while.  So if that has changed recently I would like to know.

Thank you,
Eric



