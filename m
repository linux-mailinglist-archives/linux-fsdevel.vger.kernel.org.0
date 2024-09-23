Return-Path: <linux-fsdevel+bounces-29901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CEE97F14A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 21:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBE11F22814
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 19:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274A81A0732;
	Mon, 23 Sep 2024 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rwr6JOxb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hgYHeLhk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rwr6JOxb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hgYHeLhk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ACB1A01DB;
	Mon, 23 Sep 2024 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727120350; cv=none; b=YdrLWWdsc4deCijoE1e2K4E1TZ68A70eKlnNsfM5rBpaW3XjQk9XcwLdXoCnwmoMmFfjUPRjrqtIdYo4hFFmngXPyiNnMixVSURh0foG/rKSYz/kgsUHGa1POhYTfq4NdbkZSzxrMsqGrAWXY88HIlwq2Pf62SWnqs2ms/dRsnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727120350; c=relaxed/simple;
	bh=fif18Gbqv3h2FyGK8EMsN1zq5El7xh5nAnmet2jGCBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WXTmwBemD6vBh7+1wbwXlBZ3XIn4Ob4SkST9L9ak7WmA24hBJaRLYPCkfi5lbBX0WsYX0ekuXQMz2L80RZL1NRmmKr//rQZ8PKlwxQPn9RE6sJgBJ7bnx/eldt9rwIX8Vwwmi2POzMzEbrBjXq65448i4C/a+eIU1Kgf3syozaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rwr6JOxb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hgYHeLhk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rwr6JOxb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hgYHeLhk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7AF1E21DC3;
	Mon, 23 Sep 2024 19:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727120346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btFVzvo3cYlCIaFbLMC8UzMj/n6rmtuNvZUl+PCyxSQ=;
	b=Rwr6JOxbkiklNQw+x4Hjx6dHODAJH+Vwmbh1oihVfmkQC7lsG+p5BjchvPPL04TD2zATCg
	TifUqy+Diu6JkyKTwQ4p/pZlVE2/b+WV5V2ts7eGqv0d/UucPlG/p5Ds0FgTFCaz4Exzfi
	comE3NVl7Z2xAnjL4VIhyNaSx61SsZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727120346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btFVzvo3cYlCIaFbLMC8UzMj/n6rmtuNvZUl+PCyxSQ=;
	b=hgYHeLhkGlG/3YkB/t+moHHtkdI3ssLeOy9yq9aecJLkPfk3Yh/cev2O45V2KL92Y1Ehr6
	oumwpzkQmAwe5CAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727120346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btFVzvo3cYlCIaFbLMC8UzMj/n6rmtuNvZUl+PCyxSQ=;
	b=Rwr6JOxbkiklNQw+x4Hjx6dHODAJH+Vwmbh1oihVfmkQC7lsG+p5BjchvPPL04TD2zATCg
	TifUqy+Diu6JkyKTwQ4p/pZlVE2/b+WV5V2ts7eGqv0d/UucPlG/p5Ds0FgTFCaz4Exzfi
	comE3NVl7Z2xAnjL4VIhyNaSx61SsZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727120346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btFVzvo3cYlCIaFbLMC8UzMj/n6rmtuNvZUl+PCyxSQ=;
	b=hgYHeLhkGlG/3YkB/t+moHHtkdI3ssLeOy9yq9aecJLkPfk3Yh/cev2O45V2KL92Y1Ehr6
	oumwpzkQmAwe5CAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 360B31347F;
	Mon, 23 Sep 2024 19:39:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Oor9BtrD8Wa0OQAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 23 Sep 2024 19:39:06 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
Cc: Gabriel Krisman Bertazi <krisman@kernel.org>,  David Gow
 <davidgow@google.com>,  Shuah Khan <skhan@linuxfoundation.org>,
  linux-fsdevel@vger.kernel.org,  ~lkcamp/patches@lists.sr.ht,
  linux-kselftest@vger.kernel.org,  kunit-dev@googlegroups.com,
  porlando@lkcamp.dev,  dpereira@lkcamp.dev
Subject: Re: [PATCH 1/2] unicode: kunit: refactor selftest to kunit tests
In-Reply-To: <20240923173454.264852-2-gbittencourt@lkcamp.dev> (Gabriela
	Bittencourt's message of "Mon, 23 Sep 2024 14:34:53 -0300")
References: <20240923173454.264852-1-gbittencourt@lkcamp.dev>
	<20240923173454.264852-2-gbittencourt@lkcamp.dev>
Date: Mon, 23 Sep 2024 15:39:05 -0400
Message-ID: <87r09axiqu.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lkcamp.dev:email]
X-Spam-Flag: NO
X-Spam-Level: 

Gabriela Bittencourt <gbittencourt@lkcamp.dev> writes:

>
> -static ssize_t utf8len(const struct unicode_map *um, enum utf8_normalization n,
> -		const char *s)
> +static ssize_t utf8len(const struct unicode_map *um, enum utf8_normalization n, const char *s)
>  {

Please, do not make indentation-only changes, specially as part of a larger
change.  It makes the patch much harder to review.


>  	return utf8nlen(um, n, s, (size_t)-1);
>  }
>  
>  static int utf8cursor(struct utf8cursor *u8c, const struct unicode_map *um,
> -		enum utf8_normalization n, const char *s)
> +		      enum utf8_normalization n, const char *s)

