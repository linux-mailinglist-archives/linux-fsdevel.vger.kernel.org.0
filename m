Return-Path: <linux-fsdevel+bounces-55769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7515EB0E762
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 01:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77ED97B03FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 23:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AE128C2BE;
	Tue, 22 Jul 2025 23:57:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6452B239082;
	Tue, 22 Jul 2025 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753228619; cv=none; b=iFWncRh/Fh/BAmhpLPpeWDTZ3aY+6IQRa7x6FYdGz0bY2LXz4r7rPcNMicAWPcHva/P2i/ff2iS9acOoC6KOutmPxc0gJoZrnrhu2esFGLHprxFBgkeQmkAIlUIV4ky/JIEfAr+3BKaMQvsg8ngPW/7kGVfm/i+gG6pkjOOUnSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753228619; c=relaxed/simple;
	bh=a8eCLYQCbaGuBj9/91as4Az7N2duReG1uoUUWGuLhzY=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=DIQ7VKxzdEcCR5TSmXdbt8C1XBNO/wA/RrpL7n1txWmx303Nxq63NfGqdHaQS1kSs+pE801UG7rkmsUye4EMnISKYL/lT/fSxDN/pvf+NAHhhqffMTDPe0CyGzAWgKCY4L3NUJbinwKVE8tZwFPUqlTess9QXt+IEkQT0RFnYq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:54088)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1ueMW1-000zuR-EC; Tue, 22 Jul 2025 17:35:21 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:46488 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1ueMW0-00E3C9-Cu; Tue, 22 Jul 2025 17:35:21 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,  Thomas =?utf-8?Q?W?=
 =?utf-8?Q?ei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,
  Martin KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Linux-Fsdevel
 <linux-fsdevel@vger.kernel.org>,  bpf <bpf@vger.kernel.org>,  LKML
 <linux-kernel@vger.kernel.org>
References: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de>
	<20250721-remove-usermode-driver-v1-2-0d0083334382@linutronix.de>
	<CAADnVQ+Mw=bG-HZ5KMMDWzr_JqcCwWNQNf-JRvRsTLZ6P7-tUw@mail.gmail.com>
	<20250722063328.GA15403@lst.de>
Date: Tue, 22 Jul 2025 18:33:47 -0500
In-Reply-To: <20250722063328.GA15403@lst.de> (Christoph Hellwig's message of
	"Tue, 22 Jul 2025 08:33:28 +0200")
Message-ID: <87cy9rpzqc.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1ueMW0-00E3C9-Cu;;;mid=<87cy9rpzqc.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX199tPFUBRTw11rx3Pb8fqqmAgjycIgSwCI=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
	*      [score: 0.3244]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christoph Hellwig <hch@lst.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 565 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 15 (2.6%), b_tie_ro: 13 (2.3%), parse: 1.64
	(0.3%), extract_message_metadata: 26 (4.6%), get_uri_detail_list: 1.85
	(0.3%), tests_pri_-2000: 34 (6.0%), tests_pri_-1000: 4.3 (0.8%),
	tests_pri_-950: 1.42 (0.3%), tests_pri_-900: 1.16 (0.2%),
	tests_pri_-90: 85 (15.0%), check_bayes: 81 (14.3%), b_tokenize: 9
	(1.6%), b_tok_get_all: 8 (1.4%), b_comp_prob: 2.5 (0.4%),
	b_tok_touch_all: 58 (10.2%), b_finish: 1.13 (0.2%), tests_pri_0: 378
	(66.9%), check_dkim_signature: 0.70 (0.1%), check_dkim_adsp: 3.6
	(0.6%), poll_dns_idle: 0.80 (0.1%), tests_pri_10: 3.9 (0.7%),
	tests_pri_500: 11 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH bpf-next 2/2] umd: Remove usermode driver framework
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, jolsa@kernel.org, haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org, john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org, viro@zeniv.linux.org.uk, thomas.weissschuh@linutronix.de, alexei.starovoitov@gmail.com, hch@lst.de
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Christoph Hellwig <hch@lst.de> writes:

> On Mon, Jul 21, 2025 at 08:51:22AM -0700, Alexei Starovoitov wrote:
>> On Mon, Jul 21, 2025 at 2:05=E2=80=AFAM Thomas Wei=C3=9Fschuh
>> <thomas.weissschuh@linutronix.de> wrote:
>> >
>> > The code is unused since commit 98e20e5e13d2 ("bpfilter: remove bpfilt=
er"),
>> > remove it.
>>=20
>> Correct, but we have plans to use it.
>> Since it's not causing any problems we prefer to keep it
>> to avoid reverting the removal later.
>
> Plans to eventually use something are no reason to keep code that's been
> unused for almost 2 years around.  Unless the removal would conflict with
> currently queued up in linux-next code it is always better to just drop
> it and reinstate it when (or rather usually IFF) it is used again.

I wonder if those are the same plans that existed in June of 2020 when I
split out the usermode driver code from user mode helper?

As far as I know this code has never been seriously used, so I am in
favor of simplifying the maintenance burden.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric


