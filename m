Return-Path: <linux-fsdevel+bounces-4961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6865C806C0D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997AB1C20962
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A132DF65
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FKeU3LMZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C24109;
	Wed,  6 Dec 2023 01:56:03 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 42E7E21F3E;
	Wed,  6 Dec 2023 09:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701856557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=38oqPwid60kS6euzFAYt5HgeBK7Z4xKSWiLADq6sPMY=;
	b=FKeU3LMZDT6YmQll0fLvK+UGD/SN8T7VGmFqsMDJZ9gc7NNDpRzn0VjFzbOasPnTTTwXm8
	xPVqFHyCbTZoR93GW8VwteHKafJJLTvb8OSsW9IsNoI+X0Eqqx1X8Q9Bl9H/XbIz9boQoX
	ZDeYZXSjELH22O3pRsNY1WMUbqC3LoU=
Received: from suse.cz (unknown [10.100.201.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 2839E2C153;
	Wed,  6 Dec 2023 09:55:51 +0000 (UTC)
Date: Wed, 6 Dec 2023 10:55:51 +0100
From: Petr Mladek <pmladek@suse.com>
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
	josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Iurii Zaikin <yzaikin@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Balbir Singh <bsingharora@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 07/10] printk: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <ZXBFJ3G9ERfI55Sc@alley>
References: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
 <20231107-jag-sysctl_remove_empty_elem_kernel-v1-7-e4ce1388dfa0@samsung.com>
 <CGME20231128140754eucas1p2cf2c17554954e94d0dc14967e1f5e750@eucas1p2.samsung.com>
 <ZWX0L4lV8TWOgcpv@alley>
 <20231204085628.pf7yxppacf4pm2cv@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204085628.pf7yxppacf4pm2cv@localhost>
X-Spam-Score: 22.12
X-Spamd-Result: default: False [22.12 / 50.00];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[149.44.160.134:from];
	 RDNS_NONE(1.00)[];
	 TO_DN_SOME(0.00)[];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
	 HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
	 MX_GOOD(-0.01)[];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FORGED_RECIPIENTS(2.00)[m:mgorman@suse.de,s:mgorman@imap.suse.de];
	 BAYES_HAM(-3.00)[100.00%];
	 RDNS_DNSFAIL(0.00)[];
	 ARC_NA(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 FROM_HAS_DN(0.00)[];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 NEURAL_SPAM_SHORT(2.12)[0.707];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_TWELVE(0.00)[46];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.org,infradead.org,joshtriplett.org,chromium.org,xmission.com,google.com,goodmis.org,arm.com,linutronix.de,amacapital.net,redhat.com,linaro.org,suse.de,linux.ibm.com,intel.com,davemloft.net,gmail.com,iogearbox.net,linux.dev,vger.kernel.org,lists.infradead.org];
	 HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RCVD_COUNT_TWO(0.00)[2]
X-Spamd-Bar: ++++++++++++++++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=fail (smtp-out1.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Queue-Id: 42E7E21F3E

On Mon 2023-12-04 09:56:28, Joel Granados wrote:
> Hey Petr
> 
> I missed this message somehow....
> 
> On Tue, Nov 28, 2023 at 03:07:43PM +0100, Petr Mladek wrote:
> > On Tue 2023-11-07 14:45:07, Joel Granados via B4 Relay wrote:
> > > From: Joel Granados <j.granados@samsung.com>
> > > 
> > > This commit comes at the tail end of a greater effort to remove the
> > > empty elements at the end of the ctl_table arrays (sentinels) which
> > > will reduce the overall build time size of the kernel and run time
> > > memory bloat by ~64 bytes per sentinel (further information Link :
> > > https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> > > 
> > > rm sentinel element from printk_sysctls
> > > 
> > > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > 
> > I am a bit sceptical if the size and time reduction is worth the
> > effort. I feel that this change makes the access a bit less secure.
> In what way "less secure"? Can you expand on that?
> 
> Notice that if you pass a pointer to the register functions, you will
> get a warning/error on compilation.

I have vague memories that some arrays were not static or the length
has been somehow manipulated. But I might be wrong.

You are right that it should be safe with the static arrays.
And the NULL sentinel might be more error-prone after all.

Let's forget my mumbles.

Best Regards,
Petr

