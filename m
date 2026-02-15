Return-Path: <linux-fsdevel+bounces-77249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIQOH5SLkWkrjwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 10:02:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D24FB13E5FF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 10:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 323ED3014570
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 09:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296E8287257;
	Sun, 15 Feb 2026 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6yphLgs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A527BF7D
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Feb 2026 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771146122; cv=none; b=DEXlVf7ilzLVPXyGCuk7Qgo8p+M6nInKTubvwT3qTuE5s9jNEGJnu3ZLtERunmUR31DqKohDSzlZQ92gt74tD0tpYDbYHo4IzTBT1s8Ge2sc4QomBvJW3z/8QEO+5KKdEQrHYMgbnoMS6kdo/BCtFLgOabyjaj6oZe2lV8jLfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771146122; c=relaxed/simple;
	bh=W6T4NKMFGU2utFNEhPpN8fZf0hDKTQ6a+z8Ar/UV6dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLRL4MukE5MVuhjfeGDZ/FA+D4ET5YqxyZJAiieMcxp5B75nfCav7Ad1+XGfr15GfilquR71PcATYjR4fuonO/9ahFjUCnwKAJ2kTwhDQgOKbT9lx+PWFC0NIzRUmybA4Utzbv6FB5vkMo8SFPr6xvrsqetEUQdMP/GUvF9w3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6yphLgs; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so1772762f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Feb 2026 01:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771146120; x=1771750920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+D0ODJnkgxsrPA3UYy81wUrrkW2kcfyG+MPWkVZLGUk=;
        b=S6yphLgs/m+PstcT6JoZP/nYSovXkFDplNeEQVtl6jyOyUeYp2mAe1BJ0f+zDzzWaR
         CeWutWf0eNMJC0Uww7j3uwfYIQnxzXrPrSh5mJNAtbsb89c4EWaGC0hFJmFbfIo+v4iM
         Va2938r2H/zquw6VuE/pDcXU3C37IznRCGVfuSHorOHR3qw1gExiler0I+5fQH3Ybocq
         B/D3VZJsvRIy/4iqYNA0LKbA9/nojoeghHskOACUv7l5QA5pBycNCyZoVs8oD0sSJ8p/
         aJxceRQ/BJPNieoWgi40YqCy1GMF2LY4UbsTKaS8nPAKW1xiosXx6CirjHhvGc8DkAmE
         lSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771146120; x=1771750920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+D0ODJnkgxsrPA3UYy81wUrrkW2kcfyG+MPWkVZLGUk=;
        b=UNU4VMtkDoneW6YNNR0MP53gQxzI2LxTx9ipEcz6ozJ9EnYlFi7RyX1JqqvzfU65Rh
         3lw4SIrrk3VZBZabV7FSI3ILbr1PbfMU/5GlN6VrD/bSl0YTkSeJNxrMBAF3q6ZWQzaQ
         WVEyV+7u2FSeq3XCjT5eujY4PBQCkc+j+3duzW642tkvkqkvL/45TMXR0WSRlxD2PY/X
         jkLqfABG+F56/pTM+2wZ5Z9EMHQV3rfRiSZa7o/8MT/XyYvuOkaGrb3N4tj81DwUvk5o
         vi6M8rYfH45rSYxLbOvVFvks7VAgEdCktjS5woLpHVk6VN9YT7FANKJtudh6pgZ7cCgy
         smRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKA59DrLwRyo1iVqjjDU7w92A1/MSgTcxhHlreWdc6BYw9PaoENoiHPKPBwRWwCrFnV39arCjgp00+xqND@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7t1HaBRI3LAfVHt6Wm3wMXK4k+h/rzDq4Wf4aHS+srpNTCWDA
	aoP2dFOdL7VvHC0lsXrH+4bUBnwW+zCV97cCOcwhObGiG9AicXqlyoTq
