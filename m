Return-Path: <linux-fsdevel+bounces-75949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L3NLAvPfGlbOwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 16:32:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D7BC0C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 16:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D79A3044648
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 15:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4805132ED31;
	Fri, 30 Jan 2026 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0KQp0ypV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tRQx2Qeq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341DD31280F;
	Fri, 30 Jan 2026 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787097; cv=none; b=enDKTXwAMI2BmiOuPP1mCt7Rev8i0SVeMWmFioPoimaf8tkbRcLx8t3GiFxJvZrTRZQNh62IP5YAI8c8QNq3cORdsgY408Bje7HDgWfWQSMP4Cq312ocuLl/NBMa4kpmQsswEc80A9eMJEY3al+g5iDVBIScWy7DjGC2GhpyiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787097; c=relaxed/simple;
	bh=fOeDEk/IglYGyJoaC4rl87IP7u52uvkE7LuzzFUoZCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pvgq2OAq1zO5WU0Ry5gA3FL8XDE3hoZ9a8R0+hoQcUUmYFaurmO07zP5IP/dSAhLcIUqARx1IYiQUwyQLEsn6SBkK0PZ9eJNCXa0zcgG+xV4zJSXuyzlongo5GTqQmyacpjNUgVMRM2hjR+SEQ9kQ2N61tvy1pjMy57zXDyu1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0KQp0ypV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tRQx2Qeq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769787091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vOa37cugu1e7NFG01Hi5lQxNeOFAbNhgF4zlCMpuWB0=;
	b=0KQp0ypVQ4kZaeO3mPHMfxJV+hK/54vG6DKBi+oQw7b2zUOdcXSHVjzGTkDhg+DII5BPUq
	aN49RxuHT0Y324cEPE9hahaKdLHrEB12udzdH1NvAbslSIBaR+apFss0VpjAJQGlvJvNWz
	Qkt0FDwz1uMiX4gq49nlr83YKlkc4clstGJ1Gn1qJZPTuOUjrQYGQ2og6q2aakCd23E2bK
	j7QeXx4RcIyDXczvYB5hGiBrowZd2spJR3vfcC58o7tRoab9LXrUZs+RPcCpb6cx/pdJtb
	HBe2qGa1jRaFKPPNxGpTtUqYNPr0BFkp5fHngur0T+mOUqFJcq3Nhz3k8u/Dpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769787091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vOa37cugu1e7NFG01Hi5lQxNeOFAbNhgF4zlCMpuWB0=;
	b=tRQx2QeqDh72ig5xLjiaegMLqnl9AhaSG7GZod8dlzScFDOmHttRC8Fl88vJKoOCPg8W40
	GHTlrnG5vPdq05BA==
To: Petr Mladek <pmladek@suse.com>, Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jiri Slaby <jirislaby@kernel.org>,
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Andreas Larsson
 <andreas@gaisler.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jacky Huang <ychuang3@nuvoton.com>,
 Shan-Chun Hung <schung@nuvoton.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 linux-serial@vger.kernel.org, netdev@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/19] printk/nbcon: Use an enum to specify the required
 callback in console_is_usable()
In-Reply-To: <aWZyEHsOJFLRLRKT@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-1-21a291bcf197@suse.com>
 <aWZyEHsOJFLRLRKT@pathway.suse.cz>
Date: Fri, 30 Jan 2026 16:37:30 +0106
Message-ID: <878qdf3ynh.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75949-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[45];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nod.at,cambridgegreys.com,sipsolutions.net,linuxfoundation.org,windriver.com,kernel.org,chromium.org,goodmis.org,debian.org,lunn.ch,davemloft.net,google.com,redhat.com,linux-m68k.org,intel.com,igalia.com,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,gaisler.com,linux.intel.com,foss.st.com,nuvoton.com,nxp.com,lists.infradead.org,vger.kernel.org,lists.sourceforge.net,lists.linux-m68k.org,lists.ozlabs.org,st-md-mailman.stormreply.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.ogness@linutronix.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,jogness.linutronix.de:mid,linutronix.de:email,linutronix.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 365D7BC0C8
X-Rspamd-Action: no action

On 2026-01-13, Petr Mladek <pmladek@suse.com> wrote:
> On Sat 2025-12-27 09:16:08, Marcos Paulo de Souza wrote:
>> The current usage of console_is_usable() is clumsy. The parameter
>> @use_atomic is boolean and thus not self-explanatory. The function is
>> called twice in situations when there are no-strict requirements.
>> 
>> Replace it with enum nbcon_write_cb which provides a more descriptive
>> values for all 3 situations: atomic, thread or any.
>> 
>> Note that console_is_usable() checks only NBCON_USE_ATOMIC because
>> .write_thread() callback is mandatory. But the other two values still
>> make sense because they describe the intention of the caller.
>> 
>> --- a/include/linux/console.h
>> +++ b/include/linux/console.h
>> @@ -202,6 +202,19 @@ enum cons_flags {
>>  	CON_NBCON_ATOMIC_UNSAFE	= BIT(9),
>>  };
>>  
>> +/**
>> + * enum nbcon_write_cb - Defines which nbcon write() callback must be used based
>> + *                       on the caller context.
>> + * @NBCON_USE_ATOMIC: Use con->write_atomic().
>> + * @NBCON_USE_THREAD: Use con->write_thread().
>> + * @NBCON_USE_ANY:    The caller does not have any strict requirements.
>> + */
>> +enum nbcon_write_cb {
>> +	NBCON_USE_ATOMIC,
>> +	NBCON_USE_THREAD,
>> +	NBCON_USE_ANY,
>
> AFAIK, this would define NBCON_USE_ATOMIC as zero. See below.

Yes, although the start value is not guaranteed. And anyway if is to be
used as bits, it should be explicitly set so (such as with enum
cons_flags).

But in reality, we only care about NBCON_USE_ATOMIC and
!NBCON_USE_ATOMIC, so I agree with your comments below about keeping it
a simple enum and not caring about the numerical value.

>> @@ -631,7 +645,7 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
>>  		return false;
>>  
>>  	if (flags & CON_NBCON) {
>> -		if (use_atomic) {
>> +		if (nwc & NBCON_USE_ATOMIC) {
>
> Let's keep it defined by as zero and use here:
>
> 		if (nwc == NBCON_USE_ATOMIC) {
>
> Note that we do _not_ want to return "false" for "NBCON_USE_ANY"
> when con->write_atomic does not exist.

I agree.

If changed to "nwc == NBCON_USE_ATOMIC":

Reviewed-by: John Ogness <john.ogness@linutronix.de>