likewise.

>  {
>  	return utf8ncursor(u8c, um, n, s, (unsigned int)-1);
>  }
>  
> -static void check_utf8_nfdi(struct unicode_map *um)
> +static void check_utf8_nfdi(struct kunit *test)
>  {
>  	int i;
>  	struct utf8cursor u8c;
> +	struct unicode_map *um = test->priv;
>  
>  	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
>  		int len = strlen(nfdi_test_data[i].str);
> @@ -181,28 +161,29 @@ static void check_utf8_nfdi(struct unicode_map *um)
>  		int j = 0;
>  		unsigned char c;
>  
> -		test((utf8len(um, UTF8_NFDI, nfdi_test_data[i].str) == nlen));
> -		test((utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str, len) ==
> -			nlen));
> +		KUNIT_EXPECT_EQ(test, utf8len(um, UTF8_NFDI, nfdi_test_data[i].str), nlen);
> +		KUNIT_EXPECT_EQ(test, utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str, len),
> +				nlen);
> -		if (utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str) < 0)
> -			pr_err("can't create cursor\n");
> +		KUNIT_EXPECT_GE_MSG(test, utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str),
> +				    0, "Can't create cursor\n");

These KUNIT_ macros are way less readable than the existing code,
IMO. the old macro makes it obvious what we are checking, without having
to dig into the definition.  But, meh, I can live with it.



>  
>  		while ((c = utf8byte(&u8c)) > 0) {
> -			test_f((c == nfdi_test_data[i].dec[j]),
> -			       "Unexpected byte 0x%x should be 0x%x\n",
> -			       c, nfdi_test_data[i].dec[j]);
> +			KUNIT_EXPECT_EQ_MSG(test, c, nfdi_test_data[i].dec[j],
> +					    "Unexpected byte 0x%x should be 0x%x\n",
> +					    c, nfdi_test_data[i].dec[j]);
>  			j++;
>  		}
>  
> -		test((j == nlen));
> +		KUNIT_EXPECT_EQ(test, j, nlen);
>  	}
>  }
>  
> -static void check_utf8_nfdicf(struct unicode_map *um)
> +static void check_utf8_nfdicf(struct kunit *test)
>  {
>  	int i;
>  	struct utf8cursor u8c;
> +	struct unicode_map *um = test->priv;
>  
>  	for (i = 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
>  		int len = strlen(nfdicf_test_data[i].str);
> @@ -210,29 +191,30 @@ static void check_utf8_nfdicf(struct unicode_map *um)
>  		int j = 0;
>  		unsigned char c;
>  
> -		test((utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].str) ==
> -				nlen));
> -		test((utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].str, len) ==
> -				nlen));
> +		KUNIT_EXPECT_EQ(test, utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].str),
> +				nlen);
> +		KUNIT_EXPECT_EQ(test, utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].str, len),
> +				nlen);
>  
> -		if (utf8cursor(&u8c, um, UTF8_NFDICF,
> -				nfdicf_test_data[i].str) < 0)
> -			pr_err("can't create cursor\n");
> +		KUNIT_EXPECT_GE_MSG(test,
> +				    utf8cursor(&u8c, um, UTF8_NFDICF, nfdicf_test_data[i].str),
> +				    0, "Can't create cursor\n");
>  
>  		while ((c = utf8byte(&u8c)) > 0) {
> -			test_f((c == nfdicf_test_data[i].ncf[j]),
> -			       "Unexpected byte 0x%x should be 0x%x\n",
> -			       c, nfdicf_test_data[i].ncf[j]);
> +			KUNIT_EXPECT_EQ_MSG(test, c, nfdicf_test_data[i].ncf[j],
> +					    "Unexpected byte 0x%x should be 0x%x\n",
> +					    c, nfdicf_test_data[i].ncf[j]);
>  			j++;
>  		}
>  
> -		test((j == nlen));
> +		KUNIT_EXPECT_EQ(test, j, nlen);
>  	}
>  }
>  
> -static void check_utf8_comparisons(struct unicode_map *table)
> +static void check_utf8_comparisons(struct kunit *test)
>  {
>  	int i;
> +	struct unicode_map *um = test->priv;
>  
>  	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
>  		const struct qstr s1 = {.name = nfdi_test_data[i].str,
> @@ -240,8 +222,9 @@ static void check_utf8_comparisons(struct unicode_map *table)
>  		const struct qstr s2 = {.name = nfdi_test_data[i].dec,
>  					.len = sizeof(nfdi_test_data[i].dec)};
>  
> -		test_f(!utf8_strncmp(table, &s1, &s2),
> -		       "%s %s comparison mismatch\n", s1.name, s2.name);
> +		// strncmp returns 0 when strings are equal

We don't do comments with // in the kernel (aside from SPDX).  Please, use /* */.

> +		KUNIT_EXPECT_EQ_MSG(test, utf8_strncmp(um, &s1, &s2), 0,
> +				    "%s %s comparison mismatch\n", s1.name, s2.name);

Yuck. This is even less readable.  Is there a kunit macro that receives
an expression, similar to WARN_ON/BUG_ON? It would be way more readable.
Something like this.

KUNIT_BLA(test, utf8_strncmp(um, &s1,&s2) == 0, "BAD TEST!")


-- 
Gabriel Krisman Bertazi