X-Gm-Gg: AZuq6aLV3nXZD1ucyKUKffrcVH3CZFq9UEJ1Pyy3Rps/MIc9D/rLjDIdbFBxfedpAF2
	C+Ch9og1U3/sR9ooAOk2pMyLcTPu67RYeRUbknv8L96Ht+Q2aZhm3Kqhox9bB/J8jf5Ku+cqS9o
	8PpRjP4urMOcVw7GvfgQv07V68maORvIS0fP1l91c+1Rkqr+UXlcNojpbAr9tQAljIhyqrD0aU/
	o5qNoqHnQRpgYKArJUcxd52sK0Q2MqAyyvJzXvvzO+qOiHKN4QjIIPxNcRmYR4/bywcTLqk54ZV
	hocPC6SFCghgQVhdluni17KBs/RhISEdwby6OPFAfQul55nayTUz3CUb/sQdlcmmodIigBo0NeJ
	12acPdJQLhTg9BVhSeVo5/u66DxX6pyN3MB+ZN+cdHqkQdDnk8v+1WY8QSrWe3aNREiahfXrLbj
	EBSPkF3PK/cqKtP+nQcrYm
X-Received: by 2002:a05:6000:2311:b0:435:a258:76e with SMTP id ffacd0b85a97d-4379793dd5emr12414131f8f.60.1771146118907;
        Sun, 15 Feb 2026 01:01:58 -0800 (PST)
Received: from localhost ([2a0d:6fc2:4b0a:db00:eb98:5335:fc91:c4bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abd793sm18612064f8f.25.2026.02.15.01.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 01:01:58 -0800 (PST)
Date: Sun, 15 Feb 2026 11:01:57 +0200
From: Amir Goldstein <amir73il@gmail.com>
To: Pankaj Raghav <pankaj.raghav@linux.dev>,
	Andres Freund <andres@anarazel.de>
Cc: linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	djwong@kernel.org, john.g.garry@oracle.com, willy@infradead.org,
	hch@lst.de, ritesh.list@gmail.com, jack@suse.cz,
	ojaswin@linux.ibm.com, Luis Chamberlain <mcgrof@kernel.org>,
	dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>,
	gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com,
	vi.shah@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <aZGLhTvjmRVZNA8m@amir-ThinkPad-T480>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77249-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,suse.cz,linux.ibm.com,redhat.com,samsung.com,mit.edu];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[forms.gle:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D24FB13E5FF
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 11:20:36AM +0100, Pankaj Raghav wrote:
> Hi all,
> 
> Atomic (untorn) writes for Direct I/O have successfully landed in kernel
> for ext4 and XFS[1][2]. However, extending this support to Buffered I/O
> remains a contentious topic, with previous discussions often stalling due to
> concerns about complexity versus utility.
> 
> I would like to propose a session to discuss the concrete use cases for
> buffered atomic writes and if possible, talk about the outstanding
> architectural blockers blocking the current RFCs[3][4].
> 
> ## Use Case:
> 
> A recurring objection to buffered atomics is the lack of a convincing use
> case, with the argument that databases should simply migrate to direct I/O.
> We have been working with PostgreSQL developer Andres Freund, who has
> highlighted a specific architectural requirement where buffered I/O remains
> preferable in certain scenarios.
> 
> While Postgres recently started to support direct I/O, optimal performance
> requires a large, statically configured user-space buffer pool. This becomes
> problematic when running many Postgres instances on the same hardware, a
> common deployment scenario. Statically partitioning RAM for direct I/O
> caches across many instances is inefficient compared to allowing the kernel
> page cache to dynamically balance memory pressure between instances.
> 
> The other use case is using postgres as part of a larger workload on one
> instance. Using up enough memory for postgres' buffer pool to make DIO use
> viable is often not realistic, because some deployments require a lot of
> memory to cache database IO, while others need a lot of memory for
> non-database caching.
> 
> Enabling atomic writes for this buffered workload would allow Postgres to
> disable full-page writes [5]. For direct I/O, this has shown to reduce
> transaction variability; for buffered I/O, we expect similar gains,
> alongside decreased WAL bandwidth and storage costs for WAL archival. As a
> side note, for most workloads full page writes occupy  a significant portion
> of WAL volume.
> 
> Andres has agreed to attend LSFMM this year to discuss these requirements.
> 

Andres,

If you wish to attend LSFMM, please request an invite via the Google
form:

  https://forms.gle/hUgiEksr8CA1migCA

Thanks,
Amir.

