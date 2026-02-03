Return-Path: <linux-fsdevel+bounces-76179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIqyGIPJgWl1JwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 11:10:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F94D7599
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 11:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21C48302380F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2016439C636;
	Tue,  3 Feb 2026 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5XkA7LP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BBE39446D
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113406; cv=none; b=JxJWw4SA25Pf+SPaIvYuXwGl1fdm8fmbE6OWvxV5lfCLArBlj5cGK5oxyUq66Va8IdEyLTHPl+L1Eq6/Shgg34ztIMEStjakxCbJ5fZhVM/fgluTfDStlgw3dlrNlRzQPZna4KOENmfqmPcPjruEHUwMi0YJtt/EKWf0bI0PIlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113406; c=relaxed/simple;
	bh=OItMYGPQqHUE+urHop5qPqb1i6vjQEt+fmTKE7EtbcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcmDr39DnaWTvRGuk6zGn2ddiuM4k8e8BthEyKpuvv0yPcqB4p3uftc3925GBA2m7SkwMgfd0M9s9e6Okn7vTFTKAiwdqCBdQK+ka0r2o4hHITAY9hPhFIIboth2AnpydT/h/u1AiKgiKxvJwnlQ7KQx4ZRxvuScophWENPQRD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5XkA7LP; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b885e8c6700so889273266b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 02:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770113404; x=1770718204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvrluIg2iCtRBY994OY5LcLdBsBGupkAkPLQLUuiFys=;
        b=f5XkA7LPDfidXkkvwKYxbA5kz+1grBtygA8SZlga7p/pJZqzCnWtFBVZG6/5d1Qw7K
         CtdcV6L2t9vbE4V1kgGqcYGMFGJAGLAmjSt++lPaKvrpe1K7A0Ca1tAfDfj5UErJEnhj
         KbRU+8Ix/XhnHob7PI8kJ/+Q5MTcWyvcH4ALT6IBFA84BFtrQ16l0WEbEQ+Rv5ZsANez
         Gmq30GokLPA5Om/t2EwKIVzk/QG0Npv9g8Wke52QqVT7WEZ5+FNktjEIlcrm+hiJpvYZ
         KyDeeCkzmtWS2Pgk7T9j9Ca+f00P1MMbHNzSYxTOGQKtBMiMJSNi3vxuYBdu27fDkrbi
         Vg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113404; x=1770718204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GvrluIg2iCtRBY994OY5LcLdBsBGupkAkPLQLUuiFys=;
        b=Ci/wF7S/hF1U9Q2bjSZjvXZV+uKwLIYaD0HfMc5O0vLYIPyJd5ShFjgzLa3qhGf3o6
         8V9zEf6j/ngMRK6UaeCY766FYh64kXD1gDo/h0yU3lVwK9wW/WqiLsC7pI98Y7cBJ7zI
         qahO74NgU22KJAq1GqeoTGzRSxEkVNMbL1XAxpCjtTlpghRJi9X4DP8d0Jii6ObZwHKH
         cKScEIpBSgsk32/D4RCxVwFf1PugRu7y1XiAE4I8r2zmQsuhBjf3zWrg7R10pG9p657v
         MRgc+qe5F/x/8lTB/bZ7ymkrQ1v/CHfrbeTHg1wtOmM8Kzez+4n+q9WzIYpP6vi4YCXL
         pNEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkEOJoB7ln+RRPN2myeU91TZ0z0MIwXYTkY4UB5WtM2Vf1OPH6n0yzwQULeAquTujyNhlCJp8cgkX/Zd/z@vger.kernel.org
X-Gm-Message-State: AOJu0YznYz3VpYt+n4Z8y9GaukewtvKn/Ij5uJi1FmgGfByBfewrMHmu
	Od6ioS4/ZuxJgavgH7gzuN0YSkXLNB/SSoFOL7ig9O78xxhhJG91tdRKjGUDow==
X-Gm-Gg: AZuq6aKh5RB/hPjRlqSJUWIMz1+venCpwB77JfS8Z587gfj+MWLi10EC9/qk6+fHZiN
	VJGkkmHewG5knfVVI+NRkZSh/OGpYEt569EeSXiokr9wXp+aqn0Jkp8+6ZDsm763GntRiG8dlSO
	CepsjFC6tn3wIVY19xzZeNQZPhbcaWTGw9Gh4UthrVYgfm1cQE7kpDtQyNA4SaA6kcbhs/gRCvH
	YtOF3+UK3tRdxLc0MRV3ee67HWU4v09TasTVnQbvZhWHNwo2h7K5ELJY6py89PfTOjS1Bfs+fGM
	tAx8UkPfd5E5lBX0WFjbLa2SuJMAhgM6AsykQw29eWtkVfwCixeQcmqyx2l7qgQHYJPoZrwG+bS
	PlTkNousCgfoFDSWoy9ziiRM95MjW0/j8ImWMGphURXPyZexwNlGbHLmv7CxMqwV4ZaMrtEXP9F
	VZK2NIIwM=
X-Received: by 2002:a05:600c:628c:b0:47e:e8de:7420 with SMTP id 5b1f17b1804b1-482db47ce23mr183596905e9.22.1770106824499;
        Tue, 03 Feb 2026 00:20:24 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483051286e0sm47463035e9.5.2026.02.03.00.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 00:20:22 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: dhowells@redhat.com
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	cem@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	kundan.kumar@samsung.com,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org,
	wqu@suse.com
Subject: Re: [PATCH 03/14] iov_iter: extract a iov_iter_extract_bvecs helper from bio code
Date: Tue,  3 Feb 2026 11:20:16 +0300
Message-ID: <20260203082016.2824493-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1763225.1769180226@warthog.procyon.org.uk>
References: <1763225.1769180226@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76179-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06F94D7599
X-Rspamd-Action: no action

David Howells <dhowells@redhat.com>:
> vmsplice from there into process address
> space

You mean vmsplice from pipe? According to this comment
(but I didn't read actual code) vmsplice *from* pipe
(as opposed to vmsplice *to* pipe) is equivalent to
normal readv:

https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/splice.c#L1500


-- 
Askar Safin

